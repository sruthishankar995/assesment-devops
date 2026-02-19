Goals (6–12 Month Plan) :

Eliminate manual deployments

Introduce Infrastructure as Code

Improve scalability and reliability

Handle load spikes safely

Reduce downtime

Improve observability

Support future growth

 Target Architecture
                Route53
                   │
              CloudFront
                   │
                  ALB
                   │
        ┌──────────┴──────────┐
        │                     │
   React Frontend        Python API
                               │
                               ▼
                           SQS Queue
                               │
                          Worker Pods
                               │
                               ▼
                        Aurora PostgreSQL
                               │
                               ▼
                               S3

Technology Choices: 

Container Orchestration: Amazon EKS

Why Kubernetes (EKS) instead of ECS?

Fine-grained autoscaling (CPU + memory)

Independent scaling for worker pods

Strong ecosystem

Future microservices flexibility

Advanced deployment strategies (Blue/Green, Canary)

EKS provides long-term scalability and flexibility for a growing startup.

Migration Plan (Minimizing Downtime)

Phase 1 (Months 0–3): Stabilization & Foundations

Highest Priority

Introduce Terraform for infrastructure

Containerize frontend and backend

Implement GitHub Actions CI/CD

Centralized logging (CloudWatch)

Basic autoscaling on EC2

This reduces operational risk immediately.

Phase 2 (Months 3–6): Platform Migration

Deploy EKS cluster

Deploy workloads to EKS

Implement ALB Ingress

Introduce Blue/Green deployments

Gradually shift traffic from EC2 to EKS

Downtime minimized by:

Running EC2 and EKS in parallel

Gradually shifting traffic using ALB weighted routing

Phase 3 (Months 6–12): Scalability & Resilience

Migrate RDS → Aurora PostgreSQL

Introduce SQS for heavy background tasks

Deploy autoscaling worker pods

Implement HPA (Horizontal Pod Autoscaler)

Add Redis caching

Implement advanced observability

 Handling Load Spikes
Current Problem

Large client jobs:

Consume high memory

Overload database

Block API threads

Cause downtime

Proposed Solution: Async Task Processing

Instead of:

Client → API → Heavy Processing → DB


We move to:

Client → API → SQS → Worker Pods → DB

Benefits

API remains responsive

Workers scale independently

Controlled database load

No memory thrashing in API pods

 Database Scalability Strategy:

1. Migrate to Aurora PostgreSQL

Benefits:

Better performance

Auto storage scaling

Read replicas

Faster failover

2. Read Replicas
Writes → Primary
Reads → Replica


Reduces primary database load.

3. Bulk Insert Optimization

Use batch inserts

Use COPY for large data loads

Optimize autovacuum

Partition large tables

4. Connection Pooling

Introduce:

RDS Proxy
or

PgBouncer

Prevents connection storms during load spikes.

🔍 Observability Improvements

Introduce full three-pillar observability:

Logs

Application logs → CloudWatch

Metrics

Prometheus

CloudWatch metrics

ALB and RDS monitoring

Tracing

AWS X-Ray

Alerts

SNS → Slack / Email

Alerts for:

High memory

High DB CPU

High 5xx errors

SQS queue backlog

CI/CD Modernization:

Replace manual SSH deployments with GitHub Actions:

Pipeline Flow

Run tests

Build Docker image

Push to ECR

Deploy to EKS

Blue/Green traffic shift

Automatic rollback on failure

Benefits

No manual deployments

Zero-downtime releases

Safer rollouts

Faster iteration

Security Improvements: 

IAM Roles for Service Accounts

Private subnets for EKS nodes

Secrets Manager for credentials

Encrypted RDS storage

WAF in front of ALB

VPC Endpoints for S3


What Gets Done First: 
First 3 Months

CI/CD

Containerization

Terraform

Logging

Async processing for heavy tasks

These deliver the biggest immediate stability improvements.

Months 3–6

EKS migration

Blue/Green deployments

Autoscaling workers

Database performance tuning

Months 6–12

Aurora migration

Read replicas

Advanced monitoring

Cost optimization

Disaster recovery planning

 Conclusion :

This roadmap:

Reduces downtime

Improves scalability

Handles heavy workloads safely

Introduces automation

Prepares the company for rapid growth

The strategy balances:

Immediate stabilization

Controlled migration

Long-term scalability

If needed, this document can be extended to include:

Cost estimation

Multi-region DR strategy

SLO/SLI definitions

Compliance considerations

Risk assessment

Author: DevOps Architecture Proposal
Timeline: 6–12 Months
Objective: Build scalable, reliable, production-grade infrastructure for rapid growth 

How to Run
1. Prerequisites

AWS account

Terraform ≥ 1.5

kubectl

AWS CLI configured

Docker

GitHub repository secrets configured

Deploy Infrastructure
cd startup-devops-demo/env/dev
terraform init
terraform plan
terraform apply

 Assumptions Made

1.Due to time constraints, the following assumptions were made:

2.Single AWS region deployment

3.No multi-account setup

4.No full production-grade network segmentation

5.Simplified IAM policies

6.Basic autoscaling configuration

7.No full secret rotation automation

8.Aurora chosen over self-managed PostgreSQL




Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2413C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84D161056
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhJLJfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:35:07 -0400
Received: from verein.lst.de ([213.95.11.211]:40700 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235771AbhJLJfG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 05:35:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FB2A68BEB; Tue, 12 Oct 2021 11:33:02 +0200 (CEST)
Date:   Tue, 12 Oct 2021 11:33:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/5] kyber: avoid q->disk dereferences in trace points
Message-ID: <20211012093301.GA27795@lst.de>
References: <20210929071241.934472-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


q->disk becomes invalid after the gendisk is removed.  Work around this
by caching the dev_t for the tracepoints.  The real fix would be to
properly tear down the I/O schedulers with the gendisk, but that is
a much more invasive change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/kyber-iosched.c        | 10 ++++++----
 include/trace/events/kyber.h | 19 +++++++++----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 15a8be57203d6..a0ffbabfac2c6 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -151,6 +151,7 @@ struct kyber_ctx_queue {
 
 struct kyber_queue_data {
 	struct request_queue *q;
+	dev_t dev;
 
 	/*
 	 * Each scheduling domain has a limited number of in-flight requests
@@ -257,7 +258,7 @@ static int calculate_percentile(struct kyber_queue_data *kqd,
 	}
 	memset(buckets, 0, sizeof(kqd->latency_buckets[sched_domain][type]));
 
-	trace_kyber_latency(kqd->q, kyber_domain_names[sched_domain],
+	trace_kyber_latency(kqd->dev, kyber_domain_names[sched_domain],
 			    kyber_latency_type_names[type], percentile,
 			    bucket + 1, 1 << KYBER_LATENCY_SHIFT, samples);
 
@@ -270,7 +271,7 @@ static void kyber_resize_domain(struct kyber_queue_data *kqd,
 	depth = clamp(depth, 1U, kyber_depth[sched_domain]);
 	if (depth != kqd->domain_tokens[sched_domain].sb.depth) {
 		sbitmap_queue_resize(&kqd->domain_tokens[sched_domain], depth);
-		trace_kyber_adjust(kqd->q, kyber_domain_names[sched_domain],
+		trace_kyber_adjust(kqd->dev, kyber_domain_names[sched_domain],
 				   depth);
 	}
 }
@@ -366,6 +367,7 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 		goto err;
 
 	kqd->q = q;
+	kqd->dev = disk_devt(q->disk);
 
 	kqd->cpu_latency = alloc_percpu_gfp(struct kyber_cpu_latency,
 					    GFP_KERNEL | __GFP_ZERO);
@@ -774,7 +776,7 @@ kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
 			list_del_init(&rq->queuelist);
 			return rq;
 		} else {
-			trace_kyber_throttled(kqd->q,
+			trace_kyber_throttled(kqd->dev,
 					      kyber_domain_names[khd->cur_domain]);
 		}
 	} else if (sbitmap_any_bit_set(&khd->kcq_map[khd->cur_domain])) {
@@ -787,7 +789,7 @@ kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
 			list_del_init(&rq->queuelist);
 			return rq;
 		} else {
-			trace_kyber_throttled(kqd->q,
+			trace_kyber_throttled(kqd->dev,
 					      kyber_domain_names[khd->cur_domain]);
 		}
 	}
diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index 491098a0d8ed9..bf7533f171ff9 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -13,11 +13,11 @@
 
 TRACE_EVENT(kyber_latency,
 
-	TP_PROTO(struct request_queue *q, const char *domain, const char *type,
+	TP_PROTO(dev_t dev, const char *domain, const char *type,
 		 unsigned int percentile, unsigned int numerator,
 		 unsigned int denominator, unsigned int samples),
 
-	TP_ARGS(q, domain, type, percentile, numerator, denominator, samples),
+	TP_ARGS(dev, domain, type, percentile, numerator, denominator, samples),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev				)
@@ -30,7 +30,7 @@ TRACE_EVENT(kyber_latency,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(q->disk);
+		__entry->dev		= dev;
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 		strlcpy(__entry->type, type, sizeof(__entry->type));
 		__entry->percentile	= percentile;
@@ -47,10 +47,9 @@ TRACE_EVENT(kyber_latency,
 
 TRACE_EVENT(kyber_adjust,
 
-	TP_PROTO(struct request_queue *q, const char *domain,
-		 unsigned int depth),
+	TP_PROTO(dev_t dev, const char *domain, unsigned int depth),
 
-	TP_ARGS(q, domain, depth),
+	TP_ARGS(dev, domain, depth),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
@@ -59,7 +58,7 @@ TRACE_EVENT(kyber_adjust,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(q->disk);
+		__entry->dev		= dev;
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 		__entry->depth		= depth;
 	),
@@ -71,9 +70,9 @@ TRACE_EVENT(kyber_adjust,
 
 TRACE_EVENT(kyber_throttled,
 
-	TP_PROTO(struct request_queue *q, const char *domain),
+	TP_PROTO(dev_t dev, const char *domain),
 
-	TP_ARGS(q, domain),
+	TP_ARGS(dev, domain),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
@@ -81,7 +80,7 @@ TRACE_EVENT(kyber_throttled,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(q->disk);
+		__entry->dev		= dev;
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 	),
 
-- 
2.30.2


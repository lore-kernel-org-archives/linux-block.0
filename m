Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0426FDB7
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441497; cv=none; b=EZRKV6BJj2OFq6P0r7zpqHIuYj3WBUt+9Pb/75O+x5RTTCsnUnpXPG0l9N2Owbj5Oysvxd3XP4X5Frsc3Nld7YPftbVkhmTxEPTWf8mNcjHTUcGz0JeFYBPzcTLZX7m67wab5VINVb9CrC/RXquEd7LSfrWiGVdODkaQ7glNp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441497; c=relaxed/simple;
	bh=4Q2iPo/tnEZ49XySLTXbJNcXJ7aWlvW/11m4VHSBuh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nji2OrrxippoBQ5ATGOP4EnGfHBltIqhZC2pvOvz/wgTUJLHnceoabN380dU4JHRa47fk7qKUdASKCywJ4QBrTXIOnKuwzOp2HRcsGWmFcbTE1SaXpSQO5/DR0ipxaPWUpUK80DiFNJcDyjcumNn+1UAe3ENojQETBUlI6s59PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZUmoys1F; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZUmoys1F"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85b39b536f1so1446039f.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745441494; x=1746046294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoK4bN+8xfY+ulGAa3XB64iIL6M5dgQU+nAPX6fChJA=;
        b=ZUmoys1Fg2KUfoxVmJVYB0AD5cWKaYsCl+17yVqSq6OP/Bg8jzITD3ba61bp2di60v
         IWzGTRrHNxr9DtgoygMj46X/qdrE/wfjfrwNN6ZjADwZIJFQVN/9PjAb8L7h1+l2kvUc
         8K0jZqyG5Q2PBzms6030RVfIWi0nEAGEUO664LoZGOrs82XN6DRcEl5lkJNjf3mZmCLB
         4Wj3aFAOb62UvDl/Sp11ZrxUG3O65lq5wGBfRPmAhhfliGMOYne3diMPdakxXDKJw6NW
         2W5jpxoIQJoeH6gSyScpCDhTLlbWasQzFy5VQYFYLfU1GYn2CvNWmETDLcpVMjbzHV8e
         y/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441494; x=1746046294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoK4bN+8xfY+ulGAa3XB64iIL6M5dgQU+nAPX6fChJA=;
        b=ckDbWFqRMloP7G4hPreMYbC4TGc8jPrEsZXFvahkAmFSHJFhWt1wJVfiUrzlVnHDlR
         kcH0Tq4sS9162wYO0Zd5qoJkMV/YngYdS9u30N2ftsgeOOvL3RBzpbwANneGm3OVSxqm
         nC44lw1GEPab/AqtK90GhSR+T5kqMkduQjFQ9MfhqUsEgrtMyN2uhiNdjtouxf4pTA2Y
         0C7/kdtaKboEkwyRu3r5cW4Y/6ooI9gxTV9yyCH2IuthLmIbNEEn/NorC231ed6T54HJ
         +0DySAavahWyBVyxnxxnTir941SoHGtlfd1pNwOR3bzPlltvGJ5q/5EuWkTQa8fYmlY9
         DiLg==
X-Gm-Message-State: AOJu0Yyk9ZVdocEmsbgo73duzQgchWtIfZlxY+ue+BS2o1fPO6c5gKMa
	8JlLete4MJr2j//n6aPT/ojGTSXWEJVBDdR8NnU9Jy/yPsocTJETYa7f335505G7Wns/s2FGjPN
	IieKrgTSZDJoWyzkCWWU3Yjjb6jXJRozVuapGtgBNVkR+MTHt
X-Gm-Gg: ASbGnctFK6lZaiqmeLCz7l1xvKa1B/YPML91PcyvoEpjtQBD25bui0/p5A/cWta9bGk
	io5C45jSKxKMRSJklFtQEl+AFZBMxH4LSrWbusE2Gj7sRZzKnhbXYhpiBmZA7u463Cvc+yYyeJp
	/tYIGGvDBAssyLovqgtil+XgHF13c4d6TmAdLOCGOy+5BL9FVchFkG9sqoTpfd0WE3q0n7IN/qW
	2L+CJb7v2ADwKjSvTZEanjf5TIS7PvrTESaqDKdz+NCCrQJHEcdL7H/iFobAcwv1wVTJCPnldbv
	xHm8jLDojXwrxJ5vVw1AuoI0w/ZBVQ==
X-Google-Smtp-Source: AGHT+IFJ1Z7TIe/cw66oWuzP5zk7tdlA5RhAtITdf0i5ke7NN9haVVrLyhsgZl5LKFwJ/C6phPrEpMG+gEZ2
X-Received: by 2002:a05:6602:3f92:b0:85e:5cbc:115 with SMTP id ca18e2360f4ac-8644f97cf29mr13547139f.1.1745441494510;
        Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f6a37d38e2sm517458173.2.2025.04.23.13.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 30907340159;
	Wed, 23 Apr 2025 14:51:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2B6FEE428D4; Wed, 23 Apr 2025 14:51:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] block: avoid hctx spinlock for plug with multiple queues
Date: Wed, 23 Apr 2025 14:51:27 -0600
Message-ID: <20250423205127.2976981-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250423205127.2976981-1-csander@purestorage.com>
References: <20250423205127.2976981-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_flush_plug_list() has a fast path if all requests in the plug
are destined for the same request_queue. It calls ->queue_rqs() with the
whole batch of requests, falling back on ->queue_rq() for any requests
not handled by ->queue_rqs(). However, if the requests are destined for
multiple queues, blk_mq_flush_plug_list() has a slow path that calls
blk_mq_dispatch_list() repeatedly to filter the requests by ctx/hctx.
Each queue's requests are inserted into the hctx's dispatch list under a
spinlock, then __blk_mq_sched_dispatch_requests() takes them out of the
dispatch list (taking the spinlock again), and finally
blk_mq_dispatch_rq_list() calls ->queue_rq() on each request.

Acquiring the hctx spinlock twice and calling ->queue_rq() instead of
->queue_rqs() makes the slow path significantly more expensive. Thus,
batching more requests into a single plug (e.g. io_uring_enter syscall)
can counterintuitively hurt performance by causing the plug to span
multiple queues. We have observed 2-3% of CPU time spent acquiring the
hctx spinlock alone on workloads issuing requests to multiple NVMe
devices in the same io_uring SQE batches.

Add a medium path in blk_mq_flush_plug_list() for plugs that don't have
elevators or come from a schedule, but do span multiple queues. Filter
the requests by queue and call ->queue_rqs()/->queue_rq() on the list of
requests destined to each request_queue.

With this change, we no longer see any CPU time spent in _raw_spin_lock
from blk_mq_flush_plug_list and throughput increases accordingly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-mq.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a777cb361ee3..f820c6c0cb1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2834,10 +2834,34 @@ static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
 	if (blk_queue_quiesced(q))
 		return;
 	q->mq_ops->queue_rqs(rqs);
 }
 
+static void blk_mq_extract_queue_requests(struct rq_list *rqs,
+					  struct rq_list *queue_rqs,
+					  unsigned *queue_depth)
+{
+	struct rq_list matched_rqs = {}, unmatched_rqs = {};
+	struct request *rq = rq_list_pop(rqs);
+	struct request_queue *this_q = rq->q;
+	unsigned depth = 1;
+
+	rq_list_add_tail(&matched_rqs, rq);
+	while ((rq = rq_list_pop(rqs))) {
+		if (rq->q == this_q) {
+			rq_list_add_tail(&matched_rqs, rq);
+			depth++;
+		} else {
+			rq_list_add_tail(&unmatched_rqs, rq);
+		}
+	}
+
+	*queue_rqs = matched_rqs;
+	*rqs = unmatched_rqs;
+	*queue_depth = depth;
+}
+
 static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
 {
 	struct request_queue *q = rq_list_peek(rqs)->q;
 
 	trace_block_unplug(q, depth, true);
@@ -2900,10 +2924,24 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
 	}
 	percpu_ref_put(&this_hctx->queue->q_usage_counter);
 }
 
+static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
+{
+	do {
+		struct rq_list queue_rqs;
+		unsigned depth;
+
+		blk_mq_extract_queue_requests(rqs, &queue_rqs, &depth);
+		blk_mq_dispatch_queue_requests(&queue_rqs, depth);
+		while (!rq_list_empty(&queue_rqs)) {
+			blk_mq_dispatch_list(&queue_rqs, false);
+		}
+	} while (!rq_list_empty(rqs));
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	unsigned int depth;
 
 	/*
@@ -2916,11 +2954,16 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	if (plug->rq_count == 0)
 		return;
 	depth = plug->rq_count;
 	plug->rq_count = 0;
 
-	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
+	if (!plug->has_elevator && !from_schedule) {
+		if (plug->multiple_queues) {
+			blk_mq_dispatch_multiple_queue_requests(&plug->mq_list);
+			return;
+		}
+
 		blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
 		if (rq_list_empty(&plug->mq_list))
 			return;
 	}
 
-- 
2.45.2


Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB11E5218
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745630261; cv=none; b=Og/CUjGoC4BtKUmhVTx+VipiJt+DryYrMwJi8fVsDr3rAQ7P7V4dUtWd++mFglTk9K5IS21syllgQtUMBWP88+QnWorx5H2t+vYLuIVD7ks1vq8sNQnR6Mk86o3TZUf2a3816rJzikB/3+ZHGAu5ypuOmFOCnhmN6OEnl4/xWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745630261; c=relaxed/simple;
	bh=QQIf5dt5C4yKuca2TMD3A9dUB9RNF6HldH2GRSGErzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjq8zcJJsAIddA2DmKdFw3R1ilEBXtbV+nvHMpApXU643LpjTvNsoCikybDmdDGRANQGsSzmKoHt8yRjG10EzLYtOhb+LHr/2IsDrCsJ8Z4vJj41zFMQDg9krUzLecEHufKqrcmIIlzn+B3Cl2cc9jWFZGiW84D4hyjD1I5vSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Tzdokmk2; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Tzdokmk2"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b01d8d976faso291758a12.0
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745630257; x=1746235057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDOGgOaE862gw8IvAer1t8eUgpK99QL0J22I9Usktk8=;
        b=Tzdokmk2fZmXkfk6/EzQojCGgAOfMg8h3Tm1vt8RF/fM0rByjpYuJUEV3gnvACUUUX
         coyTZqPQ1tHL+beoTQrpB6hjX+0+fV/koRScAKiXM4d4coR+EdDB+Q2GhzLNY5N3u5Xz
         w6Ruzx5IHYZykWLZx2IaBi6En3JXjk6svDVsEs45HlFznzDtR7VPg6gex1hU9jghQzFi
         TF1jy0q6O8A8sr2dEyGfYiEL0SlbB1wPQENMKTsQgdtUMFANPX/93gAUHm0S4QNn3Rjf
         QD20+atL7380cicBAeK0QbnNnpNReyeH/jntmh7MuWokLXw3MRsI5NCcp94huAHNpog8
         8taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745630257; x=1746235057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDOGgOaE862gw8IvAer1t8eUgpK99QL0J22I9Usktk8=;
        b=KdycfJkd5Tpm9En0Yd4Ku7L+iYSi+lTNHeci3rES476WGr6TJU9cI8KsA1+SDljm8+
         ZxtdPpHnGu82QlfXZkbeUJtlQJWD0Nt7XuSOoUPgknM365j5Nc4jc4LPOMtL5OSr/NVI
         Kz1dR/pCcx9Glk6lK8orgpgUxP55mUFgJ9oQcColrqOIl7fK/bAjtmX93Bfu34QNd29Q
         TznOOei0bJ/2wVYNY5tJQGrVjF5pWBPS05Bt0pxkwrgspZuLbd7bSHNtIqqOj4yJYeks
         DbtwMP3LdatTlj7yNVrc92syrTqla7yKDXYWsD/MOzHK4ialLt+uvPjT7QGVBfzHSTjJ
         RJDg==
X-Forwarded-Encrypted: i=1; AJvYcCXWHlCUh3jDYqg8//XcpLxq0W3120LWP+1gvce07jW+GQekZ1+wDA2H+rps96JIGw4238w2HiiqrxmizQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0IgF09Vpn7Ld/qlw9e8PxfM7Nb/2VJJNjV3EteicDRE24Wq2
	kMDN+3YyjXKY0nvspmZB+u4khJfmBgyhmHSRv460FfuilnBF7Pd/MfsIRhfjDD7GWKy/D2ZaYau
	nf0wKmEntnylZwTNcR+VeIA75qVwons2Q
X-Gm-Gg: ASbGncsCQHY3J+YMCy3zrlEGjV4Zd57Kf0wRa7c/dv14BMOgh+WbZ/6wRyo0DdH2Vzi
	8mOYdfr34YSrjI1qwRSB9E/MBYFzwrDvCcpjYahK9tgSnFuhGFtDKJnQntw/bFPzxQyBNeqcGO3
	65m1kUHc1RyX4KbUCVJDu9TmtvE3RgvFTfy1DPtQcjuK5KCJ8XCJe+TYLvQwN5+wGfi4f0acllU
	V0hVR67vWgL+qI6zOBVDB/NJi6Ts8uCub9XAuisvLOMAoCGLcdtfA5QpM71RvRyfs9uD/vuXgFY
	XGIJNJ1C4yKhgBqyPAuf1AsIZMWp4XRirdu7jmzhwicP
X-Google-Smtp-Source: AGHT+IHIcd1tqHI1KIxaEgnbnwUpZRHCpkBOTlnpeQ8YbWZyA6eMovZB4O6abyU4KRtb1kWf6EN+do9p179s
X-Received: by 2002:a17:90b:4a4e:b0:301:ba2b:3bc6 with SMTP id 98e67ed59e1d1-309f7ec261bmr2333968a91.7.1745630257186;
        Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-309f7820838sm150265a91.12.2025.04.25.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 96A1F3402A4;
	Fri, 25 Apr 2025 19:17:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 94516E41BE9; Fri, 25 Apr 2025 19:17:36 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] block: avoid hctx spinlock for plug with multiple queues
Date: Fri, 25 Apr 2025 19:17:28 -0600
Message-ID: <20250426011728.4189119-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250426011728.4189119-1-csander@purestorage.com>
References: <20250426011728.4189119-1-csander@purestorage.com>
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
 block/blk-mq.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a777cb361ee3..d39e144863da 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2834,10 +2834,39 @@ static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
 	if (blk_queue_quiesced(q))
 		return;
 	q->mq_ops->queue_rqs(rqs);
 }
 
+static unsigned blk_mq_extract_queue_requests(struct rq_list *rqs,
+					      struct rq_list *queue_rqs)
+{
+	struct request *rq = rq_list_pop(rqs);
+	struct request_queue *this_q = rq->q;
+	struct request **prev = &rqs->head;
+	struct rq_list matched_rqs = {};
+	struct request *last = NULL;
+	unsigned depth = 1;
+
+	rq_list_add_tail(&matched_rqs, rq);
+	while ((rq = *prev)) {
+		if (rq->q == this_q) {
+			/* move rq from rqs to matched_rqs */
+			*prev = rq->rq_next;
+			rq_list_add_tail(&matched_rqs, rq);
+			depth++;
+		} else {
+			/* leave rq in rqs */
+			prev = &rq->rq_next;
+			last = rq;
+		}
+	}
+
+	rqs->tail = last;
+	*queue_rqs = matched_rqs;
+	return depth;
+}
+
 static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
 {
 	struct request_queue *q = rq_list_peek(rqs)->q;
 
 	trace_block_unplug(q, depth, true);
@@ -2900,10 +2929,23 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
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
+		depth = blk_mq_extract_queue_requests(rqs, &queue_rqs);
+		blk_mq_dispatch_queue_requests(&queue_rqs, depth);
+		while (!rq_list_empty(&queue_rqs))
+			blk_mq_dispatch_list(&queue_rqs, false);
+	} while (!rq_list_empty(rqs));
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	unsigned int depth;
 
 	/*
@@ -2916,11 +2958,16 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
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


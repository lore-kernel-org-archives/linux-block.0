Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7F55C22
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706176; cv=none; b=YUSw25hhApoftVUOL1dAcLk0u3z1zaYYX+dr0vq0dDRv3rbmwhqzase9+dT/1YDmeRu4M9JUXGQRPBZq6wJXoaP+RD5j3BBCHtH91KAKOdjTRA2TTWOziyNjcUY5I+lebpYbiVtJGyLiEI14LYO+d475V/OtHH5wNfibFzTkhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706176; c=relaxed/simple;
	bh=GlPjxt3oj3BCCrPdSwMzmZjkBTC6jApYyuTYdBu3kEw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=mjp2k7HnJ34juZMEl5Iq4CtBZ3L0BSR1W6ZYWzbEVgAE8ImM14Dx4cEltxMNtL3T1V+V0yXh9yqS1tv3xl2DIJgKOCCKiTzsxNijYSh002VbCh7Zt8rN/vI/ZgXuAS9bbSPPLzR9djHYT1qLhxHj9G/h4ddXIqcbBqkNINVOb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1071906a12.2
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 15:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705706174; x=1706310974;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVtmkr90fpy4zVWdxYbnku08a/HtTrO3xQec9mdd3RA=;
        b=Ao0XSCAwOX3IgvmZsk9STWMfkyTOLBAY1Xr4YaE3BPTKsgMiw75kCdLGLYOsXH+AUg
         ssux8ps9Q3QEpXfFNg/O8HuGBkcAJSGXVdcyoUCo8eT39yAbiyG51p2Q0wr2WbmVbxy8
         o0dgw6zWNA2K62mLtKzUbZ5TrjC7sEYTEQf5JqLN2Zjlp9X4vwCIJplwRoBe3UBsRMIV
         Uvk456X1Hy2LHd9tY4rAiaHNwFrTmc6dN4gHUDlyeK+lZgr9WnTmWczS3JFhfBMvMjWa
         vUhFAkm0Q6+ee0M9jft3OD03qldM8kf00OWfaEGBLgveCRr9CYRk9ne2QzoV2yIBK40f
         ajcA==
X-Gm-Message-State: AOJu0Yy9PRIakhil2kKOREpNOzGUv4MJUGI13Uxtzaq+aH2mVNViTUzG
	EU47EeF9JGpG1vwtq7Rq0NVfzOKUsHiDcIvlJ+/9Y3dkhyxFFC3SUMV1Zp05
X-Google-Smtp-Source: AGHT+IHZByHq/VvwznORm0d0gpc6+6/kpcPgGBjARYt6ifZPDthBQlFGCXFFjoD4fHGhhOtu7OpYNA==
X-Received: by 2002:a17:90b:1909:b0:28e:76f6:93fa with SMTP id mp9-20020a17090b190900b0028e76f693famr441213pjb.75.1705706173922;
        Fri, 19 Jan 2024 15:16:13 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4855:2a4:21e0:417? ([2620:0:1000:8411:4855:2a4:21e0:417])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090aba9100b0028d02231727sm4608610pjr.18.2024.01.19.15.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:16:13 -0800 (PST)
Message-ID: <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
Date: Fri, 19 Jan 2024 15:16:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-4-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20240119160338.1191281-4-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 08:02, Jens Axboe wrote:
> If we attempt to insert a list of requests, but someone else is already
> running an insertion, then fallback to queueing that list internally and
> let the existing inserter finish the operation. The current inserter
> will either see and flush this list, of if it ends before we're done
> doing our bucket insert, then we'll flush it and insert ourselves.
> 
> This reduces contention on the dd->lock, which protects any request
> insertion or dispatch, by having a backup point to insert into which
> will either be flushed immediately or by an existing inserter. As the
> alternative is to just keep spinning on the dd->lock, it's very easy
> to get into a situation where multiple processes are trying to do IO
> and all sit and spin on this lock.

With this alternative patch I achieve 20% higher IOPS than with patch
3/4 of this series for 1..4 CPU cores (null_blk + fio in an x86 VM):

---
  block/mq-deadline.c | 61 ++++++++++++++++++++++++++++++++++++---------
  1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 83bc21801226..fd9038a84dc5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -89,11 +89,15 @@ struct deadline_data {
  	 */
  	struct {
  		spinlock_t lock;
+		spinlock_t insert_lock;
  		spinlock_t zone_lock;
  	} ____cacheline_aligned_in_smp;

  	unsigned long run_state;

+	struct list_head at_head;
+	struct list_head at_tail;
+
  	struct dd_per_prio per_prio[DD_PRIO_COUNT];

  	/* Data direction of latest dispatched request. */
@@ -120,6 +124,9 @@ static const enum dd_prio ioprio_class_to_prio[] = {
  	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
  };

+static void dd_insert_request(struct request_queue *q, struct request *rq,
+			      blk_insert_t flags, struct list_head *free);
+
  static inline struct rb_root *
  deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
  {
@@ -592,6 +599,30 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
  	return NULL;
  }

+static void dd_do_insert(struct request_queue *q, struct list_head *free)
+{
+	struct deadline_data *dd = q->elevator->elevator_data;
+	struct request *rq;
+	LIST_HEAD(at_head);
+	LIST_HEAD(at_tail);
+
+	spin_lock(&dd->insert_lock);
+	list_splice_init(&dd->at_head, &at_head);
+	list_splice_init(&dd->at_tail, &at_tail);
+	spin_unlock(&dd->insert_lock);
+
+	while (!list_empty(&at_head)) {
+		rq = list_first_entry(&at_head, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_insert_request(q, rq, BLK_MQ_INSERT_AT_HEAD, free);
+	}
+	while (!list_empty(&at_tail)) {
+		rq = list_first_entry(&at_tail, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_insert_request(q, rq, 0, free);
+	}
+}
+
  /*
   * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
   *
@@ -606,6 +637,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  	const unsigned long now = jiffies;
  	struct request *rq;
  	enum dd_prio prio;
+	LIST_HEAD(free);

  	/*
  	 * If someone else is already dispatching, skip this one. This will
@@ -620,6 +652,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  		return NULL;

  	spin_lock(&dd->lock);
+	dd_do_insert(hctx->queue, &free);
  	rq = dd_dispatch_prio_aged_requests(dd, now);
  	if (rq)
  		goto unlock;
@@ -638,6 +671,8 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  	clear_bit(DD_DISPATCHING, &dd->run_state);
  	spin_unlock(&dd->lock);

+	blk_mq_free_requests(&free);
+
  	return rq;
  }

@@ -727,8 +762,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
  	eq->elevator_data = dd;

  	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->insert_lock);
  	spin_lock_init(&dd->zone_lock);

+	INIT_LIST_HEAD(&dd->at_head);
+	INIT_LIST_HEAD(&dd->at_tail);
+
  	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
  		struct dd_per_prio *per_prio = &dd->per_prio[prio];

@@ -899,19 +938,13 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
  {
  	struct request_queue *q = hctx->queue;
  	struct deadline_data *dd = q->elevator->elevator_data;
-	LIST_HEAD(free);
-
-	spin_lock(&dd->lock);
-	while (!list_empty(list)) {
-		struct request *rq;

-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(q, rq, flags, &free);
-	}
-	spin_unlock(&dd->lock);
-
-	blk_mq_free_requests(&free);
+	spin_lock(&dd->insert_lock);
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
+		list_splice_init(list, &dd->at_head);
+	else
+		list_splice_init(list, &dd->at_tail);
+	spin_unlock(&dd->insert_lock);
  }

  /* Callback from inside blk_mq_rq_ctx_init(). */
@@ -990,6 +1023,10 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
  	enum dd_prio prio;

+	if (!list_empty_careful(&dd->at_head) ||
+	    !list_empty_careful(&dd->at_tail))
+		return true;
+
  	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
  		if (dd_has_work_for_prio(&dd->per_prio[prio]))
  			return true;

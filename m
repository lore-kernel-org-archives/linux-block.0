Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805E170F
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 16:03:16 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so973678b3a.1
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 16:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993795; x=1702598595;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP4GxbcJ12H/cOdm2zMa4WNoTzlTjZACWAACzj4Rsb8=;
        b=f4Z9f7ieCcrfAC+VfozhjpvyXxaRM0xsSYvqaCEnWJGm5QljpyHQX1OeBRgf7Gprhb
         HfYcJ+LTrk8SDN8nYxLGyNGenj2wAYktB+xpR0EEpjF458VMr3t6mUjnrqRcLsQ2lpDo
         1zmAMXwyEzsARwz73wu4l0XsT55skzQz30N66NpsFuvjBfzphq4m/sF56p2yDNJogowS
         h5wmLYISjAFK7ACXo/HuUWAzcbUd13c5QjYEX7C2ywdgrqcWVCzel0IEG4S9pxHNZvLS
         897H3RwUTdg157E7IVO6eTSB/G1k33yT86CO3nUCTXQbq0A6vmsccT7zsABRHERmby1v
         367g==
X-Gm-Message-State: AOJu0YyPQdh9pAEjzng8vtkko3+VRWqP7gYffr8THU+X41BcIRRQP0p2
	+Gkv6Bd3MQ5Js7F29HdVJMHd6cRmySQ=
X-Google-Smtp-Source: AGHT+IG2OkJ4CYLDYJcMcyjG2t/PcRhuZQT5yfA2eBJ+TglVVSiDHVw3YY59VcGgJJBs6Rw/Bc+hBw==
X-Received: by 2002:a05:6a20:ce93:b0:18f:e2c9:9751 with SMTP id if19-20020a056a20ce9300b0018fe2c99751mr34498pzb.19.1701993795256;
        Thu, 07 Dec 2023 16:03:15 -0800 (PST)
Received: from [172.22.37.189] (076-081-102-005.biz.spectrum.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b006c988fda657sm359269pfa.177.2023.12.07.16.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 16:03:14 -0800 (PST)
Message-ID: <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
Date: Thu, 7 Dec 2023 14:03:13 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
Content-Language: en-US
In-Reply-To: <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 16:42, Damien Le Moal wrote:
> ... when prio_aging_expire is set to 0. Right ? Otherwise, the sentence above
> reads as if you are disabling IO priority for zoned devices...

Hi Damien,

I just noticed that I posted an old version of this patch (3/3). In the patch
below I/O priorities are ignored for zoned writes.

Thanks,

Bart.


Subject: [PATCH] block/mq-deadline: Disable I/O prioritization in certain cases

Fix the following two issues:
- Even with prio_aging_expire set to zero, I/O priorities still affect the
   request order.
- Assigning I/O priorities with the ioprio cgroup policy breaks zoned
   storage support in the mq-deadline scheduler.

This patch fixes both issues by disabling I/O prioritization for these
two cases.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/mq-deadline.c | 37 ++++++++++++++++++++++++-------------
  1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index fe5da2ade953..310ff133ce20 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -119,18 +119,27 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
  	return &per_prio->sort_list[rq_data_dir(rq)];
  }

+static bool dd_use_io_priority(struct deadline_data *dd, enum req_op op)
+{
+	return dd->prio_aging_expire != 0 && !op_needs_zoned_write_locking(op);
+}
+
  /*
   * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
   * request.
   */
-static u8 dd_rq_ioclass(struct request *rq)
+static u8 dd_rq_ioclass(struct deadline_data *dd, struct request *rq)
  {
-	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
+	if (dd_use_io_priority(dd, req_op(rq)))
+		return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
+	return IOPRIO_CLASS_NONE;
  }

-static u8 dd_bio_ioclass(struct bio *bio)
+static u8 dd_bio_ioclass(struct deadline_data *dd, struct bio *bio)
  {
-	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	if (dd_use_io_priority(dd, bio_op(bio)))
+		return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	return IOPRIO_CLASS_NONE;
  }

  /*
@@ -233,7 +242,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
  			      enum elv_merge type)
  {
  	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
+	const u8 ioprio_class = dd_rq_ioclass(dd, req);
  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
  	struct dd_per_prio *per_prio = &dd->per_prio[prio];

@@ -253,7 +262,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
  			       struct request *next)
  {
  	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
+	const u8 ioprio_class = dd_rq_ioclass(dd, next);
  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];

  	lockdep_assert_held(&dd->lock);
@@ -550,7 +559,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
  	dd->batching++;
  	deadline_move_request(dd, per_prio, rq);
  done:
-	ioprio_class = dd_rq_ioclass(rq);
+	ioprio_class = dd_rq_ioclass(dd, rq);
  	prio = ioprio_class_to_prio[ioprio_class];
  	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
  	dd->per_prio[prio].stats.dispatched++;
@@ -606,9 +615,11 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  	enum dd_prio prio;

  	spin_lock(&dd->lock);
-	rq = dd_dispatch_prio_aged_requests(dd, now);
-	if (rq)
-		goto unlock;
+	if (dd->prio_aging_expire != 0) {
+		rq = dd_dispatch_prio_aged_requests(dd, now);
+		if (rq)
+			goto unlock;
+	}

  	/*
  	 * Next, dispatch requests in priority order. Ignore lower priority
@@ -749,7 +760,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
  			    struct bio *bio)
  {
  	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_bio_ioclass(bio);
+	const u8 ioprio_class = dd_bio_ioclass(dd, bio);
  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
  	sector_t sector = bio_end_sector(bio);
@@ -814,7 +825,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  	 */
  	blk_req_zone_write_unlock(rq);

-	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
+	prio = ioprio_class_to_prio[dd_rq_ioclass(dd, rq)];
  	per_prio = &dd->per_prio[prio];
  	if (!rq->elv.priv[0]) {
  		per_prio->stats.inserted++;
@@ -923,7 +934,7 @@ static void dd_finish_request(struct request *rq)
  {
  	struct request_queue *q = rq->q;
  	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
+	const u8 ioprio_class = dd_rq_ioclass(dd, rq);
  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
  	struct dd_per_prio *per_prio = &dd->per_prio[prio];



Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79DD10F
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 21:32:35 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cfabcbda7bso26928965ad.0
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 21:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701754355; x=1702359155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjbZkv80aDx60HkZ6B1AvjqTEYjhY0/sLArGOw6uMtk=;
        b=WzPvzZeWMIentYv+0WVJ60uCG6rS6Q+Gb0ZW69ZfkHHNCv5kcfiOJMtaxxsZosLWvg
         uH2AwvkqseA9AeQGRulfh2sr0y25Fip8JFVIO+TFgOu+cxVrzC3ssNFm8+fGWqbDR2o5
         XBRcJMoHPpDAIjfBu7z7lPHhiTDQ8p7aTtAQ71Ta83Dpdf5yyj3KzsD/13hnuwYb2ge1
         1Tq+PsHc+11rvEgxnb3j8HduaUzWMr2wMhwl7DHgM1FHunrESdnP44r1mo2LXcZ4mB/N
         AwDDyJabCuKqCacfaTPwbWt3mT8gR5bX0n3efMxZcFgGKeEbjznsOV4zRH/bMgevogXu
         3VlA==
X-Gm-Message-State: AOJu0YzGstwQge6tIWYu7Xvfrr0VBVXJF9GF6dYp/ZAPvaaRvZMrD58X
	NyFDDO3FRIiy9LX4wM28LoM=
X-Google-Smtp-Source: AGHT+IGjxJ8LpW5ouLrRH+uTvBN5R+xucl7OdDRC84RdVSpM+DQFYRWYHvvZbz1Q8S+a+1zcd7e1KQ==
X-Received: by 2002:a17:902:7481:b0:1d0:6ffd:6103 with SMTP id h1-20020a170902748100b001d06ffd6103mr1115695pll.37.1701754355080;
        Mon, 04 Dec 2023 21:32:35 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d30d00b001cfcc10491fsm1145375plc.161.2023.12.04.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:32:34 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in certain cases
Date: Mon,  4 Dec 2023 21:32:13 -0800
Message-ID: <20231205053213.522772-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231205053213.522772-1-bvanassche@acm.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 block/mq-deadline.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index fe5da2ade953..6781cef0109e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -123,14 +123,16 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
  * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
  * request.
  */
-static u8 dd_rq_ioclass(struct request *rq)
+static u8 dd_rq_ioclass(struct deadline_data *dd, struct request *rq)
 {
-	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
+	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(req_get_ioprio(rq)) :
+				       IOPRIO_CLASS_NONE;
 }
 
-static u8 dd_bio_ioclass(struct bio *bio)
+static u8 dd_bio_ioclass(struct deadline_data *dd, struct bio *bio)
 {
-	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(bio->bi_ioprio) :
+				       IOPRIO_CLASS_NONE;
 }
 
 /*
@@ -233,7 +235,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
+	const u8 ioprio_class = dd_rq_ioclass(dd, req);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -253,7 +255,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
+	const u8 ioprio_class = dd_rq_ioclass(dd, next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
 	lockdep_assert_held(&dd->lock);
@@ -550,7 +552,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
-	ioprio_class = dd_rq_ioclass(rq);
+	ioprio_class = dd_rq_ioclass(dd, rq);
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
 	dd->per_prio[prio].stats.dispatched++;
@@ -749,7 +751,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 			    struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_bio_ioclass(bio);
+	const u8 ioprio_class = dd_bio_ioclass(dd, bio);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
@@ -814,7 +816,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
+	prio = ioprio_class_to_prio[dd_rq_ioclass(dd, rq)];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
@@ -923,7 +925,7 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
+	const u8 ioprio_class = dd_rq_ioclass(dd, rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 

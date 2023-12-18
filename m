Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855587408D
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5913922ab10so2294808eaf.1
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 13:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934058; x=1703538858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/IgCh6hFZVSZ9VmGW8j+wPURodjNiyEfdjlu8brBDE=;
        b=Mt167EEA6bz4BK9Al/69LNz5JyX/EjoMeeVixoiPnsZ4sk341yXjajDRLfUwaazVAd
         Rd/y8Z+FiOikvklew6Cyt2gu0bnhIKHZXzwjFDUSgFM1maQM46Dl87LpJgURcqTFjYVa
         gFtBptosztD1uwsGmwPE496FQeo912atwgKqUqvPF2IOMD14eZmM9Fjc15SORmaZNfq2
         QvK7wqL2yWxiTzAyAvxqlevGe51h3KsgzPtc7Sy+p7pXBNTrHG+TvFxtUj6VEl/S68zq
         AYsaCT6S6s3h4IOL/Cylj4Z7ZyUyTo9VoMUze7niXSwM+jHR+FkvDgnAmHac1CBs7Mg7
         xRiQ==
X-Gm-Message-State: AOJu0YzkYNQUcV6TwJt5Om7UQat27XDBC0NxMx0eFfN0QZvdNjGzyP8Q
	6J/SR2/VTDqKR2qc8caFooc=
X-Google-Smtp-Source: AGHT+IHa+HNPAbjd2hPI55BcDUh9mC2onuwErgKNN5Tl/YdMKWNCDDV0Qw2eTbUZO5ziawaTa7F1jw==
X-Received: by 2002:a05:6359:2c43:b0:170:2c52:2b4d with SMTP id qv3-20020a0563592c4300b001702c522b4dmr8767596rwb.19.1702934058280;
        Mon, 18 Dec 2023 13:14:18 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b006c320b9897fsm3371497pfo.126.2023.12.18.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:14:17 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write reordering due to I/O prioritization
Date: Mon, 18 Dec 2023 13:13:42 -0800
Message-ID: <20231218211342.2179689-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218211342.2179689-1-bvanassche@acm.org>
References: <20231218211342.2179689-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning I/O priorities with the ioprio cgroup policy may cause
different I/O priorities to be assigned to write requests for the same
zone. Prevent that this causes unaligned write errors by adding zoned
writes for the same zone in the same priority queue as prior zoned
writes.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig.iosched    |   5 ++
 block/mq-deadline.c      |  81 +++++++++++++++---
 block/mq-deadline_test.c | 175 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h   |  17 ++++
 4 files changed, 268 insertions(+), 10 deletions(-)
 create mode 100644 block/mq-deadline_test.c

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 27f11320b8d1..3e2fcbdbac65 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -7,6 +7,11 @@ config MQ_IOSCHED_DEADLINE
 	help
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_DEADLINE_TEST
+	tristate "MQ deadline unit tests" if !KUNIT_ALL_TESTS
+	depends on MQ_IOSCHED_DEADLINE && KUNIT
+	default KUNIT_ALL_TESTS
+
 config MQ_IOSCHED_KYBER
 	tristate "Kyber I/O scheduler"
 	default y
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index c0f92cc729ca..d1d54cac4c37 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -46,6 +46,8 @@ enum dd_data_dir {
 enum { DD_DIR_COUNT = 2 };
 
 enum dd_prio {
+	DD_INVALID_PRIO	= -1,
+	DD_PRIO_MIN	= 0,
 	DD_RT_PRIO	= 0,
 	DD_BE_PRIO	= 1,
 	DD_IDLE_PRIO	= 2,
@@ -113,6 +115,12 @@ static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
 };
 
+static const u8 prio_to_ioprio_class[] = {
+	[DD_RT_PRIO]	= IOPRIO_CLASS_RT,
+	[DD_BE_PRIO]	= IOPRIO_CLASS_BE,
+	[DD_IDLE_PRIO]	= IOPRIO_CLASS_IDLE,
+};
+
 static inline struct rb_root *
 deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
 {
@@ -194,18 +202,67 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	return deadline_first_rq_past_pos(per_prio, data_dir, pos);
 }
 
+/*
+ * If any sequential write requests are pending for the zone containing @pos,
+ * return the I/O priority for these write requests.
+ */
+static enum dd_prio dd_zone_prio(struct deadline_data *dd,
+				 struct block_device *bdev, sector_t pos)
+{
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct gendisk *disk = bdev->bd_disk;
+	const unsigned int zno = disk_zone_no(disk, pos);
+	enum dd_prio prio;
+
+	pos -= bdev_offset_from_zone_start(bdev, pos);
+	for (prio = DD_PRIO_MIN; prio <= DD_PRIO_MAX; prio++) {
+		struct dd_per_prio *per_prio = &dd->per_prio[prio];
+		struct request *rq;
+
+		rq = deadline_first_rq_past_pos(per_prio, DD_WRITE, pos);
+		while (rq && blk_rq_zone_no(rq) == zno) {
+			struct rb_node *node;
+
+			if (blk_rq_is_seq_zoned_write(rq))
+				return prio;
+			node = rb_next(&rq->rb_node);
+			if (!node)
+				break;
+			rq = rb_entry_rq(node);
+		}
+	}
+#endif
+	return DD_INVALID_PRIO;
+}
+
 /*
  * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
  * request.
  */
-static enum dd_prio dd_rq_ioprio(struct request *rq)
+static enum dd_prio dd_rq_ioprio(struct deadline_data *dd, struct request *rq)
 {
-	return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(req_get_ioprio(rq))];
+	enum dd_prio prio;
+
+	if (!blk_rq_is_seq_zoned_write(rq) || !rq->bio)
+		return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(
+			req_get_ioprio(rq))];
+	prio = dd_zone_prio(dd, rq->q->disk->part0, blk_rq_pos(rq));
+	if (prio == DD_INVALID_PRIO)
+		return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(
+			req_get_ioprio(rq))];
+	return prio;
 }
 
-static enum dd_prio dd_bio_ioprio(struct bio *bio)
+static enum dd_prio dd_bio_ioprio(struct deadline_data *dd, struct bio *bio)
 {
-	return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(bio->bi_ioprio)];
+	enum dd_prio prio;
+
+	if (!blk_bio_is_seq_zoned_write(bio))
+		return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(bio->bi_ioprio)];
+	prio = dd_zone_prio(dd, bio->bi_bdev, bio->bi_iter.bi_sector);
+	if (prio == DD_INVALID_PRIO)
+		return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(bio->bi_ioprio)];
+	return prio;
 }
 
 static void
@@ -246,7 +303,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const enum dd_prio prio = dd_rq_ioprio(req);
+	const enum dd_prio prio = dd_rq_ioprio(dd, req);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	/*
@@ -265,7 +322,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const enum dd_prio prio = dd_rq_ioprio(next);
+	const enum dd_prio prio = dd_rq_ioprio(dd, next);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -560,7 +617,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
-	prio = dd_rq_ioprio(rq);
+	prio = dd_rq_ioprio(dd, rq);
 	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
 	dd->per_prio[prio].stats.dispatched++;
 	/*
@@ -758,7 +815,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 			    struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const enum dd_prio prio = dd_bio_ioprio(bio);
+	const enum dd_prio prio = dd_bio_ioprio(dd, bio);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
 	struct request *__rq;
@@ -822,7 +879,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	prio = dd_rq_ioprio(rq);
+	prio = dd_rq_ioprio(dd, rq);
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
@@ -931,7 +988,7 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const enum dd_prio prio = dd_rq_ioprio(rq);
+	const enum dd_prio prio = dd_rq_ioprio(dd, rq);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	/*
@@ -1282,6 +1339,10 @@ static struct elevator_type mq_deadline = {
 };
 MODULE_ALIAS("mq-deadline-iosched");
 
+#ifdef CONFIG_MQ_IOSCHED_DEADLINE_TEST
+#include "mq-deadline_test.c"
+#endif
+
 static int __init deadline_init(void)
 {
 	return elv_register(&mq_deadline);
diff --git a/block/mq-deadline_test.c b/block/mq-deadline_test.c
new file mode 100644
index 000000000000..72bec6fd5f7a
--- /dev/null
+++ b/block/mq-deadline_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Google LLC
+ */
+#include <kunit/test.h>
+#include <linux/cleanup.h>
+
+static void test_ioprio(struct kunit *test)
+{
+	static struct block_device bdev;
+	static struct gendisk disk = { .part0 = &bdev };
+	static struct request_queue queue = { .disk = &disk };
+	static struct blk_mq_hw_ctx hctx = { .queue = &queue };
+	static struct bio bio1 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_IDLE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq1 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 1,
+				      .__data_len = 1,
+				      .bio = &bio1,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_IDLE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct bio bio2 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_BE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq2 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 3,
+				      .__data_len = 1,
+				      .bio = &bio2,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_BE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct bio bio3 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_RT
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq3 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 5,
+				      .__data_len = 1,
+				      .bio = &bio3,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_RT
+						<< IOPRIO_CLASS_SHIFT };
+	struct request *rq;
+	static LIST_HEAD(rq_list);
+
+	bdev.bd_disk = &disk;
+	bdev.bd_queue = &queue;
+	disk.queue = &queue;
+
+	dd_init_sched(&queue, &mq_deadline);
+	dd_prepare_request(&rq1);
+	dd_prepare_request(&rq2);
+	dd_prepare_request(&rq3);
+	list_add_tail(&rq1.queuelist, &rq_list);
+	list_add_tail(&rq2.queuelist, &rq_list);
+	list_add_tail(&rq3.queuelist, &rq_list);
+	dd_insert_requests(&hctx, &rq_list, false);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq3);
+	dd_finish_request(rq);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq2);
+	dd_finish_request(rq);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq1);
+	dd_finish_request(rq);
+	dd_exit_sched(queue.elevator);
+}
+
+/*
+ * Test that the write order is preserved if a higher I/O priority is assigned
+ * to higher LBAs. This test fails if dd_zone_prio() always returns
+ * DD_INVALID_PRIO.
+ */
+static void test_zone_prio(struct kunit *test)
+{
+	static struct block_device bdev;
+	static unsigned long seq_zones_wlock[1];
+	static struct gendisk disk = { .conv_zones_bitmap = NULL,
+				       .seq_zones_wlock = seq_zones_wlock,
+				       .part0 = &bdev };
+	static struct request_queue queue = {
+		.disk = &disk,
+		.limits = { .zoned = BLK_ZONED_HM, .chunk_sectors = 16 }
+	};
+	static struct blk_mq_hw_ctx hctx = { .queue = &queue };
+	static struct bio bio1 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_IDLE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq1 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 1,
+				      .__data_len = 1,
+				      .bio = &bio1,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_IDLE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct bio bio2 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_BE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq2 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 3,
+				      .__data_len = 1,
+				      .bio = &bio2,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_BE
+						<< IOPRIO_CLASS_SHIFT };
+	static struct bio bio3 = { .bi_bdev = &bdev,
+				   .bi_opf = REQ_OP_WRITE,
+				   .bi_ioprio = IOPRIO_CLASS_RT
+						<< IOPRIO_CLASS_SHIFT };
+	static struct request rq3 = { .q = &queue,
+				      .cmd_flags = REQ_OP_WRITE,
+				      .__sector = 5,
+				      .__data_len = 1,
+				      .bio = &bio3,
+				      .mq_hctx = &hctx,
+				      .ioprio = IOPRIO_CLASS_RT
+						<< IOPRIO_CLASS_SHIFT };
+	struct request *rq;
+	static LIST_HEAD(rq_list);
+
+	bdev.bd_disk = &disk;
+	bdev.bd_queue = &queue;
+	disk.queue = &queue;
+
+	KUNIT_EXPECT_TRUE(test, blk_rq_is_seq_zoned_write(&rq1));
+	KUNIT_EXPECT_TRUE(test, blk_rq_is_seq_zoned_write(&rq2));
+	KUNIT_EXPECT_TRUE(test, blk_rq_is_seq_zoned_write(&rq3));
+
+	dd_init_sched(&queue, &mq_deadline);
+	dd_prepare_request(&rq1);
+	dd_prepare_request(&rq2);
+	dd_prepare_request(&rq3);
+	list_add_tail(&rq1.queuelist, &rq_list);
+	list_add_tail(&rq2.queuelist, &rq_list);
+	list_add_tail(&rq3.queuelist, &rq_list);
+	dd_insert_requests(&hctx, &rq_list, false);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq1);
+	dd_finish_request(rq);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq2);
+	dd_finish_request(rq);
+	rq = dd_dispatch_request(&hctx);
+	KUNIT_EXPECT_PTR_EQ(test, rq, &rq3);
+	dd_finish_request(rq);
+	dd_exit_sched(queue.elevator);
+}
+
+static struct kunit_case mq_deadline_test_cases[] = {
+	KUNIT_CASE(test_ioprio),
+	KUNIT_CASE(test_zone_prio),
+	{}
+};
+
+static struct kunit_suite mq_deadline_test_suite = {
+	.name = "mq-deadline",
+	.test_cases = mq_deadline_test_cases,
+};
+kunit_test_suite(mq_deadline_test_suite);
+
+MODULE_DESCRIPTION("mq-deadline unit tests");
+MODULE_AUTHOR("Bart Van Assche");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..e7fa81170b7c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1149,6 +1149,18 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
 	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
 }
 
+/**
+ * blk_bio_is_seq_zoned_write() - Check if @bio requires write serialization.
+ * @bio: Bio to examine.
+ *
+ * Note: REQ_OP_ZONE_APPEND bios do not require serialization.
+ */
+static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
+{
+	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector) &&
+		op_needs_zoned_write_locking(bio_op(bio));
+}
+
 static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 {
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
@@ -1196,6 +1208,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
+{
+	return false;
+}
+
 static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
 {
 	return false;

Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C491C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861720866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZpwhSNUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEAE2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEAE2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556684928; x=1588220928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSq+1lyoS/wueGzOeesF0ImsRClD+zEbR3R7t42OLQk=;
  b=ZpwhSNUfv4d9DvuQAKlod6Dt20Y0nRM9L9X1jD3pKjnTJoOLm1AUkokV
   lQh+NhhmtDOytof0UfoqUBiAv9xQ91ZKkEIUT5ar/Bi+OMdIi4VlYEjuh
   qzSThbbzLTtAL4Ar0zSCVL6xlryoBBoXRD6IOHV7mKO4im77WyxgAP/s4
   QyL0M9vvUdBei9zlkRKMaku4j61qbi6DWQUW3K1Z14lljpz4b+rnF/MOr
   Yw2GDgTcscCJ0l4kQ3VNNHZgTLnZ3tUYGG+m0dJJB0S9IRS1DJH6zHJji
   S7+Y5TwzgvvGV1CzdmF14wnS4iIK/NQ9QE49ZQP+wxqJBIIbih9kvpGJN
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="108436746"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:28:48 +0800
IronPort-SDR: riRFJ3VEBxZPcsGli9FhDKw4k1gfaOrMDb+X3RMKdVWzYn1+t5yYqI+KHL1AHxM+tAoGxw0U6W
 Rmch6eutIIQtCAC1Mg8ye5rGtku2J4Ckq2WkaHuVDaNnICXXEay/E5yPmOwv+3T1Fsq1Qmquq6
 8VAzjUnX1Qv6WQ7QsCR1O85swv1j9jwfVbzQT3EGM0LY7oKqR3QuCbmL3DGuZD02VQgCVtPD56
 ugaE89fj7mic3tpuzYKT97igURvpS0G9BTQVuBMX0zGkDEpvTzXFdHOka1ozramphKpj045Pob
 8Ugk3FtIJby1eU5dy9OFR3OY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:16 -0700
IronPort-SDR: 5CsuL3nLObzEnLPbjBZA9AWXWRHE1w17yF0/DmRBuc04sGdtmwO1v02nRfIcaD97yXWdn9lv6k
 lzRpSi5C4nHNZVYO5EnCt5yghzKhO+EGtB5InCKveqoRuqZeIlqipbzikJqlfFI0Pl8ooxW9Qy
 GGDIJeVVQ8nNZRNM4YTg8uttT+3Qq6KbOf/A2gwJiYrI0VCoKIOKwhKqEcgHQV99E1KDsNJfJh
 Eyl2IdeAD0ZA9q9ing+3+PC/JSEX0jQT3IVZUIKNWwWQ7V5GkcwHdVNNzedpi0Czb4BhVG0a1I
 vzY=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:48 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 03/18] blktrace: update trace to track more actions
Date:   Tue, 30 Apr 2019 21:28:16 -0700
Message-Id: <20190501042831.5313-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The existing blocktrace API has different data type when it comes to
tracking the action. Now that we have increased the size of action mask
and the action itself update all the APIs prototypes to handle action of
size u64. Also with extension we now we can track the priorities, so
update the API to hold the priority values for logging.

Also, in the previous patch we have added two new block trace actions
for REQ_OP_WRITE_ZEROES and REQ_OP_ZONE_RESET. Add those action into
the __blk_add_trace() so we can track new actions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 165 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e1c6d79fb4cc..6d2b4adae76e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -63,9 +63,16 @@ static void blk_unregister_tracepoints(void);
 /*
  * Send out a notify message.
  */
+#ifdef CONFIG_BLKTRACE_EXT
+static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
+		       const void *data, size_t len,
+		       union kernfs_node_id *cgid)
+
+#else
 static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 		       const void *data, size_t len,
 		       union kernfs_node_id *cgid)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	struct blk_io_trace *t;
 	struct ring_buffer_event *event = NULL;
@@ -180,8 +187,14 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
 
+
+#ifdef CONFIG_BLKTRACE_EXT
+static int act_log_check(struct blk_trace *bt, u64 what, sector_t sector,
+			 pid_t pid)
+#else
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	if (((bt->act_mask << BLK_TC_SHIFT) & what) == 0)
 		return 1;
@@ -196,8 +209,15 @@ static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 /*
  * Data direction bit lookup
  */
+
+#ifdef CONFIG_BLKTRACE_EXT
+static const u64 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
+                                BLK_TC_ACT(BLK_TC_WRITE) };
+
+#else
 static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
-				 BLK_TC_ACT(BLK_TC_WRITE) };
+                                 BLK_TC_ACT(BLK_TC_WRITE) };
+#endif /* CONFIG_BLKTRACE_EXT */
 
 #define BLK_TC_RAHEAD		BLK_TC_AHEAD
 #define BLK_TC_PREFLUSH		BLK_TC_FLUSH
@@ -210,9 +230,16 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  * The worker for the various blk_add_trace*() types. Fills out a
  * blk_io_trace structure and places it in a per-cpu subbuffer.
  */
+
+#ifdef CONFIG_BLKTRACE_EXT
+static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
+		     int op, int op_flags, u64 what, int error, int pdu_len,
+		     void *pdu_data, union kernfs_node_id *cgid, u32 ioprio)
+#else
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u32 what, int error, int pdu_len,
 		     void *pdu_data, union kernfs_node_id *cgid)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -238,6 +265,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		what |= BLK_TC_ACT(BLK_TC_DISCARD);
 	if (op == REQ_OP_FLUSH)
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
+
+#ifdef CONFIG_BLKTRACE_EXT
+	if (unlikely(op == REQ_OP_WRITE_ZEROES))
+		what |= BLK_TC_ACT(BLK_TC_WRITE_ZEROES);
+	if (unlikely(op == REQ_OP_ZONE_RESET))
+		what |= BLK_TC_ACT(BLK_TC_ZONE_RESET);
+#endif /* CONFIG_BLKTRACE_EXT */
+
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
 
@@ -535,8 +570,14 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		goto err;
 
 	bt->act_mask = buts->act_mask;
+
+#ifdef CONFIG_BLKTRACE_EXT
+	if (!bt->act_mask)
+		bt->act_mask = (u64) -1ULL;
+#else
 	if (!bt->act_mask)
 		bt->act_mask = (u16) -1;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	blk_trace_setup_lba(bt, bdev);
 
@@ -802,9 +843,16 @@ blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
  *     Records an action against a request. Will log the bio offset + size.
  *
  **/
+#ifdef CONFIG_BLKTRACE_EXT
+static void blk_add_trace_rq(struct request *rq, int error,
+			     unsigned int nr_bytes, u64 what,
+			     union kernfs_node_id *cgid)
+
+#else
 static void blk_add_trace_rq(struct request *rq, int error,
 			     unsigned int nr_bytes, u32 what,
 			     union kernfs_node_id *cgid)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	struct blk_trace *bt = rq->q->blk_trace;
 
@@ -816,8 +864,14 @@ static void blk_add_trace_rq(struct request *rq, int error,
 	else
 		what |= BLK_TC_ACT(BLK_TC_FS);
 
+#ifdef CONFIG_BLKTRACE_EXT
+	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
+		rq->cmd_flags, what, error, 0, NULL, cgid, req_get_ioprio(rq));
+
+#else
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
 			rq->cmd_flags, what, error, 0, NULL, cgid);
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 
 static void blk_add_trace_rq_insert(void *ignore,
@@ -860,17 +914,31 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *     Records an action against a bio. Will log the bio offset + size.
  *
  **/
+
+#ifdef CONFIG_BLKTRACE_EXT
+static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
+			      u64 what, int error)
+
+#else
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 			      u32 what, int error)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	struct blk_trace *bt = q->blk_trace;
 
 	if (likely(!bt))
 		return;
 
+#ifdef CONFIG_BLKTRACE_EXT
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
+			blk_trace_bio_get_cgid(q, bio), bio_prio(bio));
+
+#else
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
 			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
 			blk_trace_bio_get_cgid(q, bio));
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 
 static void blk_add_trace_bio_bounce(void *ignore,
@@ -917,9 +985,16 @@ static void blk_add_trace_getrq(void *ignore,
 	else {
 		struct blk_trace *bt = q->blk_trace;
 
+#ifdef CONFIG_BLKTRACE_EXT
+		if (bt)
+			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
+					NULL, NULL, 0);
+
+#else
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
 					NULL, NULL);
+#endif /* CONFIG_BLKTRACE_EXT */
 	}
 }
 
@@ -933,9 +1008,17 @@ static void blk_add_trace_sleeprq(void *ignore,
 	else {
 		struct blk_trace *bt = q->blk_trace;
 
+
+#ifdef CONFIG_BLKTRACE_EXT
+		if (bt)
+			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
+					0, 0, NULL, NULL, 0);
+
+#else
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
 					0, 0, NULL, NULL);
+#endif /* CONFIG_BLKTRACE_EXT */
 	}
 }
 
@@ -943,8 +1026,14 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt = q->blk_trace;
 
+#ifdef CONFIG_BLKTRACE_EXT
+	if (bt)
+		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL,
+				0);
+#else
 	if (bt)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 
 static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
@@ -954,14 +1043,24 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(depth);
+
+#ifdef CONFIG_BLKTRACE_EXT
+		u64 what;
+#else
 		u32 what;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 		if (explicit)
 			what = BLK_TA_UNPLUG_IO;
 		else
 			what = BLK_TA_UNPLUG_TIMER;
 
+#ifdef CONFIG_BLKTRACE_EXT
+		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu,
+				NULL, 0);
+#else
 		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, NULL);
+#endif /* CONFIG_BLKTRACE_EXT */
 	}
 }
 
@@ -974,10 +1073,18 @@ static void blk_add_trace_split(void *ignore,
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(pdu);
 
+#ifdef CONFIG_BLKTRACE_EXT
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
+				&rpdu, blk_trace_bio_get_cgid(q, bio),
+				bio_prio(bio));
+#else
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
 				&rpdu, blk_trace_bio_get_cgid(q, bio));
+#endif /* CONFIG_BLKTRACE_EXT */
 	}
 }
 
@@ -1008,9 +1115,16 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.device_to   = cpu_to_be32(bio_dev(bio));
 	r.sector_from = cpu_to_be64(from);
 
+#ifdef CONFIG_BLKTRACE_EXT
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
+			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio),
+			bio_prio(bio));
+#else
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
 			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
 			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 
 /**
@@ -1041,9 +1155,17 @@ static void blk_add_trace_rq_remap(void *ignore,
 	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
 	r.sector_from = cpu_to_be64(from);
 
+
+#ifdef CONFIG_BLKTRACE_EXT
+	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
+			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+			sizeof(r), &r, blk_trace_request_get_cgid(q, rq),
+			req_get_ioprio(rq));
+#else
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
 			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
 			sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 
 /**
@@ -1066,9 +1188,16 @@ void blk_add_driver_data(struct request_queue *q,
 	if (likely(!bt))
 		return;
 
+#ifdef CONFIG_BLKTRACE_EXT
+	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
+				BLK_TA_DRV_DATA, 0, len, data,
+				blk_trace_request_get_cgid(q, rq),
+				req_get_ioprio(rq));
+#else
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
 				BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(q, rq));
+#endif /* CONFIG_BLKTRACE_EXT */
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
 
@@ -1139,7 +1268,11 @@ static void blk_unregister_tracepoints(void)
 static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
 {
 	int i = 0;
+#ifdef CONFIG_BLKTRACE_EXT
+	u64 tc = t->action >> BLK_TC_SHIFT;
+#else
 	int tc = t->action >> BLK_TC_SHIFT;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	if ((t->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE) {
 		rwbs[i++] = 'N';
@@ -1151,6 +1284,17 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
 
 	if (tc & BLK_TC_DISCARD)
 		rwbs[i++] = 'D';
+
+#ifdef CONFIG_BLKTRACE_EXT
+	else if ((tc & BLK_TC_WRITE_ZEROES)) {
+	/* instead of adding nested if in BLK_TC_WRITE keep the code clean */
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+	} else if ((tc & BLK_TC_ZONE_RESET)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	}
+#endif /* CONFIG_BLKTRACE_EXT */
 	else if (tc & BLK_TC_WRITE)
 		rwbs[i++] = 'W';
 	else if (t->bytes)
@@ -1193,7 +1337,11 @@ static inline int pdu_real_len(const struct trace_entry *ent, bool has_cg)
 			(has_cg ? sizeof(union kernfs_node_id) : 0);
 }
 
+#ifdef CONFIG_BLKTRACE_EXT
+static inline u64 t_action(const struct trace_entry *ent)
+#else
 static inline u32 t_action(const struct trace_entry *ent)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	return te_blk_io_trace(ent)->action;
 }
@@ -1474,7 +1622,12 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 	bool has_cg;
 
 	t	   = te_blk_io_trace(iter->ent);
+
+#ifdef CONFIG_BLKTRACE_EXT
+	what = (t->action & ((1ULL << BLK_TC_SHIFT) - 1)) & ~__BLK_TA_CGROUP;
+#else
 	what	   = (t->action & ((1 << BLK_TC_SHIFT) - 1)) & ~__BLK_TA_CGROUP;
+#endif /* CONFIG_BLKTRACE_EXT */
 	long_act   = !!(tr->trace_flags & TRACE_ITER_VERBOSE);
 	log_action = classic ? &blk_log_action_classic : &blk_log_action;
 	has_cg	   = t->action & __BLK_TA_CGROUP;
@@ -1617,7 +1770,13 @@ static int blk_trace_setup_queue(struct request_queue *q,
 		goto free_bt;
 
 	bt->dev = bdev->bd_dev;
+
+#ifdef CONFIG_BLKTRACE_EXT
+	bt->act_mask = (u64)-1ULL;
+
+#else
 	bt->act_mask = (u16)-1;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	blk_trace_setup_lba(bt, bdev);
 
@@ -1688,6 +1847,10 @@ static const struct {
 	{ BLK_TC_DISCARD,	"discard"	},
 	{ BLK_TC_DRV_DATA,	"drv_data"	},
 	{ BLK_TC_FUA,		"fua"		},
+#ifdef CONFIG_BLKTRACE_EXT
+	{ BLK_TC_WRITE_ZEROES,	"write-zeroes"	},
+	{ BLK_TC_ZONE_RESET,	"zone-reset"	},
+#endif /* CONFIG_BLKTRACE_EXT */
 };
 
 static int blk_trace_str2mask(const char *str)
-- 
2.19.1


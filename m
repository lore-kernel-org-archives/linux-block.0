Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9907DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiF2XcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiF2XcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:13 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E01331F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:12 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 23so16761407pgc.8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUwQNhKdj5FS6+nM73CMMd1G3s4noanfDGs9XhwY62A=;
        b=UI/xqh/267YLb+vyy78ov3ICv0kqmviXbUgDtQ9LMx+AIUzsGjIFym3IKpCrr6mnJK
         j8cK2ZX4Gafu6ZN7vZsp88aeI3gUfdHcmiagnf8fU/ZM0LoeqRkUXW0V1r62iL3cfx4n
         sdp9KsG6WIaxBtzAjYALLGzhZH4bzJKSiFGojs7/eJOujK++ilWAR4V3ap4kIsnDXt0i
         9rtBXVwanLp3TONCWMP79Qh6LmzbGUGFvwryP0oHpCH623hlC/nxUOTiMvP4qyd9BsvI
         dPM034n04LFiFGVL5tTQ6dhBeXfss0vhQcqgsrcF2lj3NnresjaTfHE5JhKinVomH8bB
         LGnQ==
X-Gm-Message-State: AJIora8c9WYYFlLGJZ4X8vEsOHAGxVOYkJbnLffZfOYbbcp6yQEP1rnk
        GltkoLMfM59svxwvjAg37AE=
X-Google-Smtp-Source: AGRyM1s4FMDh7NSUv1OqmD4RvNOngorq094ejeVUW0ATf6cDmjk5gymdTC/qcGzemdtS3HBcbAq9ng==
X-Received: by 2002:a63:e64f:0:b0:40d:e79f:8b73 with SMTP id p15-20020a63e64f000000b0040de79f8b73mr4865935pgj.243.1656545531617;
        Wed, 29 Jun 2022 16:32:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 11/63] blktrace: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:30:53 -0700
Message-Id: <20220629233145.2779494-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for a function
argument that represents a combination of a request operation and request
flags. Rename that argument from 'op' into 'opf' to make its role more
clear.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blktrace_api.h |  3 ++-
 kernel/trace/blktrace.c      | 51 ++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index f6f9b544365a..cfbda114348c 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -7,6 +7,7 @@
 #include <linux/compat.h>
 #include <uapi/linux/blktrace_api.h>
 #include <linux/list.h>
+#include <linux/blk_types.h>
 
 #if defined(CONFIG_BLK_DEV_IO_TRACE)
 
@@ -105,7 +106,7 @@ struct compat_blk_user_trace_setup {
 
 #endif
 
-void blk_fill_rwbs(char *rwbs, unsigned int op);
+void blk_fill_rwbs(char *rwbs, blk_opf_t opf);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index cee788817fb3..26688c16afd6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -205,7 +205,7 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
 #define BLK_TC_PREFLUSH		BLK_TC_FLUSH
 
 /* The ilog2() calls fall out because they're constant */
-#define MASK_TC_BIT(rw, __name) ((rw & REQ_ ## __name) << \
+#define MASK_TC_BIT(rw, __name) ((__force u32)(rw & REQ_ ## __name) <<	\
 	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ## __name))
 
 /*
@@ -213,8 +213,8 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  * blk_io_trace structure and places it in a per-cpu subbuffer.
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
-		     int op, int op_flags, u32 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid)
+			    const blk_opf_t opf, u32 what, int error,
+			    int pdu_len, void *pdu_data, u64 cgid)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -227,16 +227,17 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	int cpu;
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
+	const enum req_op op = opf & REQ_OP_MASK;
 
 	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
 		return;
 
 	what |= ddir_act[op_is_write(op) ? WRITE : READ];
-	what |= MASK_TC_BIT(op_flags, SYNC);
-	what |= MASK_TC_BIT(op_flags, RAHEAD);
-	what |= MASK_TC_BIT(op_flags, META);
-	what |= MASK_TC_BIT(op_flags, PREFLUSH);
-	what |= MASK_TC_BIT(op_flags, FUA);
+	what |= MASK_TC_BIT(opf, SYNC);
+	what |= MASK_TC_BIT(opf, RAHEAD);
+	what |= MASK_TC_BIT(opf, META);
+	what |= MASK_TC_BIT(opf, PREFLUSH);
+	what |= MASK_TC_BIT(opf, FUA);
 	if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
 		what |= BLK_TC_ACT(BLK_TC_DISCARD);
 	if (op == REQ_OP_FLUSH)
@@ -842,9 +843,8 @@ static void blk_add_trace_rq(struct request *rq, blk_status_t error,
 	else
 		what |= BLK_TC_ACT(BLK_TC_FS);
 
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, blk_status_to_errno(error), 0,
-			NULL, cgid);
+	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, rq->cmd_flags,
+			what, blk_status_to_errno(error), 0, NULL, cgid);
 	rcu_read_unlock();
 }
 
@@ -903,7 +903,7 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 	}
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
+			bio->bi_opf, what, error, 0, NULL,
 			blk_trace_bio_get_cgid(q, bio));
 	rcu_read_unlock();
 }
@@ -949,7 +949,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
 	if (bt)
-		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
+		__blk_add_trace(bt, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 	rcu_read_unlock();
 }
 
@@ -969,7 +969,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER;
 
-		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
+		__blk_add_trace(bt, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
 	}
 	rcu_read_unlock();
 }
@@ -985,8 +985,7 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 		__be64 rpdu = cpu_to_be64(pdu);
 
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
-				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
-				BLK_TA_SPLIT,
+				bio->bi_iter.bi_size, bio->bi_opf, BLK_TA_SPLIT,
 				blk_status_to_errno(bio->bi_status),
 				sizeof(rpdu), &rpdu,
 				blk_trace_bio_get_cgid(q, bio));
@@ -1022,7 +1021,7 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
+			bio->bi_opf, BLK_TA_REMAP,
 			blk_status_to_errno(bio->bi_status),
 			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
 	rcu_read_unlock();
@@ -1058,7 +1057,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			req_op(rq), rq->cmd_flags, BLK_TA_REMAP, 0,
+			rq->cmd_flags, BLK_TA_REMAP, 0,
 			sizeof(r), &r, blk_trace_request_get_cgid(rq));
 	rcu_read_unlock();
 }
@@ -1084,7 +1083,7 @@ void blk_add_driver_data(struct request *rq, void *data, size_t len)
 		return;
 	}
 
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
+	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0,
 				BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(rq));
 	rcu_read_unlock();
@@ -1881,14 +1880,14 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
  *     caller with resulting string.
  *
  **/
-void blk_fill_rwbs(char *rwbs, unsigned int op)
+void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 {
 	int i = 0;
 
-	if (op & REQ_PREFLUSH)
+	if (opf & REQ_PREFLUSH)
 		rwbs[i++] = 'F';
 
-	switch (op & REQ_OP_MASK) {
+	switch (opf & REQ_OP_MASK) {
 	case REQ_OP_WRITE:
 		rwbs[i++] = 'W';
 		break;
@@ -1909,13 +1908,13 @@ void blk_fill_rwbs(char *rwbs, unsigned int op)
 		rwbs[i++] = 'N';
 	}
 
-	if (op & REQ_FUA)
+	if (opf & REQ_FUA)
 		rwbs[i++] = 'F';
-	if (op & REQ_RAHEAD)
+	if (opf & REQ_RAHEAD)
 		rwbs[i++] = 'A';
-	if (op & REQ_SYNC)
+	if (opf & REQ_SYNC)
 		rwbs[i++] = 'S';
-	if (op & REQ_META)
+	if (opf & REQ_META)
 		rwbs[i++] = 'M';
 
 	rwbs[i] = '\0';

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D35BC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352936AbhLCPjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381833AbhLCPjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:39:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B01C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 07:35:44 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e128so4218045iof.1
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rszWOi244onMayab42j/UepL6JlRWHBNJe1ouQFy7gg=;
        b=md14UZv6JNVLVXMsJQ8YfhSWqL9fatA+hhpg5QS5iQtCMnw8Nd2WzFk1em71LN3lB+
         Tz5VoiCFwpkN9X1X8eNwI9tQbqPudJt3o1e8GlSzogRxhdV/erRaCMzQr4kyRsNaoRsj
         VfYlcx+eg55QGGuEBL+ey6llJ64y5mM1raK1exqmXiXPZKU+lqAgh33EHJDVRMSx5LXm
         orCQlAhtXuHp++aAKR3p1xc3KvoQ0EgFBUHIPFwvz4KN6EdDbQEtDWtaAU/MOH7bv9bN
         hsjSdToJi9RS7IIlve9E4U3ekITdoiBzPde6uLQFBj35KQNA7lvsYr66lT26aFu9DXou
         3pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rszWOi244onMayab42j/UepL6JlRWHBNJe1ouQFy7gg=;
        b=WtzrPtPMazPklzqyOBjCY/QmtY1GphVTuFM+iQBoR+ON+0eJAFzEoRI5iRRYItydtb
         pgShXudb7jbJoLIhbJ3pNXSn2vB8Xkb+ORIQWmyKIgnrxTkGvEGPQvuA7zMfWTp2CI0T
         Vce9lz8jXzT2CD/5oCM001PZFm+RpbzpVSlV2Hl0P1+F7Vh/uenO8oAirGQX5VdR/uGw
         3x26oUssT/QssCmULIaCDaQgK53q0W48RwMmqcXTLIpTTR0kxGmo9fxIHv8QSikoTcX0
         PKCGWYFTHWDdI9B8mtRcwpC8TId7Ye4Ro/r1jI3q5AHbkrhMkPzrhiadsm3PtAaWkng4
         nVJA==
X-Gm-Message-State: AOAM530HWwh0IHdzYS+N3dAKEYsqO4vAJ+msBDFjXKXMVICTuHHcxIL1
        cwKQnIa7BapkkTSrLGfdd60fjD3XG6/esvRr
X-Google-Smtp-Source: ABdhPJxLp+I+DH/eDh7ajEdUXJj6btPdbnR9AR4KVMHpYWe39tonCEK4w9iPbtn44pj5Oi0CtXdvIQ==
X-Received: by 2002:a6b:e007:: with SMTP id z7mr21615648iog.58.1638545743588;
        Fri, 03 Dec 2021 07:35:43 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x2sm1756757iom.46.2021.12.03.07.35.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 07:35:43 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: switch to atomic_t for request references
Message-ID: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
Date:   Fri, 3 Dec 2021 08:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

refcount_t is not as expensive as it used to be, but it's still more
expensive than the io_uring method of using atomic_t and just checking
for potential over/underflow.

This borrows that same implementation, which in turn is based on the
mm implementation from Linus.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f78bb39e589e..e4df894189ce 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -229,7 +229,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
-	if (!refcount_dec_and_test(&flush_rq->ref)) {
+	if (!req_ref_put_and_test(flush_rq)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return;
@@ -349,7 +349,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * and READ flush_rq->end_io
 	 */
 	smp_wmb();
-	refcount_set(&flush_rq->ref, 1);
+	req_ref_set(flush_rq, 1);
 
 	blk_flush_queue_rq(flush_rq, false);
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336abee33..380e2dd31bfc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -228,7 +228,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 
 	spin_lock_irqsave(&tags->lock, flags);
 	rq = tags->rqs[bitnr];
-	if (!rq || rq->tag != bitnr || !refcount_inc_not_zero(&rq->ref))
+	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
 		rq = NULL;
 	spin_unlock_irqrestore(&tags->lock, flags);
 	return rq;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fa464a3e2f9a..22ec21aa0c22 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -386,7 +386,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* tag was already set */
 	WRITE_ONCE(rq->deadline, 0);
-	refcount_set(&rq->ref, 1);
+	req_ref_set(rq, 1);
 
 	if (rq->rq_flags & RQF_ELV) {
 		struct elevator_queue *e = data->q->elevator;
@@ -634,7 +634,7 @@ void blk_mq_free_request(struct request *rq)
 	rq_qos_done(q, rq);
 
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-	if (refcount_dec_and_test(&rq->ref))
+	if (req_ref_put_and_test(rq))
 		__blk_mq_free_request(rq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
@@ -930,7 +930,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		rq_qos_done(rq->q, rq);
 
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-		if (!refcount_dec_and_test(&rq->ref))
+		if (!req_ref_put_and_test(rq))
 			continue;
 
 		blk_crypto_free_request(rq);
@@ -1373,7 +1373,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 {
 	if (is_flush_rq(rq))
 		rq->end_io(rq, 0);
-	else if (refcount_dec_and_test(&rq->ref))
+	else if (req_ref_put_and_test(rq))
 		__blk_mq_free_request(rq);
 }
 
@@ -3003,7 +3003,7 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 			unsigned long rq_addr = (unsigned long)rq;
 
 			if (rq_addr >= start && rq_addr < end) {
-				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+				WARN_ON_ONCE(req_ref_read(rq) != 0);
 				cmpxchg(&drv_tags->rqs[i], rq, NULL);
 			}
 		}
@@ -3337,7 +3337,7 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 	if (!tags)
 		return;
 
-	WARN_ON_ONCE(refcount_read(&flush_rq->ref) != 0);
+	WARN_ON_ONCE(req_ref_read(flush_rq) != 0);
 
 	for (i = 0; i < queue_depth; i++)
 		cmpxchg(&tags->rqs[i], flush_rq, NULL);
diff --git a/block/blk.h b/block/blk.h
index 296411900c55..f869f4b2dec9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -473,4 +473,35 @@ static inline bool should_fail_request(struct block_device *part,
 }
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
+/*
+ * Optimized request reference counting. Ideally we'd make timeouts be more
+ * clever, as that's the only reason we need references at all... But until
+ * this happens, this is faster than using refcount_t. Also see:
+ *
+ * abc54d634334 ("io_uring: switch to atomic_t for io_kiocb reference count")
+ */
+#define req_ref_zero_or_close_to_overflow(req)	\
+	((unsigned int) atomic_read(&(req->ref)) + 127u <= 127u)
+
+static inline bool req_ref_inc_not_zero(struct request *req)
+{
+	return atomic_inc_not_zero(&req->ref);
+}
+
+static inline bool req_ref_put_and_test(struct request *req)
+{
+	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
+	return atomic_dec_and_test(&req->ref);
+}
+
+static inline void req_ref_set(struct request *req, int value)
+{
+	atomic_set(&req->ref, value);
+}
+
+static inline int req_ref_read(struct request *req)
+{
+	return atomic_read(&req->ref);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index bfc3cc61f653..ecdc049b52fa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -138,7 +138,7 @@ struct request {
 	unsigned short ioprio;
 
 	enum mq_rq_state state;
-	refcount_t ref;
+	atomic_t ref;
 
 	unsigned long deadline;
 
-- 
Jens Axboe


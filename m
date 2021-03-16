Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E5BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FA06509D
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhCPDT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234849AbhCPDTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhtTZBRRpja8MMSLJvzi2bXYke2hXN6fXMc9kYf1Bpc=;
        b=SOoUdZJg0EQ3edkTSSE3o6wPNMMor2ewLpPMLrxdlJC7ddw4pmeFpxzhQE/tl4Vq794WmE
        YftBWjYZRbaqyuaJvF7ZUIDuTU338Qqx7NJWhkV4nzv8lXUoH/AfdRspx1dhkTBHWdP+5c
        sF7FOBZvZZfd/PEaHjpGLwIjja+FXUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-i569yDTKNjWdptLojf8tsA-1; Mon, 15 Mar 2021 23:19:03 -0400
X-MC-Unique: i569yDTKNjWdptLojf8tsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D94A087139C;
        Tue, 16 Mar 2021 03:19:01 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EE83100239A;
        Tue, 16 Mar 2021 03:18:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 08/11] block: use per-task poll context to implement bio based io poll
Date:   Tue, 16 Mar 2021 11:15:20 +0800
Message-Id: <20210316031523.864506-9-ming.lei@redhat.com>
In-Reply-To: <20210316031523.864506-1-ming.lei@redhat.com>
References: <20210316031523.864506-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently bio based IO poll needs to poll all hw queue blindly, this way
is very inefficient, and the big reason is that we can't pass bio
submission result to io poll task.

In IO submission context, store associated underlying bios into the
submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
and return current->pid to caller of submit_bio() for any DM or bio based
driver's IO, which is submitted from FS.

In IO poll context, the passed cookie tells us the PID of submission
context, and we can find the bio from that submission context. Moving
bio from submission queue to poll queue of the poll context, and keep
polling until these bios are ended. Remove bio from poll queue if the
bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.

Usually submission shares context with io poll. The per-task poll context
is just like stack variable, and it is cheap to move data between the two
per-task queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c               |   5 ++
 block/blk-core.c          |  74 +++++++++++++++++-
 block/blk-mq.c            | 156 +++++++++++++++++++++++++++++++++++++-
 include/linux/blk_types.h |   3 +
 4 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a..bcf5eca0e8e3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
  **/
 void bio_endio(struct bio *bio)
 {
+	/* BIO_END_BY_POLL has to be set before calling submit_bio */
+	if (bio_flagged(bio, BIO_END_BY_POLL)) {
+		bio_set_flag(bio, BIO_DONE);
+		return;
+	}
 again:
 	if (!bio_remaining_done(bio))
 		return;
diff --git a/block/blk-core.c b/block/blk-core.c
index a082bbc856fb..970b23fa2e6e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -854,6 +854,40 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
 		bio->bi_opf |= REQ_TAG;
 }
 
+static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
+{
+	struct blk_bio_poll_data data = {
+		.bio	=	bio,
+	};
+	struct blk_bio_poll_ctx *pc = ioc->data;
+	unsigned int queued;
+
+	/* lock is required if there is more than one writer */
+	if (unlikely(atomic_read(&ioc->nr_tasks) > 1)) {
+		spin_lock(&pc->lock);
+		queued = kfifo_put(&pc->sq, data);
+		spin_unlock(&pc->lock);
+	} else {
+		queued = kfifo_put(&pc->sq, data);
+	}
+
+	/*
+	 * Now the bio is added per-task fifo, mark it as END_BY_POLL,
+	 * so we can save cookie into this bio after submit_bio().
+	 */
+	if (queued)
+		bio_set_flag(bio, BIO_END_BY_POLL);
+	else
+		bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
+
+	return queued;
+}
+
+static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
+{
+	bio->bi_iter.bi_private_data = cookie;
+}
+
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
@@ -1008,7 +1042,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
  * bio_list_on_stack[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
-static blk_qc_t __submit_bio_noacct(struct bio *bio)
+static blk_qc_t __submit_bio_noacct_int(struct bio *bio, struct io_context *ioc)
 {
 	struct bio_list bio_list_on_stack[2];
 	blk_qc_t ret = BLK_QC_T_NONE;
@@ -1031,7 +1065,16 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 		bio_list_on_stack[1] = bio_list_on_stack[0];
 		bio_list_init(&bio_list_on_stack[0]);
 
-		ret = __submit_bio(bio);
+		if (ioc && queue_is_mq(q) &&
+				(bio->bi_opf & (REQ_HIPRI | REQ_TAG))) {
+			bool queued = blk_bio_poll_prep_submit(ioc, bio);
+
+			ret = __submit_bio(bio);
+			if (queued)
+				blk_bio_poll_post_submit(bio, ret);
+		} else {
+			ret = __submit_bio(bio);
+		}
 
 		/*
 		 * Sort new bios into those for a lower level and those for the
@@ -1057,6 +1100,33 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	return ret;
 }
 
+static inline blk_qc_t __submit_bio_noacct_poll(struct bio *bio,
+		struct io_context *ioc)
+{
+	struct blk_bio_poll_ctx *pc = ioc->data;
+	int entries = kfifo_len(&pc->sq);
+
+	__submit_bio_noacct_int(bio, ioc);
+
+	/* bio submissions queued to per-task poll context */
+	if (kfifo_len(&pc->sq) > entries)
+		return current->pid;
+
+	/* swapper's pid is 0, but it can't submit poll IO for us */
+	return 0;
+}
+
+static inline blk_qc_t __submit_bio_noacct(struct bio *bio)
+{
+	struct io_context *ioc = current->io_context;
+
+	if (ioc && ioc->data && (bio->bi_opf & REQ_HIPRI))
+		return __submit_bio_noacct_poll(bio, ioc);
+
+	return __submit_bio_noacct_int(bio, NULL);
+}
+
+
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 03f59915fe2c..4e6f1467d303 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3865,14 +3865,168 @@ static inline int blk_mq_poll_hctx(struct request_queue *q,
 	return ret;
 }
 
+static blk_qc_t bio_get_poll_cookie(struct bio *bio)
+{
+	return bio->bi_iter.bi_private_data;
+}
+
+static int blk_mq_poll_io(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	blk_qc_t cookie = bio_get_poll_cookie(bio);
+	int ret = 0;
+
+	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
+		struct blk_mq_hw_ctx *hctx =
+			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+
+		ret += blk_mq_poll_hctx(q, hctx);
+	}
+	return ret;
+}
+
+static int blk_bio_poll_and_end_io(struct request_queue *q,
+		struct blk_bio_poll_ctx *poll_ctx)
+{
+	struct blk_bio_poll_data *poll_data = &poll_ctx->pq[0];
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < BLK_BIO_POLL_PQ_SZ; i++) {
+		struct bio *bio = poll_data[i].bio;
+
+		if (!bio)
+			continue;
+
+		ret += blk_mq_poll_io(bio);
+		if (bio_flagged(bio, BIO_DONE)) {
+			poll_data[i].bio = NULL;
+
+			/* clear BIO_END_BY_POLL and end me really */
+			bio_clear_flag(bio, BIO_END_BY_POLL);
+			bio_endio(bio);
+		}
+	}
+	return ret;
+}
+
+static int __blk_bio_poll_io(struct request_queue *q,
+		struct blk_bio_poll_ctx *submit_ctx,
+		struct blk_bio_poll_ctx *poll_ctx)
+{
+	struct blk_bio_poll_data *poll_data = &poll_ctx->pq[0];
+	int i;
+
+	/*
+	 * Move IO submission result from submission queue in submission
+	 * context to poll queue of poll context.
+	 *
+	 * There may be more than one readers on poll queue of the same
+	 * submission context, so have to lock here.
+	 */
+	spin_lock(&submit_ctx->lock);
+	for (i = 0; i < BLK_BIO_POLL_PQ_SZ; i++) {
+		if (poll_data[i].bio == NULL &&
+				!kfifo_get(&submit_ctx->sq, &poll_data[i]))
+			break;
+	}
+	spin_unlock(&submit_ctx->lock);
+
+	return blk_bio_poll_and_end_io(q, poll_ctx);
+}
+
+static int blk_bio_poll_io(struct request_queue *q,
+		struct io_context *submit_ioc,
+		struct io_context *poll_ioc)
+{
+	struct blk_bio_poll_ctx *submit_ctx = submit_ioc->data;
+	struct blk_bio_poll_ctx *poll_ctx = poll_ioc->data;
+	int ret;
+
+	if (unlikely(atomic_read(&poll_ioc->nr_tasks) > 1)) {
+		mutex_lock(&poll_ctx->pq_lock);
+		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
+		mutex_unlock(&poll_ctx->pq_lock);
+	} else {
+		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
+	}
+	return ret;
+}
+
+static bool blk_bio_ioc_valid(struct task_struct *t)
+{
+	if (!t)
+		return false;
+
+	if (!t->io_context)
+		return false;
+
+	if (!t->io_context->data)
+		return false;
+
+	return true;
+}
+
+static int __blk_bio_poll(struct request_queue *q, blk_qc_t cookie)
+{
+	struct io_context *poll_ioc = current->io_context;
+	pid_t pid;
+	struct task_struct *submit_task;
+	int ret;
+
+	pid = (pid_t)cookie;
+
+	/* io poll often share io submission context */
+	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
+		return blk_bio_poll_io(q, poll_ioc, poll_ioc);
+
+	submit_task = find_get_task_by_vpid(pid);
+	if (likely(blk_bio_ioc_valid(submit_task)))
+		ret = blk_bio_poll_io(q, submit_task->io_context,
+				poll_ioc);
+	else
+		ret = 0;
+
+	put_task_struct(submit_task);
+
+	return ret;
+}
+
 static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
+	long state;
+
+	/* no need to poll */
+	if (cookie == 0)
+		return 0;
+
 	/*
 	 * Create poll queue for storing poll bio and its cookie from
 	 * submission queue
 	 */
 	blk_create_io_context(q, true);
 
+	state = current->state;
+	do {
+		int ret;
+
+		ret = __blk_bio_poll(q, cookie);
+		if (ret > 0) {
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+
+		if (current->state == TASK_RUNNING)
+			return 1;
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
 	return 0;
 }
 
@@ -3893,7 +4047,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
+	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))
 		return 0;
 
 	if (current->plug)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a1bcade4bcc3..53f64eea9652 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -304,6 +304,9 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_END_BY_POLL,	/* end by blk_bio_poll() explicitly */
+	/* set when bio can be ended, used for bio with BIO_END_BY_POLL */
+	BIO_DONE,
 	BIO_FLAG_LAST
 };
 
-- 
2.29.2


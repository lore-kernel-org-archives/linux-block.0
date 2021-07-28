Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C98C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D89460F41
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhG1IRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 04:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234363AbhG1IRG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 04:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdfX05LskuF4LkLPQ7JXhLXY5W9XsKs2E3Vm5Szjjo0=;
        b=gW+Ck8OVm8bGtZ8DNX4OJTYzi4sBLGFZrJYeyHFp4qRCz8jygbT6R1WJIbwVmI6hXruD8d
        53/Cm6XIP2spnvNjsqQBul6Opmwba83KYKrg/ioVh3+IjmnAhPU3S0oSxBmiJ2TA87HcmC
        ULomoiP+LHLSN0kbgPHfeDD0x3VpPp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-6uIouBW2PHOpc-u15TNomw-1; Wed, 28 Jul 2021 04:17:01 -0400
X-MC-Unique: 6uIouBW2PHOpc-u15TNomw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF4771006C84;
        Wed, 28 Jul 2021 08:16:59 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF62A60C05;
        Wed, 28 Jul 2021 08:16:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/7] loop: clean up blkcg association
Date:   Wed, 28 Jul 2021 16:16:33 +0800
Message-Id: <20210728081638.1500953-3-ming.lei@redhat.com>
In-Reply-To: <20210728081638.1500953-1-ming.lei@redhat.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each loop_worker is responsible for running requests originated from
same blkcg, so:

1) associate with kthread in the entry of loop_process_work(), and
disassociate in the end of this function, then we can avoid to do
both for each request.

2) remove ->blkcg_css and ->memcg_css from 'loop_cmd' since both are
per loop_worker.

Also kill #ifdef in the related functions.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 81 +++++++++++++++++++++++---------------------
 drivers/block/loop.h |  2 --
 2 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..1756c17d3936 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -936,23 +936,46 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 {
 	return !css || css == blkcg_root_css;
 }
+static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	/* always use the first bio's css */
+	struct blkcg *blkcg = bio_blkcg(rq->bio);
+
+	if (blkcg)
+		return &blkcg->css;
+	return NULL;
+}
 #else
 static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 {
 	return !css;
 }
+static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)
+{
+	return NULL;
+}
 #endif
 
+static struct cgroup_subsys_state *loop_rq_get_memcg_css(
+		struct cgroup_subsys_state *blkcg_css)
+{
+	if (blkcg_css)
+		return memcg_get_e_css(blkcg_css->cgroup);
+	return NULL;
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
+	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (queue_on_root_worker(cmd->blkcg_css))
+	if (queue_on_root_worker(blkcg_css))
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -960,10 +983,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	while (*node) {
 		parent = *node;
 		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if (cur_worker->blkcg_css == cmd->blkcg_css) {
+		if (cur_worker->blkcg_css == blkcg_css) {
 			worker = cur_worker;
 			break;
-		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
+		} else if ((long)cur_worker->blkcg_css < (long)blkcg_css) {
 			node = &(*node)->rb_left;
 		} else {
 			node = &(*node)->rb_right;
@@ -977,15 +1000,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
 	 */
-	if (!worker) {
-		cmd->blkcg_css = NULL;
-		if (cmd->memcg_css)
-			css_put(cmd->memcg_css);
-		cmd->memcg_css = NULL;
+	if (!worker)
 		goto queue_work;
-	}
 
-	worker->blkcg_css = cmd->blkcg_css;
+	worker->blkcg_css = blkcg_css;
 	css_get(worker->blkcg_css);
 	INIT_WORK(&worker->work, loop_workfn);
 	INIT_LIST_HEAD(&worker->cmd_list);
@@ -2098,19 +2116,6 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
-	/* always use the first bio's css */
-	cmd->blkcg_css = NULL;
-	cmd->memcg_css = NULL;
-#ifdef CONFIG_BLK_CGROUP
-	if (rq->bio && rq->bio->bi_blkg) {
-		cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
-#ifdef CONFIG_MEMCG
-		cmd->memcg_css =
-			cgroup_get_e_css(cmd->blkcg_css->cgroup,
-					&memory_cgrp_subsys);
-#endif
-	}
-#endif
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -2122,28 +2127,14 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	const bool write = op_is_write(req_op(rq));
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
-	struct mem_cgroup *old_memcg = NULL;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
-	if (cmd->blkcg_css)
-		kthread_associate_blkcg(cmd->blkcg_css);
-	if (cmd->memcg_css)
-		old_memcg = set_active_memcg(
-			mem_cgroup_from_css(cmd->memcg_css));
-
 	ret = do_req_filebacked(lo, rq);
 
-	if (cmd->blkcg_css)
-		kthread_associate_blkcg(NULL);
-
-	if (cmd->memcg_css) {
-		set_active_memcg(old_memcg);
-		css_put(cmd->memcg_css);
-	}
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
@@ -2199,7 +2190,21 @@ static void loop_workfn(struct work_struct *work)
 {
 	struct loop_worker *worker =
 		container_of(work, struct loop_worker, work);
-	loop_process_work(worker, &worker->cmd_list, worker->lo);
+	struct mem_cgroup *old_memcg = NULL;
+	struct cgroup_subsys_state *memcg_css = NULL;
+
+	kthread_associate_blkcg(worker->blkcg_css);
+	memcg_css = loop_rq_get_memcg_css(worker->blkcg_css);
+	if (memcg_css) {
+		old_memcg = set_active_memcg(
+				mem_cgroup_from_css(memcg_css));
+		loop_process_work(worker, &worker->cmd_list, worker->lo);
+		set_active_memcg(old_memcg);
+		css_put(memcg_css);
+	} else {
+		loop_process_work(worker, &worker->cmd_list, worker->lo);
+	}
+	kthread_associate_blkcg(NULL);
 }
 
 static void loop_rootcg_workfn(struct work_struct *work)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63a..a52a3fd89457 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -77,8 +77,6 @@ struct loop_cmd {
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
-	struct cgroup_subsys_state *blkcg_css;
-	struct cgroup_subsys_state *memcg_css;
 };
 
 /* Support for loadable transfer modules */
-- 
2.31.1


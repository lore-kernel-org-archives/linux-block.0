Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F9DC07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60B2613F3
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGEK3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEK3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 06:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625480792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+khomSlsBTaZrmb4bOTeOLJEuuMnA+00ifG+zQXawDk=;
        b=aqELABhctNg+riQ3Qqu2oVaylH7UISpo420r8UUA1gopo5wjqhuvTQtqcx5sGHWENzRYic
        1W+t0CeiCrEyYELMmEf71rrKPjQJGE6y6TJ0ekA9ApuozcuzmFAA/nu0XC8+v8f+pmcAsP
        ChkXVlfdNWztpPK7M4tKpT9JvvXlCfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588--foVwoj3NESpeEV3caas8Q-1; Mon, 05 Jul 2021 06:26:29 -0400
X-MC-Unique: -foVwoj3NESpeEV3caas8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B65800D62;
        Mon,  5 Jul 2021 10:26:28 +0000 (UTC)
Received: from localhost (ovpn-13-193.pek2.redhat.com [10.72.13.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00D611000358;
        Mon,  5 Jul 2021 10:26:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 1/6] loop: clean up blkcg association
Date:   Mon,  5 Jul 2021 18:26:02 +0800
Message-Id: <20210705102607.127810-2-ming.lei@redhat.com>
In-Reply-To: <20210705102607.127810-1-ming.lei@redhat.com>
References: <20210705102607.127810-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Cc: Michal Koutný <mkoutny@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 67 ++++++++++++++++++++------------------------
 drivers/block/loop.h |  2 --
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 02509bc54242..8378b8455f7c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -949,10 +949,17 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
+	struct cgroup_subsys_state *blkcg_css = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
+	if (rq->bio && rq->bio->bi_blkg)
+		blkcg_css = &bio_blkcg(rq->bio)->css;
+#endif
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (queue_on_root_worker(cmd->blkcg_css))
+	if (queue_on_root_worker(blkcg_css))
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -960,10 +967,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -977,15 +984,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -2100,19 +2102,6 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2124,28 +2113,14 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
@@ -2201,7 +2176,25 @@ static void loop_workfn(struct work_struct *work)
 {
 	struct loop_worker *worker =
 		container_of(work, struct loop_worker, work);
+	struct mem_cgroup *old_memcg = NULL;
+	struct cgroup_subsys_state *memcg_css = NULL;
+
+	kthread_associate_blkcg(worker->blkcg_css);
+#ifdef CONFIG_MEMCG
+	memcg_css = cgroup_get_e_css(worker->blkcg_css->cgroup,
+			&memory_cgrp_subsys);
+#endif
+	if (memcg_css)
+		old_memcg = set_active_memcg(
+				mem_cgroup_from_css(memcg_css));
+
 	loop_process_work(worker, &worker->cmd_list, worker->lo);
+
+	kthread_associate_blkcg(NULL);
+	if (memcg_css) {
+		set_active_memcg(old_memcg);
+		css_put(memcg_css);
+	}
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


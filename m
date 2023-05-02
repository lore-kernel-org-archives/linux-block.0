Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E88C77B73
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 02:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjEBCn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 22:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBCn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 22:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC935AE
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682995360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DTK1+JN8SQ/DDzzOxqF2XHU53fm6EaNRk4arOaJaguY=;
        b=WFCrsYFnmg2/QPb+NPSk3OMx+RedaL7GlTVitSvq2pRjvQkHDLwhLK1T+AYfPQMRr/L461
        wseJjpAM7AwP7GfbPcFtq73UVC9UyWa1MYp/SCY9HLNFpZDzTY23zEFiLjTyzL+tMzdkiN
        06MwQKEHZxrsQjsJwyKo8dc1HRMGq34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-34tPFbFFOEe7yRN-QtERQQ-1; Mon, 01 May 2023 22:42:37 -0400
X-MC-Unique: 34tPFbFFOEe7yRN-QtERQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E88F858F09;
        Tue,  2 May 2023 02:42:37 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 649502166B29;
        Tue,  2 May 2023 02:42:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk: add timeout handler
Date:   Tue,  2 May 2023 10:42:31 +0800
Message-Id: <20230502024231.888498-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add timeout handler, so that we can provide forward progress guarantee for
unprivileged ublk, which can't be trusted.

One thing is that sync() calls sync_bdevs(wait) for all block devices after
running sync_bdevs(no_wait), and if one device can't move on, the sync() won't
return any more.

Add timeout for unprivileged ublk to avoid such affect for other users which call
sync() syscall.

Meantime clear UBLK_F_USER_RECOVERY_REISSUE for unprivileged ublk since
that feature may cause IO hang too.

Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- clear UBLK_F_USER_RECOVERY* which can't provide forward progress
	  now

 drivers/block/ublk_drv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index afbef182820b..6c61f77f49d2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -129,6 +129,7 @@ struct ublk_queue {
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
+	bool timeout;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
 	struct ublk_io ios[];
@@ -898,6 +899,22 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 	}
 }
 
+static enum blk_eh_timer_return ublk_timeout(struct request *rq)
+{
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+
+	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
+		if (!ubq->timeout) {
+			send_sig(SIGKILL, ubq->ubq_daemon, 0);
+			ubq->timeout = true;
+		}
+
+		return BLK_EH_DONE;
+	}
+
+	return BLK_EH_RESET_TIMER;
+}
+
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -957,6 +974,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
 	.init_hctx	= ublk_init_hctx,
 	.init_request   = ublk_init_rq,
+	.timeout	= ublk_timeout,
 };
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
@@ -1737,6 +1755,18 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
 		return -EPERM;
 
+	/*
+	 * unprivileged device can't be trusted, but RECOVERY and
+	 * RECOVERY_REISSUE still may hang error handling, so can't
+	 * support recovery features for unprivileged ublk now
+	 *
+	 * TODO: provide forward progress for RECOVERY handler, so that
+	 * unprivileged device can benefit from it
+	 */
+	if (info.flags & UBLK_F_UNPRIVILEGED_DEV)
+		info.flags &= ~(UBLK_F_USER_RECOVERY_REISSUE |
+				UBLK_F_USER_RECOVERY);
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
@@ -2007,6 +2037,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	put_task_struct(ubq->ubq_daemon);
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
-- 
2.38.1


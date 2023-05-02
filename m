Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622CC77B73
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 01:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEBBCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjEBBCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 21:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3E30EE
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682989320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7czkw31t5OIFAuRtkN2mKbBPDxr2zVtyGLqFv9ptBgI=;
        b=UxA6BnhFG+zaxHiuqU1bnaAnKjV28M8C5IRgHoYRJe/8fjROcq9WeFAZ/sj+iJDWM+pzN7
        ui9c3uHErEc5hbqeds1htdTaBKHS3oqgYPK9sN72waDChuJeiIRneWmPziSzEN/Zjl80rx
        GDj4MQFwUddUF7joIZH9XWoB3VMZV7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-uczDJnjoOImGhplFnQ2htw-1; Mon, 01 May 2023 21:01:59 -0400
X-MC-Unique: uczDJnjoOImGhplFnQ2htw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 411E82A59558;
        Tue,  2 May 2023 01:01:59 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F94D40C2009;
        Tue,  2 May 2023 01:01:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: add timeout handler
Date:   Tue,  2 May 2023 09:01:50 +0800
Message-Id: <20230502010150.878696-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index afbef182820b..50f5e5abd721 100644
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
-- 
2.38.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A420C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiG0OQs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiG0OQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1262E1C7
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKGA2iQQgzIxsUqIM4bDkt615LMys8IkMgemkBkJr68=;
        b=hfLCdhB4XRffCifu9lUcfjaZVg5FPtwXVRi5oJ2+v5EDj5QsvBuZzbLns7vk/1MUCCZ7Vm
        Y6v4jEL0KP8utw4e0mRUhSDxJ1RJGz9GMAQ6cX2IIXCoNcBnucJJgW4ocdoFgxxJiaPvmK
        lFL9bmUD9yU3wDJPflBfyN6OQo8+UFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-RP5UGnjtN9GjXwTmZgUyPg-1; Wed, 27 Jul 2022 10:16:44 -0400
X-MC-Unique: RP5UGnjtN9GjXwTmZgUyPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D76D80418F;
        Wed, 27 Jul 2022 14:16:44 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9652F4047D22;
        Wed, 27 Jul 2022 14:16:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] ublk_drv: cancel device even though disk isn't up
Date:   Wed, 27 Jul 2022 22:16:25 +0800
Message-Id: <20220727141628.985429-3-ming.lei@redhat.com>
In-Reply-To: <20220727141628.985429-1-ming.lei@redhat.com>
References: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each ublk queue is started before adding disk, we have to
cancel queues in ublk_stop_dev() so that ubq daemon can be exited,
otherwise DEL_DEV command may hang forever.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b30d6c3355e8..cb880308a378 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -791,16 +791,27 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 				UBLK_DAEMON_MONITOR_PERIOD);
 }
 
+static inline bool ublk_queue_ready(struct ublk_queue *ubq)
+{
+	return ubq->nr_io_ready == ubq->q_depth;
+}
+
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
 
+	if (!ublk_queue_ready(ubq))
+		return;
+
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_ACTIVE)
 			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
 	}
+
+	/* all io commands are canceled */
+	ubq->nr_io_ready = 0;
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
@@ -821,19 +832,14 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	del_gendisk(ub->ub_disk);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
 	ub->dev_info.ublksrv_pid = -1;
-	ublk_cancel_dev(ub);
 	put_disk(ub->ub_disk);
 	ub->ub_disk = NULL;
  unlock:
+	ublk_cancel_dev(ub);
 	mutex_unlock(&ub->mutex);
 	cancel_delayed_work_sync(&ub->monitor_work);
 }
 
-static inline bool ublk_queue_ready(struct ublk_queue *ubq)
-{
-	return ubq->nr_io_ready == ubq->q_depth;
-}
-
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-- 
2.31.1


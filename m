Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC3C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiG3J2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiG3J2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 05:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E4941D15
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659173320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riJEvY4/2v7KV2+f9lCKnzaisklRv1nJ7JktMntnAoo=;
        b=QzeT9S90CIWx9pRRFGxacsroRw5iKhboegzn8VKJ/GtbH/lvasVNG+YkWfk2lN0doPKKIi
        5GqsKxpZPAr5PMJsE+EY41+O+RU+fQY6AE9W7HWiopmUf0Cw5IssLpw2OXHf6wLuHQ3KrC
        RhLWrmZwwiv4qeX6kP4yVzYSEYG1vo0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-f_OMVNgwMOemo7LljM4cyA-1; Sat, 30 Jul 2022 05:28:37 -0400
X-MC-Unique: f_OMVNgwMOemo7LljM4cyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B3873804525;
        Sat, 30 Jul 2022 09:28:36 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86D91141511F;
        Sat, 30 Jul 2022 09:28:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/4] ublk_drv: cancel device even though disk isn't up
Date:   Sat, 30 Jul 2022 17:27:47 +0800
Message-Id: <20220730092750.1118167-2-ming.lei@redhat.com>
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each ublk queue is started before adding disk, we have to cancel queues in
ublk_stop_dev() so that ubq daemon can be exited, otherwise DEL_DEV command
may hang forever.

Also avoid to cancel queues two times by checking if queue is ready,
otherwise use-after-free on io_uring may be triggered because ublk_stop_dev
is called by ublk_remove() too.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3f1906965ac8..7ece4c2ef062 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -788,16 +788,27 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
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
@@ -818,19 +829,14 @@ static void ublk_stop_dev(struct ublk_device *ub)
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


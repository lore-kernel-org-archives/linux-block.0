Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E8CCA488
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 02:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiGVCha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiGVCh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 22:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B64783F13
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658457446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AusC9PF5eCCtwzKbk9FPOCcdSThtY7KFOyvTjwZJJno=;
        b=ir22ZnZX74q8hYluLPpDrF/c6HgGvWHA3Vzh1vcqdmMCyUqqI+b33XfRpFvbfueFA0Rmuv
        XecgabkFoMxLB5vhAAJEFwKwzDik8cts6xRP5r3V0/EdvjkQ2Yyf4VEnhMsj92AwaNtFn5
        vAFzd5Q54UTQI103vHmkfdwLhCZ0RJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-Ww5fp4pBMCCs5NcW3VQoIw-1; Thu, 21 Jul 2022 22:37:23 -0400
X-MC-Unique: Ww5fp4pBMCCs5NcW3VQoIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FB9F3C025BD;
        Fri, 22 Jul 2022 02:37:23 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92D622166B26;
        Fri, 22 Jul 2022 02:37:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk_drv: move destroying device out of ublk_add_dev
Date:   Fri, 22 Jul 2022 10:36:37 +0800
Message-Id: <20220722023638.601667-2-ming.lei@redhat.com>
In-Reply-To: <20220722023638.601667-1-ming.lei@redhat.com>
References: <20220722023638.601667-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ublk_device is allocated in ublk_ctrl_add_dev(), so code will become more
readable by just letting ublk_ctrl_add_dev() destroy ublk_device in case
of ublk_add_dev() failure.

Meantime ub->mutex is destroyed in __ublk_destroy_dev(), but it may
not be initialized when ublk_add_dev() fails, so fix it by moving
mutex_init(ub->mutex) before any failure path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f058f40b639c..d03563286c76 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1106,9 +1106,10 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
+	mutex_init(&ub->mutex);
 
 	if (ublk_init_queues(ub))
-		goto out_destroy_dev;
+		return err;
 
 	ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
@@ -1122,7 +1123,6 @@ static int ublk_add_dev(struct ublk_device *ub)
 		goto out_deinit_queues;
 
 	ublk_align_max_io_size(ub);
-	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->mm_lock);
 
 	/* add char dev so that ublksrv daemon can be setup */
@@ -1130,8 +1130,6 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 out_deinit_queues:
 	ublk_deinit_queues(ub);
-out_destroy_dev:
-	__ublk_destroy_dev(ub);
 	return err;
 }
 
@@ -1331,8 +1329,10 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	ub->dev_info.dev_id = ub->ub_number;
 
 	ret = ublk_add_dev(ub);
-	if (ret)
+	if (ret) {
+		__ublk_destroy_dev(ub);
 		goto out_unlock;
+	}
 
 	if (copy_to_user(argp, &ub->dev_info, sizeof(info))) {
 		ublk_remove(ub);
-- 
2.31.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2198C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGVFJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGVFJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 271E85B781
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658466596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJ9PLP69guFB61Ah3ylF9yAu7fxAbKdSP7Xc7z3GaMk=;
        b=fo6zTddfkMj/TqmZwyL3dYaN5GHFuiyNqGvcIkNDY3ME/45G5k16wLzvulC8nAlri9q7FQ
        LOvM34sEPepkk4LG1sMjQ97eOCgLtSj9HwGvTHRVIEUQpDAEq3gmtMn1UsaLwCfp0JVfip
        Cb4YTMKBoXsAhjuWBqxmjV+WKrl/IZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-2-H3BD7CNBqkguFM39gxiQ-1; Fri, 22 Jul 2022 01:09:42 -0400
X-MC-Unique: 2-H3BD7CNBqkguFM39gxiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00F26185A7BA;
        Fri, 22 Jul 2022 05:09:42 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32DD0492C3B;
        Fri, 22 Jul 2022 05:09:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/2] ublk_drv: fix error handling of ublk_add_dev
Date:   Fri, 22 Jul 2022 13:09:29 +0800
Message-Id: <20220722050930.611232-2-ming.lei@redhat.com>
In-Reply-To: <20220722050930.611232-1-ming.lei@redhat.com>
References: <20220722050930.611232-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__ublk_destroy_dev() is called for handling error in ublk_add_dev(),
but either tagset isn't allocated or mutex isn't initialized.

So fix the issue by letting ublk_add_dev cleanup its own allocation,
and simply call kfree(ub) outside of ublk_add_dev which is named
as ublk_add_tagset(), meantime ublk_add_chdev() is moved out too.

Now the error handling in ublk_ctrl_add_dev() becomes more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f058f40b639c..a427f020527d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1093,7 +1093,7 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 }
 
 /* add tag_set & cdev, cleanup everything in case of failure */
-static int ublk_add_dev(struct ublk_device *ub)
+static int ublk_add_tagset(struct ublk_device *ub)
 {
 	int err = -ENOMEM;
 
@@ -1108,7 +1108,7 @@ static int ublk_add_dev(struct ublk_device *ub)
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
 
 	if (ublk_init_queues(ub))
-		goto out_destroy_dev;
+		return err;
 
 	ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
@@ -1125,13 +1125,10 @@ static int ublk_add_dev(struct ublk_device *ub)
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->mm_lock);
 
-	/* add char dev so that ublksrv daemon can be setup */
-	return ublk_add_chdev(ub);
+	return 0;
 
 out_deinit_queues:
 	ublk_deinit_queues(ub);
-out_destroy_dev:
-	__ublk_destroy_dev(ub);
 	return err;
 }
 
@@ -1330,7 +1327,18 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
-	ret = ublk_add_dev(ub);
+	ret = ublk_add_tagset(ub);
+	if (ret) {
+		kfree(ub);
+		goto out_unlock;
+	}
+
+	/*
+	 * add char dev so that ublksrv daemon can be setup
+	 *
+	 * ublk_add_chdev() will cleanup everything if it fails.
+	 */
+	ret = ublk_add_chdev(ub);
 	if (ret)
 		goto out_unlock;
 
-- 
2.31.1


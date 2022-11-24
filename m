Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 03:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKXDGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXDGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B82C6046
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669259147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LejFhpN6n8yc8hE2vpv0vnMGeJQCT3tiPfp3mxPaAY=;
        b=ZkSUY381YfWKp8bY5iQ/AVlNPSWo0dcf3rzpCtf0ODAonKp/O3+uklqsy/lKPLRCsGjoEQ
        1oVEfdSGiMvmeWDPdFkklJxPF629unaFnr+WeTs6fJTLHWHVell4MffQ2LkvS/kmMzHANE
        K6yvzyMj0gw1fVvVhTQzEf29LPRBv2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-zEPiV6CmNZ-SbwIV10xcqw-1; Wed, 23 Nov 2022 22:05:43 -0500
X-MC-Unique: zEPiV6CmNZ-SbwIV10xcqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2922E101A528;
        Thu, 24 Nov 2022 03:05:43 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 750BF40C83BB;
        Thu, 24 Nov 2022 03:05:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Dan Carpenter <error27@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/6] ublk_drv: add module parameter of ublks_max for limiting max allowed ublk dev
Date:   Thu, 24 Nov 2022 11:04:53 +0800
Message-Id: <20221124030454.476152-6-ming.lei@redhat.com>
In-Reply-To: <20221124030454.476152-1-ming.lei@redhat.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting unprivileged ublk device by limiting max number
ublk devices added. Otherwise too many ublk devices could be added by
un-trusted user, which can be thought as one DoS.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 04a28a2f2e1f..b12dd5ebe975 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -186,6 +186,15 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
+/*
+ * Max ublk devices allowed to add
+ *
+ * It can be extended to one per-user limit in future or even controlled
+ * by cgroup.
+ */
+static unsigned int ublks_max = 64;
+static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
+
 static struct miscdevice ublk_misc;
 
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
@@ -1441,6 +1450,8 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	ret = cdev_device_add(&ub->cdev, dev);
 	if (ret)
 		goto fail;
+
+	ublks_added++;
 	return 0;
  fail:
 	put_device(dev);
@@ -1483,6 +1494,7 @@ static void ublk_remove(struct ublk_device *ub)
 	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	put_device(&ub->cdev_dev);
+	ublks_added--;
 }
 
 static struct ublk_device *ublk_get_device_from_id(int idx)
@@ -1642,6 +1654,10 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		return ret;
 
+	ret = -EACCES;
+	if (ublks_added >= ublks_max)
+		goto out_unlock;
+
 	ret = -ENOMEM;
 	ub = kzalloc(sizeof(*ub), GFP_KERNEL);
 	if (!ub)
@@ -2093,5 +2109,8 @@ static void __exit ublk_exit(void)
 module_init(ublk_init);
 module_exit(ublk_exit);
 
+module_param(ublks_max, int, 0444);
+MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
+
 MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
 MODULE_LICENSE("GPL");
-- 
2.31.1


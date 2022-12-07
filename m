Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC45C4708E
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 12:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLGMfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLGMfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164814F19C
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzB4SyPqyxBC0K+kb88mBkilbt+PQzHj8+4M1bCPPVo=;
        b=EhWRfZXD+cySqh4x756o/Ida8BQevDfDl8T/dXqXDjSil5L7oUrTTGoUlZH4UOKiCVL8+k
        rSgEcnk3dEeXERUc+EZ5esSzN0ouy1bT9k9Pm2pnnIjVhDKl9zWdPy3fB1kItDLV5GSWw/
        NN92sO4JDWxtL7L7irHlN8pIzXj3NxQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-ufBHnFinM7WM6uZSIMyeZg-1; Wed, 07 Dec 2022 07:33:41 -0500
X-MC-Unique: ufBHnFinM7WM6uZSIMyeZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5583B29324A5;
        Wed,  7 Dec 2022 12:33:41 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5729749BB60;
        Wed,  7 Dec 2022 12:33:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/6] ublk_drv: add module parameter of ublks_max for limiting max allowed ublk dev
Date:   Wed,  7 Dec 2022 20:33:04 +0800
Message-Id: <20221207123305.937678-6-ming.lei@redhat.com>
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting unprivileged ublk device by limiting max number
ublk devices added. Otherwise too many ublk devices could be added by
un-trusted user, which can be thought as one DoS.

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index baea8933a3d9..f91b3e124cc2 100644
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


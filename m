Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94FC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B061166
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhKDHhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 03:37:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27112 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDHhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 03:37:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HlFjN6cPgz1DJ4R;
        Thu,  4 Nov 2021 15:32:56 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 15:35:02 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:35:02 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <lars.ellenberg@linbit.com>, <axboe@kernel.dk>
CC:     <mcgrof@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] drbd: Fix double free problem in drbd_create_device
Date:   Thu, 4 Nov 2021 16:07:09 +0800
Message-ID: <1636013229-26309-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In drbd_create_device(), the 'out_no_io_page' lable has called 
blk_cleanup_disk() when return failed.

So remove the 'out_cleanup_disk' lable to avoid double free the
disk pointer.

Fixes: e92ab4eda516 ("drbd: add error handling support for add_disk()")
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/block/drbd/drbd_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 19db80a..53ba2dd 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2796,7 +2796,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	err = add_disk(disk);
 	if (err)
-		goto out_cleanup_disk;
+		goto out_idr_remove_vol;
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
@@ -2810,8 +2810,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	drbd_debugfs_device_add(device);
 	return NO_ERROR;
 
-out_cleanup_disk:
-	blk_cleanup_disk(disk);
 out_idr_remove_vol:
 	idr_remove(&connection->peer_devices, vnr);
 out_idr_remove_from_resource:
-- 
1.8.3.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A3C43470
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA69460FF3
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhDAR4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:56:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15895 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhDARpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 13:45:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FB36h56DGzjXrG;
        Thu,  1 Apr 2021 20:54:36 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 20:56:18 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <linux-block@vger.kernel.org>
Subject: [PATCH] drivers core: don't do anything in device_del() when device_add() fail
Date:   Thu, 1 Apr 2021 09:01:38 -0400
Message-ID: <20210401130138.2164928-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recently, our syzbot test reported NULL pointer dereference in
device_del() by injecting memory allocation fail in device_add().

For now, callers of device_add(), such as add_disk(), may ignore
device_add()'s fail and go on working. In unregister path, it will
call device_del() from del_gendisk(). That can cause various NULL
pointer dereference, including dev->p is NULL in kill_device(),
'name' is NULL in sysfs_remove_link(), kobj->sd is 'NULL' when call
dpm_sysfs_remove(), and so on.

To avoid these kernel panic, we call device_del() only when device_add()
is success.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f29839382f81..a10ec5dbc577 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3380,6 +3380,9 @@ void device_del(struct device *dev)
 	struct class_interface *class_intf;
 	unsigned int noio_flag;
 
+	if (!dev->p)
+		return;
+
 	device_lock(dev);
 	kill_device(dev);
 	device_unlock(dev);
-- 
2.25.4


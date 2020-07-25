Return-Path: <SRS0=mT+h=BE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC7C433E1
	for <linux-block@archiver.kernel.org>; Sat, 25 Jul 2020 02:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53232206E3
	for <linux-block@archiver.kernel.org>; Sat, 25 Jul 2020 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGYC02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:26:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGYC02 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jul 2020 22:26:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A873FF51C619BC27CBE;
        Sat, 25 Jul 2020 10:26:24 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:26:20 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nbd: add missed destroy_workqueue when nbd_start_device fails
Date:   Sat, 25 Jul 2020 10:27:50 +0800
Message-ID: <1595644070-26293-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

destroy_workqueue() should be called to destroy ndev->tx_wq
when nbd_start_device init resources fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce7e9f22..45e0a9f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -4,7 +4,7 @@
  *
  * Note that you can not swap over this thing, yet. Seems to work but
  * deadlocks sometimes - you can not swap over TCP in general.
- * 
+ *
  * Copyright 1997-2000, 2008 Pavel Machek <pavel@ucw.cz>
  * Parts copyright 2001 Steven Whitehouse <steve@chygwyn.com>
  *
@@ -1270,6 +1270,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
+		destroy_workqueue(nbd->recv_workq);
 		return error;
 	}
 	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
@@ -1291,6 +1292,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 			 */
 			if (i)
 				flush_workqueue(nbd->recv_workq);
+			destroy_workqueue(nbd->recv_workq);
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
-- 
2.7.4


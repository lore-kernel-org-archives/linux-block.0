Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B645C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABAD21850
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 06:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfKSGCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:02:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfKSGCF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 01:02:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 919E13E336AF090E4B98;
        Tue, 19 Nov 2019 14:02:02 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 14:01:52 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>
Subject: [v2] nbd:fix memory leak in nbd_get_socket()
Date:   Tue, 19 Nov 2019 14:09:11 +0800
Message-ID: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before return NULL,put the sock first.

Cc: stable@vger.kernel.org
Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v2: add cc:stable tag
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a94ee45..19e7599 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -993,6 +993,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
+		sockfd_put(sock);
 		return NULL;
 	}
 
-- 
2.7.4


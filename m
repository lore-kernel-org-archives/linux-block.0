Return-Path: <SRS0=gmaS=7Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34AAC433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DAE206D7
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 08:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLI5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:57:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbgFLI5l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jun 2020 04:57:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EA043C61EFE8A206547;
        Fri, 12 Jun 2020 16:57:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 16:57:32 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] nbd: Fix memory leak in nbd_add_socket
Date:   Fri, 12 Jun 2020 17:04:37 +0800
Message-ID: <20200612090437.77977-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nbd_add_socket
  socks = krealloc(num_connections+1) -->if num_connections is 0, alloc 1
  nsock = kzalloc                     -->If fail, will return

nbd_config_put
  if (config->num_connections)        -->0, not free
    kfree(config->socks)

Thus memleak happens, this patch fixes that.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/block/nbd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..3e7709317b17 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1037,21 +1037,22 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		return -EBUSY;
 	}

+	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
+	if (!nsock) {
+		sockfd_put(sock);
+		return -ENOMEM;
+	}
+
 	socks = krealloc(config->socks, (config->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks) {
 		sockfd_put(sock);
+		kfree(nsock);
 		return -ENOMEM;
 	}

 	config->socks = socks;

-	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
-	if (!nsock) {
-		sockfd_put(sock);
-		return -ENOMEM;
-	}
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
--
2.26.0.106.g9fadedd


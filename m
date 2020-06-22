Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE61C433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0852068F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFVLNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:13:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbgFVLNH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 07:13:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB557B8189E77C3B414F;
        Mon, 22 Jun 2020 19:13:05 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 22 Jun 2020
 19:12:56 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <Markus.Elfring@web.de>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <navid.emamdoost@gmail.com>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v3] nbd: Fix memory leak in nbd_add_socket
Date:   Mon, 22 Jun 2020 19:20:01 +0800
Message-ID: <20200622112001.105047-1-zhengbin13@huawei.com>
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

When adding first socket to nbd, if nsock's allocation failed, the data
structure member "config->socks" was reallocated, but the data structure
member "config->num_connections" was not updated. A memory leak will occur
then because the function "nbd_config_put" will free "config->socks" only
when "config->num_connections" is not zero.

Fixes: 03bf73c315ed ("nbd: prevent memory leak")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---

v1->v2: improve change description
v2->v3: fix some code style issues, improve change description, thanks to
        Markus for the review.

 drivers/block/nbd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..ce7e9f223b20 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1033,25 +1033,26 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	     test_bit(NBD_RT_BOUND, &config->runtime_flags))) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
-		sockfd_put(sock);
-		return -EBUSY;
+		err = -EBUSY;
+		goto put_socket;
+	}
+
+	nsock = kzalloc(sizeof(*nsock), GFP_KERNEL);
+	if (!nsock) {
+		err = -ENOMEM;
+		goto put_socket;
 	}

 	socks = krealloc(config->socks, (config->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks) {
-		sockfd_put(sock);
-		return -ENOMEM;
+		kfree(nsock);
+		err = -ENOMEM;
+		goto put_socket;
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
@@ -1063,6 +1064,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	atomic_inc(&config->live_connections);

 	return 0;
+
+put_socket:
+	sockfd_put(sock);
+	return err;
 }

 static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
--
2.26.0.106.g9fadedd


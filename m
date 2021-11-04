Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C09C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 04:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B8B611C3
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 04:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhKDEFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 00:05:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25357 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDEFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 00:05:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hl8x04JDJzbhXG;
        Thu,  4 Nov 2021 11:57:40 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 12:02:25 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 12:02:25 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] nbd: code clean for kiocb_done()
Date:   Thu, 4 Nov 2021 12:34:32 +0800
Message-ID: <1636000472-3092-1-git-send-email-wubo40@huawei.com>
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

A simple code clean for nbd_genl_status()

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/block/nbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b47b2a8..175ea97 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2375,7 +2375,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	reply_head = genlmsg_put_reply(reply, info, &nbd_genl_family, 0,
 				       NBD_CMD_STATUS);
 	if (!reply_head) {
-		nlmsg_free(reply);
 		goto out;
 	}
 
@@ -2383,7 +2382,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-			nlmsg_free(reply);
 			goto out;
 		}
 	} else {
@@ -2392,7 +2390,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 		if (nbd) {
 			ret = populate_nbd_status(nbd, reply);
 			if (ret) {
-				nlmsg_free(reply);
 				goto out;
 			}
 		}
@@ -2401,6 +2398,8 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	genlmsg_end(reply, reply_head);
 	ret = genlmsg_reply(reply, info);
 out:
+	if (reply)
+		nlmsg_free(reply);
 	mutex_unlock(&nbd_index_mutex);
 	return ret;
 }
-- 
1.8.3.1


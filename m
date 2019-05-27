Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB8C07542
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 05:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C288F2075B
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 05:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfE0FqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 01:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0FqL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 01:46:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22F1330820C9;
        Mon, 27 May 2019 05:46:11 +0000 (UTC)
Received: from rhel3.localdomain (ovpn-12-147.pek2.redhat.com [10.72.12.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30B5560C9B;
        Mon, 27 May 2019 05:46:07 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        atumball@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] nbd: fix crash when the blksize is zero
Date:   Mon, 27 May 2019 13:44:38 +0800
Message-Id: <20190527054438.13548-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 27 May 2019 05:46:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

This will allow the blksize to be set zero and then use 1024 as
default.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a..4c1de1c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -135,6 +135,8 @@ struct nbd_cmd {
 
 #define NBD_MAGIC 0x68797548
 
+#define NBD_DEF_BLKSIZE 1024
+
 static unsigned int nbds_max = 16;
 static int max_part = 16;
 static struct workqueue_struct *recv_workqueue;
@@ -1237,6 +1239,14 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 		nbd_config_put(nbd);
 }
 
+static bool nbd_is_valid_blksize(unsigned long blksize)
+{
+	if (!blksize || !is_power_of_2(blksize) || blksize < 512 ||
+		blksize > PAGE_SIZE)
+		return false;
+	return true;
+}
+
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
@@ -1252,8 +1262,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
-		if (!arg || !is_power_of_2(arg) || arg < 512 ||
-		    arg > PAGE_SIZE)
+		if (!arg)
+			arg = NBD_DEF_BLKSIZE;
+		if (!nbd_is_valid_blksize(arg))
 			return -EINVAL;
 		nbd_size_set(nbd, arg,
 			     div_s64(config->bytesize, arg));
@@ -1333,7 +1344,7 @@ static struct nbd_config *nbd_alloc_config(void)
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
 	init_waitqueue_head(&config->conn_wait);
-	config->blksize = 1024;
+	config->blksize = NBD_DEF_BLKSIZE;
 	atomic_set(&config->live_connections, 0);
 	try_module_get(THIS_MODULE);
 	return config;
@@ -1769,6 +1780,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
 		u64 bsize =
 			nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
+		if (!bsize)
+			bsize = NBD_DEF_BLKSIZE;
+		if (!nbd_is_valid_blksize(bsize))
+			return -EINVAL;
 		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
 	}
 	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-- 
1.8.3.1


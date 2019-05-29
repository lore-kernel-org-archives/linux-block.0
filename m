Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B64C46470
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CBB24135
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfE2UQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfE2UQJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C2DB30C3198;
        Wed, 29 May 2019 20:16:09 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-41.rdu2.redhat.com [10.10.122.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083CF19C70;
        Wed, 29 May 2019 20:16:08 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/2] nbd: fix crash when the blksize is zero v2
Date:   Wed, 29 May 2019 15:16:05 -0500
Message-Id: <20190529201606.14903-2-mchristi@redhat.com>
In-Reply-To: <20190529201606.14903-1-mchristi@redhat.com>
References: <20190529201606.14903-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 29 May 2019 20:16:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

This will allow the blksize to be set zero and then use 1024 as
default.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
[fix to use goto out instead of return in genl_connect]
Signed-off-by: Mike Christie <mchristi@redhat.com>
---

V2:
- Fix error handling in genl_connect.

 drivers/block/nbd.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a8a2ba..236253fbf455 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -135,6 +135,8 @@ static struct dentry *nbd_dbg_dir;
 
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
+	    blksize > PAGE_SIZE)
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
@@ -1769,6 +1780,12 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
 		u64 bsize =
 			nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
+		if (!bsize)
+			bsize = NBD_DEF_BLKSIZE;
+		if (!nbd_is_valid_blksize(bsize)) {
+			ret = -EINVAL;
+			goto out;
+		}
 		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
 	}
 	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-- 
2.21.0


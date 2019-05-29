Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B1C28CC1
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEF024135
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfE2UQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfE2UQK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51FC08831F;
        Wed, 29 May 2019 20:16:10 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-41.rdu2.redhat.com [10.10.122.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C44321972C;
        Wed, 29 May 2019 20:16:09 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 2/2] nbd: add netlink reconfigure resize support v3
Date:   Wed, 29 May 2019 15:16:06 -0500
Message-Id: <20190529201606.14903-3-mchristi@redhat.com>
In-Reply-To: <20190529201606.14903-1-mchristi@redhat.com>
References: <20190529201606.14903-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 May 2019 20:16:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the device is setup with ioctl we can resize the device after the
initial setup, but if the device is setup with netlink we cannot use the
resize related ioctls and there is no netlink reconfigure size ATTR
handling code.

This patch adds netlink reconfigure resize support to match the ioctl
interface.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---

V3;
- If the device size or block size has not changed do not call
nbd_size_set.

V2:
- Merge reconfig and connect resize related code to helper and avoid
multiple nbd_size_set calls.

 drivers/block/nbd.c | 48 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 236253fbf455..9486555e6391 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1685,6 +1685,30 @@ nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
 	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
 };
 
+static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
+{
+	struct nbd_config *config = nbd->config;
+	u64 bsize = config->blksize;
+	u64 bytes = config->bytesize;
+
+	if (info->attrs[NBD_ATTR_SIZE_BYTES])
+		bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
+
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
+		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
+		if (!bsize)
+			bsize = NBD_DEF_BLKSIZE;
+		if (!nbd_is_valid_blksize(bsize)) {
+			printk(KERN_ERR "Invalid block size %llu\n", bsize);
+			return -EINVAL;
+		}
+	}
+
+	if (bytes != config->bytesize || bsize != config->blksize)
+		nbd_size_set(nbd, bsize, div64_u64(bytes, bsize));
+	return 0;
+}
+
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd = NULL;
@@ -1772,22 +1796,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	refcount_set(&nbd->config_refs, 1);
 	set_bit(NBD_BOUND, &config->runtime_flags);
 
-	if (info->attrs[NBD_ATTR_SIZE_BYTES]) {
-		u64 bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
-		nbd_size_set(nbd, config->blksize,
-			     div64_u64(bytes, config->blksize));
-	}
-	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
-		u64 bsize =
-			nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
-		if (!bsize)
-			bsize = NBD_DEF_BLKSIZE;
-		if (!nbd_is_valid_blksize(bsize)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
-	}
+	ret = nbd_genl_size_set(info, nbd);
+	if (ret)
+		goto out;
+
 	if (info->attrs[NBD_ATTR_TIMEOUT]) {
 		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
 		nbd->tag_set.timeout = timeout * HZ;
@@ -1956,6 +1968,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	ret = nbd_genl_size_set(info, nbd);
+	if (ret)
+		goto out;
+
 	if (info->attrs[NBD_ATTR_TIMEOUT]) {
 		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
 		nbd->tag_set.timeout = timeout * HZ;
-- 
2.21.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF15C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E9601FD
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhHKMwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHKMwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 08:52:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2AC061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gx6W6wlVWZJkJhCx8D92XleAgs9HpKjOXDw5OWXK6YQ=; b=ZxCQInjbAKr9x0+p+HJ4YIf6Tz
        30mHrkdvaQ4WlUVubHxw3nONpnoGnp6Go3wIwGXyZKVEdJbGVYTMyzh5IHjjpCn9/VBPYanQEAXqL
        wyIbRLJfX/LFDljQOHfLFsCnAbC11RqMbxq/tL6QrAS6CDsxLVKeHBIESnWeOp/kZjDnMIXWGsCtS
        3e57t/g4p9/mrvB6dNntjZYqzRbV3gtTSWq4CM6+mVA+aKdql55/cR5G01kFzYaViRWmGxs4De7PS
        4toyL98clKFutIjsQ+MkdxCXLkUVd0s7MHic7Ohf5uaMbnWmpGBq4/80BB740aladpghN9ALQjiXV
        Mq7JSUJQ==;
Received: from [2001:4bb8:184:6215:7ee3:d0e9:131a:82ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDng3-00DQBi-5d; Wed, 11 Aug 2021 12:50:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 5/6] nbd: refactor device search and allocation in nbd_genl_connect
Date:   Wed, 11 Aug 2021 14:44:27 +0200
Message-Id: <20210811124428.2368491-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
References: <20210811124428.2368491-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use idr_for_each_entry instead of the awkward callback to find an
existing device for the index == -1 case, and de-duplicate the device
allocation if no existing device was found.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 08161c73c9ed..0b46a608f879 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1765,18 +1765,6 @@ static struct nbd_device *nbd_dev_add(int index)
 	return ERR_PTR(err);
 }
 
-static int find_free_cb(int id, void *ptr, void *data)
-{
-	struct nbd_device *nbd = ptr;
-	struct nbd_device **found = data;
-
-	if (!refcount_read(&nbd->config_refs)) {
-		*found = nbd;
-		return 1;
-	}
-	return 0;
-}
-
 /* Netlink interface. */
 static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_INDEX]		=	{ .type = NLA_U32 },
@@ -1846,31 +1834,26 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 again:
 	mutex_lock(&nbd_index_mutex);
 	if (index == -1) {
-		ret = idr_for_each(&nbd_index_idr, &find_free_cb, &nbd);
-		if (ret == 0) {
-			nbd = nbd_dev_add(-1);
-			if (IS_ERR(nbd)) {
-				mutex_unlock(&nbd_index_mutex);
-				printk(KERN_ERR "nbd: failed to add new device\n");
-				return PTR_ERR(nbd);
+		struct nbd_device *tmp;
+		int id;
+
+		idr_for_each_entry(&nbd_index_idr, tmp, id) {
+			if (!refcount_read(&tmp->config_refs)) {
+				nbd = tmp;
+				break;
 			}
 		}
 	} else {
 		nbd = idr_find(&nbd_index_idr, index);
-		if (!nbd) {
-			nbd = nbd_dev_add(index);
-			if (IS_ERR(nbd)) {
-				mutex_unlock(&nbd_index_mutex);
-				printk(KERN_ERR "nbd: failed to add new device\n");
-				return PTR_ERR(nbd);
-			}
-		}
 	}
+
 	if (!nbd) {
-		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
-		       index);
-		mutex_unlock(&nbd_index_mutex);
-		return -EINVAL;
+		nbd = nbd_dev_add(index);
+		if (IS_ERR(nbd)) {
+			mutex_unlock(&nbd_index_mutex);
+			pr_err("nbd: failed to add new device\n");
+			return PTR_ERR(nbd);
+		}
 	}
 
 	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
-- 
2.30.2


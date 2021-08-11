Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDAEC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C787860FC3
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhHKMui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhHKMug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 08:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5BC06179B
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3mjdZMlNYqnRKE0+IaFRdNsseXkfPbPjC5ghDv9vByM=; b=WiFSG1BYq4TIKneYknmEF9YLLu
        zqFg5SdkKfxOZMNr6bgpWL9Jhsvtbysz6gbxuBBalCujhf/SN5aFT9XVH26K1IzOY5KlHwfYwM8pb
        b0mPFyTaVID3DfzN7Nf2tXXfBXi6k1+Lb+7LBFooK22IoinaYdJHd7BaadwqRKkHfolQ/+jDWK6Bh
        Jo1HgCN4/j0ob2Eu9hzOzu3ErFR9vumxfUVmSVnUMCQjFX7Kth5Rt8EG6OxnrHMjLyWGJ0uTOPsGc
        nMLRSK1zOgcgCYLo2CnZT7A2KLeiOpHZqdb8OCrQsVweVLvj8echmDpwbtIIgyScahZy5XbKGfWy7
        i3eOmnrw==;
Received: from [2001:4bb8:184:6215:7ee3:d0e9:131a:82ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDneb-00DQ2A-4D; Wed, 11 Aug 2021 12:48:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 4/6] nbd: return the allocated nbd_device from nbd_dev_add
Date:   Wed, 11 Aug 2021 14:44:26 +0200
Message-Id: <20210811124428.2368491-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
References: <20210811124428.2368491-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return the device we just allocated instead of doing an extra search for
it in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index de8b23af2486..08161c73c9ed 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1681,7 +1681,7 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static int nbd_dev_add(int index)
+static struct nbd_device *nbd_dev_add(int index)
 {
 	struct nbd_device *nbd;
 	struct gendisk *disk;
@@ -1753,7 +1753,7 @@ static int nbd_dev_add(int index)
 	sprintf(disk->disk_name, "nbd%d", index);
 	add_disk(disk);
 	nbd_total_devices++;
-	return index;
+	return nbd;
 
 out_free_idr:
 	idr_remove(&nbd_index_idr, index);
@@ -1762,7 +1762,7 @@ static int nbd_dev_add(int index)
 out_free_nbd:
 	kfree(nbd);
 out:
-	return err;
+	return ERR_PTR(err);
 }
 
 static int find_free_cb(int id, void *ptr, void *data)
@@ -1848,25 +1848,22 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &find_free_cb, &nbd);
 		if (ret == 0) {
-			int new_index;
-			new_index = nbd_dev_add(-1);
-			if (new_index < 0) {
+			nbd = nbd_dev_add(-1);
+			if (IS_ERR(nbd)) {
 				mutex_unlock(&nbd_index_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
-				return new_index;
+				return PTR_ERR(nbd);
 			}
-			nbd = idr_find(&nbd_index_idr, new_index);
 		}
 	} else {
 		nbd = idr_find(&nbd_index_idr, index);
 		if (!nbd) {
-			ret = nbd_dev_add(index);
-			if (ret < 0) {
+			nbd = nbd_dev_add(index);
+			if (IS_ERR(nbd)) {
 				mutex_unlock(&nbd_index_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
+				return PTR_ERR(nbd);
 			}
-			nbd = idr_find(&nbd_index_idr, index);
 		}
 	}
 	if (!nbd) {
-- 
2.30.2


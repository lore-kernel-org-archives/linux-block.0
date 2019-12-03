Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE8C432C3
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620EA20661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q3glmRFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCJjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I/dfLPEiJpRIYKhZnVcBN19bbymOFqlsA3ZFJkAje4A=; b=Q3glmRFUmXm846UB98NIjadgfc
        cbEDWXy4kbrVUEcip/ig0mXig60bCZ9diASH0ejo7QZ/3MlS2Z9kwY9icBLyslX5U/GIVW96XuwDP
        E7pCxLJ8Gonpv6KlYcYMfC1NOqh7mrzcDWeag/zMpJtYkPuGbCHGcH1PxVVbzJkKUUM3j6icWtVYw
        GlyJK7vnyeLRrjb0JbTRejZC3QbUVnJQvYLA4gKG6oPQsBMgiu0o9aCcojofdgNhAl2lQp9DCLokT
        n7wz2UomZMIz3jxPGL1V5Q4LSgWFBTkgWJvJuJaqdqNUQ7pD/TL3lRW5qEFg8f5cmB2fHktQuxVrb
        VrSQ+qBQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eH-00023t-DH; Tue, 03 Dec 2019 09:39:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/8] null_blk: fix zone size paramter check
Date:   Tue,  3 Dec 2019 10:39:01 +0100
Message-Id: <20191203093908.24612-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

For zoned=1 mode, the zone size must be a power of 2. Check this not
only when the zone size is specified during modprobe, but also when
creating a zoned null_blk device using configfs.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk_main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 795fda576824..53ba9c7f2786 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1607,7 +1607,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	return blk_mq_alloc_tag_set(set);
 }
 
-static void null_validate_conf(struct nullb_device *dev)
+static int null_validate_conf(struct nullb_device *dev)
 {
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
@@ -1634,6 +1634,14 @@ static void null_validate_conf(struct nullb_device *dev)
 	/* can not stop a queue */
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
+
+	if (dev->zoned &&
+	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
+		pr_err("zone_size must be power-of-two\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -1666,7 +1674,9 @@ static int null_add_dev(struct nullb_device *dev)
 	struct nullb *nullb;
 	int rv;
 
-	null_validate_conf(dev);
+	rv = null_validate_conf(dev);
+	if (rv)
+		return rv;
 
 	nullb = kzalloc_node(sizeof(*nullb), GFP_KERNEL, dev->home_node);
 	if (!nullb) {
@@ -1792,11 +1802,6 @@ static int __init null_init(void)
 		g_bs = PAGE_SIZE;
 	}
 
-	if (!is_power_of_2(g_zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
-
 	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
 		pr_err("invalid home_node value\n");
 		g_home_node = NUMA_NO_NODE;
-- 
2.20.1


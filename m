Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76494C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321AB2192A
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+fdu4Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgINHKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgINHKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 03:10:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D84C06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=seop/G6ltcPMuUChhihr9hrjZOz8RlybwS4wMIqBO0Q=; b=G+fdu4Qpm7AYfhJwTp+YeH0mXG
        no+5gSe5GKw5kjJKgQoZ0Yxx++m4rrt7aQr7DekBtSzWpp3AwnooSelu1qF0Vh6px7wV7+ORFvdTp
        IxNKVEJBJy+7vch85HAvRw4YYVRYJX9HjIovXon60H//gSksyp8cjuwXf6mc6+4lnGN8vD9LiZhf+
        hD/r/iOtO5OdW6R6lNjZ8lUGJpJEWHqC+TEAqpkY6KIjWwmY85NHTlkoUVYwREQOT7VHZ1wG2a571
        x1TBlmGR2Xiv1qaJLMHiMRnofSyFZ5mK2WvKPQiOmGYcH8guo9n7NGmDn9q5Q2PJg3il3/Vrg+xSf
        OkdEJdlg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHicu-0006qC-20; Mon, 14 Sep 2020 07:10:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] umem: remove ->revalidate_disk
Date:   Mon, 14 Sep 2020 09:03:36 +0200
Message-Id: <20200914070337.1578317-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914070337.1578317-1-hch@lst.de>
References: <20200914070337.1578317-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->revalidate_disk is only called during add_disk for pd, but at that
point the driver has already set the capacity to the same value a little
earlier, so this additional update is entirely superflous.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/umem.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 2b95d7b33b9186..58df81988d1207 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -746,21 +746,6 @@ static void del_battery_timer(void)
 	del_timer(&battery_timer);
 }
 
-/*
- * Note no locks taken out here.  In a worst case scenario, we could drop
- * a chunk of system memory.  But that should never happen, since validation
- * happens at open or mount time, when locks are held.
- *
- *	That's crap, since doing that while some partitions are opened
- * or mounted will give you really nasty results.
- */
-static int mm_revalidate(struct gendisk *disk)
-{
-	struct cardinfo *card = disk->private_data;
-	set_capacity(disk, card->mm_size << 1);
-	return 0;
-}
-
 static int mm_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	struct cardinfo *card = bdev->bd_disk->private_data;
@@ -781,7 +766,6 @@ static const struct block_device_operations mm_fops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= mm_submit_bio,
 	.getgeo		= mm_getgeo,
-	.revalidate_disk = mm_revalidate,
 };
 
 static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
-- 
2.28.0


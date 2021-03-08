Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3BC433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9626513A
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCHHq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 02:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhCHHqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 02:46:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA8C06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 23:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KvvVKL5yYTWIbgugXKJBcDwWaMRqskGEcVfDiHCc12k=; b=G3IVGMSoYEyTDZ8yRL6Jt+5g33
        SDd0+MgQjjvsKoANSIu2A8vsnZm1mcWVUWG7LnG+pLFFi570TuZwTPHPsyFpQm/MjiQrShFHG1XyW
        J4h054u28smrhfqVSWqBqW5ug4l3T+t43+hEvRafvqiHE/KpWzdi2CHPAjW2pUKyJsXD7/VIh5kAO
        e8o+IG5kGXmvCjQ5NUsJHj8d+BeysG4MvXxpohEZpYxTht/hk5J0Vzo6auDgjqHwuzrJI9mLbtbKU
        PIqbi450eR+fHK93z5Rxv7gus73/aVWSjFbC0wG6qTy/5dG2bsPAOj5/UY0QPYEqdUACRqH3c/lvR
        1L+mZkkw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJAaX-00FBq7-Vw; Mon, 08 Mar 2021 07:46:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] umem: remove ->revalidate_disk
Date:   Mon,  8 Mar 2021 08:45:49 +0100
Message-Id: <20210308074550.422714-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308074550.422714-1-hch@lst.de>
References: <20210308074550.422714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
index 982732dbe82e69..4c8320bfc46b5c 100644
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
2.30.1


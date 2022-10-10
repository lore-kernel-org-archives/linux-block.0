Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 13:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJJNTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJJNTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 09:19:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765541D30
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+5Nl9hmrlYBUvWzDGsmzEab15Hde/M7Sk3YczfDFm3c=; b=oBGu/VsGsM1rNW8QlIj6+Ax9b8
        dcMkEXcJUDzNzs/vtiIdqz/JJn78tvQs5eUX4EN5MBaff4hkVJxX6S4R/MEH+UE50F4phgI3Qp0F/
        ii5k6JrSV1l5+zXmnszj6wY77EUo+C2GCQy+6f9JdMkxIQEt/BMhAEnJ2/+/Ry3apimhmHg++AkHD
        RggPPRKjAhX1fEtWjjG+jXzKPct7zbdDyxLHcpirPpwbaVdN7Eg3E/4Fzr9CG/bIMzTxnMeO5DCBE
        uYr14CcAuwxDXU20wyIkkymafLaizrMarz+Td9vbks4H9elfXATjYdqOrrKrykU5waR5lDjWdOgrc
        m2Z5J3Qw==;
Received: from [2001:4bb8:18a:723b:fb35:3fe:67e:4563] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohsgO-0010E4-Lv; Mon, 10 Oct 2022 13:19:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] block: fix leaking minors of hidden disks
Date:   Mon, 10 Oct 2022 15:18:57 +0200
Message-Id: <20221010131857.748129-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The major/minor of a hidden gendisk is not propagated to the block
device because it is never registered using bdev_add.  But the lack of
bd_dev also causes the dynamic major minor number not to be freed.
Assign bd_dev manually to ensure the dynamic major minor gets freed.

Based on a patch by Keith Busch.

Fixes:  8ddcd653257c ("block: introduce GENHD_FL_HIDDEN")
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
---
 block/genhd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c5..17b33c62423df 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -507,6 +507,13 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+	} else {
+		/*
+		 * Even if the block_device for a hidden gendisk is not
+		 * registered, it needs to have a valid bd_dev so that the
+		 * freeing of the dynamic major works.
+		 */
+		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
 	}
 
 	disk_update_readahead(disk);
-- 
2.30.2


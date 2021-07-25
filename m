Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA8AC4338F
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C55660F13
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhGYFPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:15:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F32C061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AvJYaFfBVMBdBjuwOKPXGcoUZ/ezVxHu1ITShLP6r9M=; b=ZTL66CNGnUE97Vp9Eq1/Bmh61p
        xxPiSw06yFWO2xElIeNGpuFZsVJkrB1rML+pQcxwqVOvImV9thsGjvuY4bnYwyboxgZ2BxdYBw+hy
        GB9mXNX2PX8cBIaQrV5yIMXB5yvQ8reEFrE/d/4qREpzWbteSm+xTCiNi7ddMRLLldlxUXeZY5zQo
        +NfvyO0UeRe6qgBrZ2G118Sxf4hhvQXEcEeld7DPNxyeKm0Ku21cAV6ERqvI3O+Vw/7Mp+8evtbs9
        p2f+i3bM6pYcv0l8qhxknvzVYZHmVSTqfQ6dpbSOARcXt3BJ3QwcxzZAg/1+HrA8tOTU3N/hJTbV5
        bILtM81w==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X6o-00Cpgt-LI; Sun, 25 Jul 2021 05:55:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: remove the extra kobject reference in bd_link_disk_holder
Date:   Sun, 25 Jul 2021 07:54:52 +0200
Message-Id: <20210725055458.29008-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the new block_device life time rules there is no way for the
bdev to go away as long as there is a holder, so remove these.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/holder.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 904a1dcd5c12..960654a71342 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -92,11 +92,6 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del;
-	/*
-	 * bdev could be deleted beneath us which would implicitly destroy
-	 * the holder directory.  Hold on to it.
-	 */
-	kobject_get(bdev->bd_holder_dir);
 
 	list_add(&holder->list, &bdev->bd_holder_disks);
 	goto out_unlock;
@@ -130,7 +125,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
 		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-- 
2.30.2


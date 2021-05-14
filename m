Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3415C43461
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B474961460
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhENNUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhENNUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 09:20:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721FC06174A
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=53wtTPad2Y8dLBLU4ADQMRxEycXNzduRhTAuj7y8IOU=; b=iBc1Kjpbjy4eNBLZ2u8nxrFtmv
        vIsFfoMknC4m7dzI1MjqVAqbHomk3Y05SobRZH/s2Qo26zxAzzxTdD7Ue2k6SDs5HzhkTG05Gdc0F
        KTjAUNCD6OplYsd/4s9sR8lViTpAk2XBomh3cy23IFba/HO8u5zf5UDOrH9hBZk64jZOax+FWp5wH
        DaV5Rybgl4F2N0eW9ghjIzhy31NTL7uByWBk9BvgV5tQIq+nNuqSxfwhYOesd6Y1zrpGXFSCZPfbX
        6aYemQG3sNLNGsv3fjC8c+LxcCeV74Vp5AopV5k2xdTXUK60jEIR28aA+9sgr5GJcVsuW8aHHxtBA
        0+XKk2mw==;
Received: from [2001:4bb8:198:fbc8:cf38:8667:24ad:8b9e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhXiM-00Bzya-U1; Fri, 14 May 2021 13:18:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPART
Date:   Fri, 14 May 2021 15:18:42 +0200
Message-Id: <20210514131842.1600568-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514131842.1600568-1-hch@lst.de>
References: <20210514131842.1600568-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gulam Mohamed <gulam.mohamed@oracle.com>

When BLKRRPART is called concurrently with del_gendisk, the partitions
rescan can create a stale partition that will never be be cleaned up.

Fix this by checking the the disk is up before rescanning partitions
while under bd_mutex.

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 580bae995b87..4494411fa4d3 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1244,6 +1244,9 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
+	if (!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
+
 rescan:
 	if (bdev->bd_part_count)
 		return -EBUSY;
-- 
2.30.2


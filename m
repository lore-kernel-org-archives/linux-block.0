Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463CC54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 06:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15C120CC7
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 06:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcdEPkBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgDUGMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUGMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 02:12:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C3C061A0F;
        Mon, 20 Apr 2020 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Fs0wPMYxvGmO2IT3Wvj2CTBXvnvcNivwuYu4FRE1SCI=; b=bcdEPkBfhKOPABDQ5Dsha37HM3
        eiUij9xN/DG0iEUE2o4+ymVZLXy4WTHEZ93i2poYzXi35OEw0UaBNRCm3UsBgg7WNR3KoPmruhr/f
        Tt1f1l2KDEI5rtmjNRHaRnSEi8NEoX+foGuKXs/UKBrK4hLSFO5WKIx+MuLWRFDoBZl9/tom0LjvL
        cMc+fqi77vKCxaNuCR0ezJ69UZ4M47yK9VJWZ+NadNl/qN521hJSN1uCz91OFkf2D96u10vgrxuDg
        afXttZeFQSKeSpoFZG8emNnEtWtBBpYYGRPESwFvXeXzwCtxh0SUBj/5wVxPD7Kij8oDkhJIYT/m9
        Ni0TgIVQ==;
Received: from [2001:4bb8:191:e12c:292e:7dec:cf13:becd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQm9B-0000MF-HQ; Tue, 21 Apr 2020 06:12:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] partitions/ibm: stop using ioctl_by_bdev
Date:   Tue, 21 Apr 2020 08:12:26 +0200
Message-Id: <20200421061226.33731-4-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421061226.33731-1-hch@lst.de>
References: <20200421061226.33731-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just call the getgeo and biodasdinfo methods directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/ibm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..21dc6da20ff2 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -289,6 +289,7 @@ static int find_cms1_partitions(struct parsed_partitions *state,
 int ibm_partition(struct parsed_partitions *state)
 {
 	struct block_device *bdev = state->bdev;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
@@ -308,15 +309,16 @@ int ibm_partition(struct parsed_partitions *state)
 	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
 	if (info == NULL)
 		goto out_exit;
-	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
+	geo = kzalloc(sizeof(struct hd_geometry), GFP_KERNEL);
 	if (geo == NULL)
 		goto out_nogeo;
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	geo->start = get_start_sect(bdev);
+	if (!disk->fops->getgeo || disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+	if (!disk->fops->biodasdinfo || disk->fops->biodasdinfo(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
-- 
2.26.1


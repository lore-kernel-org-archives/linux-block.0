Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381AC433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F82083E
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltNSU7Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHaSJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgHaSJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:09:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C6C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CGLRxORyJfgIM8iKzIdIkGUptjrObHkxZKhjMwgJS8A=; b=ltNSU7Gj7LE3+dYZTnGrmDhzrs
        39QkaUVYjWiTLbzvLSQQMfArLJe/B00rQic5Chg411Q/NYYkoOe/ZfcxATUN1uBsVEUwPnrADLvaO
        WF9vLQT3rgPAoM/vi2u/yIik4QeIVp1bkZZuLtacIXzkjTIL7RukylEcZBN2AkQmTmpLco5MgAUaT
        MmWR6JLiKgV/aqJUU91t3xy5djH9Ph+2LybDlMaM3NzWql26UFJlBJIgEa0OqjEQCwEQmCOfhiTKb
        +622e+AcYciKzpuWTemKLmmQmC4Vu8o6htKY/JfKIvoGK6o6jPz69px1yJHoWVPmGL9g3Bqxe7LQd
        JCqb9wJw==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoEx-00024I-O8; Mon, 31 Aug 2020 18:09:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: remove the discard_alignment field from struct hd_struct
Date:   Mon, 31 Aug 2020 20:02:34 +0200
Message-Id: <20200831180239.2372776-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The alignment offset is only used in slow path callers, so just calculate
it on the fly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 7 ++++---
 include/linux/blkdev.h  | 4 ++--
 include/linux/genhd.h   | 1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4baa065eef7864..1150474caca0cf 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -209,7 +209,10 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 					   struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%u\n", p->discard_alignment);
+
+	return sprintf(buf, "%u\n",
+		queue_limit_discard_alignment(&part_to_disk(p)->queue->limits,
+				p->start_sect));
 }
 
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
@@ -400,8 +403,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	pdev = part_to_dev(p);
 
 	p->start_sect = start;
-	p->discard_alignment =
-		queue_limit_discard_alignment(&disk->queue->limits, start);
 	p->nr_sects = len;
 	p->partno = partno;
 	p->policy = get_disk_ro(disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba1f5f5e11c647..d0d61bc81615b2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1498,8 +1498,8 @@ static inline int bdev_discard_alignment(struct block_device *bdev)
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (bdev != bdev->bd_contains)
-		return bdev->bd_part->discard_alignment;
-
+		return queue_limit_discard_alignment(&q->limits,
+				bdev->bd_part->start_sect);
 	return q->limits.discard_alignment;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index bfa411c80dbbf8..9ea2ca31c278ea 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -65,7 +65,6 @@ struct hd_struct {
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
-	unsigned int discard_alignment;
 	struct device __dev;
 	struct kobject *holder_dir;
 	int policy, partno;
-- 
2.28.0


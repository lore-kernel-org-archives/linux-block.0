Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D404C433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D6320866
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VQQVYJke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHaSHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHaSHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B5C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qaPsLp1YSbweV0eOlJwr9aKO6hbWEujlR8hcnDj2Rc4=; b=VQQVYJkeNL8ZamcwQ2rpWTPZ8r
        tA1+SEj3jyitLVrvxkMyVoYK0zz7OdSX3dlVxMIjbLTdVK/mNBk4CuACPuN3tli7lwFdO/UporB7d
        uCHlra7rSMB1o17L2eGoi8rVdQfMtUlhsbG8ps0SZBaZ3ftQ48Wkuqv6qOyffkN2lrH/ZfijtgeVI
        Yj9L1OVN4xVC7L6MDl+PJdPv5mtiVnlJzax/74vrPfOIty370VDNKmWFoO+qI9NqKYh2RvlaR6KqE
        6BUck7FsgHXdZYd5SnusAWKy+QlzNBnPQ+5wDhxRtZSFksNWY0v+10mMt0WoYGsZWoJn0NMFvJk1o
        mk3LqxFw==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoCq-0001tU-KR; Mon, 31 Aug 2020 18:07:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: remove the alignment_offset field from struct hd_struct
Date:   Mon, 31 Aug 2020 20:02:33 +0200
Message-Id: <20200831180239.2372776-2-hch@lst.de>
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
 include/linux/blkdev.h  | 5 ++---
 include/linux/genhd.h   | 1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 328a2cb7875ba1..4baa065eef7864 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -199,7 +199,10 @@ static ssize_t part_alignment_offset_show(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%llu\n", (unsigned long long)p->alignment_offset);
+
+	return sprintf(buf, "%u\n",
+		queue_limit_alignment_offset(&part_to_disk(p)->queue->limits,
+				p->start_sect));
 }
 
 static ssize_t part_discard_alignment_show(struct device *dev,
@@ -397,8 +400,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	pdev = part_to_dev(p);
 
 	p->start_sect = start;
-	p->alignment_offset =
-		queue_limit_alignment_offset(&disk->queue->limits, start);
 	p->discard_alignment =
 		queue_limit_discard_alignment(&disk->queue->limits, start);
 	p->nr_sects = len;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a1730b30ad210..ba1f5f5e11c647 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1456,10 +1456,9 @@ static inline int bdev_alignment_offset(struct block_device *bdev)
 
 	if (q->limits.misaligned)
 		return -1;
-
 	if (bdev != bdev->bd_contains)
-		return bdev->bd_part->alignment_offset;
-
+		return queue_limit_alignment_offset(&q->limits,
+				bdev->bd_part->start_sect);
 	return q->limits.alignment_offset;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 39025dc0397c04..bfa411c80dbbf8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -65,7 +65,6 @@ struct hd_struct {
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
-	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
 	struct kobject *holder_dir;
-- 
2.28.0


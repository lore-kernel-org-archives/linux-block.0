Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F70C54FCF
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9962073E
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAUDnzmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCYPvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:51:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgCYPvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dVvUUl4brKfhB22qok93RMhMjOzy6dfQt+DTKwqJrMw=; b=nAUDnzmQvv3kmqdvZEBq9kL07J
        DEyyXrjEe/4Y5uFUwS9NjRvRhtTPHO7PS/1Zd1eaxBWKrCF6jHv4BDjs4hEvcaWC48L5YvESUC3lK
        Nfe57ZwQ0esyrKhkpbj37eg4Ta53z6VnmXNmiZLXSCzbtV4osxyOgjTkJHx/8MX+Gw+6lvzI9UD1/
        YCO7rnDfvdQw9sOH+9+4L2v4MffkSNqEm2LJS6fIGuUojJbV+7+Q/OlsLI/iUSHTd5G+ftJR8MnI/
        JoCUIwesO2PBF7F4hX49bf3OvW1wQwWHokhpBTYwMvEJ8VYYoYT7eTNLH5LJXvRUNxWW3tPDs7Mq4
        Du0XnDLg==;
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8JK-0006ke-8N; Wed, 25 Mar 2020 15:51:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] block: make the init_part_stats return value more logical
Date:   Wed, 25 Mar 2020 16:48:43 +0100
Message-Id: <20200325154843.1349040-10-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return 0 / -ENOMEM instead of a boolean dressed up as int.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c             | 2 +-
 block/partitions/core.c   | 2 +-
 include/linux/part_stat.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 6323cc789efa..95aef19ca8ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1644,7 +1644,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (disk) {
-		if (!init_part_stats(&disk->part0)) {
+		if (init_part_stats(&disk->part0)) {
 			kfree(disk);
 			return NULL;
 		}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b79c4513629b..6509351cb9d3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -377,7 +377,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p)
 		return ERR_PTR(-EBUSY);
 
-	if (!init_part_stats(p)) {
+	if (init_part_stats(p)) {
 		err = -ENOMEM;
 		goto out_free;
 	}
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ece607607a86..521ad787b0ec 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -48,8 +48,8 @@ static inline int init_part_stats(struct hd_struct *part)
 {
 	part->dkstats = alloc_percpu(struct disk_stats);
 	if (!part->dkstats)
-		return 0;
-	return 1;
+		return -ENOMEM;
+	return 0;
 }
 
 static inline void free_part_stats(struct hd_struct *part)
@@ -72,7 +72,7 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 
 static inline int init_part_stats(struct hd_struct *part)
 {
-	return 1;
+	return 0;
 }
 
 static inline void free_part_stats(struct hd_struct *part)
-- 
2.25.1


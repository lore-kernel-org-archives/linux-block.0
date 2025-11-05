Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DC343D9C
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372352; cv=none; b=YCJcKqLm2N6osw/NVNgd5H1EK4xOX6Q72oZsxieq/amyT6HqCjVnXahzUdq28LHSHy/9ksqS3GReDqIACekxK7FGu0P4/EwUDUitAexFAXd4/3Hz3R594ZQKS6Me3E3drq5sITXdhXVkX3UdMCTxWmJ00xKuZk604HWePOIlfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372352; c=relaxed/simple;
	bh=Y3huvySxgMgE+AwPQjKvuPAFFxrfTZt44GJ5BnSZmHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDhFS7xwOtrNL1hiGg3isoOTQKL+/HlDyHtFond5VFl2ayTX1tlEET4P7viwYYFHugySmil8YrZpm7Zq3uxJDNIn0hx9JvCIaiL5onCQsh+0V9qgAUbdUmgjelo3CVK6PUS7RSm7N9kTrVZhMzcJp17CmIvPzCL0mMrQ2ExhVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vrL1i30Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vrL1i30Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/g3VrcpycMpY03VIzpesO8TqTLWPV4qw3CGzBsall7w=; b=vrL1i30QHBTeaUoQRY6hb4w5Al
	yfVpDVXZlI8T2WuuUL10k79jKbiDo/cLOFB3gEkSLYIrUAmmJucCX1jxkhGj7LBcNWgqPaDX6DtJm
	n6KCb1bXqwRsp78JcjX07d1fq/sf5ImE/sYrMeG08oSH5XPEguiELNySVz3qAVqrom9IRXzZneHoJ
	AXJ79266Ez078qUvXxLDrGT4tPmsJnxCuHfUH1Aujtjf2wvb8s7rVvzXFP8fzm/JK0bZXrJNd6Ufi
	7X/LNZe2mjg2aUZ2SsSvUGVXmnpIEBIHPnW5K2OaIfLC+dZACiWcDk5lXCt2SDG0ErDwF3edTW4uG
	mdHvmsyA==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGjYS-0000000EKwA-373A;
	Wed, 05 Nov 2025 19:52:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: don't leak disk->zones_cond for !disk_need_zone_resources
Date: Wed,  5 Nov 2025 14:52:14 -0500
Message-ID: <20251105195225.2733142-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105195225.2733142-1-hch@lst.de>
References: <20251105195225.2733142-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

disk->zones_cond is allocated for all zoned devices, but
disk_free_zone_resources skips it when the zone write plug hash is not
allocated, leaking the allocation for non-mq devices that don't emulate
zone append.  This is reported by kmemleak-enabled xfstests for various
tests that use simple device mapper targets.

Fix this by moving all code that requires writes plugs from
disk_free_zone_resources into disk_destroy_zone_wplugs_hash_table
and executing the rest of the code, including the disk->zones_cond
freeing unconditionally.

Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bba64b427082..a0ce17e2143f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1834,6 +1834,14 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	kfree(disk->zone_wplugs_hash);
 	disk->zone_wplugs_hash = NULL;
 	disk->zone_wplugs_hash_bits = 0;
+
+	/*
+	 * Wait for the zone write plugs to be RCU-freed before destroying the
+	 * mempool.
+	 */
+	rcu_barrier();
+	mempool_destroy(disk->zone_wplugs_pool);
+	disk->zone_wplugs_pool = NULL;
 }
 
 static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
@@ -1850,9 +1858,6 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 
 void disk_free_zone_resources(struct gendisk *disk)
 {
-	if (!disk->zone_wplugs_pool)
-		return;
-
 	if (disk->zone_wplugs_wq) {
 		destroy_workqueue(disk->zone_wplugs_wq);
 		disk->zone_wplugs_wq = NULL;
@@ -1860,15 +1865,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
-	/*
-	 * Wait for the zone write plugs to be RCU-freed before
-	 * destorying the mempool.
-	 */
-	rcu_barrier();
-
-	mempool_destroy(disk->zone_wplugs_pool);
-	disk->zone_wplugs_pool = NULL;
-
 	disk_set_zones_cond_array(disk, NULL);
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
-- 
2.47.3


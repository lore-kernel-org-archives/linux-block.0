Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9362C865
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tDv6bLut"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J5fLPXWrQzodzztAaisOKjkOGrm1QVNAOSMH6Hp8Tps=; b=tDv6bLutgoBpyAaq/BrAUiKrao
	nZP1XM8ZPPiHs7y5gnHp4sgM6rDhFOwW7mMTBkZ3kWqmCv2DrFnjInwJr7OiNvjFktRoDXPCx7YBh
	2bKYqyO79Rw1q6DpcMnS9Qd5zvO8W2vdTVnYGmy+KLK+tPmfA7ljKysjUzWmoQLYEnE0Or/0j7YX8
	hFVrtN+NClcg9IY6yG9lOoyLl2IMxGDU6b/e/x1fy9Oks796J2OAiuclR2GgT9jX5neOU6Ld6SCMO
	D6g/NeySsq/Pr7pUw7bvzIuPisp1wfKjAB+mXZ6ObsSih1qfq0trKCF7/2BJ3WXLKpPmUJbfzc+xX
	qV+MVamg==;
Received: from 128.red-83-57-75.dynamicip.rima-tde.net ([83.57.75.128] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ8V-00EI6a-2r;
	Wed, 27 Dec 2023 09:23:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: rename and document BLK_DEF_MAX_SECTORS
Date: Wed, 27 Dec 2023 09:23:05 +0000
Message-Id: <20231227092305.279567-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231227092305.279567-1-hch@lst.de>
References: <20231227092305.279567-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Give BLK_DEF_MAX_SECTORS a _CAP postfix and document what it is used for.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 2 +-
 block/blk-sysfs.c      | 2 +-
 drivers/scsi/sd.c      | 2 +-
 include/linux/blkdev.h | 9 ++++++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 33b3f767b81e24..ba6e0e97118c08 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -139,7 +139,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	if (limits->max_user_sectors)
 		max_sectors = min(max_sectors, limits->max_user_sectors);
 	else
-		max_sectors = min(max_sectors, BLK_DEF_MAX_SECTORS);
+		max_sectors = min(max_sectors, BLK_DEF_MAX_SECTORS_CAP);
 
 	max_sectors = round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d5e669a401b0cc..40bab5975c5612 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -241,7 +241,7 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	if (max_sectors_kb == 0) {
 		q->limits.max_user_sectors = 0;
 		max_sectors_kb = min(max_hw_sectors_kb,
-				     BLK_DEF_MAX_SECTORS >> 1);
+				     BLK_DEF_MAX_SECTORS_CAP >> 1);
 	} else {
 		if (max_sectors_kb > max_hw_sectors_kb ||
 		    max_sectors_kb < page_kb)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8c8ac5cd1833b4..6bedd2d5298f6d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3500,7 +3500,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	} else {
 		q->limits.io_opt = 0;
 		rw_max = min_not_zero(logical_to_sectors(sdp, dev_max),
-				      (sector_t)BLK_DEF_MAX_SECTORS);
+				      (sector_t)BLK_DEF_MAX_SECTORS_CAP);
 	}
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ce1ab712552e3c..9f9fbc22c4b037 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1056,7 +1056,14 @@ enum blk_default_limits {
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
 
-#define BLK_DEF_MAX_SECTORS 2560u
+/*
+ * Default upper limit for the software max_sectors limit used for
+ * regular file system I/O.  This can be increased through sysfs.
+ *
+ * Not to be confused with the max_hw_sector limit that is entirely
+ * controlled by the driver, usually based on hardware limits.
+ */
+#define BLK_DEF_MAX_SECTORS_CAP	2560u
 
 static inline unsigned long queue_segment_boundary(const struct request_queue *q)
 {
-- 
2.39.2


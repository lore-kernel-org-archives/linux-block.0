Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5F67730;
	Mon, 22 Jan 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945059; cv=none; b=fQqaKC4IYnjhcxtzjfe/mt0M4S10BT1iAe7S62zCv/RcyddjO3R6dn6ygNPe3A5+VpoE6+HSS8Bah0f809Ku+i+kQE/3c5sUx/SZBTczvxP3ris6H6iNhRkzNxld+wX4wT1k4W76HbDO37VSbwNzxiI0qWPCtMO0FoEIaaNXd68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945059; c=relaxed/simple;
	bh=Gh8McriUG18P7CB9TaC1gl0wLgs+XtciEyJdjT7ge2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRtA0zcICkLhN2XFBi3aQjfLwfSC1ET5GO18wpIaA7A1TgZUwayevWyWFxaEDx6bfEg8PEjUT/oyCKFWPRXi64cafdKecHAiAi1uzbmaJ9XS+V10Ceza69eKEKwcd7OJwLBWDSYb3XeHs+SPIDStOxH3djptc/2QA1wOOcR7cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hxr9mV+M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hxr9mV+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0fYloV3kA50WO8sjNj3hp0KcqaKX8i7xkE5ohU+1CrE=; b=Hxr9mV+My/Cskt5lfmG9ZuDmik
	h7v+Uw5bJUNRq+3x5682kbJ/tArBuOaLvHYDdM140PL4q9uzlKTvbRJZos3RubWUazRMr/7z7IxcW
	duxniXyn2NRGg8+a9bb1wF4GczozzR+FDlDuUR+d64z19RA71CIO8jC7r5vFHaK5dvhXkQ2Fz8pRV
	YsUZl/tAq36fLSoCMTCuwadNMygGJcn/u01/BfSvAdJbkpzKFonT7aWyNtTN2DbZJu3sxh9Q+vPxg
	IrVFQTquhOrM0V3u3iYDqr3E0mXR83MPs2jAtFDTglKeYTNr5k5LpqtyL+AydQgyobZ3Of5TSSewR
	CwlK5Ssg==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEh-00DH2n-39;
	Mon, 22 Jan 2024 17:37:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 14/15] loop: pass queue_limits to blk_mq_alloc_disk
Date: Mon, 22 Jan 2024 18:36:44 +0100
Message-Id: <20240122173645.1686078-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the max_hw_sector limit loop sets at initialization time directly to
blk_mq_alloc_disk instead of updating it right after the allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7abeb586942677..26c8ea79086798 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1971,6 +1971,12 @@ static const struct blk_mq_ops loop_mq_ops = {
 
 static int loop_add(int i)
 {
+	struct queue_limits lim = {
+		/*
+		 * Random number picked from the historic block max_sectors cap.
+		 */
+		.max_hw_sectors		= 2560u,
+	};
 	struct loop_device *lo;
 	struct gendisk *disk;
 	int err;
@@ -2014,16 +2020,13 @@ static int loop_add(int i)
 	if (err)
 		goto out_free_idr;
 
-	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, NULL, lo);
+	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, &lim, lo);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
-	/* random number picked from the history block max_sectors cap */
-	blk_queue_max_hw_sectors(lo->lo_queue, 2560u);
-
 	/*
 	 * By default, we do buffer IO, so it doesn't make sense to enable
 	 * merge because the I/O submitted to backing file is handled page by
-- 
2.39.2


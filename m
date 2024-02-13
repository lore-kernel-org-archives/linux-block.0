Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6718C19;
	Tue, 13 Feb 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809772; cv=none; b=miTEEao6DDbBhOo87sDQKnPAdVWm8g5mIVd6uG3n7ieiTzu18h5cN3YR7/MOsG3xaHNiGADw3pg8FzhS3wT17fbnoMK9KfSW56Ga7L6X2kKwi73KdR7YHrysr7KtB6FmcEVAT1up6xnrvsLWOfLalYeaAmyqS0kvH/SbFWq4GQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809772; c=relaxed/simple;
	bh=w586ArhPfKm9bAMkYeSRUYjeNqFc0qWnxxC7UORiduo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLoZOCo1pCT05IBLSnc/nj/UPHWFJ2eKKFxVl/vrDCARLi4oFcuDSaCwOA6ebRUmo2M2PtR4jbfb2clyEk4uJwJ6OQ7Kt+mRTe+Wt5i8wHZwf+3Dm/lD9WTZoogFSq74zVKfXYUCexrmuk19oyoofgppOXn9SdMbjhDeHAMGx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a9xNM1gA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9xNM1gA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YZzI2qzFink9WZtdPiGrGdyVWJZL9xIcaGTFOqTyA10=; b=a9xNM1gAwBgyDeEXQRtX7JlkiM
	KQv6W+mPuAtJXPy3htagbeKwv+EUzchcFKrIqWQq5vCUpragwB8GDpgumUIa1WozponUYgZTVFopg
	sThG7e3+FekhWDkVcl6bHTrKzrBbLfrf9t/Ve2kT77KXyslqvZPOqImHVbaj1SOhrtrL7RnBO0M9M
	AHALbn4nA/soqP9jXfgD4w6rTKF+jmIagFdF2zppLBuoSfOBEMQ21Un1+/DgIv3mAeDgGSZRVbFab
	s1er8+T1wuerGbOS4ijdv3aXl+GMmxY2sz3Ty4M40L7Dw7MvW+u2U5gEGlKd03Z2UCah9im6XGXFb
	MOhEcLIg==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnKo-00000008H7Z-0R4O;
	Tue, 13 Feb 2024 07:36:07 +0000
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
	virtualization@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/15] loop: pass queue_limits to blk_mq_alloc_disk
Date: Tue, 13 Feb 2024 08:34:24 +0100
Message-Id: <20240213073425.1621680-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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


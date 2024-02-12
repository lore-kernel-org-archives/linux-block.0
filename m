Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBA1171D;
	Mon, 12 Feb 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720427; cv=none; b=GrfpflieC9Pad8yOlTcGeqUlSp8Jm3x41+V+d6npzziNkHd4Cn+uj06NVNeOj2oECTlODADXHZe4QlHxSQqjemOKTw0hOhsZ+GzthvZX4qI3ho+N/HhubGwp1mCpqPKlXIFR9LrTiMPZyvw3YukHk+whaUhGUiicoVvwrKo/nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720427; c=relaxed/simple;
	bh=w586ArhPfKm9bAMkYeSRUYjeNqFc0qWnxxC7UORiduo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyPzNNja9jUakJ2tiRe7XwjDaJWGRRN/AxJBhALXXMXg0SElPv+Fx7mJRVzi/sULlOEucPt+y8zYVAMewOO6nfAJCWVZKerflJNFdzP3rvnAnLvpGARAnqMLcbMdet5NFYKwvOTZgappjRH9rOOv/vKGInLO3WDBMiMf/4WguF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zgy1x712; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zgy1x712"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YZzI2qzFink9WZtdPiGrGdyVWJZL9xIcaGTFOqTyA10=; b=Zgy1x712nMhW/TeQyo67LcmyRS
	Jt7Xk7VYV4g/edU1ad5X2p+T923hal8+pDJMHBGJWui4Y4X9N+O5t1tdtkMzR9adEkcOGzPY+IUj1
	0gbdK8dJ1VNpaKCwf23zmvb85nK/3j9xUDin4Y7NpvGx1El1K2lWWRO8/Ei97Zatx67UVIgneemGA
	sLEMS9V040Xt5W0AF7J/0p46rfzoy2wDiQnlOGHS88yRiBTjt7ATKXOGaIFRdgi2if5+Q6ynb4I/m
	sIP+ts1ycJzMIgBENQZDa6ki8z/3JC2rdnu64EOQi8gJ4m1EjtfF2V/vlU0aJYhecisN/MAZ4Uxu/
	k22SROZw==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5j-00000004Q2N-2vHo;
	Mon, 12 Feb 2024 06:47:00 +0000
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
Date: Mon, 12 Feb 2024 07:46:08 +0100
Message-Id: <20240212064609.1327143-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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


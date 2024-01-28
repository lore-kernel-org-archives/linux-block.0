Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896923C49A;
	Sun, 28 Jan 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461158; cv=none; b=olXPYS6ZBwRXRzeewIHN7etdsMa+iLH80CUaXKiwI62O5QGL60H+UcpWb6MOk+qQ9oI2sGnbz/Ji4V96WdNvmaTysAc4qdJmYmzd1e8cdZphvkQTfgjkZ/WVCY9EdNuuZjkA+VOi9aNhzffgmXEDbLjmG2JlTPghENY2HoOWuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461158; c=relaxed/simple;
	bh=pacC1cn/AH9PVWOkaZAi+JoJacdLTHjt978zbzbqJe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOIjUipZG+J64y/wxTuOMXBKTpt99IsjPwkOsa9iiw/u6BhsAGJrrqmINy/F79zo2OsB0NoozCVwEvfq5BMXGqcYUmQxVl7YjT+XgZ9Qzb6kFrBtOLqbOCv+qb1VV8HmjaeXfPrf+2xdhKpyVrKbHT5oyxK/ALRLZsQ3C3obE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ih99wOT2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ih99wOT2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L873Lxa+31+KXE3rwv/O5G9PEYjkpCTeABnTliJ/uBU=; b=ih99wOT2J6u3CVtu5I5NEJwWWX
	SLA339Jw4VbOQf3XKdPHh7T/UJ3B/N7DD0GFHiVdbWL+9dNvK4WVTZEfHSpDQTixFFsR/Pl/uBeav
	IQPV7ONn3edsJbPbrsxR7ZM5hLoaSqKIhB7gfsnUax6z66ZmCrtnGFfBgo9LxYTc5Ux6s21zhnrmR
	SpCcVmZQFNtL/Zcg5HLmXy/Niv+wv88v6ql4OfOq5kKGsAv+GQ5XLsx5Ym7tAiXKJWbHihrdwOQKs
	PZ2GnLEWht3OljPJP5ZI2q220GjyWBiwHMVSHmO5g1VIBK2IttfKvfSs0+PNIv2RiIB9+H9y23eM2
	7GZZrbsw==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Ux-0000000A2VD-0dDt;
	Sun, 28 Jan 2024 16:59:11 +0000
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
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/14] loop: pass queue_limits to blk_mq_alloc_disk
Date: Sun, 28 Jan 2024 17:58:12 +0100
Message-Id: <20240128165813.3213508-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


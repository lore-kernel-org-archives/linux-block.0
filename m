Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E057603F
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388688; cv=none; b=lI2RVSVq/lis6yJS+oqwGqziiYEmborChUk+j60gzTgVDz1UHwu8raDolfnSJ/21mlgUgBJx5mNGEp2xC3Ss+ylX5F8hnRHXomHO/v6zS1Edn/3cEBbzKLAQa8f2Y6aW8DOumiJVlbEiani3HAKqlZH5Hp3Qu4lyFFeYmht8r/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388688; c=relaxed/simple;
	bh=KFc7IAk8uB3Zh8gYBUQR5avMTMAfuUQqpT0v6hHt1aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2SPPE2ilhRRazHKaFgZfYqYiJBsmuPYVBd8PNq4w72pQn+SGIbxuTeUlqlM9miwS91KPodt4Kpr0VDwUPDveJT0t9BU+Vvq3W10/XEC6ZzROnkNq4uf0ZpxPy3p6NU0jVyzq+JrSDc5HfR92hrqA1K2nMylVZGjBVIYnd8s7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M66Gx8qY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M66Gx8qY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eO/3nbbVzg8iMKfN+ylhsylK7vJco51ZbreUKFSXgPI=; b=M66Gx8qYQTZz/vtkMmhv1glQ71
	YNXH4eCwRv6G1YRQH49nanpMOMVhY1f7stGrIRhmCZnz8lncGGrAENRtFOmn9TlvH5rXzM4Uan6KJ
	99iBxgTT7VpKJ3C2DPSa93iK03jaO0LdQeX2DdWQIFsxOo1k8AAELvP1Hq4VrISsXx2uZgntkCnSj
	VDooEie3OXUaclTxHfiQjF0Ewgv02Iv31MpcyplZZrlMmeyl9ITDJeOxJqq9nI0yzLUfKhqwBljon
	CMJ2oRYBYyb9bboTsst2BaQHyU/wE8yN6TUXfFZdE1J3YNInhNChcIgfRSf3lI0CUmy9l9Cl8x0YV
	V60YbkVQ==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8qs-00000005ind-0t5r;
	Tue, 08 Oct 2024 11:58:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: mark the disk dead before taking open_mutx in del_gendisk
Date: Tue,  8 Oct 2024 13:57:51 +0200
Message-ID: <20241008115756.355936-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008115756.355936-1-hch@lst.de>
References: <20241008115756.355936-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that we stop sd and sr from submitting passthrough commands from
their ->release methods we can and should start the drain before taking
->open_mutex, so that we can entirely prevent this kind of deadlock by
ensuring that the disk is clearly marked dead before open_mutex is
taken in del_gendisk.

This includes a revert of commit 7e04da2dc701 ("block: fix deadlock
between sd_remove & sd_release"), which was a partial fix for a similar
deadlock.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ac1c496ad43343..98c8d13171c642 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -655,16 +655,6 @@ void del_gendisk(struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
 		return;
 
-	disk_del_events(disk);
-
-	/*
-	 * Prevent new openers by unlinked the bdev inode.
-	 */
-	mutex_lock(&disk->open_mutex);
-	xa_for_each(&disk->part_tbl, idx, part)
-		bdev_unhash(part);
-	mutex_unlock(&disk->open_mutex);
-
 	/*
 	 * Tell the file system to write back all dirty data and shut down if
 	 * it hasn't been notified earlier.
@@ -673,10 +663,22 @@ void del_gendisk(struct gendisk *disk)
 		blk_report_disk_dead(disk, false);
 
 	/*
-	 * Drop all partitions now that the disk is marked dead.
+	 * Then mark the disk dead to stop new requests from being served ASAP.
+	 * This needs to happen before taking ->open_mutex to prevent deadlocks
+	 * with SCSI ULPs that send passthrough commands from their ->release
+	 * methods.
 	 */
-	mutex_lock(&disk->open_mutex);
 	__blk_mark_disk_dead(disk);
+
+	disk_del_events(disk);
+
+	/*
+	 * Prevent new openers by unlinking the bdev inode, and drop all
+	 * partitions.
+	 */
+	mutex_lock(&disk->open_mutex);
+	xa_for_each(&disk->part_tbl, idx, part)
+		bdev_unhash(part);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
-- 
2.45.2


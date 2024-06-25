Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F0101D5
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294767; cv=none; b=gGQVPcg2CThKyguCU86FjbA22SY+QWflE+4giSBaJ77Hk1wMR+rOtkwj74lwz9v2wp3thBdBTi6lkwjFcHg+hCgikAGw1tseTQhlaCT9S8T2wM9wJu9aqgPaVWJK3QTtalqodjsgwjd7t9Xo6T7iO0eC3W/+UohGI4unTFjej/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294767; c=relaxed/simple;
	bh=7GIfuDO7jXZBMKe83HfOrnw4Ge9j/hHvzQyrcrXAhnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFZOPIuereSRzvxPN350FB6cjZ1Mu/k9NjFA53dUiUIY2ldvhsm9HnJCR8BLJqM8xLpZvjzjjbDf35Dj9w/TP3xINS9wZHIu3pV4JTigtjNFJ4V3E7n8zB7Q7M7ME8BOa/uuNhq0rMkT6Kuye31rCsjZCGSslVdLFmjkxYekHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qxjfUNGr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxjfUNGr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YTqoi2mljEbOakIcyABD2RlNt0qxMc+ByhNNWPILtBo=; b=qxjfUNGrFRJ3+bkq5zQGMbxXyp
	NShKIzRbzMRz0vpAorvKvJfJjSQJfoJtrm43kX6bIGy2MQyBPJEU8FtCghwFFE3FmruB0OtD3b88k
	tUs2LJ8Ad/65Sq08z3+iGg0G0cR2WGaY3qNf4q3HcyMd1SkbBQmlpTLawnaRNnuR+Rl1J1ufWNQe+
	XezKmH0tg/tUX5pBJyykoXC9AWG7lr3Z2S0xN+kMnjM6zGaAh19lcXl7UiQPwL7+M5WR+hijlW+GT
	vRHwRtBHK+VwoSA+GzA0MNGmfYmYgj3/KoMe1g1JQY4GUE//zEKVqxJJxEu/IIZ06T1SsGkYEJWlk
	kzmtEWWw==;
Received: from [2001:4bb8:2dc:a91f:de7e:f7c0:f265:d96e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLz6f-00000001jNR-2t83;
	Tue, 25 Jun 2024 05:52:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: roger.pau@citrix.com
Cc: jgross@suse.com,
	marmarek@invisiblethingslab.com,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	Rusty Bird <rustybird@net-c.com>
Subject: [PATCH] xen-blkfront: fix sector_size propagation to the block layer
Date: Tue, 25 Jun 2024 07:52:38 +0200
Message-ID: <20240625055238.7934-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Ensure that info->sector_size and info->physical_sector_size are set
before the call to blkif_set_queue_limits by doing away with the
local variables and arguments that propagate them.

Thanks to Marek Marczykowski-Górecki and Jürgen Groß for root causing
the issue.

Fixes: ba3f67c11638 ("xen-blkfront: atomically update queue limits")
Reported-by: Rusty Bird <rustybird@net-c.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index fa3a2ba525458b..59ce113b882a0e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1070,8 +1070,7 @@ static char *encode_disk_name(char *ptr, unsigned int n)
 }
 
 static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
-		struct blkfront_info *info, u16 sector_size,
-		unsigned int physical_sector_size)
+		struct blkfront_info *info)
 {
 	struct queue_limits lim = {};
 	struct gendisk *gd;
@@ -1165,8 +1164,6 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	info->rq = gd->queue;
 	info->gd = gd;
-	info->sector_size = sector_size;
-	info->physical_sector_size = physical_sector_size;
 
 	xlvbd_flush(info);
 
@@ -2320,8 +2317,6 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 static void blkfront_connect(struct blkfront_info *info)
 {
 	unsigned long long sectors;
-	unsigned long sector_size;
-	unsigned int physical_sector_size;
 	int err, i;
 	struct blkfront_ring_info *rinfo;
 
@@ -2360,7 +2355,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
 			    "sectors", "%llu", &sectors,
 			    "info", "%u", &info->vdisk_info,
-			    "sector-size", "%lu", &sector_size,
+			    "sector-size", "%lu", &info->sector_size,
 			    NULL);
 	if (err) {
 		xenbus_dev_fatal(info->xbdev, err,
@@ -2374,9 +2369,9 @@ static void blkfront_connect(struct blkfront_info *info)
 	 * provide this. Assume physical sector size to be the same as
 	 * sector_size in that case.
 	 */
-	physical_sector_size = xenbus_read_unsigned(info->xbdev->otherend,
+	info->physical_sector_size = xenbus_read_unsigned(info->xbdev->otherend,
 						    "physical-sector-size",
-						    sector_size);
+						    info->sector_size);
 	blkfront_gather_backend_features(info);
 	for_each_rinfo(info, rinfo, i) {
 		err = blkfront_setup_indirect(rinfo);
@@ -2388,8 +2383,7 @@ static void blkfront_connect(struct blkfront_info *info)
 		}
 	}
 
-	err = xlvbd_alloc_gendisk(sectors, info, sector_size,
-				  physical_sector_size);
+	err = xlvbd_alloc_gendisk(sectors, info);
 	if (err) {
 		xenbus_dev_fatal(info->xbdev, err, "xlvbd_add at %s",
 				 info->xbdev->otherend);
-- 
2.43.0


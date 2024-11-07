Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78A10F9
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958034; cv=none; b=rfEkD7ZcQTgsH/u5/I9ezYNx1Qf+1rdKv/NchfPSE8U6qAFs8bSxxN/dvuMUWDL2CnTtzoqVcy33ZtYWAR4T5FA2CYnPj+iJaDjRq3fhythEvfYlSSwNCUiB3huWLlLJf7vYIq4HG32NpcgdhrULSgLSy0bDWmmKakcHYOA9GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958034; c=relaxed/simple;
	bh=KKC9Gi2egwnNg0NgM/0oJOngoktqb2ly4hkmBiJ3+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsoF0d+5ROGo67XX3SFfbN8ojsXDplRhpCsPbm2otHu70BYHnA2+xoeD9KfDfWGcHPBsPVMW1GJU9rRzQlFKyteqiEQccwvewCPvQvXpHqEjKvneNfKClfMDZQX4qcxP/BF7EIK++MaPDNVTjsfq4JcU/+m/OBFEDnPnDTTdGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88E71227A87; Thu,  7 Nov 2024 06:40:28 +0100 (CET)
Date: Thu, 7 Nov 2024 06:40:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
Message-ID: <20241107054028.GA2135@lst.de>
References: <20241106231323.8008-1-dlemoal@kernel.org> <20241106231323.8008-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106231323.8008-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

As sparse rcu warnings got in my radar for something else, I did
run sparse over this and it complains.  It will need the little
gem below to fix (and a rebase of the second patch).  Otherwise the
series looks great and way better than my initial hack, thanks!

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a7855555d6d..bf4458b11720 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -350,11 +350,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
 {
+	unsigned long *bitmap;
 	bool is_conv;
 
 	rcu_read_lock();
-	is_conv = disk->conv_zones_bitmap &&
-		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
+	bitmap = rcu_dereference(disk->conv_zones_bitmap);
+	is_conv = bitmap && test_bit(disk_zone_no(disk, sector), bitmap);
 	rcu_read_unlock();
 
 	return is_conv;
@@ -1467,11 +1468,10 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
 	unsigned long flags;
 
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	if (bitmap)
+		nr_conv_zones = bitmap_weight(bitmap, disk->nr_zones);
 	bitmap = rcu_replace_pointer(disk->conv_zones_bitmap, bitmap,
 				     lockdep_is_held(&disk->zone_wplugs_lock));
-	if (disk->conv_zones_bitmap)
-		nr_conv_zones = bitmap_weight(disk->conv_zones_bitmap,
-					      disk->nr_zones);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 
 	kfree_rcu_mightsleep(bitmap);

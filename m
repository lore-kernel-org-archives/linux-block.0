Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C43EE1D5
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155241; cv=none; b=pAtPGMs1GEwuWmoW6ymygjUKL0/Q8c3pDFfBJvdefmoOAWfbAoCJm2/wwjcVhZ3zBsk3af++KuCj3lMmnIHjAeur0ATsX+mAQ0n7qWFe7WFMZKDJgE8ywAV0bT09ZR2ajQJ8HrUHbx6dDnAXW5aUJna7S6rsdI7hOGK1EAplRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155241; c=relaxed/simple;
	bh=v3SEm37h/4bIjMv3TPZA+UDgRmdo9v+xWkPxUWXy4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMPuP/ofv1XwEw37/u13fImVY8LPtbvk8CD3+1eR4NsD6Ww7RjrMvnAVTXgDxSvW0p3BZ+JTuhCJ2dVN1V0chfbv59gpFa3obDX4ZL8eGQZfc0XBmTetwaE79+j2dWp2D56Si2hc9q5yAbITNI7ycy1Xq7lAZKmSQBNsCgZ3yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XOYaaDZs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XOYaaDZs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJh2T8kzlh2kn;
	Thu,  2 Apr 2026 18:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155232; x=1777747233; bh=FMhEq
	eyhZsvnV4JIPansa5p5pL+kFmpp2mfLVnCXhS8=; b=XOYaaDZswlJERqWvakKTh
	alpY0YYsbcCAKmKbEXVrwEtKyL0B/nefXFLBS/jAARTecXLW8WTi50gTh8EJtMEu
	HqQQOpJJPAI2yXCJ0rftGkdvg8CltZ7cCYiW1SLwPJ6VMIfbxDEy2o8fMq+jRYxf
	/41b+J33evtdtGlnBGunEzsu1JHLOTiwE0DAXcW4S3M+iHNV/ZWEohMepCAQIt6G
	6GTA7A8zQTZLbMIMi1KG2ONn14+6DmLO4vv4plM3LnCp2eiHBk2JCX9chva5DFVC
	/Ppf7X22NFQo3S4UGB6KAA3mNExyd6n1izjaWIx/svDPzL/wQmbo9P9HRe1gpp3x
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fc1OyB9P_BRW; Thu,  2 Apr 2026 18:40:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJZ3Zz6zlh2g0;
	Thu,  2 Apr 2026 18:40:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 09/12] block/blk-zoned: Refactor blkdev_zone_mgmt_ioctl()
Date: Thu,  2 Apr 2026 11:39:41 -0700
Message-ID: <20260402183950.3626956-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch@lst.de>

Split the zone reset case into a separate helper so that the conditional
locking goes away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bfd9733ebd31..30cad2bb9291 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -417,20 +417,32 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, unsigned int cmd,
 	return 0;
 }
=20
-static int blkdev_truncate_zone_range(struct block_device *bdev,
-		blk_mode_t mode, const struct blk_zone_range *zrange)
+static int blkdev_reset_zone(struct block_device *bdev, blk_mode_t mode,
+			     struct blk_zone_range *zrange)
 {
 	loff_t start, end;
+	int ret =3D -EINVAL;
=20
+	inode_lock(bdev->bd_mapping->host);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	if (zrange->sector + zrange->nr_sectors <=3D zrange->sector ||
 	    zrange->sector + zrange->nr_sectors > get_capacity(bdev->bd_disk))
 		/* Out of range */
-		return -EINVAL;
+		goto out_unlock;
=20
 	start =3D zrange->sector << SECTOR_SHIFT;
 	end =3D ((zrange->sector + zrange->nr_sectors) << SECTOR_SHIFT) - 1;
=20
-	return truncate_bdev_range(bdev, mode, start, end);
+	ret =3D truncate_bdev_range(bdev, mode, start, end);
+	if (ret)
+		goto out_unlock;
+
+	ret =3D blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET, zrange->sector,
+			       zrange->nr_sectors);
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+	return ret;
 }
=20
 /*
@@ -443,7 +455,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 blk_mode_t mode,
 	void __user *argp =3D (void __user *)arg;
 	struct blk_zone_range zrange;
 	enum req_op op;
-	int ret;
=20
 	if (!argp)
 		return -EINVAL;
@@ -459,15 +470,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, blk_mode_t mode,
=20
 	switch (cmd) {
 	case BLKRESETZONE:
-		op =3D REQ_OP_ZONE_RESET;
-
-		/* Invalidate the page cache, including dirty pages. */
-		inode_lock(bdev->bd_mapping->host);
-		filemap_invalidate_lock(bdev->bd_mapping);
-		ret =3D blkdev_truncate_zone_range(bdev, mode, &zrange);
-		if (ret)
-			goto fail;
-		break;
+		return blkdev_reset_zone(bdev, mode, &zrange);
 	case BLKOPENZONE:
 		op =3D REQ_OP_ZONE_OPEN;
 		break;
@@ -481,15 +484,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, blk_mode_t mode,
 		return -ENOTTY;
 	}
=20
-	ret =3D blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
-
-fail:
-	if (cmd =3D=3D BLKRESETZONE) {
-		filemap_invalidate_unlock(bdev->bd_mapping);
-		inode_unlock(bdev->bd_mapping->host);
-	}
-
-	return ret;
+	return blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 }
=20
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zon=
e)

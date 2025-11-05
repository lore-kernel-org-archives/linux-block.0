Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1955221703
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371378; cv=none; b=luzazDSPiRhonQKbzHtBeUDFXBa0vYcpc5pOnghww3Li/QPpltBXe1hAYf9ZK6Bizv93WjmiB/vsDEls90wVTXp25/yXqROSNzZFWQYUkkhc3cjKERi1j4cwPMHq3d8QjNsJ5A50Uf/nFsRekyt/vposr0AZxseCzVmT0I0yM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371378; c=relaxed/simple;
	bh=hw8YjjkmSAovDaDbMFzHs9Jg61WjV5+z44tOWnLyI8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWSPFKdjlYXvBVSuh2FEqJmcFdbx0WuyrPCbiYkyFoBJ1DFO/DrUDiKDYdoSuwfyvdgqZVy9+i3HMA57hfHsUE2FK0QoM3WkOaSnQNKxFTUTLsFnY4uTEw+ap5wpkCGikpRD3fmsSjF6AVkorPywofqTbKUgGHf9/1H2zpvV7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xdmRkz6x; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xdmRkz6x"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d1wYC3jyrzmsT1c;
	Wed,  5 Nov 2025 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1762371373; x=1764963374; bh=/kdwObjjscr+3B/oc0hTc48lCe0iNBxJHRK
	FQplEVmg=; b=xdmRkz6xiAnBdPyaLeu1IlixBeEXGP+QBupGnvQmj7Uq/UX61JN
	8CULKBP/l5OgJlWg79ohQTLIn5AzmNb55eS9WTwK62DpTFhT2B3Sskg0Cx646b8q
	PnBvvxpIm+4so4sC6SjvE3fZj19xq8QpM6HweH0/+r6ewRtsZDaJkXAP0gMEJgMp
	gIlexF09uBq3ijxgTrahF8YoAwOEFYlvNYM767l+o22GyflUp8HHQDXP3FHOY5Fu
	aHrUwpDz5Ki60jrENmaXpaFrEpAxe3kULhFs34pSMAl2nqFwGxfwNoE/lKrettOd
	aOj5XKk9Onvn74c27yt2ymXhbISvRpaPFkw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sznC9ybqUsXs; Wed,  5 Nov 2025 19:36:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d1wY33vFbzmrkYh;
	Wed,  5 Nov 2025 19:36:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: Unexport blkdev_get_zone_info()
Date: Wed,  5 Nov 2025 11:35:53 -0800
Message-ID: <20251105193554.3169623-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unexport blkdev_get_zone_info() because it has no callers outside the
block layer.

Fixes: f2284eec5053 ("block: introduce blkdev_get_zone_info()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 3 +--
 include/linux/blkdev.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bba64b427082..e3972db4bd66 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -914,7 +914,7 @@ static int blkdev_report_zone_fallback(struct block_d=
evice *bdev,
  *
  *    Returns 0 on success and a negative error code on failure.
  */
-int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
+static int blkdev_get_zone_info(struct block_device *bdev, sector_t sect=
or,
 			 struct blk_zone *zone)
 {
 	struct gendisk *disk =3D bdev->bd_disk;
@@ -1001,7 +1001,6 @@ int blkdev_get_zone_info(struct block_device *bdev,=
 sector_t sector,
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
=20
 /**
  * blkdev_report_zones_cached - Get cached zones information
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f0ab02e0a673..7884f86e172f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -436,9 +436,6 @@ typedef int (*report_zones_cb)(struct blk_zone *zone,=
 unsigned int idx,
 int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 		     unsigned int idx, struct blk_report_zones_args *args);
=20
-int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
-			 struct blk_zone *zone);
-
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);

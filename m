Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C5364E9E
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689144; cv=none; b=GrtzIE82xCXe15Ln8JiygVPRIrdWUyrThKF9sDIWM2s9tn29YNhuL5OMyF3QeD1OEHW4DsUV6D1p22+2CHCjxxtLob1INlCWTgA1mEfhs9RJ2sniWpN/BSAgFXRVbrWdAmxvWCK3kBWItMP3Uhs9wWXG27SQNJN4FF1e7eaq48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689144; c=relaxed/simple;
	bh=5lUp4qDZh7JZ2NGrRmvIAyk8UdVvaQakAva2eOdGVXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3tRV1cTpGVsrlk0q6OT5tpQqsw1+IMC/bj0Z1TvQvGfPtfkND4qKwarIr4YvvofCa1tKpK33djEdWa+5FGkZiYSLHCfePBDUBgG8iUl5CdckuMy7oC3HEv1FAqgQd+y3IdwGffoQ60esPrLslB1iIXIW17SuuikVEqUMdp5e3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3ZDTLGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3ZDTLGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3161F00A3D;
	Fri, 14 Aug 2026 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689143;
	bh=Tv0cqVWyc4imCWD84Gsi79JtI2iu5WZuJdwlcWK5EEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q3ZDTLGgGpBPSTt/2zQselcPyrbK96NJVPfxNTbF2hBjrYJ0jdza2StqhBUakAWQ7
	 t7F3P1A0RRGe6ji9HszBn/qu7vFW2WGuH/Wou4LUsFZTlCjnJH/Ayq6uyr6+e2SWQp
	 40ceCXNbX9/NnorHXRodXYGl5GyfWhrdqtW42sPmsxWlucimo1IwUb/msGt33S9Bv2
	 Y1zGgmZc9lO12gOVgpeW8Mpb7HyTwJ7HoeLSlvFUYfUu0qYcVrpQIi9/S/8TEkyF3O
	 xcS3m23j78p7uqZFW7GuYKJj7LibRykVVmEPXpql+l2WkcmitdmRogJMintVefnBdb
	 XejlCUyniKNiw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 13/13] block: flag zoned disks with GENHD_FL_NO_PART
Date: Fri, 14 Aug 2026 15:32:01 +0900
Message-ID: <20260814063201.1762743-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814063201.1762743-1-dlemoal@kernel.org>
References: <20260814063201.1762743-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zoned block devices do not support partitions. However, the partition
table is nevertheless still inspected, and any partition found ignored
with a warning in add_partition(). While this is generally not a problem,
and in fact beneficial to the user as it indicates an invalid use of a
zoned block device, scanning for a partition table on the device may
result in issuing read operations to offline zones (e.g. after a disk head
is depopulated for disks that support head management operations).

Since partitions are ignored anyway, completely disable partition scanning
for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
The existing check in add_partition() is left as-is to ensure that we
still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
still endup trying to add partitions.

Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
through sysfs the ext_range attribute with the value of 1 instead of the
default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
disks do not support partitions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/genhd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index e8ce0cabf392..34a64077ba02 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -447,6 +447,13 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
 	}
 
+	/*
+	 * We do not support partitions with zoned block devices, so do not try
+	 * to scan the partitions table.
+	 */
+	if (blk_queue_is_zoned(disk->queue))
+		disk->flags |= GENHD_FL_NO_PART;
+
 	/*
 	 * If the driver provides an explicit major number it also must provide
 	 * the number of minors numbers supported, and those will be used to
-- 
2.55.0


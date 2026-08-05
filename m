Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53630E84F
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896865; cv=none; b=PBbApKpqs3xPx3XqYG9/NUGKHVVeuqL4Ew2DMg8OkrOLPH/TnbbnRYpDyy395RFhYFalOxmqpI0LF8VHcxnNy1FXg3/cfzNGVj3MzVj4cNFFv0bPEx5tO/EQe1Gx1YN7WkEjjpKuRXlbeodhAdtWz07H5bRGswYGt/tl2CWBciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896865; c=relaxed/simple;
	bh=t2+B+lvNbpfuYhPog6jddBpA22+OxO99qdZsR+gcPnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5ms02yc6ctEY6AoTaq0oTjhqdc0KCjww5tLWlRutOsuOQDUddR8r5SzK82dYVUEHFA//24QtwAK7tWYDVNwvJKMNabdFNFWMlimP/qu4FWCdU4Rs8OXhaXV+SmKlxcopNA3umHzEd+eacnPQs+r4nxJp0V/9vTjCCWLzGaCliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCp2pY96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCp2pY96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF4C1F00A3A;
	Wed,  5 Aug 2026 02:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896864;
	bh=ranPTEh7AKfmtndcufM4QwY7bQ0yYS5QDYyh0UNAcgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TCp2pY96/FpYAftZpbqUzfTl2oWAAUv2ErgS8rPog8wU+dm/gvrp1xB83Kl0FAFX4
	 6yYaEdzQMfqA36RSMza0oPcypXP/jyHztybgIrjKz1f39OQGvNTgBj54gV5oSUB6dY
	 TqhIARDqW8SrNlTdTbXHurW8dFBhC7IEGbiS8QU+g0pT09Ir1xpyZu06b3GMLctfKF
	 AHs1HbahCLR5E9nXe8qkN0dcu2JCnWy0qymgU1Yrw+kwYY+5NbLch/KyKRp4zLlOSc
	 d6uUQW4vDHknfF8CDu1GtZFZoga9vTKDTIE1p5YjKd+kFDMsYhWn8xwT9HV0zQXQXW
	 Ho5gnrhGfDmRQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/14] block: flag zoned disks with GENHD_FL_NO_PART
Date: Wed,  5 Aug 2026 11:27:18 +0900
Message-ID: <20260805022719.735323-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805022719.735323-1-dlemoal@kernel.org>
References: <20260805022719.735323-1-dlemoal@kernel.org>
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


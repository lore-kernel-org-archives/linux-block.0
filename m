Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF043344031
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715293; cv=none; b=HbEYejOzCJ+BCbWVQcYhrpiIkoStEbkVzPhKFcFMJliHvZT6+DOBFhIHpYO+Apu4A4nrQOk1qYXGJInEcKYjjI/q+Rkr+wsxfpGnS5ByAseLupXGhzildXsG28gbbPPCVJ8UJqG1Cr2XaMe99t5Za3oiVoS8B4/o2ij1pAwfRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715293; c=relaxed/simple;
	bh=5+Ph6Vj3Jpd4WBHfZVK2laoMJWRuKXNHr+lDnMRx8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qss+WdWYgOHaZrBuME0MZaYnYHBPIRhqx6nq9fcjSaJEIGwRAFGC/Wue6qFgxkPu1mmiYIptu3Uc8zwpuYXyUljeDJjVydfIB76dstH3D6JBt+naam8YiM9JBy1cYmH+cRYtwFAjapidJWdbWLKYpa3klOykoTMSBULg6Ua3faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOtbKibX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOtbKibX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF971F000E9;
	Fri, 14 Aug 2026 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715291;
	bh=Pn6vCiK6QRt7ZS15aKx1WahmpjUk7Aun9FTZL4Mn0DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOtbKibXMajE2ohaNtbET8Idr5d+iMcuMTIHPdY0w8tYyXNMw6fiMqTl1IchdFPSi
	 oUgb2X68gleeiMU6Hs4ccbxZKPFmsnGGHDINtSvkYPDyzFGO4h6GGstR3WOFMZCi+0
	 PQTFFKmo/U4luMyU9BNO9ghTczbz7YXq7ZSeIpusWVTwdDNcoPLWxhEcCtFhhB0sqV
	 wFE7JM9yH9WJ9ETqoalpvs2xOAF3o0zcPFj+CYzS/UE5KzPQN+9gGu6lqW+lDyeVgf
	 oqDH3ICYzBR7XqEF3RAJJH2s4cXI4DXpnzbFkARgWvLI92QHNIaG90SjozwQC7Jmgt
	 cZnFjAevhoq8g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 13/13] block: flag zoned disks with GENHD_FL_NO_PART
Date: Fri, 14 Aug 2026 22:47:50 +0900
Message-ID: <20260814134750.2100304-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814134750.2100304-1-dlemoal@kernel.org>
References: <20260814134750.2100304-1-dlemoal@kernel.org>
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

Fixes: 5eac3eb30c9a ("block: Remove partition support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


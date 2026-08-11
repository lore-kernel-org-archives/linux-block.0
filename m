Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F243C7AF
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445954; cv=none; b=mn2uHjYorxTzaPS4YPOtR0CmE5blzfptXQIr5GPg3FS3GEgw33ZtiET/VAYCSnSNdsZEvi2WkPf/T5xAG6T0WPFQbk1haVxSTgCO7rt9RVbhUOpuO1XZBJhTp36IdbAXAKr49CVfz9+ST9uKIXAbYRQWc/sID/008xjv6auaSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445954; c=relaxed/simple;
	bh=r0fqw+wWJvnAxpXQTFBnlU6bE2y1knqQ/xVnYp9rIP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4JYIIg+h01gfXhiQRjvEHc8F3hOKEtWSyUgPGTR9C4ZTDWt1DUS+1f3/lOQVMBMXmurXxbbEHHByGmDQXfieFNushv6WXHdCplItAMXH/3GHKkqzlORhS0L8wCM7/5x8Qv1TA/CrtjJx/8P1ClRQmGHLNAWUCl91bc8Y2kaNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyf68L0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyf68L0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408BB1F000E9;
	Tue, 11 Aug 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445953;
	bh=zJ0k+ARIqR2cdOzaG9hsPKfUywIej44S1HcMyAg36pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tyf68L0Zog0kcn9vcRBef4pvobvk36lDxo3M/qLBSP+x1piHZG3lhyb0FMKpAa8Zq
	 WZQxyA8SjNMxG3dSNr7HHkB6WdyivlPGx9iQGny5e5+8+V/XmBEA1HDdmpMWKBDOHN
	 5TtpVffiUgDOscIsOlJFRTSgB5GRGeymao6912i9EfxYrcLmBJYSj6ksbORwEGool0
	 3mfK97y/87Av7wyF9HhM7YjS0Ys/HYxn6U1xURvaAvglKzip5oAlQXRxsav7jQ317v
	 pLBhbSE9lasphEPJIDW+vk4K0o+QjkQt2cns7haZnF/c/NzcykzYscU1yDVvwqKswm
	 O46lwLnO3KuRw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 13/13] block: flag zoned disks with GENHD_FL_NO_PART
Date: Tue, 11 Aug 2026 19:58:52 +0900
Message-ID: <20260811105852.1245357-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
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


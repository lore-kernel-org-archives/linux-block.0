Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363A3A7F41
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144665; cv=none; b=TuE12OiTrGlUVOdVDAzql/5Hdp1VUo0n44sTk/uoE2u88n4MfqPVAzNi+jRBVmgN9RNfaI//p4nPunDU/Goblc/ZenK1fh+MkwXeRysraV4HgH8A1+0Q/Bt0bXKL8KJGO5jme54uFFi7vZouc9NvYsaqCLkMIJzh9bb9h9YOzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144665; c=relaxed/simple;
	bh=5God4r+EXpPWJ8lmeqTGzQTcgBrXakTNI20Vl+JljX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZAibcGiNuS+AL7Nst05ejCLf+lofWuO/7dzsl6kGBYVpLqraU09Y22BBw3Wyv+HF7SD8ztPOqFATe9oCYmIdGV09qdXj5ULg++bRJ40X4BW9OBSqDQx3wIBCfll5KFmlKWRd/HVj+SlCHcUlObrpKX3zXBbGx1WfScQg1tVNgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxpNorIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxpNorIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860211F000E9;
	Mon, 31 Aug 2026 02:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788144661;
	bh=rY6S+/wwVbPR/5N7OtJs12poPLjKEV4gQHIIHoaw19g=;
	h=From:To:Subject:Date;
	b=KxpNorIiVrN0Hbadey0gmeX/Bs2ponVtQ9M94iA0zYE0ym1eFyD7dXbY+W5Jimhqw
	 /WFu0zHKtwjVSQ/+SrDyqAMpTfvI63IcKvm/+2sQYl0BxezZhBnuPpl9ixDWg/Sy3w
	 riCVN6oCfFdNYPMy6PLxDezd7HajUkiWXjzwh4NsroYbp06iuzd6An9TqfnWmHLWFT
	 g4fIBQMAJszOJntdB/iu8+k0mJwQ4RY9+TUuqJyCX1JwmXyaUbq0IirZIyFtK/ikUI
	 /ZBYRtBB8+6tc8ATIrH0GJ8rssiEvjv8ckCVE8rQbGC4Zdy7FKLnaChuE8UuGOmsV8
	 hXWvtHRm7vDAw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH RESEND] block: flag zoned disks with GENHD_FL_NO_PART
Date: Mon, 31 Aug 2026 11:50:50 +0900
Message-ID: <20260831025050.667758-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
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
index f1990c7cdfb9..10ca8b4d6eea 100644
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


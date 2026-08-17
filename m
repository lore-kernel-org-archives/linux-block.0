Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89282C15AC
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958236; cv=none; b=JELA4bS3CUuVb9TTT8VzbdTpWaoj+OXazW55Ku0v5JMIUcckpR7PD7sD0EsqHyNOKMisQYi2zg1J3kt8PRXj6H7rIUuwog+SyuUUtUFhXCUk80TkTxptc7m4HHnBT3AyinzueVlD7L9Ps+aPEbHS9CD/Bl52KhQgDOHuu3BaXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958236; c=relaxed/simple;
	bh=5+Ph6Vj3Jpd4WBHfZVK2laoMJWRuKXNHr+lDnMRx8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQmNvVJ58P+WPOkPnIbPfz/3VcK54ubnwK6Nym8w5aUFoXRsoKYivpGNj1DRy+hck5Cu06gTU7slYi2xnYZ7cMPjGljw17G40U0qtaznp138XbhH+Jr4urakm7i6AJl+eEQQ5+0yiLMuGSuigd7NqASJ5SO4rk2H5zsHuhA62qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh/HjVZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh/HjVZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4921A1F000E9;
	Mon, 17 Aug 2026 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786958226;
	bh=Pn6vCiK6QRt7ZS15aKx1WahmpjUk7Aun9FTZL4Mn0DI=;
	h=From:To:Cc:Subject:Date;
	b=hh/HjVZKxo5jtmjdu5/d6Pg3MnffiyOxD6P1VpUdgji7e3XH0zfm6hn3h7ejP+6gy
	 kdGPJ0H+l79k/iMq+zVykFWCytjGxH09frP24AbB2qDEfBCTLXNZiS79JkByueVUb0
	 1a0emwUd+loqymLlpUZu57tx6lyze/bUzIZFUbXzTULAd5et644do4hzD5+C/Slyg4
	 9P9czrBrBJsK+AF4btjRqf0OfPJINYKk8yNtKkeh+/2x5a4Qvc8b6FRdwiKBQwYpvX
	 nlRTFrBkWNh81Asv/VCnipQkxsP2BBP3Pe0NGMuUbHngy06CYGa60yUKNaPPFWHpOr
	 uvJGcZ6haviKQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: flag zoned disks with GENHD_FL_NO_PART
Date: Mon, 17 Aug 2026 18:16:54 +0900
Message-ID: <20260817091654.471293-1-dlemoal@kernel.org>
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


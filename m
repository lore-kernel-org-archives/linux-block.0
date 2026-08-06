Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504E48095D
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032308; cv=none; b=UpixG2ML+vRJMn+pI35hQ+0XIN8wPKIzpRjURAdwXzow6Qh6TJ9NSMtWxNXacR1SEs/uDqfVwiblIfzwHXBicXfUno+7Fa2XsuvkYjkrT1C6Z3JKrDoOqrRjWHzb75nGLF3bgxEY1YHB410MuFBp1zAZOizIicjDUxS1Hohs/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032308; c=relaxed/simple;
	bh=t2+B+lvNbpfuYhPog6jddBpA22+OxO99qdZsR+gcPnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxnmcVGVSLTmVyKmlBd+8tH9LHABHXz/8vZbG+7z8+sG+y2JG3b5grUzzubG4Afz1uP4c3qTyMobOzK1htdy73pZlrDUvJeV1s1BwqcIM1MrXfaRrdwz2K3M3alQ0ARNEN5dLviuF6of6glQD8EAZnFpYpZS8plIc/A8MB9UU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCDcF8gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCDcF8gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7B1F00A3A;
	Thu,  6 Aug 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032307;
	bh=ranPTEh7AKfmtndcufM4QwY7bQ0yYS5QDYyh0UNAcgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCDcF8gdk050eLe6ps0jQkyWWhPM5MmWc0F0193fiopM2LFWYiBxXEJmIYRiuHtgy
	 g9/4J6l0i5tQCqMRKoI94irXQm8fEmVcF3waFOcN1PCq5QNq17dnV+fZbZnCPPDKYp
	 zJBkwFLaCBUht4W3hluVBhhUuNxoCky7ZyIIwwbn7SQzGJckzdo/zHh989yDePsOrr
	 WCXGjOn3tqxZCQvkx6dWsajRzKXfRs9zhg0CNhIMe8HjkmNeM8WMfNBimduzx6sH1s
	 3tZYtST1wVDrbTKE2s403uQf4zMZuORCtGa+Is1gB4mCofk1HzjroKhs3olv6ZlHFb
	 fBaJ9BNXPzesA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 13/13] block: flag zoned disks with GENHD_FL_NO_PART
Date: Fri,  7 Aug 2026 01:04:45 +0900
Message-ID: <20260806160445.848337-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806160445.848337-1-dlemoal@kernel.org>
References: <20260806160445.848337-1-dlemoal@kernel.org>
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


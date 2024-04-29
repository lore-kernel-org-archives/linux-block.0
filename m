Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25012A154
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412950; cv=none; b=D7kRTSgHaWSnUtT9UX8h/pElgNduN+BzqlVZNNaEHkkGo6ujvszLroVdKIWlT+KROl+ydfvMbZdC71gENtET5EZ60Wr9vIMNNXclt7UjjGumS+0dEQl46hIlegK+w2sfPlfUuOvpa/zVmys4//Kh+SI1MzUVCaBQKfH68QWYFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412950; c=relaxed/simple;
	bh=61xSSI6EQ1vnhz21pwP8KoztwnvDMKCv/pcK8cpnT+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SSSQxI7AbNK5piLedzJD+1BjKGmixy6LTXQ4ULrIguYmn3BDTI3+FQyriJW0pjK9WgspxZYdczNqGER2uzEE+aeLgibSrfljx8Dfac/RR6gqzn3bRXMd3E/udiCU3x8ir1dnoH8sUExZhXr60TshfH6ufAncbdkLvdNMbqubaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f209D2gO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f209D2gO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hHybFAQBj9YS9lzxfeccJTe4kQ40qZp6bsRLsL3Ffzs=; b=f209D2gObRqvrG92Fxf8gbCWSC
	15TRTZaoKmGZLIYcUw57InniBjp+Ba5ranQ2UX6cv9JGvIvFerNL5N3HPFxEcja+fU2QprsYNtp7k
	2Lr/CzOjgE1i5UgHyEi+v/PxQ9N6Zjj8N54FGe0yktmJX+3RKHwPWDSc2fCzaSEMUaW+TMyi9pKsU
	nlEE0pQE3WsbJqSUpH8Jxk8Ht6vlM/Eb1/JIzNkq0cGkHyKa9MzVRm4luFwVhpfqP+wTYPWVaRLni
	VkAeiNSU/y5sZpOX3Y98uxCiIhY87IuxWRH1cGnsLng986up4SRyedZ4rXJrqdeaBssLOqBIW4SSI
	4zJc9fVg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1V7k-00000003mac-0GIR;
	Mon, 29 Apr 2024 17:49:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: add a partscan sysfs attribute for disks
Date: Mon, 29 Apr 2024 19:49:01 +0200
Message-Id: <20240429174901.1643909-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429174901.1643909-1-hch@lst.de>
References: <20240429174901.1643909-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This attribute reports if partition scanning is enabled for a given disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/ABI/stable/sysfs-block | 10 ++++++++++
 block/genhd.c                        |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b71..db58fdcdff31b0 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -101,6 +101,16 @@ Description:
 		devices that support receiving integrity metadata.
 
 
+What:		/sys/block/<disk>/partscan
+Date:		Atorl 2024
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		The /sys/block/<disk>/partscan files reports if partition
+		scanning is enabled for the disk.  It returns "1" if partition
+		scanning is enabled, or "0" if not.  The value type is a 32-bit
+		unsigned integer, but only "0" and "1" are valid values.
+
+
 What:		/sys/block/<disk>/<partition>/alignment_offset
 Date:		April 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
diff --git a/block/genhd.c b/block/genhd.c
index 4b85963d09dbb4..dec2ee338fb44a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1044,6 +1044,12 @@ static ssize_t diskseq_show(struct device *dev,
 	return sprintf(buf, "%llu\n", disk->diskseq);
 }
 
+static ssize_t partscan_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1057,6 +1063,7 @@ static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
+static DEVICE_ATTR(partscan, 0444, partscan_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1103,6 +1110,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
+	&dev_attr_partscan.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
-- 
2.39.2


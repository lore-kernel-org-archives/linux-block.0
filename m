Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2A4229C6
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109303; cv=none; b=BrcRonBvcvnaa1E3oBUb0JpkjDBo5IE06eKoGeTIG9fOFuAm15cQiG4ZrvJ2ErRwoh0Ncovld2OE5YL5Svfiee2N39S8LTdgJb1dgUFbUnQf+vaiTxs0IMbcboa1MVMTONxuFMSwoRrvGqiOui4NlAoDodWO0YLDCaIfHbHYdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109303; c=relaxed/simple;
	bh=1Tw16ecFeY3trHefO0ZqGu0P4NYetUtW5mTvXs9+G8k=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=W1xtAwzwhJS7fdr7H37JWvnTQYhG3N/cCwlX4tvSBF9qLVcauBQmc2e3bxno1xF95Dlh+QeD0DyRdZDlgKLAx4GIEbJUH1IisQLH3psLpG8H3JnFTlE/ifWOaX1vNm8HfxaLEKvcrutujU6V49fJXGHQhkn9Ez+F1ThyLcAlKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eH1VHeMt; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eH1VHeMt"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260911064811epoutp0381c81d3ebe34a8e96c7b95842c9db31a~UMWv3isnL1176511765epoutp03B
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260911064811epoutp0381c81d3ebe34a8e96c7b95842c9db31a~UMWv3isnL1176511765epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789109291;
	bh=MJWGPirATsuvDBDEAquo3ZEpJ2LRuh/TvxwBOW6E+cQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=eH1VHeMtocuPF4aOydWcNAfzC+z3XOVkVwOjP4Jw3+iCTrC5CZLtG1Ef2+/O4fi6b
	 9kptne+HLD4Gl/MqywcJhZfRvClqYi93OpdClKZHwCs2Sgu9ZoNUZPtle9X0q7Xfq9
	 TerXyy588OK+zLha5AMH88J4NRfgPG1Ne6ShnBeQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260911064811epcas2p26b635da1fcaa7ac5d7ea971bb6fecfe1~UMWvdf5b-1477414774epcas2p2I;
	Fri, 11 Sep 2026 06:48:11 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.207]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hh4qt5hRVz6B9mB; Fri, 11 Sep
	2026 06:48:10 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH 2/2] block: add a sysfs interface to reserve write streams
 for  a partition
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From: Keoseong Park <keosung.park@samsung.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
CC: Jinyoung Choi <j-young.choi@samsung.com>, Jeuk Kim
	<jeuk20.kim@samsung.com>, Yunjae Jo <yunjae00.jo@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SSDR Gost Dev
	<gost.dev@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260911064810epcms2p602edf30b82d843295e88c391b9cd62e6@epcms2p6>
Date: Fri, 11 Sep 2026 15:48:10 +0900
X-CMS-MailID: 20260911064810epcms2p602edf30b82d843295e88c391b9cd62e6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b
References: <20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p4>
	<CGME20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p6>

Add /sys/block/<disk>/<partition>/write_streams. Writing N reserves N
of the disk's write streams that no other partition can use, exposed as
its streams 1..N. Writing 0 gives them back. N is capped at U8_MAX
because bio->bi_write_stream is a u8, and asking for more streams than
the disk has left fails with -ENOSPC. The IDs come from a per-disk
bitmap protected by open_mutex and are released when the partition is
removed, including by a partition table rescan. I/O to the whole-disk
device can use any write stream, just as it can write to any sector of
a partition.

The count can only be changed while the partition is not open, the
same rule as for a partition table change: users see a fixed number of
streams from open to close, and no I/O can be in flight while the map
is replaced. Writing the current value is always allowed so that a
rule that sets it can be re-run. Growing or shrinking keeps the
streams that stay, so that a partition keeps writing through the same
disk streams and its data stays together.

The store must not wait for open_mutex while holding the sysfs active
reference, as drop_partition() removes the attribute with open_mutex
held. Break the active protection first and re-check that the
partition still exists under the mutex.

Nothing changes until the file is written.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 Documentation/ABI/stable/sysfs-block |  19 ++++
 block/partitions/core.c              | 128 +++++++++++++++++++++++++++
 include/linux/blkdev.h               |   2 +
 3 files changed, 149 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 900b3fc4c72d..442f4c221bde 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -218,6 +218,25 @@ Description:
 		same as the format of /sys/block/<disk>/stat.
 
 
+What:		/sys/block/<disk>/<partition>/write_streams
+Date:		September 2026
+Contact:	Keoseong Park <keosung.park@samsung.com>
+Description:
+		[RW] Number of the disk's write streams reserved for the
+		partition. Writing N reserves N disk write streams that no
+		other partition can use and exposes them as the partition's
+		write streams 1 to N. Writing 0 gives them back. At most
+		/sys/block/<disk>/queue/max_write_streams streams, and never
+		more than 255, can be reserved on a disk. The number can
+		only be changed while the partition is not open, and a change
+		keeps the stream numbers that survive it pointing at the same
+		disk write streams. Partitions have no write streams unless
+		reserved here, and the reservation is lost when the partition
+		is removed, including by a partition table rescan. I/O to
+		the whole-disk device can use any write stream, just as it
+		can write to any sector of a partition.
+
+
 What:		/sys/block/<disk>/queue/add_random
 Date:		June 2010
 Contact:	linux-block@vger.kernel.org
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7c..77852eb2acbe 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -205,6 +205,130 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
 }
 
+static ssize_t part_write_streams_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", dev_to_bdev(dev)->bd_nr_write_streams);
+}
+
+/*
+ * Give the write streams of @part back to the disk.  Called from
+ * drop_partition() with open_mutex held; the map is left alone because a
+ * write racing with del_gendisk() still uses it until the bdev is freed.
+ */
+static void part_put_write_streams(struct block_device *part)
+{
+	struct gendisk *disk = part->bd_disk;
+	unsigned int i;
+
+	lockdep_assert_held(&disk->open_mutex);
+
+	for (i = 0; i < part->bd_nr_write_streams; i++)
+		__clear_bit(part->bd_write_stream_map[i],
+			    disk->write_streams_reserved);
+}
+
+static int part_set_write_streams(struct block_device *part, u8 nr)
+{
+	struct gendisk *disk = part->bd_disk;
+	unsigned int max = min_t(unsigned int,
+				 bdev_limits(part)->max_write_streams, U8_MAX);
+	u8 *map = NULL;
+	unsigned int i, id, nr_free;
+	int ret = 0;
+	u8 cur;
+
+	if (nr > max)
+		return -EINVAL;
+
+	if (nr) {
+		map = kmalloc(nr, GFP_KERNEL);
+		if (!map)
+			return -ENOMEM;
+	}
+
+	mutex_lock(&disk->open_mutex);
+
+	/* the partition may have been dropped while waiting for the mutex */
+	if (xa_load(&disk->part_tbl, bdev_partno(part)) != part) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	cur = part->bd_nr_write_streams;
+
+	/* a no-op change is allowed while open */
+	if (nr == cur)
+		goto out;
+
+	/* the streams must not change under a user of the partition */
+	if (atomic_read(&part->bd_openers)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	nr_free = max - bitmap_weight(disk->write_streams_reserved, max + 1);
+	if (nr > cur && nr - cur > nr_free) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	/*
+	 * Keep the streams that stay, so that a partition keeps writing
+	 * through the same disk streams and its data stays together.
+	 */
+	for (i = 0; i < min(cur, nr); i++)
+		map[i] = part->bd_write_stream_map[i];
+
+	if (nr < cur) {
+		for (i = nr; i < cur; i++)
+			__clear_bit(part->bd_write_stream_map[i],
+				    disk->write_streams_reserved);
+	} else {
+		for (i = cur; i < nr; i++) {
+			id = find_next_zero_bit(disk->write_streams_reserved,
+						max + 1, 1);
+			__set_bit(id, disk->write_streams_reserved);
+			map[i] = id;
+		}
+	}
+
+	swap(part->bd_write_stream_map, map);
+	part->bd_nr_write_streams = nr;
+
+out:
+	mutex_unlock(&disk->open_mutex);
+	kfree(map);
+
+	return ret;
+}
+
+static ssize_t part_write_streams_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct kernfs_node *kn;
+	u8 nr;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &nr);
+	if (ret)
+		return ret;
+
+	/*
+	 * drop_partition() removes this attribute with open_mutex held, so
+	 * don't hold the active reference while waiting for the mutex.
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn)
+		return -ENXIO;
+
+	ret = part_set_write_streams(dev_to_bdev(dev), nr);
+	sysfs_unbreak_active_protection(kn);
+
+	return ret ? ret : count;
+}
+
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
 static DEVICE_ATTR(start, 0444, part_start_show, NULL);
 static DEVICE_ATTR(size, 0444, part_size_show, NULL);
@@ -213,6 +337,8 @@ static DEVICE_ATTR(alignment_offset, 0444, part_alignment_offset_show, NULL);
 static DEVICE_ATTR(discard_alignment, 0444, part_discard_alignment_show, NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
+static DEVICE_ATTR(write_streams, 0644, part_write_streams_show,
+		   part_write_streams_store);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 static struct device_attribute dev_attr_fail =
 	__ATTR(make-it-fail, 0644, part_fail_show, part_fail_store);
@@ -227,6 +353,7 @@ static struct attribute *part_attrs[] = {
 	&dev_attr_discard_alignment.attr,
 	&dev_attr_stat.attr,
 	&dev_attr_inflight.attr,
+	&dev_attr_write_streams.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
@@ -274,6 +401,7 @@ void drop_partition(struct block_device *part)
 {
 	lockdep_assert_held(&part->bd_disk->open_mutex);
 
+	part_put_write_streams(part);
 	xa_erase(&part->bd_disk->part_tbl, bdev_partno(part));
 	kobject_put(part->bd_holder_dir);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 686ed60a0bb7..5d241d7b0802 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -178,6 +178,8 @@ struct gendisk {
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
+	/* reserved by partitions, bit N = stream N (0 unused), open_mutex */
+	DECLARE_BITMAP(write_streams_reserved, U8_MAX + 1);
 
 	struct backing_dev_info	*bdi;
 	struct kobject queue_kobj;	/* the queue/ directory */
-- 
2.43.0


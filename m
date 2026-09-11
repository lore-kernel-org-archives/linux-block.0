Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AC400DF9
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109255; cv=none; b=nE5wsNdbIL0+pbAuMLOt5Epza5t6+SmEQitBDdqG8JAnL9RwEhvGPR9iGJE2xJ5X3Rfrh6/oMQ+G2NgxtFyT2auxqpE7BV0Tvlm0zLu6SYW+wXpT86AwGx8+fKzibov5g21C7Q8VhKQV5t50Ot7afB1tjkjTxFlmxMQaVdciAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109255; c=relaxed/simple;
	bh=YHZcjxwKiAHIu8TghwLYCjOIi5LF+P22DFhT2hsVNGs=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=UNzK+7NjABQrfWBMv+HPPqL5Kk7lH016L0fuAjrDt/6rP3vk2ixYhKj7vtmqgJVWetT1Vg+9bdyVpKcyRnbNVrm4V84SxdfHNvqosRi+QvQqov+FG06REiA7pdx5NUWKOKOK4m2U9xVgz9mIOJ7tpAAI8JHbth5hHX3coYZbDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Kw0Msg48; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kw0Msg48"
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260911064726epoutp03be64e462d68cb9c10875ab1c1a18929e~UMWGCXGbk1271212712epoutp03W
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:47:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260911064726epoutp03be64e462d68cb9c10875ab1c1a18929e~UMWGCXGbk1271212712epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789109246;
	bh=K2nPs1gd52O/bnO84GX6blGypq4FG75Urc/oLYdPXiM=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Kw0Msg48Z0P7bpSzdityOTJEJoglzcNLJZHqX9t+7ShLtyhReYPtlNpnwUTtVmV89
	 WZZ4yCbVzmlyC7bR0dgA7vTCUddc/Nm7Vdpb0NJoTvW40HNzaOXINKtmc07hcs0MZM
	 k0LKjPzeCaKfqAObIafWQe/akv8x0Ieln5FpdASs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20260911064726epcas2p11b632fcfe465765089eb970dcd8460bb~UMWFodZ1z0941409414epcas2p1W;
	Fri, 11 Sep 2026 06:47:26 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.209]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hh4q20RX4z2SSKs; Fri, 11 Sep
	2026 06:47:26 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH 1/2] block: allow write streams on partitions
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
Message-ID: <20260911064725epcms2p7c3928bafd87fcddc72560e615c7ab8a0@epcms2p7>
Date: Fri, 11 Sep 2026 15:47:25 +0900
X-CMS-MailID: 20260911064725epcms2p7c3928bafd87fcddc72560e615c7ab8a0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b
References: <20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p4>
	<CGME20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p7>

bdev_max_write_streams() returns 0 for partitions, so nothing on top of
a partition can use write streams. Passing the disk's streams through
would not be correct either: two partitions sharing a stream would put
unrelated data into the same reclaim unit.

Give each partition its own subset of the disk's write streams, kept in
a per-partition map in struct block_device. bdev_max_write_streams()
reports the partition's count, so existing users work with
partition-relative stream numbers (1..count), and blk_partition_remap()
translates them to disk streams like it remaps sectors. Only
REQ_OP_WRITE bios are translated, as that is the only operation that
consumes a write stream. A write with a stream beyond the partition's
count fails the bio; blkdev_direct_IO() rejects those before
submission, so this only catches in-kernel submitters.

Nothing assigns streams to partitions yet, so there is no functional
change.

The idea of translating the stream in blk_partition_remap() is from an
earlier patch by Christoph Hellwig, which assigned a contiguous range of
streams to each partition instead of a map.

Link: https://lore.kernel.org/all/20241119121632.1225556-16-hch@lst.de/
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 block/bdev.c              |  1 +
 block/blk-core.c          | 10 +++++++++-
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..7306a4ef0a86 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -438,6 +438,7 @@ static void bdev_free_inode(struct inode *inode)
 
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
+	kfree(bdev->bd_write_stream_map);
 	security_bdev_free(bdev);
 
 	if (!bdev_is_partition(bdev)) {
diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..3b6f09b3943f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -616,7 +616,8 @@ static inline int bio_check_eod(struct bio *bio)
 }
 
 /*
- * Remap block n of partition p to block n+start(p) of the disk.
+ * Remap block n of partition p to block n+start(p) of the disk, and the
+ * write streams of partition p to the disk write streams reserved for them.
  */
 static int blk_partition_remap(struct bio *bio)
 {
@@ -630,6 +631,13 @@ static int blk_partition_remap(struct bio *bio)
 				      bio->bi_iter.bi_sector -
 				      p->bd_start_sect);
 	}
+	if (bio->bi_write_stream && bio_op(bio) == REQ_OP_WRITE) {
+		if (unlikely(bio->bi_write_stream > p->bd_nr_write_streams))
+			return -EINVAL;
+
+		bio->bi_write_stream =
+			p->bd_write_stream_map[bio->bi_write_stream - 1];
+	}
 	bio_set_flag(bio, BIO_REMAPPED);
 	return 0;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 98e21b4cbf32..0bbfa2708099 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -71,6 +71,9 @@ struct block_device {
 
 	struct partition_meta_info *bd_meta_info;
 	int			bd_writers;
+	/* partition write stream s is disk stream bd_write_stream_map[s - 1] */
+	u8			bd_nr_write_streams;
+	u8			*bd_write_stream_map;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..686ed60a0bb7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1303,7 +1303,7 @@ static inline unsigned int bdev_max_segments(struct block_device *bdev)
 static inline unsigned short bdev_max_write_streams(struct block_device *bdev)
 {
 	if (bdev_is_partition(bdev))
-		return 0;
+		return bdev->bd_nr_write_streams;
 	return bdev_limits(bdev)->max_write_streams;
 }
 
-- 
2.43.0


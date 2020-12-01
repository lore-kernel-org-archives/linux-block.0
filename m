Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2336C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8192087D
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D4uMPzcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgLAHM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:12:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27049 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgLAHM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 02:12:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201201071212epoutp04675f8fc60686da49765c21702d281caf~MhjWwaw1O2930329303epoutp047
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 07:12:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201201071212epoutp04675f8fc60686da49765c21702d281caf~MhjWwaw1O2930329303epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606806732;
        bh=WEVp52PYiP5ZKnvlAuzxoQAkOa8ajyFydOnIeV+LoRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4uMPzccIiFD3JPdrR41IFJpteJpB0OeoJ+BcqfLk9jzeNPJRr5ssq8hFsvGGLLN8
         GX72ukD3pikFdh3JX0ZAyrN6ofkX9Ot46zs7aVqvNsTCa/wkDi8jsku8vq8vHzlITC
         xCZB5W5wBAVHvLRxiTDR6bejrLZ0B+BxKOQZtkLw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20201201071211epcas5p22b5360a27ecdb4601565f8d0a1b4c60b~MhjWK5fay0289002890epcas5p26;
        Tue,  1 Dec 2020 07:12:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.10.50652.BCCE5CF5; Tue,  1 Dec 2020 16:12:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63~MgTrz0ndC0186001860epcas5p1U;
        Tue,  1 Dec 2020 05:40:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201201054057epsmtrp2919f442b9ed9306e92fe2bd199c770cd~MgTry0VOr1422614226epsmtrp2V;
        Tue,  1 Dec 2020 05:40:57 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-c8-5fc5eccb5e81
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.6E.13470.967D5CF5; Tue,  1 Dec 2020 14:40:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201201054055epsmtip21ab53e9553905e57df53c46569a6dac2~MgTpu-ZeS0405104051epsmtip2N;
        Tue,  1 Dec 2020 05:40:54 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH 1/2] block: add simple copy support
Date:   Tue,  1 Dec 2020 11:09:48 +0530
Message-Id: <20201201053949.143175-2-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201053949.143175-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7bCmhu7pN0fjDR7MkLFYfbefzaK1/RuT
        xcrVR5ksHt/5zG5x9P9bNotJh64xWuy9pW1xedccNov5y56yW2z7PZ/Z4sqURcwW616/Z7F4
        8P46u8XrHyfZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPvi2rGD0+b5LzaD/Q
        zRTAGcVlk5Kak1mWWqRvl8CV8eH+XOaCCTMZK642/mBrYNxT28XIySEhYCKx4txd1i5GLg4h
        gd2MEjcbPzNBOJ8YJaZsmQiV+cYo8WH/SWaYliuHGqGq9jJKvDjazgLhfGaU2Pi4mxWkik1A
        V+Lakk0sILaIgJLE3/VNYEXMAvOZJCbfvgpWJCxgLvF2wwqgURwcLAKqEluum4CEeQXsJDrf
        LGGB2CYvMfPSd3YQm1PAXuLji34miBpBiZMzn4DVMAPVNG+dzQwyX0LgDIfEpN0f2UFmSgi4
        SFxYJwoxR1ji1fEt7BC2lMTnd3vZIOxyiWed05gg7AZGib735RC2vcTFPX/BTmMW0JRYv0sf
        IiwrMfXUOiaItXwSvb+fQLXySuyY94QJYquaxKntZhBhGYkPh3dBbfKQuPr2LyMkqCYxSnT8
        b2WawKgwC8k3s5B8Mwth8wJG5lWMkqkFxbnpqcWmBUZ5qeV6xYm5xaV56XrJ+bmbGMGpTctr
        B+PDBx/0DjEycTAeYpTgYFYS4WX5dyReiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/SjzNxQgLp
        iSWp2ampBalFMFkmDk6pBqb1WbX9FitnHBB6vV1agil0v9/hGVOvXtnt2ecy3zLX8d6m4ivB
        Lf+vPH0bY1z4XLWwbLfxvcIJs/rcPK6z2LSpTbl1N9h3nob6tdxPFo9XG317v99m0m4/hQVN
        VvFef/6p3WV2SvK83JuX7RtifuiSd3lvs7hhmLB+9jS/Aw/fNzxZ8e79/OjsmRtWTegKk/YW
        bHUqPXkk2fzCWc4ow84u53uLz+r3LZ27fnJh5ZNl32wmhUofqLbLmsDh9U9AdPJehTeFr3h2
        bZnvv6NQ5HXhng9s4ZXW3yp5pu8MXWif4xc9Kzm8YZ5yufyRGyLX7GfkKTxt9dz8oF006ceB
        Dlarpf1uE6embpx/8NqrzQ5KLMUZiYZazEXFiQDyVG9B3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG7m9aPxBu+WcVqsvtvPZtHa/o3J
        YuXqo0wWj+98Zrc4+v8tm8WkQ9cYLfbe0ra4vGsOm8X8ZU/ZLbb9ns9scWXKImaLda/fs1g8
        eH+d3eL1j5NsDnweO2fdZfc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH35ZVjB6fN8l5tB/o
        ZgrgjOKySUnNySxLLdK3S+DK+HB/LnPBhJmMFVcbf7A1MO6p7WLk5JAQMJG4cqiRqYuRi0NI
        YDejROfKI0wQCRmJtXc72SBsYYmV/56zg9hCAh8ZJb68Cwax2QR0Ja4t2cQCYosIKEn8Xd/E
        AjKIWWA9k8SujV/AmoUFzCXeblgBNJSDg0VAVWLLdROQMK+AnUTnmyUsEPPlJWZe+g42n1PA
        XuLji34miF12Eo9fzGeHqBeUODnzCQvIGGYBdYn184RAwsxArc1bZzNPYBSchaRqFkLVLCRV
        CxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMealuYOxu2rPugdYmTiYDzEKMHB
        rCTCy/LvSLwQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1MLUotgskwcnFIN
        THtW1huLiwcdieJ/YhE7I62JSdF06YXid24npixWnnS2+S17l7htldxE82taZ9O4mHZf8YyX
        5upzD1/noL/jTqzmlcousTtLawuNZj+oyj+vYH39Z9unK++bd6Zm/v4b7ru1IrxH70da2LKM
        NNPjPJ6c3hNjpga9D/+0rcy9brPFZ+NFmvxz5pQqPRJMk5iw9ZVGmc6riMkPld5cNKlNlHg5
        j2lx1/8qr0AFuc9NiyOuNJUueMtwQHyF4NE3f18rG56J3N3PyTlNXETypBFf+skwvgbGTx/v
        Hi/sWfh7cfPzQ4WvOo+p5X+Lufxo77wNLav2zGBu2vVB2cp+Xx7r/eV/stl9PA0c/Xr2Pnzv
        o8RSnJFoqMVcVJwIAKYBIxUkAwAA
X-CMS-MailID: 20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
        <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add new BLKCOPY ioctl that offloads copying of multiple sources
to a destination to the device. Accept copy_ranges that contains
destination, no of sources and pointer to the array of source
ranges. Each range_entry contains start and length of source
ranges (in bytes).

Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
bio with control information as payload and submit to the device.
REQ_OP_COPY(19) is a write op and takes zone_write_lock when submitted
to zoned device.

Introduce queue limits for simple copy and other helper functions.
Add device limits as sysfs entries.
	- max_copy_sectors
	- max_copy_ranges_sectors
	- max_copy_nr_ranges

max_copy_sectors = 0 indicates the device doesn't support copy.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 block/blk-core.c          | 104 +++++++++++++++++++++++++++++++---
 block/blk-lib.c           | 116 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  11 ++++
 block/blk-sysfs.c         |  23 ++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  43 ++++++++++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |   7 +++
 include/linux/blkdev.h    |  15 +++++
 include/uapi/linux/fs.h   |  21 +++++++
 12 files changed, 337 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e..6818d0cdf627 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -719,6 +719,17 @@ static noinline int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
+static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
+		sector_t nr_sectors, sector_t maxsector)
+{
+	if (nr_sectors && maxsector && (nr_sectors > maxsector ||
+				start > maxsector - nr_sectors)) {
+		handle_bad_sector(bio, maxsector);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * Check whether this bio extends beyond the end of the device or partition.
  * This may well happen - the kernel calls bread() without checking the size of
@@ -737,6 +748,75 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
 	return 0;
 }
 
+/*
+ * Check for copy limits and remap source ranges if needed.
+ */
+static inline int blk_check_copy(struct bio *bio)
+{
+	struct hd_struct *p = NULL;
+	struct request_queue *q = bio->bi_disk->queue;
+	struct blk_copy_payload *payload;
+	unsigned short nr_range;
+	int ret = -EIO;
+	int i, copy_len = 0;
+
+	rcu_read_lock();
+
+	if (bio->bi_partno) {
+		p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+		if (unlikely(!p))
+			goto out;
+		if (unlikely(bio_check_ro(bio, p)))
+			goto out;
+	} else {
+		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+			goto out;
+	}
+
+	payload = bio_data(bio);
+	nr_range = payload->copy_range;
+
+	/* cannot handle copy crossing nr_ranges limit */
+	if (payload->copy_range > q->limits.max_copy_nr_ranges)
+		goto out;
+
+	for (i = 0; i < nr_range; i++) {
+		copy_len += payload->range[i].len;
+		if (p) {
+			if (bio_check_copy_eod(bio, payload->range[i].src,
+					payload->range[i].len, part_nr_sects_read(p)))
+				goto out;
+			payload->range[i].src += p->start_sect;
+		} else {
+			if (unlikely(bio_check_copy_eod(bio, payload->range[i].src,
+					payload->range[i].len,
+					get_capacity(bio->bi_disk))))
+				goto out;
+		}
+	}
+
+	/* cannot handle copy more than copy limits */
+	if (copy_len > q->limits.max_copy_sectors)
+		goto out;
+
+	if (p) {
+		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,
+					part_nr_sects_read(p))))
+			goto out;
+	} else {
+		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,
+					get_capacity(bio->bi_disk))))
+			goto out;
+
+	}
+
+	if (p)
+		bio->bi_partno = 0;
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -825,14 +905,16 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (should_fail_bio(bio))
 		goto end_io;
 
-	if (bio->bi_partno) {
-		if (unlikely(blk_partition_remap(bio)))
-			goto end_io;
-	} else {
-		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
-			goto end_io;
-		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
-			goto end_io;
+	if (likely(!op_is_copy(bio->bi_opf))) {
+		if (bio->bi_partno) {
+			if (unlikely(blk_partition_remap(bio)))
+				goto end_io;
+		} else {
+			if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+				goto end_io;
+			if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
+				goto end_io;
+		}
 	}
 
 	/*
@@ -856,6 +938,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (!blk_queue_discard(q))
 			goto not_supported;
 		break;
+	case REQ_OP_COPY:
+		if (!blk_queue_copy(q))
+			goto not_supported;
+		if (unlikely(blk_check_copy(bio)))
+			goto end_io;
+		break;
 	case REQ_OP_SECURE_ERASE:
 		if (!blk_queue_secure_erase(q))
 			goto not_supported;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e90614fd8d6a..db4947f7014d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -150,6 +150,122 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
+		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
+		int flags, struct bio **biop)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio;
+	struct blk_copy_payload *payload;
+	unsigned int op;
+	sector_t bs_mask;
+	sector_t src_sects, len = 0, total_len = 0;
+	int i, ret, total_size;
+
+	if (!q)
+		return -ENXIO;
+
+	if (!nr_srcs)
+		return -EINVAL;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	if (!blk_queue_copy(q))
+		return -EOPNOTSUPP;
+	op = REQ_OP_COPY;
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if (dest & bs_mask)
+		return -EINVAL;
+
+	payload = kmalloc(sizeof(struct blk_copy_payload) +
+			nr_srcs * sizeof(struct range_entry),
+				GFP_ATOMIC | __GFP_NOWARN);
+	if (!payload)
+		return -ENOMEM;
+
+	bio = bio_alloc(gfp_mask, 1);
+	bio->bi_iter.bi_sector = dest;
+	bio_set_dev(bio, bdev);
+	bio_set_op_attrs(bio, op, REQ_NOMERGE);
+
+	payload->dest = dest;
+
+	for (i = 0; i < nr_srcs; i++) {
+		/*  copy payload provided are in bytes */
+		src_sects = rlist[i].src;
+		if (src_sects & bs_mask)
+			return -EINVAL;
+		src_sects = src_sects >> SECTOR_SHIFT;
+
+		if (len & bs_mask)
+			return -EINVAL;
+		len = rlist[i].len >> SECTOR_SHIFT;
+		if (len > q->limits.max_copy_range_sectors)
+			return -EINVAL;
+
+		total_len += len;
+
+		WARN_ON_ONCE((src_sects << 9) > UINT_MAX);
+
+		payload->range[i].src = src_sects;
+		payload->range[i].len = len;
+	}
+
+	/* storing # of source ranges */
+	payload->copy_range = i;
+	/* storing copy len so far */
+	payload->copy_size = total_len;
+
+	total_size = sizeof(struct blk_copy_payload) + nr_srcs * sizeof(struct range_entry);
+	ret = bio_add_page(bio, virt_to_page(payload), total_size,
+					   offset_in_page(payload));
+	if (ret != total_size) {
+		kfree(payload);
+		return -ENOMEM;
+	}
+
+	*biop = bio;
+	return 0;
+}
+EXPORT_SYMBOL(__blkdev_issue_copy);
+
+/**
+ * blkdev_issue_copy - queue a copy
+ * @bdev:       blockdev to issue copy for
+ * @dest:	dest sector
+ * @nr_srcs:	number of source ranges to copy
+ * @rlist:	list of range entries
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ * @flags:      BLKDEV_COPY_* flags to control behaviour	//TODO
+ *
+ * Description:
+ *    Issue a copy request for dest sector with source in rlist
+ */
+int blkdev_issue_copy(struct block_device *bdev, sector_t dest,
+		int nr_srcs, struct range_entry *rlist,
+		gfp_t gfp_mask, unsigned long flags)
+{
+	struct bio *bio = NULL;
+	int ret;
+
+	ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
+			&bio);
+	if (!ret && bio) {
+		ret = submit_bio_wait(bio);
+		if (ret == -EOPNOTSUPP)
+			ret = 0;
+
+		kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
+				bio_first_bvec_all(bio)->bv_offset);
+		bio_put(bio);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_copy);
+
 /**
  * __blkdev_issue_write_same - generate number of bios with same page
  * @bdev:	target blockdev
diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..a16e7598d6ad 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -301,6 +301,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
+	case REQ_OP_COPY:
+			break;
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9741d1d83e98..18e357939ed4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,9 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->max_copy_sectors = 0;
+	lim->max_copy_nr_ranges = 0;
+	lim->max_copy_range_sectors = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -549,6 +552,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
 	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
 
+	/* copy limits */
+	t->max_copy_sectors = min_not_zero(t->max_copy_sectors,
+			b->max_copy_sectors);
+	t->max_copy_range_sectors = min_not_zero(t->max_copy_range_sectors,
+			b->max_copy_range_sectors);
+	t->max_copy_nr_ranges = min_not_zero(t->max_copy_nr_ranges,
+			b->max_copy_nr_ranges);
+
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
 		t->physical_block_size = t->logical_block_size;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..e5aabb6a3ac1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -166,6 +166,23 @@ static ssize_t queue_discard_granularity_show(struct request_queue *q, char *pag
 	return queue_var_show(q->limits.discard_granularity, page);
 }
 
+static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.max_copy_sectors, page);
+}
+
+static ssize_t queue_max_copy_range_sectors_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_range_sectors, page);
+}
+
+static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_nr_ranges, page);
+}
+
 static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
 {
 
@@ -590,6 +607,9 @@ QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
+QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
@@ -636,6 +656,9 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_max_copy_sectors_entry.attr,
+	&queue_max_copy_range_sectors_entry.attr,
+	&queue_max_copy_nr_ranges_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6817a673e5ce..6e5fef3cc615 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -75,6 +75,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
+	case REQ_OP_COPY:
 		return blk_rq_zone_is_seq(rq);
 	default:
 		return false;
diff --git a/block/bounce.c b/block/bounce.c
index 162a6eee8999..7fbdc52decb3 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -254,6 +254,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
 	switch (bio_op(bio)) {
+	case REQ_OP_COPY:
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
diff --git a/block/ioctl.c b/block/ioctl.c
index 6b785181344f..a4a507d85e56 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -142,6 +142,47 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 				    GFP_KERNEL, flags);
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg, unsigned long flags)
+{
+	struct copy_range crange;
+	struct range_entry *rlist;
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t dest;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!blk_queue_copy(q))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	if (crange.dest & ((1 << SECTOR_SHIFT) - 1))
+		return -EFAULT;
+	dest = crange.dest >> SECTOR_SHIFT;
+
+	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
+			GFP_ATOMIC | __GFP_NOWARN);
+
+	if (!rlist)
+		return -ENOMEM;
+
+	if (copy_from_user(rlist, (void __user *)crange.range_list,
+				sizeof(*rlist) * crange.nr_range)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = blkdev_issue_copy(bdev, dest, crange.nr_range,
+			rlist, GFP_KERNEL, flags);
+out:
+	kfree(rlist);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -467,6 +508,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKSECDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg,
 				BLKDEV_DISCARD_SECURE);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg, 0);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKREPORTZONE:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ecf67108f091..7e40a37f0ee5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -71,6 +71,7 @@ static inline bool bio_has_data(struct bio *bio)
 static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
+	       bio_op(bio) == REQ_OP_COPY ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc..fbb6396b0317 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -360,6 +360,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 15,
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= 17,
+	/* copy ranges within device */
+	REQ_OP_COPY		= 19,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
@@ -486,6 +488,11 @@ static inline bool op_is_discard(unsigned int op)
 	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
 }
 
+static inline bool op_is_copy(unsigned int op)
+{
+	return (op & REQ_OP_MASK) == REQ_OP_COPY;
+}
+
 /*
  * Check if a bio or request operation is a zone management operation, with
  * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..dbeaeebf41c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -340,10 +340,13 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		max_copy_sectors;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
+	unsigned short		max_copy_range_sectors;
+	unsigned short		max_copy_nr_ranges;
 
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
@@ -625,6 +628,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_COPY		30	/* supports copy */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -647,6 +651,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
@@ -1059,6 +1064,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_COPY))
+		return q->limits.max_copy_sectors;
+
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
@@ -1330,6 +1338,13 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
 
+extern int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
+		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
+		int flags, struct bio **biop);
+extern int blkdev_issue_copy(struct block_device *bdev, sector_t dest,
+		int nr_srcs, struct range_entry *rlist,
+		gfp_t gfp_mask, unsigned long flags);
+
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..e6d7b1232f3a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,26 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+struct range_entry {
+	__u64 src;
+	__u64 len;
+};
+
+struct copy_range {
+	__u64 dest;
+	__u64 nr_range;
+	__u64 range_list;
+	__u64 rsvd;
+};
+
+struct blk_copy_payload {
+	sector_t	dest;
+	int		copy_range;
+	int		copy_size;
+	int		err;
+	struct	range_entry	range[];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -184,6 +204,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKCOPY _IOWR(0x12, 128, struct copy_range)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.25.1


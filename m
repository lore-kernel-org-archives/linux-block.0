Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32AC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A36D229F0
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbgLDLDM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 06:03:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46257 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbgLDLDM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 06:03:12 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201204110225epoutp04dcba62ef76c2ade3f1b1939ca1684009~NfoN4XXH12046520465epoutp042
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 11:02:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201204110225epoutp04dcba62ef76c2ade3f1b1939ca1684009~NfoN4XXH12046520465epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607079745;
        bh=LkfscQGUqGi5vNP0JFLqpySqtZKgWZFy6zzZtQPfxqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDatY6+LKeiY5tHuGq0E3G/BK1vx9k4YgScrOdk4Dvj3KihH4moupGjnR53xuSEm6
         vJ6AIuqkZO4koowOvb+bGhos7YM0NWapnXOi5AuAJbICAViZa7QUHFXDB0ig2CK6kr
         Yx/sP4KpLjMFc+zfJ5wkY4NPrSrWzJFW/x+1yt8I=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201204110224epcas5p409c9c9f48d10c8d5b635b710199e41ce~NfoNYKalR1182411824epcas5p4Z;
        Fri,  4 Dec 2020 11:02:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.E1.33964.0471ACF5; Fri,  4 Dec 2020 20:02:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053~Nem07aUXO3264732647epcas5p33;
        Fri,  4 Dec 2020 09:47:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201204094731epsmtrp168c53d646a5885afb1f4f5314a847624~Nem06gFV62092920929epsmtrp18;
        Fri,  4 Dec 2020 09:47:31 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-87-5fca17409dbe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.28.13470.3B50ACF5; Fri,  4 Dec 2020 18:47:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201204094721epsmtip2cfb4d47d6104e6da69959fd1c8c8d662~Nemrhwffj0388403884epsmtip2O;
        Fri,  4 Dec 2020 09:47:21 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v2 1/2] block: add simple copy support
Date:   Fri,  4 Dec 2020 15:16:58 +0530
Message-Id: <20201204094659.12732-2-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204094659.12732-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmuq6D+Kl4g/Vr5CxW3+1ns2ht/8Zk
        sffdbFaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFvOXPWW32PZ7PrPFlSmLmC3W
        vX7PYvHg/XV2i9c/TrJZtG38yugg4LFz1l12j/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawebzf
        d5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZXQ8usRasGgGY8XmGadYGxgv13Qx
        cnJICJhI3LvTy9TFyMUhJLCbUWLb6SPMEM4nRomrq9qgMt8YJaa/vMcC07LxeSdUYi+jxJLJ
        S6Ccz4wSP05tYQSpYhPQlbi2ZBNYh4iAksTf9U0sIEXMAqeYJJr+7WIHSQgLWEk0bP3DDGKz
        CKhKXHr8BqyZV8BW4u/LJnaIdfISMy99B7M5BewkVmx7xwZRIyhxcuYTsAXMQDXNW2eDHS4h
        cIdD4vrGS6wQzS4SP6feg7KFJV4d3wI1VEriZX8blF0u8axzGhOE3cAo0fe+HMK2l7i45y9Q
        nANogabE+l36EGFZiamn1jFB7OWT6P39BKqVV2LHvCdg5RICahKntptBhGUkPhzexQYR9pD4
        sYYNElYTGSVmN01lmsCoMAvJN7OQfDMLYfECRuZVjJKpBcW56anFpgXGeanlesWJucWleel6
        yfm5mxjBqU/Lewfjowcf9A4xMnEwHmKU4GBWEuGNVT0ZL8SbklhZlVqUH19UmpNafIhRmoNF
        SZxX6ceZOCGB9MSS1OzU1ILUIpgsEwenVAPTucT8/ZYyu1KVE097SPy+2vLx3MH+RPYWh+rg
        gvf+K4ru6OitOXZzsghD6f+L1qy/N59TkBN9mdR0/XKyl6nCz6zzjd0Nxr2GB1cfST0aePTg
        1NMtG/nvVSzQKjzYzftxdva9VRc8rW9kFX15wFti9bash+3fakH7vf8Ph3OZy5hP7QrTsDp8
        5vGRdykdYqs+lD75HqB6oyAlTzAh7UOUoKjdsfOlt7t0bd3iHl6/9VB7iaKDkuX8z3/t9O+a
        GczkENMTauW6kqATdUv9iERaWZP0PtUFkrf2y0i9nZlvl69i5M5oe+h2/LpVhmYrbQ4xMe+d
        6MRy77Wv+sWyW9WFjD8Mn77sStyw4nbpvBVKLMUZiYZazEXFiQBAg3i97AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvO5m1lPxBivnS1usvtvPZtHa/o3J
        Yu+72awWK1cfZbJ4fOczu8XR/2/ZLCYdusZosfeWtsXlXXPYLOYve8puse33fGaLK1MWMVus
        e/2exeLB++vsFq9/nGSzaNv4ldFBwGPnrLvsHufvbWTxuHy21GPTqk42j81L6j1232xg83i/
        7yqbR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3St0vgyuh4dIm1YNEMxorNM06xNjBeruli
        5OSQEDCR2Pi8k6mLkYtDSGA3o8TSXRfYIBIyEmvvdkLZwhIr/z1nhyj6yChxc+ZrdpAEm4Cu
        xLUlm1hAbBEBJYm/65vAbGaBO0wS2364gtjCAlYSDVv/MIPYLAKqEpcev2EEsXkFbCX+vmxi
        h1ggLzHz0ncwm1PATmLFtndgi4WAaprbF0LVC0qcnPkEaD4H0Hx1ifXzhCBWyUs0b53NPIFR
        cBaSqlkIVbOQVC1gZF7FKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREci1qaOxi3r/qg
        d4iRiYPxEKMEB7OSCG+s6sl4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuoBSAumJJanZqakF
        qUUwWSYOTqkGJvPHD1YlbT3Gplm8PYJjflzktuN7zl8T8lDmUtLdethmJlsAx5ZDEt12d83C
        ja4J+CbU7LZ7nfNRqqpqfVqo3b/Tc86Up/fNn/WBof7DhY7jc+aeBWLBTXwVzXrXdZb/2f7q
        mfL2fV+tdolWP9b50/wrli2xnj127qqyGQt2C+oJc11aqz/t7i6Fo1/C7jjHvD6Xukdk56l9
        jy55LX22vmnF8tKlbhouMUva1hlbXHq4ufej6YKFp1q9L0Z1bT35fp9ylOPcZO5TTjuLY3ZN
        lpk+2/huxlnZrvydYecuv/+So35ZOrDkUNOqnD8Pn/659eTb4uoz+w//3z/76Kmp/Aa6NQu1
        omJ3aj0qe1uTf1uJpTgj0VCLuag4EQDZDv1VNAMAAA==
X-CMS-MailID: 20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053
References: <20201204094659.12732-1-selvakuma.s1@samsung.com>
        <CGME20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053@epcas5p3.samsung.com>
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
 block/blk-core.c          |  94 ++++++++++++++++++++++++++---
 block/blk-lib.c           | 123 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  11 ++++
 block/blk-sysfs.c         |  23 +++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  43 +++++++++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  15 +++++
 include/linux/blkdev.h    |  15 +++++
 include/uapi/linux/fs.h   |  13 ++++
 12 files changed, 334 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e..07d64514e77b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -719,6 +719,17 @@ static noinline int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
+static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
+		sector_t nr_sectors, sector_t maxsector)
+{
+	if (nr_sectors && maxsector &&
+	    (nr_sectors > maxsector || start > maxsector - nr_sectors)) {
+		handle_bad_sector(bio, maxsector);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * Check whether this bio extends beyond the end of the device or partition.
  * This may well happen - the kernel calls bread() without checking the size of
@@ -737,6 +748,65 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
 	return 0;
 }
 
+/*
+ * Check for copy limits and remap source ranges if needed.
+ */
+static int blk_check_copy(struct bio *bio)
+{
+	struct hd_struct *p = NULL;
+	struct request_queue *q = bio->bi_disk->queue;
+	struct blk_copy_payload *payload;
+	int i, maxsector, start_sect = 0, ret = -EIO;
+	unsigned short nr_range;
+
+	rcu_read_lock();
+
+	if (bio->bi_partno) {
+		p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+		if (unlikely(!p))
+			goto out;
+		if (unlikely(bio_check_ro(bio, p)))
+			goto out;
+		maxsector = part_nr_sects_read(p);
+		start_sect = p->start_sect;
+	} else {
+		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+			goto out;
+		maxsector =  get_capacity(bio->bi_disk);
+	}
+
+	payload = bio_data(bio);
+	nr_range = payload->copy_range;
+
+	/* cannot handle copy crossing nr_ranges limit */
+	if (payload->copy_range > q->limits.max_copy_nr_ranges)
+		goto out;
+
+	/* cannot handle copy more than copy limits */
+	if (payload->copy_size > q->limits.max_copy_sectors)
+		goto out;
+
+	/* check if copy length crosses eod */
+	if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector,
+					payload->copy_size, maxsector)))
+		goto out;
+	bio->bi_iter.bi_sector += start_sect;
+
+	for (i = 0; i < nr_range; i++) {
+		if (unlikely(bio_check_copy_eod(bio, payload->range[i].src,
+					payload->range[i].len, maxsector)))
+			goto out;
+		payload->range[i].src += start_sect;
+	}
+
+	if (p)
+		bio->bi_partno = 0;
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -825,14 +895,16 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
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
@@ -856,6 +928,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
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
index e90614fd8d6a..96f727c4d0de 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -150,6 +150,129 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
+		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
+		int flags, struct bio **biop)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio;
+	struct blk_copy_payload *payload;
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
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if (dest & bs_mask)
+		return -EINVAL;
+
+	total_size = struct_size(payload, range, nr_srcs);
+	payload = kmalloc(total_size, GFP_ATOMIC | __GFP_NOWARN);
+	if (!payload)
+		return -ENOMEM;
+
+	bio = bio_alloc(gfp_mask, 1);
+	bio->bi_iter.bi_sector = dest;
+	bio->bi_opf = REQ_OP_COPY | REQ_NOMERGE;
+	bio_set_dev(bio, bdev);
+
+	payload->dest = dest;
+
+	for (i = 0; i < nr_srcs; i++) {
+		/*  copy payload provided are in bytes */
+		src_sects = rlist[i].src;
+		if (src_sects & bs_mask) {
+			ret =  -EINVAL;
+			goto err;
+		}
+		src_sects = src_sects >> SECTOR_SHIFT;
+
+		if (len & bs_mask) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		len = rlist[i].len >> SECTOR_SHIFT;
+		if (len > q->limits.max_copy_range_sectors) {
+			ret = -EINVAL;
+			goto err;
+		}
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
+	ret = bio_add_page(bio, virt_to_page(payload), total_size,
+					   offset_in_page(payload));
+	if (ret != total_size) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	*biop = bio;
+	return 0;
+err:
+	kfree(payload);
+	bio_put(bio);
+	return ret;
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
index d9b69bbde5cc..4ecb9c16702d 100644
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
@@ -545,4 +552,12 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+struct blk_copy_payload {
+	sector_t	dest;
+	int		copy_range;
+	int		copy_size;
+	int		err;
+	struct	range_entry	range[];
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
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
index f44eb0a04afd..5cadb176317a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,18 @@ struct fstrim_range {
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
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -184,6 +196,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKCOPY _IOWR(0x12, 128, struct copy_range)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.25.1


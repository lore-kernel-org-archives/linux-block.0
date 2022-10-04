Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B4C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 16:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJDQ6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJDQ6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 12:58:00 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F7665836
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 09:57:58 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id l12so13204457pjh.2
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 09:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lyCJAGqgo0ZI3+eg3lT3aBoVpQ/IN2E+yM/IuNtdBiI=;
        b=f6OiO/Z+BdNK7jHeLoGt6fh3YiC3rAwKsg9ej3ULu5u5lgkSSh2iyd7GRFb4jJ407L
         7JIcj11XRBo4FYPZ+k2v2ifDFTFw1piWl0ZxWXf783jTXsLhZT3lzEnBeXPOi8If9rEI
         Ld9b59zJMM2nFgOih67zS3+2T8c6RNi8Z7AN+X2cuFtZ8JEaxQ2eAWRW32ZUz6GlAQ+G
         SwEVPfVEO7OJz/VhkkAnqrWUOmG+/mQdp4SjfdI8co+3sR7gl3jK8hKSSp3ubxpnTG8E
         DQwrdyk7R/HUCLV5xcwWm+86MydtRzpSW2uf+rJ9B2yjwCUKC6mi22QVVMWoKuOJ2xud
         EMrw==
X-Gm-Message-State: ACrzQf1A97H8kiF7dqNUesHfzhMjDPuR9hnBd45pp/qXsu+pOBvNVTU9
        7G5mvfp2RLLfAVS94RGiqu+8MDiT/m0=
X-Google-Smtp-Source: AMsMyM4F0OkqwdkqTL+wtFc7A0GtXb2UWkD4mMKRv9f50Mtehjd62D3uHThDRfzFARxwPqUlcoFqvg==
X-Received: by 2002:a17:90a:4502:b0:202:7a55:558f with SMTP id u2-20020a17090a450200b002027a55558fmr640615pjg.108.1664902677589;
        Tue, 04 Oct 2022 09:57:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b6b5:f763:ff03:8283? ([2620:15c:211:201:b6b5:f763:ff03:8283])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b00202fbd9c21dsm8148899pjl.48.2022.10.04.09.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 09:57:56 -0700 (PDT)
Message-ID: <466b656e-cb5f-51eb-09f7-d3198513dee3@acm.org>
Date:   Tue, 4 Oct 2022 09:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Supporting segment sizes smaller than the page size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
 <20220922053917.GA27293@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220922053917.GA27293@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/22 22:39, Christoph Hellwig wrote:
> On Wed, Sep 21, 2022 at 04:28:32PM -0700, Bart Van Assche wrote:
>> I have been asked to add support for DMA segment sizes that are smaller
>> than the page size to support a UFS controller with a maximum DMA segment
>> size of 4 KiB and a page size > 4 KiB (my understanding of the JEDEC UFS
>> host controller specification is that UFS host controllers should support a
>> maximum DMA segment size of 256 KiB). Does anyone want to comment on this
>> before I start working on a patch series?
> 
> Don't do it.  This gets us into all kinds of corner cases, and even
> worse now requires to do the expensive segment walk for every I/O while
> right now we have a nice little fast path.

Hi Christoph,

I think the patches below show that this functionality can be implemented
easily and also without affecting the performance of the hot path significantly.
This functionality is needed for systems that include an Exynos UFS host
controller (e.g. mobile phones and Tesla cars) and for which the page size is
larger than 4 KiB.

Please let me know if you want me to introduce a kernel configuration option for
enabling small segment support.

Thanks,

Bart.



Subject: [PATCH 1/6] block: Introduce QUEUE_FLAG_SUB_PAGE_SEGMENTS

Prepare for introducing support for segments smaller than the page size
one driver at a time by introducing the request queue flag
QUEUE_FLAG_SUB_PAGE_SEGMENTS. Although I am not aware of any storage
controller that restricts the segment size to 512 bytes, supporting 512
bytes as minimum segment size makes it easy to test small segment support
on systems with PAGE_SIZE = 4096.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-settings.c   | 10 ++++++----
  include/linux/blkdev.h |  3 +++
  2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..878529096d6e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -277,10 +277,12 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
   **/
  void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
  {
-	if (max_size < PAGE_SIZE) {
-		max_size = PAGE_SIZE;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_size);
+	unsigned int min_segment_size = blk_queue_sub_page_segments(q) ?
+		SECTOR_SIZE : PAGE_SIZE;
+
+	if (max_size < min_segment_size) {
+		max_size = min_segment_size;
+		printk(KERN_INFO "%s: set to minimum %d\n", __func__, max_size);
  	}

  	/* see blk_queue_virt_boundary() for the explanation */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 49373d002631..35a804dfece0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SUB_PAGE_SEGMENTS 31	/* segments smaller than one page */

  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -619,6 +620,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
  #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
  #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_sub_page_segments(q)				\
+	test_bit(QUEUE_FLAG_SUB_PAGE_SEGMENTS, &(q)->queue_flags)

  extern void blk_set_pm_only(struct request_queue *q);
  extern void blk_clear_pm_only(struct request_queue *q);

------------------------------------------------------------------------------

Subject: [PATCH 2/6] block: Make a check inside bio_map_user_iov() more strict

Before changing the return value of bio_add_hw_page() into a value in
the range [0, len], make the callers of this function verify that the
entire data range has been added.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-map.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..2609614b9a9e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -310,8 +310,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
  				if (n > bytes)
  					n = bytes;

-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
+				if (bio_add_hw_page(rq->q, bio, page, n, offs,
+						max_sectors, &same_page) < n) {
  					if (same_page)
  						put_page(page);
  					break;

------------------------------------------------------------------------------

Subject: [PATCH 3/6] block: Add support for segments smaller than the page
  size

Add the necessary checks in the bio splitting code for splitting bios
into segments smaller than the page size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-map.c   | 12 +++++++++---
  block/blk-merge.c | 13 ++++++++++---
  block/blk.h       |  5 +++--
  3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 2609614b9a9e..b1b643d54436 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -383,15 +383,19 @@ static struct bio *bio_map_kern(struct request_queue *q, void *data,
  	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
  	unsigned long start = kaddr >> PAGE_SHIFT;
  	const int nr_pages = end - start;
+	int nr_bvecs = nr_pages;
  	bool is_vmalloc = is_vmalloc_addr(data);
  	struct page *page;
  	int offset, i;
  	struct bio *bio;

-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	if (q->limits.max_segment_size < PAGE_SIZE)
+		nr_bvecs *= (PAGE_SIZE + q->limits.max_segment_size - 1) /
+			q->limits.max_segment_size;
+	bio = bio_kmalloc(nr_bvecs, gfp_mask);
  	if (!bio)
  		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_bvecs, 0);

  	if (is_vmalloc) {
  		flush_kernel_vmap_range(data, len);
@@ -530,8 +534,10 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
  	struct bio_vec bv;
  	unsigned int nr_segs = 0;

-	bio_for_each_bvec(bv, bio, iter)
+	bio_for_each_bvec(bv, bio, iter) {
+		bv.bv_len = min(bv.bv_len, rq->q->limits.max_segment_size);
  		nr_segs++;
+	}

  	if (!rq->bio) {
  		blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0c90d502ec87..b134dd1411c9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -291,8 +291,14 @@ static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,

  		if (nsegs < lim->max_segments &&
  		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			nsegs++;
+		    bv.bv_offset + bv.bv_len <= PAGE_SIZE &&
+		    bv.bv_len <= lim->max_segment_size) {
+			/* single-page bvec optimization */
+			if (lim->max_segment_size > PAGE_SIZE)
+				nsegs++;
+			else
+				nsegs += (bv.bv_len + lim->max_segment_size -
+					  1) / lim->max_segment_size;
  			bytes += bv.bv_len;
  		} else {
  			if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
@@ -528,7 +534,8 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
  			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))
  				goto next_bvec;

-			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE)
+			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE &&
+			    bvec.bv_len <= q->limits.max_segment_size)
  				nsegs += __blk_bvec_map_sg(bvec, sglist, sg);
  			else
  				nsegs += blk_bvec_map_sg(q, &bvec, sglist, sg);
diff --git a/block/blk.h b/block/blk.h
index 5350bf363035..acf3b8bae46e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -290,7 +290,7 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
  				const char *, size_t);

  static inline bool bio_may_exceed_limits(struct bio *bio,
-		struct queue_limits *lim)
+					 const struct queue_limits *lim)
  {
  	switch (bio_op(bio)) {
  	case REQ_OP_DISCARD:
@@ -302,7 +302,7 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
  	}

  	/*
-	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
+	 * Check whether bio splitting should be performed.
  	 * This is a quick and dirty check that relies on the fact that
  	 * bi_io_vec[0] is always valid if a bio has data.  The check might
  	 * lead to occasional false negatives when bios are cloned, but compared
@@ -310,6 +310,7 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
  	 * doesn't matter anyway.
  	 */
  	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
+		bio->bi_io_vec->bv_len > lim->max_segment_size ||
  		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
  }

------------------------------------------------------------------------------

Subject: [PATCH 4/6] scsi: core: Set the SUB_PAGE_SEGMENTS request queue flag

This patch enables support for segments smaller than the page size.
No changes other than setting the SUB_PAGE_SEGMENTS flag are required
since the SCSI code uses blk_rq_map_sg().

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/scsi/scsi_lib.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d7ec4ab2b111..99b706b11f41 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1869,6 +1869,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
  {
  	struct device *dev = shost->dma_dev;

+	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, q);
+
  	/*
  	 * this limit is imposed by hardware restrictions
  	 */

------------------------------------------------------------------------------

Subject: [PATCH 5/6] scsi_debug: Support configuring the maximum segment size

Add a kernel module parameter for configuring the maximum segment size.
This patch enables testing SCSI support for segments smaller than the
page size.

Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/scsi/scsi_debug.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..1c7575440519 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -770,6 +770,7 @@ static int sdebug_sector_size = DEF_SECTOR_SIZE;
  static int sdeb_tur_ms_to_ready = DEF_TUR_MS_TO_READY;
  static int sdebug_virtual_gb = DEF_VIRTUAL_GB;
  static int sdebug_vpd_use_hostno = DEF_VPD_USE_HOSTNO;
+static unsigned int sdebug_max_segment_size = -1U;
  static unsigned int sdebug_lbpu = DEF_LBPU;
  static unsigned int sdebug_lbpws = DEF_LBPWS;
  static unsigned int sdebug_lbpws10 = DEF_LBPWS10;
@@ -5844,6 +5845,7 @@ module_param_named(ndelay, sdebug_ndelay, int, S_IRUGO | S_IWUSR);
  module_param_named(no_lun_0, sdebug_no_lun_0, int, S_IRUGO | S_IWUSR);
  module_param_named(no_rwlock, sdebug_no_rwlock, bool, S_IRUGO | S_IWUSR);
  module_param_named(no_uld, sdebug_no_uld, int, S_IRUGO);
+module_param_named(max_segment_size, sdebug_max_segment_size, uint, S_IRUGO);
  module_param_named(num_parts, sdebug_num_parts, int, S_IRUGO);
  module_param_named(num_tgts, sdebug_num_tgts, int, S_IRUGO | S_IWUSR);
  module_param_named(opt_blks, sdebug_opt_blks, int, S_IRUGO);
@@ -7804,6 +7806,7 @@ static int sdebug_driver_probe(struct device *dev)

  	sdebug_driver_template.can_queue = sdebug_max_queue;
  	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
+	sdebug_driver_template.max_segment_size = sdebug_max_segment_size;
  	if (!sdebug_clustering)
  		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;

------------------------------------------------------------------------------

Subject: [PATCH 6/6] null_blk: Support configuring the maximum segment size

Add support for configuring the maximum segment size.

Add support for segments smaller than the page size.

This patch enables testing segments smaller than the page size with a
driver that does not call blk_rq_map_sg().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/block/null_blk/main.c     | 20 +++++++++++++++++---
  drivers/block/null_blk/null_blk.h |  1 +
  2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..bc811ab52c4a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -157,6 +157,10 @@ static int g_max_sectors;
  module_param_named(max_sectors, g_max_sectors, int, 0444);
  MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");

+static unsigned int g_max_segment_size = 1UL << 31;
+module_param_named(max_segment_size, g_max_segment_size, int, 0444);
+MODULE_PARM_DESC(max_segment_size, "Maximum size of a segment in bytes");
+
  static unsigned int nr_devices = 1;
  module_param(nr_devices, uint, 0444);
  MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -409,6 +413,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
  NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
  NULLB_DEVICE_ATTR(blocksize, uint, NULL);
  NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_segment_size, uint, NULL);
  NULLB_DEVICE_ATTR(irqmode, uint, NULL);
  NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
  NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -532,6 +537,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
  	&nullb_device_attr_queue_mode,
  	&nullb_device_attr_blocksize,
  	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_segment_size,
  	&nullb_device_attr_irqmode,
  	&nullb_device_attr_hw_queue_depth,
  	&nullb_device_attr_index,
@@ -610,7 +616,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
  	return snprintf(page, PAGE_SIZE,
  			"badblocks,blocking,blocksize,cache_size,"
  			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
+			"irqmode,max_sectors,max_segment_size,mbps,"
+			"memory_backed,no_sched,"
  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
  			"zone_capacity,zone_max_active,zone_max_open,"
@@ -673,6 +680,7 @@ static struct nullb_device *null_alloc_dev(void)
  	dev->queue_mode = g_queue_mode;
  	dev->blocksize = g_bs;
  	dev->max_sectors = g_max_sectors;
+	dev->max_segment_size = g_max_segment_size;
  	dev->irqmode = g_irqmode;
  	dev->hw_queue_depth = g_hw_queue_depth;
  	dev->blocking = g_blocking;
@@ -1214,6 +1222,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
  	unsigned int valid_len = len;
  	int err = 0;

+	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
+		  dev->max_segment_size);
  	if (!is_write) {
  		if (dev->zoned)
  			valid_len = null_zone_valid_read_len(nullb,
@@ -1249,7 +1259,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)

  	spin_lock_irq(&nullb->lock);
  	rq_for_each_segment(bvec, rq, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
  				     op_is_write(req_op(rq)), sector,
  				     rq->cmd_flags & REQ_FUA);
@@ -1276,7 +1287,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)

  	spin_lock_irq(&nullb->lock);
  	bio_for_each_segment(bvec, bio, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
  				     op_is_write(bio_op(bio)), sector,
  				     bio->bi_opf & REQ_FUA);
@@ -2088,6 +2100,7 @@ static int null_add_dev(struct nullb_device *dev)
  	nullb->q->queuedata = nullb;
  	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
+	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, nullb->q);

  	mutex_lock(&lock);
  	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
@@ -2106,6 +2119,7 @@ static int null_add_dev(struct nullb_device *dev)
  	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
  				 BLK_DEF_MAX_SECTORS);
  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);

  	if (dev->virt_boundary)
  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..6784ee9f5fda 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -102,6 +102,7 @@ struct nullb_device {
  	unsigned int queue_mode; /* block interface */
  	unsigned int blocksize; /* block size */
  	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int max_segment_size; /* Max size of a single DMA segment. */
  	unsigned int irqmode; /* IRQ completion handler */
  	unsigned int hw_queue_depth; /* queue depth */
  	unsigned int index; /* index of the disk, only valid with a disk */

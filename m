Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC72C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiF3TGf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiF3TGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 15:06:35 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E737A32
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 12:06:33 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id jb13so193265plb.9
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 12:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=KRQBd79MRCGyesv4rTAz6Vy/NMKYLZMlAVPCNEUd798=;
        b=pi+tghyyYzJ5SzOWBeiHyWQh1fBVDo5iImCkcneEaIbl7k+DmtUsgEWTP/b8+zTgoB
         eIk71tBntKjYY8ie5Trp4JhEy2rUlfKkjMjri89Z9vJmrgusJPOAiZHARD+6CPkst7ie
         BNQ+CeamCoBiZhvAsUoOOcDhh656K1FNofX+5eW197sPEPWIpY0X5vB4PIdVM3XLp2AQ
         JNYH5SwXrdr4nRMt4wVerx6I+Awvb4S1CnDiOrHFJeayEFGoyjXrca4eocoi9RowguTj
         WeAcASDQap9ntPtZp2ga8Y/M7m2cXC/KSx7UX0KShyZAo2NE6qCdokKoiSROha5LJCmq
         iSXQ==
X-Gm-Message-State: AJIora/xuZoC06Zr0FfBBJacrdM+T4wXCWm7QVvVCP5IyBMw7AV7JhyI
        Fe9Nh2+rY4DereQycXq21qM=
X-Google-Smtp-Source: AGRyM1v9jVv40Q48nqUXBgal41nv7/59I2p4rWrinAxBWe1g68dAsvR5qZ5N3+y3vIqLrCsGsCJaXA==
X-Received: by 2002:a17:902:b287:b0:16b:85cd:ef6b with SMTP id u7-20020a170902b28700b0016b85cdef6bmr15816952plr.8.1656615992732;
        Thu, 30 Jun 2022 12:06:32 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a6a0a00b001e2f383110bsm2285948pjj.11.2022.06.30.12.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:06:31 -0700 (PDT)
Message-ID: <65c4e983-ea3e-728f-68e5-8240a1a46f8c@acm.org>
Date:   Thu, 30 Jun 2022 12:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 48/63] fs/direct-io: Reduce the size of struct dio
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-49-bvanassche@acm.org>
 <20220630085038.7ubc7zemwwsyjd3e@quack3.lan>
Content-Language: en-US
In-Reply-To: <20220630085038.7ubc7zemwwsyjd3e@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 01:50, Jan Kara wrote:
> On Wed 29-06-22 16:31:30, Bart Van Assche wrote:
>> +static inline bool op_is_read(blk_opf_t opf)
>> +{
>> +	return !op_is_write(opf);
>> +}
>> +
> 
> This is a bit dangerous although currently OK for direct IO code. I'm just
> afraid someone will extend direct IO code (unlikely) or copy-paste this to
> a place where there can be more operations than read & write... Maybe just
> add here a comment like /* Direct IO code does only reads or writes */.

Hi Jan,

Since source code comments tend to get overlooked, how about replacing
this patch by the patch below?

Thanks,

Bart.

---
  fs/direct-io.c | 40 +++++++++++++++++++++++-----------------
  1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 840752006f60..94b71440c332 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -117,8 +117,7 @@ struct dio_submit {
  /* dio_state communicated between submission path and end_io */
  struct dio {
  	int flags;			/* doesn't change */
-	int op;
-	int op_flags;
+	blk_opf_t opf;			/* request operation type and flags */
  	struct gendisk *bio_disk;
  	struct inode *inode;
  	loff_t i_size;			/* i_size when submitted */
@@ -167,12 +166,13 @@ static inline unsigned dio_pages_present(struct dio_submit *sdio)
   */
  static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	ssize_t ret;

  	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
  				&sdio->from);

-	if (ret < 0 && sdio->blocks_available && (dio->op == REQ_OP_WRITE)) {
+	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
  		struct page *page = ZERO_PAGE(0);
  		/*
  		 * A memory fault, but the filesystem has some outstanding
@@ -234,6 +234,7 @@ static inline struct page *dio_get_page(struct dio *dio,
   */
  static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	loff_t offset = dio->iocb->ki_pos;
  	ssize_t transferred = 0;
  	int err;
@@ -251,7 +252,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
  		transferred = dio->result;

  		/* Check for short read case */
-		if ((dio->op == REQ_OP_READ) &&
+		if (dio_op == REQ_OP_READ &&
  		    ((offset + transferred) > dio->i_size))
  			transferred = dio->i_size - offset;
  		/* ignore EFAULT if some IO has been done */
@@ -286,7 +287,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
  	 * zeros from unwritten extents.
  	 */
  	if (flags & DIO_COMPLETE_INVALIDATE &&
-	    ret > 0 && dio->op == REQ_OP_WRITE &&
+	    ret > 0 && dio_op == REQ_OP_WRITE &&
  	    dio->inode->i_mapping->nrpages) {
  		err = invalidate_inode_pages2_range(dio->inode->i_mapping,
  					offset >> PAGE_SHIFT,
@@ -305,7 +306,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
  		 */
  		dio->iocb->ki_pos += transferred;

-		if (ret > 0 && dio->op == REQ_OP_WRITE)
+		if (ret > 0 && dio_op == REQ_OP_WRITE)
  			ret = generic_write_sync(dio->iocb, ret);
  		dio->iocb->ki_complete(dio->iocb, ret);
  	}
@@ -329,6 +330,7 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio);
  static void dio_bio_end_aio(struct bio *bio)
  {
  	struct dio *dio = bio->bi_private;
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	unsigned long remaining;
  	unsigned long flags;
  	bool defer_completion = false;
@@ -353,7 +355,7 @@ static void dio_bio_end_aio(struct bio *bio)
  		 */
  		if (dio->result)
  			defer_completion = dio->defer_completion ||
-					   (dio->op == REQ_OP_WRITE &&
+					   (dio_op == REQ_OP_WRITE &&
  					    dio->inode->i_mapping->nrpages);
  		if (defer_completion) {
  			INIT_WORK(&dio->complete_work, dio_aio_complete_work);
@@ -396,7 +398,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
  	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
  	 * we request a valid number of vectors.
  	 */
-	bio = bio_alloc(bdev, nr_vecs, dio->op | dio->op_flags, GFP_KERNEL);
+	bio = bio_alloc(bdev, nr_vecs, dio->opf, GFP_KERNEL);
  	bio->bi_iter.bi_sector = first_sector;
  	if (dio->is_async)
  		bio->bi_end_io = dio_bio_end_aio;
@@ -415,6 +417,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
   */
  static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	struct bio *bio = sdio->bio;
  	unsigned long flags;

@@ -426,7 +429,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
  	dio->refcount++;
  	spin_unlock_irqrestore(&dio->bio_lock, flags);

-	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty)
+	if (dio->is_async && dio_op == REQ_OP_READ && dio->should_dirty)
  		bio_set_pages_dirty(bio);

  	dio->bio_disk = bio->bi_bdev->bd_disk;
@@ -492,7 +495,8 @@ static struct bio *dio_await_one(struct dio *dio)
  static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
  {
  	blk_status_t err = bio->bi_status;
-	bool should_dirty = dio->op == REQ_OP_READ && dio->should_dirty;
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
+	bool should_dirty = dio_op == REQ_OP_READ && dio->should_dirty;

  	if (err) {
  		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
@@ -619,6 +623,7 @@ static int dio_set_defer_completion(struct dio *dio)
  static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
  			   struct buffer_head *map_bh)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	int ret;
  	sector_t fs_startblk;	/* Into file, in filesystem-sized blocks */
  	sector_t fs_endblk;	/* Into file, in filesystem-sized blocks */
@@ -653,7 +658,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
  		 * which may decide to handle it or also return an unmapped
  		 * buffer head.
  		 */
-		create = dio->op == REQ_OP_WRITE;
+		create = dio_op == REQ_OP_WRITE;
  		if (dio->flags & DIO_SKIP_HOLES) {
  			i_size = i_size_read(dio->inode);
  			if (i_size && fs_startblk <= (i_size - 1) >> i_blkbits)
@@ -801,10 +806,11 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
  		    unsigned offset, unsigned len, sector_t blocknr,
  		    struct buffer_head *map_bh)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	int ret = 0;
  	int boundary = sdio->boundary;	/* dio_send_cur_page may clear it */

-	if (dio->op == REQ_OP_WRITE) {
+	if (dio_op == REQ_OP_WRITE) {
  		/*
  		 * Read accounting is performed in submit_bio()
  		 */
@@ -917,6 +923,7 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
  static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
  			struct buffer_head *map_bh)
  {
+	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
  	const unsigned blkbits = sdio->blkbits;
  	const unsigned i_blkbits = blkbits + sdio->blkfactor;
  	int ret = 0;
@@ -992,7 +999,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
  				loff_t i_size_aligned;

  				/* AKPM: eargh, -ENOTBLK is a hack */
-				if (dio->op == REQ_OP_WRITE) {
+				if (dio_op == REQ_OP_WRITE) {
  					put_page(page);
  					return -ENOTBLK;
  				}
@@ -1196,12 +1203,11 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,

  	dio->inode = inode;
  	if (iov_iter_rw(iter) == WRITE) {
-		dio->op = REQ_OP_WRITE;
-		dio->op_flags = REQ_SYNC | REQ_IDLE;
+		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
  		if (iocb->ki_flags & IOCB_NOWAIT)
-			dio->op_flags |= REQ_NOWAIT;
+			dio->opf |= REQ_NOWAIT;
  	} else {
-		dio->op = REQ_OP_READ;
+		dio->opf = REQ_OP_READ;
  	}

  	/*

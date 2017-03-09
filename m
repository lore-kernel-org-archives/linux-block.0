Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:54926 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdCIF2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 00:28:38 -0500
Date: Thu, 9 Mar 2017 14:28:29 +0900
From: Minchan Kim <minchan@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
CC: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <yizhan@redhat.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170309052829.GA854@bbox>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox>
 <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
 <20170307085545.GA538@bbox>
 <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de>
 <20170308051118.GA11206@bbox>
 <1073055f-e71b-bb07-389a-53b60ccdee20@suse.de>
MIME-Version: 1.0
In-Reply-To: <1073055f-e71b-bb07-389a-53b60ccdee20@suse.de>
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 08, 2017 at 08:58:02AM +0100, Johannes Thumshirn wrote:
> On 03/08/2017 06:11 AM, Minchan Kim wrote:
> > And could you test this patch? It avoids split bio so no need new bio
> > allocations and makes zram code simple.
> > 
> > From f778d7564d5cd772f25bb181329362c29548a257 Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Wed, 8 Mar 2017 13:35:29 +0900
> > Subject: [PATCH] fix
> > 
> > Not-yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> 
> [...]
> 
> Yup, this works here.
> 
> I did a mkfs.xfs /dev/nvme0n1
> dd if=/dev/urandom of=/test.bin bs=1M count=128
> sha256sum test.bin
> mount /dev/nvme0n1 /dir
> mv test.bin /dir/
> sha256sum /dir/test.bin
> 
> No panics and sha256sum of the 128MB test file still matches
> 
> Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Thanks a lot, Johannes and Hannes!!

> 
> Now that you removed the one page limit in zram_bvec_rw() you can also
> add this hunk to remove the queue splitting:

Right. I added what you suggested with detailed description.

> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 85f4df8..27b168f6 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -868,8 +868,6 @@ static blk_qc_t zram_make_request(struct
> request_queue *queue, struct bio *bio)
>  {
>         struct zram *zram = queue->queuedata;
> 
> -       blk_queue_split(queue, &bio, queue->bio_split);
> -
>         if (!valid_io_request(zram, bio->bi_iter.bi_sector,
>                                         bio->bi_iter.bi_size)) {
>                 atomic64_inc(&zram->stats.invalid_io);
> 
> Byte,
> 	Johannes
> 

Jens, Could you replace the one merged with this? And I don't want
to add stable mark in this patch because I feel it need enough
testing in 64K page system I don't have. ;(

>From bb73e75ab0e21016f60858fd61e7dc6a6813e359 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Thu, 9 Mar 2017 14:00:40 +0900
Subject: [PATCH] zram: handle multiple pages attached bio's bvec

Johannes Thumshirn reported system goes the panic when using NVMe over
Fabrics loopback target with zram.

The reason is zram expects each bvec in bio contains a single page
but nvme can attach a huge bulk of pages attached to the bio's bvec
so that zram's index arithmetic could be wrong so that out-of-bound
access makes panic.

This patch solves the problem via removing the limit(a bvec should
contains a only single page).

Cc: Hannes Reinecke <hare@suse.com>
Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
I don't add stable mark intentionally because I think it's rather risky
without enough testing on 64K page system(ie, partial IO part).

Thanks for the help, Johannes and Hannes!!

 drivers/block/zram/zram_drv.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 01944419b1f3..fefdf260503a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -137,8 +137,7 @@ static inline bool valid_io_request(struct zram *zram,
 
 static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
 {
-	if (*offset + bvec->bv_len >= PAGE_SIZE)
-		(*index)++;
+	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
 	*offset = (*offset + bvec->bv_len) % PAGE_SIZE;
 }
 
@@ -838,34 +837,20 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	}
 
 	bio_for_each_segment(bvec, bio, iter) {
-		int max_transfer_size = PAGE_SIZE - offset;
-
-		if (bvec.bv_len > max_transfer_size) {
-			/*
-			 * zram_bvec_rw() can only make operation on a single
-			 * zram page. Split the bio vector.
-			 */
-			struct bio_vec bv;
-
-			bv.bv_page = bvec.bv_page;
-			bv.bv_len = max_transfer_size;
-			bv.bv_offset = bvec.bv_offset;
+		struct bio_vec bv = bvec;
+		unsigned int remained = bvec.bv_len;
 
+		do {
+			bv.bv_len = min_t(unsigned int, PAGE_SIZE, remained);
 			if (zram_bvec_rw(zram, &bv, index, offset,
-					 op_is_write(bio_op(bio))) < 0)
+					op_is_write(bio_op(bio))) < 0)
 				goto out;
 
-			bv.bv_len = bvec.bv_len - max_transfer_size;
-			bv.bv_offset += max_transfer_size;
-			if (zram_bvec_rw(zram, &bv, index + 1, 0,
-					 op_is_write(bio_op(bio))) < 0)
-				goto out;
-		} else
-			if (zram_bvec_rw(zram, &bvec, index, offset,
-					 op_is_write(bio_op(bio))) < 0)
-				goto out;
+			bv.bv_offset += bv.bv_len;
+			remained -= bv.bv_len;
 
-		update_position(&index, &offset, &bvec);
+			update_position(&index, &offset, &bv);
+		} while (remained);
 	}
 
 	bio_endio(bio);
@@ -882,8 +867,6 @@ static blk_qc_t zram_make_request(struct request_queue *queue, struct bio *bio)
 {
 	struct zram *zram = queue->queuedata;
 
-	blk_queue_split(queue, &bio, queue->bio_split);
-
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
 		atomic64_inc(&zram->stats.invalid_io);
-- 
2.7.4

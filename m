Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:46174 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756596AbdCHFlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2017 00:41:23 -0500
Date: Wed, 8 Mar 2017 14:11:18 +0900
From: Minchan Kim <minchan@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170308051118.GA11206@bbox>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox>
 <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
 <20170307085545.GA538@bbox>
 <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Johannes,

On Tue, Mar 07, 2017 at 10:51:45AM +0100, Johannes Thumshirn wrote:
> On 03/07/2017 09:55 AM, Minchan Kim wrote:
> > On Tue, Mar 07, 2017 at 08:48:06AM +0100, Hannes Reinecke wrote:
> >> On 03/07/2017 08:23 AM, Minchan Kim wrote:
> >>> Hi Hannes,
> >>>
> >>> On Tue, Mar 7, 2017 at 4:00 PM, Hannes Reinecke <hare@suse.de> wrote:
> >>>> On 03/07/2017 06:22 AM, Minchan Kim wrote:
> >>>>> Hello Johannes,
> >>>>>
> >>>>> On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
> >>>>>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> >>>>>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> >>>>>> pages attached to the bio's bvec this results in a kernel panic because of
> >>>>>> array out of bounds accesses in zram_decompress_page().
> >>>>>
> >>>>> First of all, thanks for the report and fix up!
> >>>>> Unfortunately, I'm not familiar with that interface of block layer.
> >>>>>
> >>>>> It seems this is a material for stable so I want to understand it clear.
> >>>>> Could you say more specific things to educate me?
> >>>>>
> >>>>> What scenario/When/How it is problem?  It will help for me to understand!
> >>>>>
> >>>
> >>> Thanks for the quick response!
> >>>
> >>>> The problem is that zram as it currently stands can only handle bios
> >>>> where each bvec contains a single page (or, to be precise, a chunk of
> >>>> data with a length of a page).
> >>>
> >>> Right.
> >>>
> >>>>
> >>>> This is not an automatic guarantee from the block layer (who is free to
> >>>> send us bios with arbitrary-sized bvecs), so we need to set the queue
> >>>> limits to ensure that.
> >>>
> >>> What does it mean "bios with arbitrary-sized bvecs"?
> >>> What kinds of scenario is it used/useful?
> >>>
> >> Each bio contains a list of bvecs, each of which points to a specific
> >> memory area:
> >>
> >> struct bio_vec {
> >> 	struct page	*bv_page;
> >> 	unsigned int	bv_len;
> >> 	unsigned int	bv_offset;
> >> };
> >>
> >> The trick now is that while 'bv_page' does point to a page, the memory
> >> area pointed to might in fact be contiguous (if several pages are
> >> adjacent). Hence we might be getting a bio_vec where bv_len is _larger_
> >> than a page.
> > 
> > Thanks for detail, Hannes!
> > 
> > If I understand it correctly, it seems to be related to bid_add_page
> > with high-order page. Right?
> > 
> > If so, I really wonder why I don't see such problem because several
> > places have used it and I expected some of them might do IO with
> > contiguous pages intentionally or by chance. Hmm,
> > 
> > IIUC, it's not a nvme specific problme but general problem which
> > can trigger normal FSes if they uses contiguos pages?
> > 
> 
> I'm not a FS expert, but a quick grep shows that non of the file-systems
> does the
> 
> for_each_sg()
> 	while(bio_add_page()))
> 
> trick NVMe does.

Aah, I see.

> 
> >>
> >> Hence the check for 'is_partial_io' in zram_drv.c (which just does a
> >> test 'if bv_len != PAGE_SIZE) is in fact wrong, as it would trigger for
> >> partial I/O (ie if the overall length of the bio_vec is _smaller_ than a
> >> page), but also for multipage bvecs (where the length of the bio_vec is
> >> _larger_ than a page).
> > 
> > Right. I need to look into that. Thanks for the pointing out!
> > 
> >>
> >> So rather than fixing the bio scanning loop in zram it's easier to set
> >> the queue limits correctly so that 'is_partial_io' does the correct
> >> thing and the overall logic in zram doesn't need to be altered.
> > 
> > 
> > Isn't that approach require new bio allocation through blk_queue_split?
> > Maybe, it wouldn't make severe regression in zram-FS workload but need
> > to test.
> 
> Yes, but blk_queue_split() needs information how big the bvecs can be,
> hence the patch.
> 
> For details have a look into blk_bio_segment_split() in block/blk-merge.c
> 
> It get's the max_sectors from blk_max_size_offset() which is
> q->limits.max_sectors when q->limits.chunk_sectors isn't set and
> then loops over the bio's bvecs to check when to split the bio and then
> calls bio_split() when appropriate.

Yeb so it causes split bio which means new bio allocations which was
not needed before.

> 
> > 
> > Is there any ways to trigger the problem without real nvme device?
> > It would really help to test/measure zram.
> 
> It isn't a /real/ device but the fabrics loopback target. If you want a
> fast reproducible test-case, have a look at:
> 
> https://github.com/ddiss/rapido/
> the cut_nvme_local.sh script set's up the correct VM for this test. Then
> a simple mkfs.xfs /dev/nvme0n1 will oops.

Thanks! I will look into that.

And could you test this patch? It avoids split bio so no need new bio
allocations and makes zram code simple.

>From f778d7564d5cd772f25bb181329362c29548a257 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 8 Mar 2017 13:35:29 +0900
Subject: [PATCH] fix

Not-yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bcb03bacdded..516c3bd97a28 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -147,8 +147,7 @@ static inline bool valid_io_request(struct zram *zram,
 
 static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
 {
-	if (*offset + bvec->bv_len >= PAGE_SIZE)
-		(*index)++;
+	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
 	*offset = (*offset + bvec->bv_len) % PAGE_SIZE;
 }
 
@@ -886,7 +885,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 {
 	int offset;
 	u32 index;
-	struct bio_vec bvec;
+	struct bio_vec bvec, bv;
 	struct bvec_iter iter;
 
 	index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
@@ -900,34 +899,23 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	}
 
 	bio_for_each_segment(bvec, bio, iter) {
-		int max_transfer_size = PAGE_SIZE - offset;
+		int remained_size = bvec.bv_len;
+		int transfer_size;
 
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
+		bv.bv_page = bvec.bv_page;
+		bv.bv_offset = bvec.bv_offset;
+		do {
+			transfer_size = min_t(int, PAGE_SIZE, remained_size);
+			bv.bv_len = transfer_size;
 
 			if (zram_bvec_rw(zram, &bv, index, offset,
-					 op_is_write(bio_op(bio))) < 0)
-				goto out;
-
-			bv.bv_len = bvec.bv_len - max_transfer_size;
-			bv.bv_offset += max_transfer_size;
-			if (zram_bvec_rw(zram, &bv, index + 1, 0,
-					 op_is_write(bio_op(bio))) < 0)
-				goto out;
-		} else
-			if (zram_bvec_rw(zram, &bvec, index, offset,
-					 op_is_write(bio_op(bio))) < 0)
+					op_is_write(bio_op(bio))) < 0)
 				goto out;
 
-		update_position(&index, &offset, &bvec);
+			bv.bv_offset += transfer_size;
+			update_position(&index, &offset, &bv);
+			remained_size -= transfer_size;
+		} while (remained_size);
 	}
 
 	bio_endio(bio);
-- 
2.7.4


> 
> > 
> > Anyway, to me, it's really subtle at this moment so I doubt it should
> > be stable material. :(
> 
> I'm not quite sure, it's at least 4.11 material. See above.

Absolutely agree that it should be 4.11 material but I don't want to
backport it to the stable because it would make regression due to
split bio works.

Anyway, if my patch I attached works for you, I will resend this
with modified descriptions includes more detail.

Thanks for the help!!

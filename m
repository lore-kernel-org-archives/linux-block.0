Return-Path: <keith.busch@intel.com>
Date: Wed, 16 Mar 2016 22:38:04 +0000
From: Keith Busch <keith.busch@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sagi Grimberg <sagig@mellanox.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Cathy Avery <cavery@redhat.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is
 set
Message-ID: <20160316223804.GA6217@localhost.lm.intel.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
 <CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
 <87oaae4cej.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oaae4cej.fsf@vitty.brq.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 16, 2016 at 05:26:28PM +0100, Vitaly Kuznetsov wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
> > We do have the above merge in bio_add_page(), so the two bios in
> > your above example shouldn't have been observed if the two buffers
> > are added to bio via the bio_add_page().
> >
> > If you see short bios in above example, maybe you need to check ntfs code:
> >
> > - if bio_add_page() is used to add buffer
> > - if using one standalone bio to transfer each 512byte, even they
> > are in same page and the sector is continuous
> 
> I'm not using ntfs, mkfs.ntfs is a userspace application which shows the
> regression when virt_boundary is in place. I should have avoided
> mentioning bio_add_pc_page() here as it is unrelated to the issue.
> 
> In particular, I'm concearned about the following call sites:
> blk_bio_segment_split()
> ll_back_merge_fn()
> ll_front_merge_fn()

I don't think blk_bio_segment_split would have seen such a bio vector
if it pages were added with bio_add_page. Those should already have
been combined. In any case, I think you can get what you're after just
by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the following
look ok to you?

---
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2613531..4aa8e44 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -96,13 +96,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	const unsigned max_sectors = get_max_io_size(q, bio);
 
 	bio_for_each_segment(bv, bio, iter) {
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
-			goto split;
-
 		if (sectors + (bv.bv_len >> 9) > max_sectors) {
 			/*
 			 * Consider this a new segment if we're splitting in
@@ -139,6 +132,13 @@ new_segment:
 		if (nsegs == queue_max_segments(q))
 			goto split;
 
+		/*
+		 * If the queue doesn't support SG gaps and adding this
+		 * offset would create a gap, disallow it.
+		 */
+		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
+			goto split;
+
 		nsegs++;
 		bvprv = bv;
 		bvprvp = &bvprv;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 413c84f..69cffbe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1400,7 +1400,8 @@ static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
 		bio_get_last_bvec(prev, &pb);
 		bio_get_first_bvec(next, &nb);
 
-		return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
+		if (!BIOVEC_PHYS_MERGEABLE(&pb, &nb))
+			return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
 	}
 
 	return false;
--

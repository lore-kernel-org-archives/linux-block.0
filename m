Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B3FC04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6FA20879
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfENJGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 05:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJGB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 05:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFD8DD964B;
        Tue, 14 May 2019 09:05:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAB5610842A1;
        Tue, 14 May 2019 09:05:50 +0000 (UTC)
Date:   Tue, 14 May 2019 17:05:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514090544.GC20468@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-2-hch@lst.de>
 <20190513094544.GA30381@ming.t460p>
 <20190513120344.GA22993@lst.de>
 <20190514043642.GB10824@ming.t460p>
 <20190514051441.GA6294@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20190514051441.GA6294@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 14 May 2019 09:06:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 07:14:41AM +0200, Christoph Hellwig wrote:
> On Tue, May 14, 2019 at 12:36:43PM +0800, Ming Lei wrote:
> > > > Some workloads need this optimization, please see 729204ef49ec00b
> > > > ("block: relax check on sg gap"):
> > > 
> > > And we still allow to merge the segments with this patch.  The only
> > > difference is that these merges do get accounted as extra segments.
> > 
> > It is easy for .nr_phys_segments to reach the max segment limit by this
> > way, then no new bio can be merged any more.
> 
> As said in my other mail we only decremented it for request merges
> in the non-gap case before and no one complained.

However we still may make it better, for example, the attached patch can
save 10~20% time when running 'mkfs.ntfs -s 512 /dev/vda', lots of small
request(63KB) can be merged to big IO(1MB).

> 
> > We don't consider segment merge between two bios in ll_new_hw_segment(),
> > in my mkfs test over virtio-blk, request size can be increased to ~1M(several
> > segments) from 63k(126 bios/segments) easily if the segment merge between
> > two bios is considered.
> 
> With the gap devices we have unlimited segment size, see my next patch
> to actually enforce that.  Which is much more efficient than using

But this patch does effect on non-gap device, and actually most of
device are non-gap type.

> multiple segments.  Also instead of hacking up the merge path even more
> we can fix the block device buffered I/O path to submit large I/Os
> instead of relying on merging like we do in the direct I/O code and every
> major file system.  I have that on my plate as a todo list item.
> 
> > > We do that in a couple of places.  For one the nvme single segment
> > > optimization that triggered this bug.  Also for range discard support
> > > in nvme and virtio.  Then we have loop that  iterate the segments, but
> > > doesn't use the nr_phys_segments count, and plenty of others that
> > > iterate over pages at the moment but should be iterating bvecs,
> > > e.g. ubd or aoe.
> > 
> > Seems discard segment doesn't consider bios merge for nvme and virtio,
> > so it should be fine in this way. Will take a close look at nvme/virtio
> > discard segment merge later.
> 
> I found the bio case by looking at doing the proper accounting in the
> bio merge path and hitting KASAN warning due to the range kmalloc.
> So that issue is real as well.

I guess the following patch may fix it:

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f1d90cd3dc47..a913110de389 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -175,7 +175,7 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 
 static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 {
-	unsigned short segments = blk_rq_nr_discard_segments(req);
+	unsigned short segments = 0;
 	unsigned short n = 0;
 	struct virtio_blk_discard_write_zeroes *range;
 	struct bio *bio;
@@ -184,6 +184,9 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	if (unmap)
 		flags |= VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP;
 
+	__rq_for_each_bio(bio, req)
+		segments++;
+
 	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
 	if (!range)
 		return -ENOMEM;


Thanks,
Ming

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-merge-bios-segment.patch"

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 21e87a714a73..af122efeb28d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -622,6 +622,8 @@ static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct bio *bio)
 {
 	int nr_phys_segs = bio_phys_segments(q, bio);
+	unsigned int seg_size =
+		req->biotail->bi_seg_back_size + bio->bi_seg_front_size;
 
 	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(q))
 		goto no_merge;
@@ -629,11 +631,15 @@ static inline int ll_new_hw_segment(struct request_queue *q,
 	if (blk_integrity_merge_bio(q, req, bio) == false)
 		goto no_merge;
 
-	/*
-	 * This will form the start of a new hw segment.  Bump both
-	 * counters.
-	 */
-	req->nr_phys_segments += nr_phys_segs;
+	if (blk_phys_contig_segment(q, req->biotail, bio)) {
+		if (nr_phys_segs)
+			req->nr_phys_segments += nr_phys_segs - 1;
+		if (nr_phys_segs == 1)
+			bio->bi_seg_back_size = seg_size;
+		if (req->nr_phys_segments == 1)
+			req->bio->bi_seg_front_size = seg_size;
+	} else
+		req->nr_phys_segments += nr_phys_segs;
 	return 1;
 
 no_merge:
-- 
2.20.1


--HlL+5n6rz5pIUxbD--

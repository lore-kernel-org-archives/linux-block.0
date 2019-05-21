Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796FC04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CFB2171F
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfEUBEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 21:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfEUBEo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 21:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37B1E3082AC3;
        Tue, 21 May 2019 01:04:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D693600C6;
        Tue, 21 May 2019 01:04:39 +0000 (UTC)
Date:   Tue, 21 May 2019 09:04:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190521010434.GA14268@ming.t460p>
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-2-hch@lst.de>
 <20190516131703.GA26943@ming.t460p>
 <20190520111141.GA5137@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520111141.GA5137@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 21 May 2019 01:04:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 20, 2019 at 01:11:41PM +0200, Christoph Hellwig wrote:
> On Thu, May 16, 2019 at 09:17:04PM +0800, Ming Lei wrote:
> > ll_merge_requests_fn() is only called from attempt_merge() in case
> > that ELEVATOR_BACK_MERGE is returned from blk_try_req_merge(). However,
> > for discard merge of both virtio_blk and nvme, ELEVATOR_DISCARD_MERGE is
> > always returned from blk_try_req_merge() in attempt_merge(), so looks
> > ll_merge_requests_fn() shouldn't be called for virtio_blk/nvme's discard
> > request. Just wondering if you may explain a bit how the change on
> > ll_merge_requests_fn() in this patch makes a difference on the above
> > two commits?
> 
> Good question.  I've seen virtio overwriting its range, but I think
> this might have been been with a series to actually decrement
> nr_phys_segments for all cases where we can merge the tail and front
> bvecs.  So mainline probably doesn't see it unless someone calls
> blk_recalc_rq_segments due to a partial completion or when using
> dm-multipath.  Thinking of it at least the latter seems like a real
> possibily, although a rather unlikely use case.

This patch shouldn't effect discard IO in case of partial completion too
cause blk_recalc_rq_segments() always return 0 for discard IO w/wo this
patch.

However looks this way is wrong, the following patch may help for this
case:

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aafeb923e7b..302667887ea1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1109,7 +1109,12 @@ static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
  */
 static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
 {
-	return max_t(unsigned short, rq->nr_phys_segments, 1);
+	struct bio *bio;
+	unsigned shart segs = 0;
+
+	__rq_for_each_bio(bio, rq)
+		segs++;
+	return segs;
 }
 
 extern int blk_rq_map_sg(struct request_queue *, struct request *, struct scatterlist *);

Or re-calculate the segment number in this way for multi-range discard IO in
__blk_recalc_rq_segments().

Thanks,
Ming

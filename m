Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1162C04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0022087E
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfEQXCU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 19:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2917 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfEQXCU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 19:02:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BED5A308429D;
        Fri, 17 May 2019 23:02:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 521C85C8B9;
        Fri, 17 May 2019 23:02:14 +0000 (UTC)
Date:   Sat, 18 May 2019 07:02:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190517230208.GB22236@ming.t460p>
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-2-hch@lst.de>
 <20190516131703.GA26943@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516131703.GA26943@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 17 May 2019 23:02:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 16, 2019 at 09:17:04PM +0800, Ming Lei wrote:
> Hi Christoph,
> 
> On Thu, May 16, 2019 at 10:40:55AM +0200, Christoph Hellwig wrote:
> > Currently ll_merge_requests_fn, unlike all other merge functions,
> > reduces nr_phys_segments by one if the last segment of the previous,
> > and the first segment of the next segement are contigous.  While this
> > seems like a nice solution to avoid building smaller than possible
> > requests it causes a mismatch between the segments actually present
> > in the request and those iterated over by the bvec iterators, including
> > __rq_for_each_bio.  This could cause overwrites of too small kmalloc
> > allocations in any driver using ranged discard, or also mistrigger
> > the single segment optimization in the nvme-pci driver.
> > 
> > We could possibly work around this by making the bvec iterators take
> > the front and back segment size into account, but that would require
> > moving them from the bio to the bio_iter and spreading this mess
> > over all users of bvecs.  Or we could simply remove this optimization
> > under the assumption that most users already build good enough bvecs,
> > and that the bio merge patch never cared about this optimization
> > either.  The latter is what this patch does.
> > 
> > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> 
> ll_merge_requests_fn() is only called from attempt_merge() in case
> that ELEVATOR_BACK_MERGE is returned from blk_try_req_merge(). However,
> for discard merge of both virtio_blk and nvme, ELEVATOR_DISCARD_MERGE is
> always returned from blk_try_req_merge() in attempt_merge(), so looks
> ll_merge_requests_fn() shouldn't be called for virtio_blk/nvme's discard
> request. Just wondering if you may explain a bit how the change on
> ll_merge_requests_fn() in this patch makes a difference on the above
> two commits?
> 
> > Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
> 
> I guess it should be dff824b2aadb ("nvme-pci: optimize mapping of small
> single segment requests").
> 
> Yes, this patch helps for this case, cause blk_rq_nr_phys_segments() may be 1
> but there are two bios which share same segment.

BTW, I just sent a single-line nvme-pci fix on this issue, which may be more
suitable to serve as v5.2 fix:

http://lists.infradead.org/pipermail/linux-nvme/2019-May/024283.html

Thanks,
Ming

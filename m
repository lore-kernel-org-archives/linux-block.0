Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdDNCE3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 22:04:29 -0400
Date: Fri, 14 Apr 2017 10:04:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "axboe@fb.com" <axboe@fb.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] block: fix bio_will_gap()
Message-ID: <20170414020415.GC29916@ming.t460p>
References: <20170413160626.14635-1-ming.lei@redhat.com>
 <1492100540.5176.6.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492100540.5176.6.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 13, 2017 at 04:22:22PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-14 at 00:06 +0800, Ming Lei wrote:
> > But if one rq starts with non-aligned buffer(the 1st bvec's
> > bv_offset isn't zero) and if we allow to merge, it is quite
> > difficult to respect sg gap limit, especially the segment
> > can't be at maximum segment size, otherwise the segment
> > ends in unaligned virt boundary. This patch trys to avoid the
> > issue by not allowing to merge if the req starts with non-aligned
> > buffer.
> 
> Hello Ming,
> 
> Why is it considered difficult to detect whether or not a gap exists if
> the offset of the first bio is non-zero? Please note that a thoroughly
> tested version of gap detection code that supports non-zero offsets for
> the first element is already upstream. See also ib_map_mr_sg() and
> ib_sg_to_pages() in drivers/infiniband/core/verbs.c.

I don't know infiniband much, but from the code, it is just about
sg, and looks not same with block's sg gap limit.

The sg gap limit in block layer actually means:
	- except for last segment, every segment has to end in aligned virt boundary
	- from the 2nd segment, offset of the segment has to be zero

But we don't store main segment info(start, size) in bio/req,
all the segments are basically computed in the flight, so it isn't
easy to check/handle sg gap. Also IMO segment handling of block layer is
quite fragile, and hope multi-page bvec can improve the case much.

We relax check for sg gap for allowing merging tons of small bios, if
these bios are physically contiguous. But if offset of the 1st bio
in the merged req isn't zero, current segment compution in
__blk_segment_map_sg() doesn't consider sg gap, so one segment may
ends in unaligned virt boundary.

Given it is late in v4.11 cycle, this patch doesn't want to touch
__blk_segment_map_sg() for avoiding regression risk, instead just
changing bio_will_gap() for avoding the case with minimized risk,
because the change is quite simple.


Thanks,
Ming

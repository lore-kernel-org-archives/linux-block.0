Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbdJSXhm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 19:37:42 -0400
Date: Fri, 20 Oct 2017 07:37:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 20/49] block: introduce bio_for_each_segment_mp()
Message-ID: <20171019233731.GD27130@ming.t460p>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-21-ming.lei@redhat.com>
 <20170810121110.GC14607@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810121110.GC14607@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 10, 2017 at 05:11:10AM -0700, Christoph Hellwig wrote:
> First: as mentioned in the previous patches I really hate the name
> scheme with the _sp and _mp postfixes.
> 
> To be clear and understandable we should always name the versions
> that iterate over segments *segment* and the ones that iterate over
> pages *page*.  To make sure we have a clean compile break for code
> using the old _segment name I'd suggest to move to pass the bvec_iter
> argument by reference, which is the right thing to do anyway.

The most confusing thing is that bio_for_each_segment() and
bio_for_each_segment_all() has been used to iterate pages for long time.
That is why I add _sp/_mp in this patchset to make the uses explicitly
and avoid to confuse people.

My plan is to switch to the real bio_for_each_segment() for iterating
real segment and bio_for_each_page() for iterating page after we reach
mutlipage bvec, and that is basically a mechanical change.

> As far as the implementation goes I don't think we actually need
> to pass the mp argument down.  Instead we always call the full-segment
> version of  bvec_iter_len / __bvec_iter_advance and then have an
> inner loop that moves the fake bvecs forward inside each full-segment
> one - that is implement the per-page version on top of the per-segment
> one.

For iterating in way of real segment(multipage bvec) instead of page, we
don't need the inner loop for moving page by page to the fake bvec, that
is why the 'mp' argument is introduced. If this argument is dropped, we
have to find another similar way to decide to fetch one segment or one
page each time.

-- 
Ming

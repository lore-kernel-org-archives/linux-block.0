Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754536AbeFNBwn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 21:52:43 -0400
Date: Thu, 14 Jun 2018 09:52:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 13/30] block: introduce rq_for_each_chunk()
Message-ID: <20180614015221.GD19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-14-ming.lei@redhat.com>
 <20180613144818.GD4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613144818.GD4693@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 07:48:18AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 09, 2018 at 08:29:57PM +0800, Ming Lei wrote:
> > There are still cases in which rq_for_each_chunk() is required, for
> > example, loop.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  include/linux/blkdev.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index bca3a92eb55f..4eaba73c784a 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -941,6 +941,10 @@ struct req_iterator {
> >  	__rq_for_each_bio(_iter.bio, _rq)			\
> >  		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
> >  
> > +#define rq_for_each_chunk(bvl, _rq, _iter)			\
> > +	__rq_for_each_bio(_iter.bio, _rq)			\
> > +		bio_for_each_chunk(bvl, _iter.bio, _iter.iter)
> 
> We have a single users of this in the loop driver.  I'd rather
> see the obvious loop open coded.

OK.

Thanks,
Ming

Return-Path: <hch@lst.de>
Date: Wed, 8 Feb 2017 12:57:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] block: optionally merge discontiguous discard bios
	into a single request
Message-ID: <20170208115710.GB11342@lst.de>
References: <20170207164658.32449-1-hch@lst.de> <20170207164658.32449-4-hch@lst.de> <CACVXFVOZfrLGb59q=V_O2xijM6t9uUq8Foj5qWZ5sAQpRSWngA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOZfrLGb59q=V_O2xijM6t9uUq8Foj5qWZ5sAQpRSWngA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 08, 2017 at 06:54:24PM +0800, Ming Lei wrote:
> > +               struct bio *bio)
> > +{
> > +       unsigned short segments = blk_rq_nr_discard_segments(req);
> > +
> > +       if (segments >= queue_max_discard_segments(q))
> > +               goto no_merge;
> > +       if (blk_rq_sectors(req) + bio_sectors(bio) >
> > +           blk_rq_get_max_sectors(req, blk_rq_pos(req)))
> > +               goto no_merge;
> > +
> > +       req->biotail->bi_next = bio;
> > +       req->biotail = bio;
> > +       req->__data_len += bio->bi_iter.bi_size;
> 
> typeof(__data_len) is unsigned, and should be easy to overflow
> for discard rq's merge.

We respect the max_discard_sectors setting which is unsigned as well
above in blk_rq_get_max_sectors(), so we can't actually overflow here.

And please remove the fullquote after your two line comment, thanks!

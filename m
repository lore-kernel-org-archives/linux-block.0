Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:24:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
Message-ID: <20170421112458.GB12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672858.27388.11409778158413625707.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672858.27388.11409778158413625707.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 03:38:48PM +1000, NeilBrown wrote:
> This patch converts bioset_create() and
> bioset_create_nobvec() to not create a workqueue so
> alloctions will never trigger punt_bios_to_rescuer().  It
> also introduces bioset_create_rescued() and
> bioset_create_nobvec_rescued() which preserve the old
> behaviour.

Why these super-early line breaks in the committ message?  They make
the text much more awkware compared to say:

This patch converts bioset_create() and bioset_create_nobvec() to not
create a workqueue so alloctions will never trigger
punt_bios_to_rescuer(). It also introduces bioset_create_rescued() and
bioset_create_nobvec_rescued() which preserve the old behaviour.

>  static struct bio_set *__bioset_create(unsigned int pool_size,
>  				       unsigned int front_pad,
> -				       bool create_bvec_pool)
> +				       bool create_bvec_pool,
> +				       bool create_rescue_workqueue)

I'd much prefer a single new bioset_create with a bunch of flags
arguments over the number of new functions and these bool arguments.

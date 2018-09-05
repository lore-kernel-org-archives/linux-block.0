Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 4 Sep 2018 23:52:33 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: remove bio_rewind_iter()
Message-ID: <20180905035232.GA2501@kmo-pixel>
References: <20180905033335.12666-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905033335.12666-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Thanks for doing this, Ming

On Wed, Sep 05, 2018 at 11:33:35AM +0800, Ming Lei wrote:
> It is pointed that bio_rewind_iter() is one very bad API[1]:
> 
> 1) bio size may not be restored after rewinding
> 
> 2) it causes some bogus change, such as 5151842b9d8732 (block: reset
> bi_iter.bi_done after splitting bio)
> 
> 3) rewinding really makes things complicated wrt. bio splitting
> 
> 4) unnecessary updating of .bi_done in fast path
> 
> [1] https://marc.info/?t=153549924200005&r=1&w=2
> 
> So this patch takes Kent's suggestion to restore one bio into its original
> state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
> given now bio_rewind_iter() is only used by bio integrity code.
> 
> Suggested-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Dmitry Monakhov <dmonakhov@openvz.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Kent Overstreet <kent.overstreet@gmail.com>

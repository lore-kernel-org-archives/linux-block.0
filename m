Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove bio_rewind_iter()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>,
 Dmitry Monakhov <dmonakhov@openvz.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>
References: <20180905033335.12666-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8990f9dd-32bd-1bdb-42e6-6d4573d34a03@kernel.dk>
Date: Wed, 5 Sep 2018 15:46:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180905033335.12666-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/4/18 9:33 PM, Ming Lei wrote:
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

Applied, thanks Ming.

-- 
Jens Axboe

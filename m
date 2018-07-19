Return-Path: <hch@lst.de>
Date: Thu, 19 Jul 2018 16:52:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: bio_iov_iter_get_pages: fix size of last
	iovec
Message-ID: <20180719145257.GC21000@lst.de>
References: <20180718075440.GA15254@ming.t460p> <20180719093918.28876-1-mwilck@suse.com> <20180719093918.28876-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719093918.28876-2-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 11:39:17AM +0200, Martin Wilck wrote:
> If the last page of the bio is not "full", the length of the last
> vector slot needs to be corrected. This slot has the index
> (bio->bi_vcnt - 1), but only in bio->bi_io_vec. In the "bv" helper
> array, which is shifted by the value of bio->bi_vcnt at function
> invocation, the correct index is (nr_pages - 1).
> 
> V2: improved readability following suggestions from Ming Lei.
> 
> Fixes: 2cefe4dbaadf ("block: add bio_iov_iter_get_pages()")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  block/bio.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 67eff5e..0964328 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -912,16 +912,16 @@ EXPORT_SYMBOL(bio_add_page);
>   */
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
> -	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> +	unsigned short idx, nr_pages = bio->bi_max_vecs - bio->bi_vcnt;

Nipick: I prefer to keep the variable(s) that are initialized first on
any given line.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

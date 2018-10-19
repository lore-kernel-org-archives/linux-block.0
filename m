Return-Path: <ming.lei@redhat.com>
Date: Fri, 19 Oct 2018 17:10:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] block: setup bounce bio_sets properly
Message-ID: <20181019091035.GB32371@ming.t460p>
References: <34e24d47-12e4-230c-4088-1d3f2ffa6b79@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34e24d47-12e4-230c-4088-1d3f2ffa6b79@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 03:24:47PM -0600, Jens Axboe wrote:
> We're only setting up the bounce bio sets if we happen
> to need bouncing for regular HIGHMEM, not if we only need
> it for ISA devices.
> 
> Reported-by: Ondrej Zary <linux@rainbow-software.org>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index b30071ac4ec6..1356a2f4aae2 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -31,6 +31,24 @@
>  static struct bio_set bounce_bio_set, bounce_bio_split;
>  static mempool_t page_pool, isa_page_pool;
>  
> +static void init_bounce_bioset(void)
> +{
> +	static bool bounce_bs_setup;
> +	int ret;
> +
> +	if (bounce_bs_setup)
> +		return;
> +
> +	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> +	BUG_ON(ret);
> +	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
> +		BUG_ON(1);
> +
> +	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
> +	BUG_ON(ret);
> +	bounce_bs_setup = true;

When initcall is run from do_basic_setup(), all CPUs and scheduler have been up,
it is likely that init_emergency_pool() is run when one driver is calling
blk_queue_bounce_limit() to start init_emergency_isa_pool().

So the above code might be run twice.

Thanks,
Ming

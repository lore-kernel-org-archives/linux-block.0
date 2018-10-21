Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: setup bounce bio_sets properly
Date: Sun, 21 Oct 2018 14:17:46 +0200
Cc: Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <34e24d47-12e4-230c-4088-1d3f2ffa6b79@kernel.dk> <20181019091035.GB32371@ming.t460p> <eee50444-9271-ca58-4e9f-d3525e85c1d5@kernel.dk>
In-Reply-To: <eee50444-9271-ca58-4e9f-d3525e85c1d5@kernel.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201810211417.46907.linux@rainbow-software.org>
List-ID: <linux-block@vger.kernel.org>

On Friday 19 October 2018 18:35:00 Jens Axboe wrote:
> On 10/19/18 3:10 AM, Ming Lei wrote:
> > On Thu, Oct 18, 2018 at 03:24:47PM -0600, Jens Axboe wrote:
> >> We're only setting up the bounce bio sets if we happen
> >> to need bouncing for regular HIGHMEM, not if we only need
> >> it for ISA devices.
> >>
> >> Reported-by: Ondrej Zary <linux@rainbow-software.org>
> >> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>
> >> diff --git a/block/bounce.c b/block/bounce.c
> >> index b30071ac4ec6..1356a2f4aae2 100644
> >> --- a/block/bounce.c
> >> +++ b/block/bounce.c
> >> @@ -31,6 +31,24 @@
> >>  static struct bio_set bounce_bio_set, bounce_bio_split;
> >>  static mempool_t page_pool, isa_page_pool;
> >>  
> >> +static void init_bounce_bioset(void)
> >> +{
> >> +	static bool bounce_bs_setup;
> >> +	int ret;
> >> +
> >> +	if (bounce_bs_setup)
> >> +		return;
> >> +
> >> +	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> >> +	BUG_ON(ret);
> >> +	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
> >> +		BUG_ON(1);
> >> +
> >> +	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
> >> +	BUG_ON(ret);
> >> +	bounce_bs_setup = true;
> > 
> > When initcall is run from do_basic_setup(), all CPUs and scheduler have been up,
> > it is likely that init_emergency_pool() is run when one driver is calling
> > blk_queue_bounce_limit() to start init_emergency_isa_pool().
> > 
> > So the above code might be run twice.
> 
> Good point, it's actually not even safe right now with the mempool
> setup. How about the below?
> 
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index b30071ac4ec6..ec0d99995f5f 100644
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
> +}
> +
>  #if defined(CONFIG_HIGHMEM)
>  static __init int init_emergency_pool(void)
>  {
> @@ -44,14 +62,7 @@ static __init int init_emergency_pool(void)
>  	BUG_ON(ret);
>  	pr_info("pool size: %d pages\n", POOL_SIZE);
>  
> -	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> -	BUG_ON(ret);
> -	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
> -		BUG_ON(1);
> -
> -	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
> -	BUG_ON(ret);
> -
> +	init_bounce_bioset();
>  	return 0;
>  }
>  
> @@ -86,6 +97,8 @@ static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
>  	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
>  }
>  
> +static DEFINE_MUTEX(isa_mutex);
> +
>  /*
>   * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
>   * as the max address, so check if the pool has already been created.
> @@ -94,14 +107,20 @@ int init_emergency_isa_pool(void)
>  {
>  	int ret;
>  
> -	if (mempool_initialized(&isa_page_pool))
> +	mutex_lock(&isa_mutex);
> +
> +	if (mempool_initialized(&isa_page_pool)) {
> +		mutex_unlock(&isa_mutex);
>  		return 0;
> +	}
>  
>  	ret = mempool_init(&isa_page_pool, ISA_POOL_SIZE, mempool_alloc_pages_isa,
>  			   mempool_free_pages, (void *) 0);
>  	BUG_ON(ret);
>  
>  	pr_info("isa pool size: %d pages\n", ISA_POOL_SIZE);
> +	init_bounce_bioset();
> +	mutex_unlock(&isa_mutex);
>  	return 0;
>  }
>  

Works for me.

-- 
Ondrej Zary

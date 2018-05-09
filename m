Return-Path: <efault@gmx.de>
Message-ID: <1525839089.15732.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 09 May 2018 06:11:29 +0200
In-Reply-To: <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
	 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
	 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
	 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
	 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
	 <1525797766.5204.2.camel@gmx.de>
	 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
	 <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
	 <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-05-08 at 19:09 -0600, Jens Axboe wrote:
> 
> Alright, I managed to reproduce it. What I think is happening is that
> BFQ is limiting the inflight case to something less than the wake
> batch for sbitmap, which can lead to stalls. I don't have time to test
> this tonight, but perhaps you can give it a go when you are back at it.
> If not, I'll try tomorrow morning.
> 
> If this is the issue, I can turn it into a real patch. This is just to
> confirm that the issue goes away with the below.

Confirmed.  Impressive high speed bug stomping.

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index e6a9c06ec70c..94ced15b6428 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -272,6 +272,7 @@ EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
>  
>  static unsigned int sbq_calc_wake_batch(unsigned int depth)
>  {
> +#if 0
>  	unsigned int wake_batch;
>  
>  	/*
> @@ -284,6 +285,9 @@ static unsigned int sbq_calc_wake_batch(unsigned int depth)
>  		wake_batch = max(1U, depth / SBQ_WAIT_QUEUES);
>  
>  	return wake_batch;
> +#else
> +	return 1;
> +#endif
>  }
>  
>  int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
> 

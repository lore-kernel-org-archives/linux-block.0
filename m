Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
Message-ID: <1530537603.13674.8.camel@gmail.com>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date: Mon, 02 Jul 2018 22:20:03 +0900
In-Reply-To: <20180702130227.gjpblurxccjqechl@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
	 <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
	 <1530536157.13674.4.camel@gmail.com>
	 <20180702130227.gjpblurxccjqechl@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Johannes,

I appreciate your kindly response.

On Mon, 2018-07-02 at 15:02 +0200, Johannes Thumshirn wrote:
> On Mon, Jul 02, 2018 at 09:55:57PM +0900, Minwoo Im wrote:
> > 
> > No 2nd follow-up patch will be there.  I thought these two parts are
> > using a same unit-function to clear the set->mq-map.  Also thought it
> > would be great for the future use when it needs to be cleared.
> > However, as you mentioned, I totally agree with your point.  It seems
> > just churns for churns' sake with no more usage for now.
> I actually mis-read your patch, I'm sorry.
> 
> You're consolidating two callers of this so I guess this is not so
> problematic. I somehow ignored the first hunk in the patch.
> 
> You could still evaluate if it isn't worth to make it:
> +static void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		set->mq_map[cpu] = 0;
> +}
> 
> and put it into 'include/linux/blk-mq.h'.

Do you mean this whole bunch of function should be moved into blk-mq.h with
'inline' format?

I have already added this function prototype to blk-mq.h without 'static' to
make blk-mq-pci.c to use it.

If you don't mind, can you please elaborate a little bit more?

Thanks,

	Minwoo Im

> 
>     Johannes

Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
Message-ID: <1530538459.13674.12.camel@gmail.com>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date: Mon, 02 Jul 2018 22:34:19 +0900
In-Reply-To: <20180702132704.3nwi4y6ex6fn5z67@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
	 <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
	 <1530536157.13674.4.camel@gmail.com>
	 <20180702130227.gjpblurxccjqechl@linux-x5ow.site>
	 <1530537603.13674.8.camel@gmail.com>
	 <20180702132704.3nwi4y6ex6fn5z67@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-02 at 15:27 +0200, Johannes Thumshirn wrote:
> On Mon, Jul 02, 2018 at 10:20:03PM +0900, Minwoo Im wrote:
> [...]
> > 
> > > 
> > > You could still evaluate if it isn't worth to make it:
> > > +static void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_possible_cpu(cpu)
> > > +		set->mq_map[cpu] = 0;
> > > +}
> > > 
> > > and put it into 'include/linux/blk-mq.h'.
> > Do you mean this whole bunch of function should be moved into blk-mq.h with
> > 'inline' format?
> yes

Johannes,

I was wondering you did mean 'inline' or not because the function in the
previous mail only with 'static' without 'inline' keyword :)
That's why I asked it one more time to figure out what you really mean.

I really appreciate your kindly directives.

I'll make it up for v2 patch.

Thanks, really.

	Minwoo Im

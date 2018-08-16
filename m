Return-Path: <mhiramat@kernel.org>
Date: Fri, 17 Aug 2018 01:38:47 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/blktrace: Fix to allow setting same value
Message-Id: <20180817013847.85ff26224bfd48d0fca1fd3f@kernel.org>
In-Reply-To: <20180816103802.08678002@gandalf.local.home>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
	<153441307534.6024.2684721209411781531.stgit@devbox>
	<20180816103802.08678002@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 16 Aug 2018 10:38:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Aug 2018 18:51:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Current trace-enable attribute in sysfs returns an error
> > if user writes the same setting value as current one,
> > e.g.
> > 
> >   # cat /sys/block/sda/trace/enable
> >   0
> >   # echo 0 > /sys/block/sda/trace/enable
> >   bash: echo: write error: Invalid argument
> >   # echo 1 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> >   bash: echo: write error: Device or resource busy
> > 
> > But this is not a preferred behavior, it should ignore
> > if new setting is same as current one. This fixes the
> > problem as below.
> > 
> >   # cat /sys/block/sda/trace/enable
> >   0
> >   # echo 0 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-block@vger.kernel.org
> > ---
> >  kernel/trace/blktrace.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 987d9a9ae283..e67db1e8a000 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -1602,11 +1602,11 @@ static int blk_trace_remove_queue(struct request_queue *q)
> >  	struct blk_trace *bt;
> >  
> >  	bt = xchg(&q->blk_trace, NULL);
> > -	if (bt == NULL)
> > -		return -EINVAL;
> > +	if (bt != NULL) {
> > +		put_probe_ref();
> > +		blk_trace_free(bt);
> > +	}
> >  
> > -	put_probe_ref();
> > -	blk_trace_free(bt);
> >  	return 0;
> >  }
> >  
> > @@ -1619,6 +1619,9 @@ static int blk_trace_setup_queue(struct request_queue *q,
> >  	struct blk_trace *bt = NULL;
> >  	int ret = -ENOMEM;
> >  
> > +	if (q->blk_trace)
> > +		return 0;
> > +
> >  	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
> >  	if (!bt)
> >  		return -ENOMEM;
> 
> Hmm, why not just do this? Does this fix it too?

Ah, yes, but we need to clear "ret" in that case.

Thanks!

> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 987d9a9ae283..10b2b9c5fd25 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1841,6 +1841,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>  	mutex_lock(&q->blk_trace_mutex);
>  
>  	if (attr == &dev_attr_enable) {
> +		if (!!value == !!q->blk_trace)
> +			goto out_unlock_bdev;
>  		if (value)
>  			ret = blk_trace_setup_queue(q, bdev);
>  		else
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>

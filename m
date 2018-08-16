Return-Path: <mhiramat@kernel.org>
Date: Fri, 17 Aug 2018 02:07:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/blktrace: Fix to allow setting same value
Message-Id: <20180817020717.7c0402429f0d4397f1b8d586@kernel.org>
In-Reply-To: <20180816124917.77c82f04@gandalf.local.home>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
	<153441307534.6024.2684721209411781531.stgit@devbox>
	<20180816103802.08678002@gandalf.local.home>
	<20180817013847.85ff26224bfd48d0fca1fd3f@kernel.org>
	<20180816124917.77c82f04@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 16 Aug 2018 12:49:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > 
> > > Hmm, why not just do this? Does this fix it too?  
> > 
> > Ah, yes, but we need to clear "ret" in that case.
> 
> Sure.
> 
> > 
> > Thanks!
> > 
> > > 
> > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > index 987d9a9ae283..10b2b9c5fd25 100644
> > > --- a/kernel/trace/blktrace.c
> > > +++ b/kernel/trace/blktrace.c
> > > @@ -1841,6 +1841,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
> > >  	mutex_lock(&q->blk_trace_mutex);
> > >  
> 
> > >  	if (attr == &dev_attr_enable) {
> > > +		if (!!value == !!q->blk_trace) {
>     +                   ret = 0;
> > > +			goto out_unlock_bdev;
>     +		}
> 

OK, I tested and ensured that this works.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>

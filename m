Return-Path: <SRS0=q5lJ=7T=goodmis.org=rostedt@kernel.org>
Date: Thu, 17 Aug 2017 19:23:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>, "J.
 Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170817192343.503fac3d@gandalf.local.home>
In-Reply-To: <20170817181818.4ef4acf3@gandalf.local.home>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
	<20170817171007.1ab33b8f@gandalf.local.home>
	<6bb40f9f-7f55-28b4-812b-a80f05bec6ea@redhat.com>
	<20170817181320.60b02500@gandalf.local.home>
	<20170817181818.4ef4acf3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 17 Aug 2017 18:18:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 17 Aug 2017 18:13:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 17 Aug 2017 17:27:22 -0400
> > Waiman Long <longman@redhat.com> wrote:
> > 
> >   
> > > It is actually what the patch is trying to do by checking for the
> > > deletion flag in the mutex_trylock loop. Please note that mutex does not
> > > guarantee FIFO ordering of lock acquisition. As a result, cpu1 may call
> > > mutex_lock() and wait for it while cpu2 can set the deletion flag later
> > > and get the mutex first before cpu1. So checking for the deletion flag
> > > before taking the mutex isn't enough.    
> > 
> > Yeah, I figured that out already (crossed emails). BTW, how did you
> > trigger this warning. I'm playing around with adding loop devices,
> > volume groups, and logical volumes, and reading the trace files
> > created in the sysfs directory, then removing those items, but it's
> > not triggering the "delete" path. What operation deletes the partition?  
> 
> I'm guessing that deleting an actual partition may work (unfortunately,
> my test box has no partition to delete ;-) I'll find another box to
> test on.
>

OK, deleting a partition doesn't trigger the lockdep splat. But I also
added a printk in the BLKPG_DEL_PARTITION case switch, which also
doesn't print. What command do I need to do to trigger that path?

Thanks,

-- Steve

Return-Path: <SRS0=d975=7S=goodmis.org=rostedt@kernel.org>
Date: Wed, 16 Aug 2017 14:17:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>, "J.
 Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] blktrace: Fix potentail deadlock between delete & sysfs
 ops
Message-ID: <20170816141749.6c11d14c@gandalf.local.home>
In-Reply-To: <6fa9f560-e1c2-f164-779f-aeefc5aa7017@redhat.com>
References: <1502384553-14442-1-git-send-email-longman@redhat.com>
	<20170815191145.3c95680e@gandalf.local.home>
	<6fa9f560-e1c2-f164-779f-aeefc5aa7017@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 16 Aug 2017 14:14:36 -0400
Waiman Long <longman@redhat.com> wrote:

> > You also just turned the mutex into a spinlock. What happens if we just
> > preempted the owner of bdev->bd_mutex and are an RT task with higher
> > priority? This will turn into a live lock.
> >  
> >> +		schedule();
> >> +	}
> >>    
> 
> That is OK because I used schedule() instead of cpu_relax() for
> inserting delay.

Please explain to me how that is OK? schedule is a nop if the current
task is the highest priority task running, and it preempted the owner
of the lock. Nothing will actually schedule.

-- Steve

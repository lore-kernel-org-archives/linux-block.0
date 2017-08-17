Return-Path: <SRS0=q5lJ=7T=goodmis.org=rostedt@kernel.org>
Date: Thu, 17 Aug 2017 16:30:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>, "J.
 Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170817163056.19ea42c8@gandalf.local.home>
In-Reply-To: <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 17 Aug 2017 12:24:39 -0400
Waiman Long <longman@redhat.com> wrote:

> On 08/17/2017 09:34 AM, Steven Rostedt wrote:
> > On Wed, 16 Aug 2017 16:40:40 -0400
> > Waiman Long <longman@redhat.com> wrote:
> >  
> >> The lockdep code had reported the following unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(s_active#228);
> >>                                lock(&bdev->bd_mutex/1);
> >>                                lock(s_active#228);
> >>   lock(&bdev->bd_mutex);  
> > Can you show the exact locations of these locks. I have no idea where
> > this "s_active" is.  
> The s_active isn't an actual lock. It is a reference count (kn->count)
> on the sysfs (kernfs) file. Removal of a sysfs file, however, require
> a wait until all the references are gone. The reference count is
> treated like a rwsem using lockdep instrumentation code.

Which kernel is this? I don't see any lockdep annotation around
kn->count (doing a git grep, I find it referenced in fs/kernfs/dir.c)

> 
> >>  *** DEADLOCK ***
> >>
> >> The deadlock may happen when one task (CPU1) is trying to delete
> >> a partition in a block device and another task (CPU0) is accessing
> >> tracing sysfs file in that partition.
> >>
> >> To avoid that, accessing tracing sysfs file will now use a mutex
> >> trylock loop and the operation will fail if a delete operation is
> >> in progress.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>
> >>  v2:
> >>    - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.
> >>    - Check for signal in the mutex_trylock loops.
> >>    - Use usleep() instead of schedule() for RT tasks.  
> > I'm sorry but I really do hate this patch.  
> 
> Any suggestion on how to make it better?

I'd like to be able to at least trigger the warning. And see the lock
issues. I wont be able to recommend anything until I understand what is
happening.


> The root cause is the lock inversion under this circumstance. I think
> modifying the blk_trace code has the least impact overall. I agree that
> the code is ugly. If you have a better suggestion, I will certainly like
> to hear it.

Again, I need to see where the issue lies before recommending something
else. I would hope there is a more elegant solution to this.

-- Steve

Return-Path: <SRS0=q5lJ=7T=goodmis.org=rostedt@kernel.org>
Date: Thu, 17 Aug 2017 17:10:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>, "J.
 Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170817171007.1ab33b8f@gandalf.local.home>
In-Reply-To: <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 17 Aug 2017 12:24:39 -0400
Waiman Long <longman@redhat.com> wrote:

> >> + * sysfs file and then acquiring the bd_mutex. Deleting a block device
> >> + * requires acquiring the bd_mutex and then waiting for all the sysfs
> >> + * references to be gone. This can lead to deadlock if both operations
> >> + * happen simultaneously. To avoid this problem, read/write to the
> >> + * the tracing sysfs files can now fail if the bd_mutex cannot be
> >> + * acquired while a deletion operation is in progress.
> >> + *
> >> + * A mutex trylock loop is used assuming that tracing sysfs operations  
> > A mutex trylock loop is not enough to stop a deadlock. But I'm guessing
> > the undocumented bd_deleting may prevent that.  
> 
> Yes, that is what the bd_deleting flag is for.
> 
> I was thinking about failing the sysfs operation after a certain number
> of trylock attempts, but then it will require changes to user space code
> to handle the occasional failures. Finally I decided to fail it only
> when a delete operation is in progress as all hopes are lost in this case.

Actually, why not just fail the attr read on deletion? If it is being
deleted, and one is reading the attribute, perhaps -ENODEV is the
proper return value?

> 
> The root cause is the lock inversion under this circumstance. I think
> modifying the blk_trace code has the least impact overall. I agree that
> the code is ugly. If you have a better suggestion, I will certainly like
> to hear it.

Instead of playing games with taking the lock, the only way this race
is hit, is if the partition is being deleted and the sysfs attribute is
being read at the same time, correct? In that case, just return
-ENODEV, and be done with it.

-- Steve

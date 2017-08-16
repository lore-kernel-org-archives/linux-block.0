Return-Path: <longman@redhat.com>
Subject: Re: [PATCH] blktrace: Fix potentail deadlock between delete & sysfs
 ops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <1502384553-14442-1-git-send-email-longman@redhat.com>
 <20170815191145.3c95680e@gandalf.local.home>
 <6fa9f560-e1c2-f164-779f-aeefc5aa7017@redhat.com>
 <20170816141749.6c11d14c@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <4841e079-c518-cdff-2fbd-661a9ef36722@redhat.com>
Date: Wed, 16 Aug 2017 14:46:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170816141749.6c11d14c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/16/2017 02:17 PM, Steven Rostedt wrote:
> On Wed, 16 Aug 2017 14:14:36 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>>> You also just turned the mutex into a spinlock. What happens if we ju=
st
>>> preempted the owner of bdev->bd_mutex and are an RT task with higher
>>> priority? This will turn into a live lock.
>>> =20
>>>> +		schedule();
>>>> +	}
>>>>   =20
>> That is OK because I used schedule() instead of cpu_relax() for
>> inserting delay.
> Please explain to me how that is OK? schedule is a nop if the current
> task is the highest priority task running, and it preempted the owner
> of the lock. Nothing will actually schedule.
>
> -- Steve

I haven't been thinking about RT tasks. You are right that it can be a
problem in this case. I think I will have to revert back to use
mutex_lock() if a RT task is running. Though in this case, the lock
inversion problem will still be there. However, it is highly unlikely
that a RT task will need to read write the block trace sysfs files.

Thanks for the input.

Cheers,
Longman

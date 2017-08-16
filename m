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
 <4841e079-c518-cdff-2fbd-661a9ef36722@redhat.com>
 <20170816145938.6cc7eaee@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <ee8f13dc-10aa-55bf-f152-5c73ae0a1d03@redhat.com>
Date: Wed, 16 Aug 2017 15:07:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170816145938.6cc7eaee@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/16/2017 02:59 PM, Steven Rostedt wrote:
> On Wed, 16 Aug 2017 14:46:42 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>
>> I haven't been thinking about RT tasks. You are right that it can be a=

>> problem in this case. I think I will have to revert back to use
>> mutex_lock() if a RT task is running. Though in this case, the lock
>> inversion problem will still be there. However, it is highly unlikely
>> that a RT task will need to read write the block trace sysfs files.
> And it is highly unlikely that the lock inversion will happen. But

That is true too:-)

> let's not switch one bug with another. And with PREEMPT_RT coming, that=

> can boost tasks into being RT, it can make the likelihood of RT tasks
> running normally non RT tasks higher.
>
> -- Steve

I am thinking about maybe letting a RT task to sleep a tiny amount of
time instead of calling schedule(). Hopefully, that will allow a
lower-priority task to make forward progress.

Cheers,
Longman

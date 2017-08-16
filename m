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
 <ee8f13dc-10aa-55bf-f152-5c73ae0a1d03@redhat.com>
 <20170816151446.372fc3d2@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <9e4fa528-8537-0864-d661-62d7e33c5359@redhat.com>
Date: Wed, 16 Aug 2017 15:26:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170816151446.372fc3d2@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/16/2017 03:14 PM, Steven Rostedt wrote:
> On Wed, 16 Aug 2017 15:07:25 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>
>> I am thinking about maybe letting a RT task to sleep a tiny amount of
>> time instead of calling schedule(). Hopefully, that will allow a
>> lower-priority task to make forward progress.
> That is actually one of the ugly hacks we have in the PREEMPT_RT patch
> (and one of the things we need to fix before getting it to mainline).
>
> A simple msleep(1).
>
> -- Steve


I am planning to use usleep_range(). That will allow a short sleep in
the us range instead of ms. The documentation suggest that for a
10us-20ms sleep.

Cheers,
Longman

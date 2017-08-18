Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v4] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1503086474-20187-1-git-send-email-longman@redhat.com>
 <1503087492.2622.13.camel@wdc.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <9bd11d22-fb98-b8aa-9f75-42b81c5fa081@redhat.com>
Date: Fri, 18 Aug 2017 16:35:48 -0400
MIME-Version: 1.0
In-Reply-To: <1503087492.2622.13.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 04:18 PM, Bart Van Assche wrote:
> On Fri, 2017-08-18 at 16:01 -0400, Waiman Long wrote:
>> [ ... ]
>> Instead of using bd_mutex, a new global blktrace mutex is now used
>> to protect against concurrent access, creation and destruction of the
>> blk_trace structure that is used only in the blktrace.c file. As
>> blktrace files will not be frequently accessed, using a global mutex
>> should not cause any performance problem.
>> [ ... ]
>> +/*
>> + * The bd_mutex was used previously for protecting blk_trace structur=
e.
>> + * That could lead to deadlock with concurrent block device deletion =
and
>> + * sysfs access. So a global blktrace_mutex is now used instead for
>> + * protecting the blk_trace structure.
>> + *
>> + * The references to the opened sysfs or device files should prevent =
the
>> + * underlying block device from being removed.
>> + */
>> +static DEFINE_MUTEX(blktrace_mutex);
> Hello Waiman,
>
> Thanks for having addressed my previous comment. Regarding this patch: =
sorry
> but I don't think it's a good idea to use a global mutex for serializin=
g
> accesses to tracing data of a single block device. Global mutexes creat=
e
> unwanted lock dependencies between different block devices. Additionall=
y, on
> multiprocessor systems global mutexes can cause cache line ping-pong be=
tween
> processors and hence can cause a severe slowdown. Please make blktrace_=
mutex
> per block device instead of global.

I fully understand the problem of a global lock. The main reason of
using a global lock here is that the blktrace APIs are not in a
performance critical path. In fact, I think it is used primarily for
debugging purpose. Activating it will certainly slow thing down no
matter what kind of lock is used.

I also don't believe that the blktrace APIs will be used in a high
enough frequency that it will cause a performance issue. Please let me
know if I am wrong in my assumptions.

Cheers,
Longman

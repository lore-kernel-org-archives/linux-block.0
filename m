Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
 <20170817093444.3276f7ab@gandalf.local.home>
 <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
 <20170817171007.1ab33b8f@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <6bb40f9f-7f55-28b4-812b-a80f05bec6ea@redhat.com>
Date: Thu, 17 Aug 2017 17:27:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170817171007.1ab33b8f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 05:10 PM, Steven Rostedt wrote:
> On Thu, 17 Aug 2017 12:24:39 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>>>> + * sysfs file and then acquiring the bd_mutex. Deleting a block dev=
ice
>>>> + * requires acquiring the bd_mutex and then waiting for all the sys=
fs
>>>> + * references to be gone. This can lead to deadlock if both operati=
ons
>>>> + * happen simultaneously. To avoid this problem, read/write to the
>>>> + * the tracing sysfs files can now fail if the bd_mutex cannot be
>>>> + * acquired while a deletion operation is in progress.
>>>> + *
>>>> + * A mutex trylock loop is used assuming that tracing sysfs operati=
ons =20
>>> A mutex trylock loop is not enough to stop a deadlock. But I'm guessi=
ng
>>> the undocumented bd_deleting may prevent that. =20
>> Yes, that is what the bd_deleting flag is for.
>>
>> I was thinking about failing the sysfs operation after a certain numbe=
r
>> of trylock attempts, but then it will require changes to user space co=
de
>> to handle the occasional failures. Finally I decided to fail it only
>> when a delete operation is in progress as all hopes are lost in this c=
ase.
> Actually, why not just fail the attr read on deletion? If it is being
> deleted, and one is reading the attribute, perhaps -ENODEV is the
> proper return value?
>
>> The root cause is the lock inversion under this circumstance. I think
>> modifying the blk_trace code has the least impact overall. I agree tha=
t
>> the code is ugly. If you have a better suggestion, I will certainly li=
ke
>> to hear it.
> Instead of playing games with taking the lock, the only way this race
> is hit, is if the partition is being deleted and the sysfs attribute is=

> being read at the same time, correct? In that case, just return
> -ENODEV, and be done with it.
>
> -- Steve

It is actually what the patch is trying to do by checking for the
deletion flag in the mutex_trylock loop. Please note that mutex does not
guarantee FIFO ordering of lock acquisition. As a result, cpu1 may call
mutex_lock() and wait for it while cpu2 can set the deletion flag later
and get the mutex first before cpu1. So checking for the deletion flag
before taking the mutex isn't enough.

Cheers,
Longman

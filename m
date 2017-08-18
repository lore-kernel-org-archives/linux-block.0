Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "bfields@fieldses.org" <bfields@fieldses.org>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "jlayton@poochiereds.net" <jlayton@poochiereds.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
 <20170817093444.3276f7ab@gandalf.local.home>
 <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
 <20170817171007.1ab33b8f@gandalf.local.home>
 <20170817173004.263d2891@gandalf.local.home>
 <5a5d0743-d2db-89c8-59cc-542835baeccf@redhat.com>
 <1503073304.2622.5.camel@wdc.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <688dc026-6902-8bd3-9d7b-38fec15dc626@redhat.com>
Date: Fri, 18 Aug 2017 13:22:44 -0400
MIME-Version: 1.0
In-Reply-To: <1503073304.2622.5.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 12:21 PM, Bart Van Assche wrote:
> On Fri, 2017-08-18 at 09:55 -0400, Waiman Long wrote:
>> On 08/17/2017 05:30 PM, Steven Rostedt wrote:
>>> On Thu, 17 Aug 2017 17:10:07 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>> Instead of playing games with taking the lock, the only way this rac=
e
>>>> is hit, is if the partition is being deleted and the sysfs attribute=
 is
>>>> being read at the same time, correct? In that case, just return
>>>> -ENODEV, and be done with it.
>>> Nevermind that wont work. Too bad there's not a mutex_lock_timeout()
>>> that we could use in a loop. It would solve the issue of forward
>>> progress with RT tasks, and will break after a timeout in case of
>>> deadlock.
>> I think it will be useful to have mutex_timed_lock(). RT-mutex does ha=
ve
>> a timed version, so I guess it shouldn't be hard to implement one for
>> mutex. I can take a shot at trying to do that.
> (just caught up with the entire e-mail thread)
>
> Sorry Waiman but personally I thoroughly detest loops around mutex_tryl=
ock() or
> mutex_timed_lock() because such loops are usually used to paper over a =
problem
> instead of fixing the root cause. What I understood from the comment in=
 v1 of your
> patch is that bd_mutex is not only held during block device creation an=
d removal
> but additionally that bd_mutex is obtained inside sysfs attribute callb=
ack methods?
> That pattern is guaranteed to lead to deadlocks. Since the block device=
 removal
> code waits until all sysfs callback methods have finished there is no n=
eed to
> protect against block device removal inside the sysfs callback methods.=
 My proposal

You are right. We don't really need to take the bd_mutex as the fact
that inside the sysfs callback method will guarantee the block device
won't go away.

> is to split bd_mutex: one global mutex that serializes block device cre=
ation and
> removal and one mutex per block device that serializes changes to a sin=
gle block
> device. Obtaining the global mutex from inside a block device sysfs cal=
lback
> function is not safe but obtaining the per-block-device mutex from insi=
de a sysfs
> callback function is safe.
>
> Bart.

The bd_mutex we are talking here is already per block device. I am
thinking about having a global blktrace mutex that is used to serialize
the read and write of blktrace attributes. Since blktrace sysfs files
are not supposed to be frequently accessed, having a global lock
shouldn't cause any problem.

Thanks,
Longman

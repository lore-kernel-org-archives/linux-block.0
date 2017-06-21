Return-Path: <jhugo@codeaurora.org>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 pprakash@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <rcochran@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Weinberger <richard@nod.at>
References: <db9c91f6-1b17-6136-84f0-03c3c2581ab4@codeaurora.org>
 <20170326232843.GA3637@linux.vnet.ibm.com>
 <d23f3f77-8158-24a4-727d-123ec526dffa@codeaurora.org>
 <20170327181711.GF3637@linux.vnet.ibm.com>
 <20170620234623.GA16200@linux.vnet.ibm.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <df080eec-62b8-7d19-c201-e1a44febb96d@codeaurora.org>
Date: Wed, 21 Jun 2017 08:39:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170620234623.GA16200@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 6/20/2017 5:46 PM, Paul E. McKenney wrote:
> On Mon, Mar 27, 2017 at 11:17:11AM -0700, Paul E. McKenney wrote:
>> On Mon, Mar 27, 2017 at 12:02:27PM -0600, Jeffrey Hugo wrote:
>>> Hi Paul.
>>>
>>> Thanks for the quick reply.
>>>
>>> On 3/26/2017 5:28 PM, Paul E. McKenney wrote:
>>>> On Sun, Mar 26, 2017 at 05:10:40PM -0600, Jeffrey Hugo wrote:
>>>
>>>>> It is a race between this work running, and the cpu offline processing.
>>>>
>>>> One quick way to test this assumption is to build a kernel with Kconfig
>>>> options CONFIG_RCU_NOCB_CPU=y and CONFIG_RCU_NOCB_CPU_ALL=y.  This will
>>>> cause call_rcu_sched() to queue the work to a kthread, which can migrate
>>>> to some other CPU.  If your analysis is correct, this should avoid
>>>> the deadlock.  (Note that the deadlock should be fixed in any case,
>>>> just a diagnostic assumption-check procedure.)
>>>
>>> I enabled CONFIG_RCU_EXPERT=y, CONFIG_RCU_NOCB_CPU=y,
>>> CONFIG_RCU_NOCB_CPU_ALL=y in my build.  I've only had time so far to
>>> do one test run however the issue reproduced, but it took a fair bit
>>> longer to do so.  An initial look at the data indicates that the
>>> work is still not running.  An odd observation, the two threads are
>>> no longer blocked on the same queue, but different ones.
>>
>> I was afraid of that...
>>
>>> Let me look at this more and see what is going on now.
>>
>> Another thing to try would be to affinity the "rcuo" kthreads to
>> some CPU that is never taken offline, just in case that kthread is
>> sometimes somehow getting stuck during the CPU-hotplug operation.
>>
>>>>> What is the opinion of the domain experts?
>>>>
>>>> I do hope that we can come up with a better fix.  No offense intended,
>>>> as coming up with -any- fix in the CPU-hotplug domain is not to be
>>>> denigrated, but this looks to be at vest quite fragile.
>>>>
>>>> 							Thanx, Paul
>>>>
>>>
>>> None taken.  I'm not particularly attached to the current fix.  I
>>> agree, it does appear to be quite fragile.
>>>
>>> I'm still not sure what a better solution would be though.  Maybe
>>> the RCU framework flushes the work somehow during cpu offline?  It
>>> would need to ensure further work is not queued after that point,
>>> which seems like it might be tricky to synchronize.  I don't know
>>> enough about the working of RCU to even attempt to implement that.
>>
>> There are some ways that RCU might be able to shrink the window during
>> which the outgoing CPU's callbacks are in limbo, but they are not free
>> of risk, so we really need to compleetly understand what is going on
>> before making any possibly ill-conceived changes.  ;-)
>>
>>> In any case, it seem like some more analysis is needed based on the
>>> latest data.
>>
>> Looking forward to hearing about you find!
> 
> Hearing nothing, I eventually took unilateral action (I am a citizen of
> USA, after all!) and produced the lightly tested patch shown below.
> 
> Does it help?
> 
> 							Thanx, Paul
> 

Wow, has it been 3 months already?  I am extremely sorry, I've been 
preempted multiple times, and this has sat on my todo list where I keep 
thinking I need to find time to come back to it but apparently not doing 
enough to make that happen.

Thank you for not forgetting about this.  I promise I will somehow clear 
my schedule to test this next week.

Thank you again.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To: "van der Linden, Frank" <fllinden@amazon.com>,
 =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
 "Agarwal, Anchal" <anchalag@amazon.com>
Cc: "Singh, Balbir" <sblbir@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <72f90be2-0b63-d3a0-e953-da9232f44d5b@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
 <f71cf3f9c54346e1b69ab42601404597@EX13D13UWB002.ant.amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f457d299-574b-52e1-782f-51cbc988f4fb@kernel.dk>
Date: Wed, 22 Aug 2018 11:30:40 -0600
MIME-Version: 1.0
In-Reply-To: <f71cf3f9c54346e1b69ab42601404597@EX13D13UWB002.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/22/18 10:42 AM, van der Linden, Frank wrote:
> On 8/22/18 7:27 AM, Jens Axboe wrote:
>> On 8/22/18 6:54 AM, Holger Hoffstätte wrote:
>>> On 08/22/18 06:10, Jens Axboe wrote:
>>>> [...]
>>>> If you have time, please look at the 3 patches I posted earlier today.
>>>> Those are for mainline, so should be OK :-)
>>> I'm just playing along at home but with those 3 I get repeatable
>>> hangs & writeback not starting at all, but curiously *only* on my btrfs
>>> device; for inexplicable reasons some other devices with ext4/xfs flush
>>> properly. Yes, that surprised me too, but it's repeatable.
>>> Now this may or may not have something to do with some of my in-testing
>>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything
>>> is golden again. Not eager to repeat since it hangs sync & requires a
>>> hard reboot.. :(
>>> Just thought you'd like to know.
>> Thanks, that's very useful info! I'll see if I can reproduce that.
>>
> I think it might be useful to kind of give a dump of what we discussed
> before this patch was sent, there was a little more than was in the
> description.
> 
> We saw hangs and heavy lock contention in the wbt code under a specific
> workload, on XFS. Crash dump analysis showed the following issues:
> 
> 1) wbt_done uses wake_up_all, which causes a thundering herd
> 2) __wbt_wait sets up a wait queue with the auto remove wake function
> (via DEFINE_WAIT), which caused two problems:
>    * combined with the use of wake_up_all, the wait queue would
> essentially be randomly reordered for tasks that did not get to run
>    * the waitqueue_active check in may_queue was not valid with the auto
> remove function, which could lead incoming tasks with requests to
> overtake existing requests
> 
> 1) was fixed by using a plain wake_up
> 2) was fixed by keeping tasks on the queue until they could break out of
> the wait loop in __wbt_wait
> 
> 
> The random reordering, causing task starvation in __wbt_wait, was the
> main problem. Simply not using the auto remove wait function, e.g.
> *only* changing DEFINE_WAIT(wait) to DEFINE_WAIT_FUNC(wait,
> default_wake_function), fixed the hang / task starvation issue in our
> tests. But there was still more lock contention than there should be, so
> we also changed wake_up_all to wake_up.
> 
> It might be useful to run your tests with only the DEFINE_WAIT change I
> describe above added to the original code to see if that still has any
> problems. That would give a good datapoint whether any remaining issues
> are due to missed wakeups or not.
> 
> There is the issue of making forward progress, or at least making it
> fast enough. With the changes as they stand now, you could come up with
> a scenario where the throttling limit is hit, but then is raised. Since
> there might still be a wait queue, you could end up putting each
> incoming task to sleep, even though it's not needed.
> 
> One way to guarantee that the wait queue clears up as fast as possible,
> without resorting to wakeup_all, is to use wakeup_nr, where the number
> of tasks to wake up is (limit - inflight).
> 
> Also, to avoid having tasks going back to sleep in the loop, you could
> do what you already proposed - always just sleep at most once, and
> unconditionally proceed after waking up. To avoid incoming tasks
> overtaking the ones that are being woken up, you could have wbt_done
> increment inflight, effectively reserving a spot for the tasks that are
> about to be woken up.
> 
> Another thing I thought about was recording the number of waiters in the
> wait queue, and modify the check from (inflight < limit) to (inflight <
> (limit - nwaiters)), and no longer use any waitqueue_active checks.
> 
> The condition checks are of course complicated by the fact that
> condition manipulation is not always done under the same lock (e.g.
> wbt_wait can be called with a NULL lock).
> 
> 
> So, these are just some of the things to consider here - maybe there's
> nothing in there that you hadn't already considered, but I thought it'd
> be useful to summarize them.
> 
> Thanks for looking in to this!

It turned out to be an unrelated problem with rq reordering in blk-mq,
mainline doesn't have it.

So I think the above change is safe and fine, but we definitely still
want the extra change of NOT allowing a queue token for the initial loop
inside __wbt_wait() for when we have current sleepers on the queue.
Without that, the initial check in __wbt_wait() is not useful at all.


-- 
Jens Axboe

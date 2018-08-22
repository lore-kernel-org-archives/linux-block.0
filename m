Return-Path: <prvs=76550dc36=fllinden@amazon.com>
From: "van der Linden, Frank" <fllinden@amazon.com>
To: Jens Axboe <axboe@kernel.dk>,
        =?iso-8859-1?Q?Holger_Hoffst=E4tte?=
	<holger@applied-asynchrony.com>,
        "Agarwal, Anchal" <anchalag@amazon.com>
CC: "Singh, Balbir" <sblbir@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
Date: Wed, 22 Aug 2018 16:42:41 +0000
Message-ID: <f71cf3f9c54346e1b69ab42601404597@EX13D13UWB002.ant.amazon.com>
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
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 8/22/18 7:27 AM, Jens Axboe wrote:=0A=
> On 8/22/18 6:54 AM, Holger Hoffst=E4tte wrote:=0A=
>> On 08/22/18 06:10, Jens Axboe wrote:=0A=
>>> [...]=0A=
>>> If you have time, please look at the 3 patches I posted earlier today.=
=0A=
>>> Those are for mainline, so should be OK :-)=0A=
>> I'm just playing along at home but with those 3 I get repeatable=0A=
>> hangs & writeback not starting at all, but curiously *only* on my btrfs=
=0A=
>> device; for inexplicable reasons some other devices with ext4/xfs flush=
=0A=
>> properly. Yes, that surprised me too, but it's repeatable.=0A=
>> Now this may or may not have something to do with some of my in-testing=
=0A=
>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything=
=0A=
>> is golden again. Not eager to repeat since it hangs sync & requires a=0A=
>> hard reboot.. :(=0A=
>> Just thought you'd like to know.=0A=
> Thanks, that's very useful info! I'll see if I can reproduce that.=0A=
>=0A=
I think it might be useful to kind of give a dump of what we discussed=0A=
before this patch was sent, there was a little more than was in the=0A=
description.=0A=
=0A=
We saw hangs and heavy lock contention in the wbt code under a specific=0A=
workload, on XFS. Crash dump analysis showed the following issues:=0A=
=0A=
1) wbt_done uses wake_up_all, which causes a thundering herd=0A=
2) __wbt_wait sets up a wait queue with the auto remove wake function=0A=
(via DEFINE_WAIT), which caused two problems:=0A=
   * combined with the use of wake_up_all, the wait queue would=0A=
essentially be randomly reordered for tasks that did not get to run=0A=
   * the waitqueue_active check in may_queue was not valid with the auto=0A=
remove function, which could lead incoming tasks with requests to=0A=
overtake existing requests=0A=
=0A=
1) was fixed by using a plain wake_up=0A=
2) was fixed by keeping tasks on the queue until they could break out of=0A=
the wait loop in __wbt_wait=0A=
=0A=
=0A=
The random reordering, causing task starvation in __wbt_wait, was the=0A=
main problem. Simply not using the auto remove wait function, e.g.=0A=
*only* changing DEFINE_WAIT(wait) to DEFINE_WAIT_FUNC(wait,=0A=
default_wake_function), fixed the hang / task starvation issue in our=0A=
tests. But there was still more lock contention than there should be, so=0A=
we also changed wake_up_all to wake_up.=0A=
=0A=
It might be useful to run your tests with only the DEFINE_WAIT change I=0A=
describe above added to the original code to see if that still has any=0A=
problems. That would give a good datapoint whether any remaining issues=0A=
are due to missed wakeups or not.=0A=
=0A=
There is the issue of making forward progress, or at least making it=0A=
fast enough. With the changes as they stand now, you could come up with=0A=
a scenario where the throttling limit is hit, but then is raised. Since=0A=
there might still be a wait queue, you could end up putting each=0A=
incoming task to sleep, even though it's not needed.=0A=
=0A=
One way to guarantee that the wait queue clears up as fast as possible,=0A=
without resorting to wakeup_all, is to use wakeup_nr, where the number=0A=
of tasks to wake up is (limit - inflight).=0A=
=0A=
Also, to avoid having tasks going back to sleep in the loop, you could=0A=
do what you already proposed - always just sleep at most once, and=0A=
unconditionally proceed after waking up. To avoid incoming tasks=0A=
overtaking the ones that are being woken up, you could have wbt_done=0A=
increment inflight, effectively reserving a spot for the tasks that are=0A=
about to be woken up.=0A=
=0A=
Another thing I thought about was recording the number of waiters in the=0A=
wait queue, and modify the check from (inflight < limit) to (inflight <=0A=
(limit - nwaiters)), and no longer use any waitqueue_active checks.=0A=
=0A=
The condition checks are of course complicated by the fact that=0A=
condition manipulation is not always done under the same lock (e.g.=0A=
wbt_wait can be called with a NULL lock).=0A=
=0A=
=0A=
So, these are just some of the things to consider here - maybe there's=0A=
nothing in there that you hadn't already considered, but I thought it'd=0A=
be useful to summarize them.=0A=
=0A=
Thanks for looking in to this!=0A=
=0A=
Frank=0A=
=0A=
=0A=

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5] blk-throttle: fix race between blkcg_bio_issue_check()
 and cgroup_rmdir()
To: Tejun Heo <tj@kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: xuejiufei <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <5c99ef07-1133-a45a-9a09-7c29e8139f5b@linux.alibaba.com>
 <20180314140901.GV2943022@devbig577.frc2.facebook.com>
 <d988a1eb-98c0-6a79-d271-778f5ca17b3e@linux.alibaba.com>
 <20180319144532.GJ2943022@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8cb0242a-4858-ec13-efee-2e3b6e4540bc@kernel.dk>
Date: Mon, 19 Mar 2018 08:52:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180319144532.GJ2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/19/18 8:45 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 15, 2018 at 09:18:55AM +0800, Joseph Qi wrote:
>>> This is pure bike-shedding but offlined reads kinda weird to me, maybe
>>> just offline would read better?  Other than that,
>>>
>> Do I need to resend a new version for this?
> 
> No idea, Jens's call.  He can fix it up if he wants to while applying
> but there's no harm in sending an updated version either.

This got queued up last week:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.17/block&id=4c6994806f708559c2812b73501406e21ae5dcd0

for 4.17.

-- 
Jens Axboe

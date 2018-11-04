Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Long Li <longli@linuxonhyperv.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
 <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
 <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
Date: Sun, 4 Nov 2018 10:24:53 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/4/18 5:02 AM, Thomas Gleixner wrote:
> Jens,
> 
> On Sat, 3 Nov 2018, Jens Axboe wrote:
> 
>> On 11/2/18 8:59 AM, Ming Lei wrote:
>>> Hi Jens,
>>>
>>> As I mentioned, there are at least two issues in the patch of '
>>> irq: add support for allocating (and affinitizing) sets of IRQs':
>>>
>>> 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
>>>
>>> 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
>>>
>>> The fix isn't trivial, and I introduce two extra patches as preparation,
>>> then the implementation can be more clean.
>>>
>>> The patchset is against mq-maps branch of block tree, feel free to
>>> integrate into the whole patchset of multiple queue maps.
>>
>> Thanks Ming, I ran this through my testing, and I end up with the
>> same maps and affinities for all the cases I cared about. I'm going
>> to drop my initial version, and add the three.
> 
> So I assume, that I can pick up Mings series instead.

Yes, let's do that.

> There is another patch pending affecting the irq affinity spreading. Can
> you folks please have a look at it?
> 
> https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

I'll give that a look and test. Thanks for the heads-up.

-- 
Jens Axboe

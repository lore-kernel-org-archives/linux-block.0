Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20181102145951.31979-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
Date: Sat, 3 Nov 2018 15:21:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/2/18 8:59 AM, Ming Lei wrote:
> Hi Jens,
> 
> As I mentioned, there are at least two issues in the patch of '
> irq: add support for allocating (and affinitizing) sets of IRQs':
> 
> 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> 
> 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> 
> The fix isn't trivial, and I introduce two extra patches as preparation,
> then the implementation can be more clean.
> 
> The patchset is against mq-maps branch of block tree, feel free to
> integrate into the whole patchset of multiple queue maps.

Thanks Ming, I ran this through my testing, and I end up with the
same maps and affinities for all the cases I cared about. I'm going
to drop my initial version, and add the three.

-- 
Jens Axboe

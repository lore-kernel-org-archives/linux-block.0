Return-Path: <keith.busch@intel.com>
Date: Tue, 30 Oct 2018 12:35:39 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 0/16] blk-mq: Add support for multiple queue maps
Message-ID: <20181030183538.GB19483@localhost.localdomain>
References: <20181030183252.17857-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 30, 2018 at 12:32:36PM -0600, Jens Axboe wrote:
> This series adds support for multiple queue maps for blk-mq.
> Since blk-mq was introduced, it's only support a single queue
> map. This means you can have 1 set of queues, and the mapping
> purely depends on what CPU an IO originated from. With this
> patch set, drivers can implement mappings that depend on both
> CPU and request type - and they can have multiple sets of mappings.
> 
> NVMe is used as a proof of concept. It adds support for a separate
> write queue set. One way to use this would be to limit the number
> of write queues to favor reads, since NVMe does round-robin service
> of queues. An easy extension of this would be to add multiple
> sets of queues, for prioritized IO.
> 
> NVMe also uses this feature to finally make the polling work
> efficiently, without triggering interrupts. This both increases
> performance (and decreases latency), at a lower system load. At
> the same time it's more flexible, as you don't have to worry about
> IRQ coalescing and redirection to avoid interrupts disturbing the
> workload. This is how polling should have worked from day 1.
> 
> This is on top of my mq-conversions branch. It can also be bound
> in my mq-maps branch.

Looks good to me. For the series:

Reviewed-by: Keith Busch <keith.busch@intel.com>

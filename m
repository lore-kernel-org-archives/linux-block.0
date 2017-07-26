Return-Path: <shli@kernel.org>
Date: Wed, 26 Jul 2017 15:29:52 -0700
From: Shaohua Li <shli@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [BUG] nvme driver crash
Message-ID: <20170726222952.pn74rllluhq6cflm@kernel.org>
References: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
 <20170726173443.GA25527@infradead.org>
 <20170726191221.GA22421@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170726191221.GA22421@vader.DHCP.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 26, 2017 at 12:12:21PM -0700, Omar Sandoval wrote:
> On Wed, Jul 26, 2017 at 10:34:43AM -0700, Christoph Hellwig wrote:
> > On Tue, Jul 25, 2017 at 03:24:08PM -0700, Shaohua Li wrote:
> > > Disable CONIFG_SMP, kernel crashes at boot time, here is the log.
> > 
> > I can reproduce the issue.  Unfortunately the addresss in the bug
> > doesn't make any sense to me when resolving it using gdb, as t just
> > points to the line where blk_mq_init_queue calls
> > blk_alloc_queue_node.
> > 
> > Can you check if you get better results in your build?
> 
> It's crashing on that line because ctrl->tagset is NULL, which is
> because...
> 
> irq_create_affinity_masks() returns NULL on !CONFIG_SMP
> -> pci_irq_get_affinity() returns NULL
> -> blk_mq_pci_map_queues() returns -EINVAL
> -> blk_mq_alloc_tag_set() returns -EINVAL
> -> nvme_dev_add() doesn't set ctrl->tagset
> 
> The two-fold fix would be to make the nvme driver handle
> blk_mq_alloc_tag_set() failing and to fall back to a dumb mapping in
> blk_mq_pci_map_queues(), but I don't know what the best way to do those
> is.

irq_create_affinity_masks returns null and prints error, could we fix that?

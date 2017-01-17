Return-Path: <keith.busch@intel.com>
Date: Tue, 17 Jan 2017 13:00:08 -0500
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Merlin <marc@merlins.org>
Subject: Re: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
Message-ID: <20170117180008.GB8989@localhost.localdomain>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-6-git-send-email-keith.busch@intel.com>
 <1031ba43-4c5e-f6a7-e12f-f6169eae5edf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1031ba43-4c5e-f6a7-e12f-f6169eae5edf@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 13, 2017 at 11:05:19PM +0200, Sagi Grimberg wrote:
> > If hardware queues are stopped for some event, like the device has been
> > suspended by power management, requests allocated on that hardware queue
> > are indefinitely stuck causing a queue freeze to wait forever.
> 
> I have a problem with this patch. IMO, this is a general issue so, so
> why do we tie a fix to calling blk_mq_update_nr_hw_queues()? We might
> not need to update nr_hw_queues at all. I'm fine with the
> blk_mq_abandon_stopped_requests but not with its call-site.
> 
> Usually a driver knows when it wants to abandon all busy requests
> blk_mq_tagset_busy_iter(), maybe the right approach is to add
> a hook for all allocated tags? Or have blk_mq_quisce_queue get a
> fail all requests parameter from the callers?

This patch is overly aggressive on failing allocated requests. There
are scenarios where we wouldn't want to abandon them, like if the hw
context is about to be brough back online, but this patch assumes all
need to be abandoned. I'll see if there's some other tricks we can have
a driver do. Thanks for the suggestions.

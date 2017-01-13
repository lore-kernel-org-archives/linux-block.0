Return-Path: <sagi@grimberg.me>
Subject: Re: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-6-git-send-email-keith.busch@intel.com>
Cc: Marc Merlin <marc@merlins.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1031ba43-4c5e-f6a7-e12f-f6169eae5edf@grimberg.me>
Date: Fri, 13 Jan 2017 23:05:19 +0200
MIME-Version: 1.0
In-Reply-To: <1483569671-1462-6-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> If hardware queues are stopped for some event, like the device has been
> suspended by power management, requests allocated on that hardware queue
> are indefinitely stuck causing a queue freeze to wait forever.

I have a problem with this patch. IMO, this is a general issue so, so
why do we tie a fix to calling blk_mq_update_nr_hw_queues()? We might
not need to update nr_hw_queues at all. I'm fine with the
blk_mq_abandon_stopped_requests but not with its call-site.

Usually a driver knows when it wants to abandon all busy requests
blk_mq_tagset_busy_iter(), maybe the right approach is to add
a hook for all allocated tags? Or have blk_mq_quisce_queue get a
fail all requests parameter from the callers?

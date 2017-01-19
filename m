Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
To: Keith Busch <keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-6-git-send-email-keith.busch@intel.com>
 <1031ba43-4c5e-f6a7-e12f-f6169eae5edf@grimberg.me>
 <20170117180008.GB8989@localhost.localdomain>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Merlin <marc@merlins.org>
Message-ID: <c17c426c-44c3-2b3a-b351-a1717e36ce35@grimberg.me>
Date: Thu, 19 Jan 2017 09:54:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170117180008.GB8989@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> If hardware queues are stopped for some event, like the device has been
>>> suspended by power management, requests allocated on that hardware queue
>>> are indefinitely stuck causing a queue freeze to wait forever.
>>
>> I have a problem with this patch. IMO, this is a general issue so, so
>> why do we tie a fix to calling blk_mq_update_nr_hw_queues()? We might
>> not need to update nr_hw_queues at all. I'm fine with the
>> blk_mq_abandon_stopped_requests but not with its call-site.
>>
>> Usually a driver knows when it wants to abandon all busy requests
>> blk_mq_tagset_busy_iter(), maybe the right approach is to add
>> a hook for all allocated tags? Or have blk_mq_quisce_queue get a
>> fail all requests parameter from the callers?
>
> This patch is overly aggressive on failing allocated requests. There
> are scenarios where we wouldn't want to abandon them, like if the hw
> context is about to be brough back online, but this patch assumes all
> need to be abandoned. I'll see if there's some other tricks we can have
> a driver do. Thanks for the suggestions.

I agree,

I do think though that this should be driven from the driver, because
for fabrics, we might have some fabric error that triggers a periodic
reconnect. So the "hw context is about to be brought back" is unknown
from the driver pov, and when we delete the controller (because we give
up) this is exactly where we need to abandon the allocated requests.

Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
To: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
 <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
 <20171229094814.GC24043@lst.de>
 <20171229153950.GB16407@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5ee695e8-f294-524a-e945-d484cea6df8a@grimberg.me>
Date: Sun, 31 Dec 2017 14:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171229153950.GB16407@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>>> Awesome!
>>>>
>>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>>
>>> Wait, aren't we unquiesce queues also in nvme_dev_disable?
>>>
>>> Doesn't that rely that the queues are suspended and queue_rq
>>> will fail there?
>>
>> We don't seem to have any other check as far as I can tell.
> 
> Ok, we currently do need this check in the submission side to flush
> entered requests on invalidated hw contexts. We didn't have a way to
> back out entered requests before, so that's why this request killing
> check still exists. We can steal bio's to back out requests now, so I
> think we should do that instead of failing them.
> 
> I'll do rework the series a bit to make that possible, plus add the
> removal of the submission side nvme_process_cq, and resend.

Not sure if stealing bios from requests is a better design. Note that
we do exactly this in other transport (nvme_[rdma|loop|fc]_is_ready).

I think it would be better to stick to a coherent behavior across
the nvme subsystem. If this condition statement is really something
that is buying us measurable performance gain, I think we should apply
it for other transports as well (although in fabrics we're a bit
different because we have a dedicated connect that enters .queue_rq)

Subject: Re: [PATCH] blk-mq: don't complete un-started request in timeout
 handler
To: Keith Busch <keith.busch@intel.com>
References: <20170322021443.26397-1-tom.leiming@gmail.com>
 <2bc8118b-4a11-f28e-50eb-22019184756b@fb.com>
 <20170322155817.GA18960@localhost.localdomain>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Yi Zhang <yizhan@redhat.com>, Bart Van Assche <bart.vanassche@sandisk.com>,
 Hannes Reinecke <hare@suse.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <eb11c238-8e12-bcc4-f21d-4292c4543da5@fb.com>
Date: Wed, 22 Mar 2017 12:35:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170322155817.GA18960@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/22/2017 11:58 AM, Keith Busch wrote:
> On Tue, Mar 21, 2017 at 11:03:59PM -0400, Jens Axboe wrote:
>> On 03/21/2017 10:14 PM, Ming Lei wrote:
>>> When iterating busy requests in timeout handler,
>>> if the STARTED flag of one request isn't set, that means
>>> the request is being processed in block layer or driver, and
>>> isn't submitted to hardware yet.
>>>
>>> In current implementation of blk_mq_check_expired(),
>>> if the request queue becomes dying, un-started requests are
>>> handled as being completed/freed immediately. This way is
>>> wrong, and can cause rq corruption or double allocation[1][2],
>>> when doing I/O and removing&resetting NVMe device at the sametime.
>>
>> I agree, completing it looks bogus. If the request is in a scheduler or
>> on a software queue, this won't end well at all. Looks like it was
>> introduced by this patch:
>>
>> commit eb130dbfc40eabcd4e10797310bda6b9f6dd7e76
>> Author: Keith Busch <keith.busch@intel.com>
>> Date:   Thu Jan 8 08:59:53 2015 -0700
>>
>>     blk-mq: End unstarted requests on a dying queue
>>
>> Before that, we just ignored it. Keith?
> 
> The above was intended for a stopped hctx on a dying queue such that
> there's nothing in flight to the driver. Nvme had been relying on this
> to end unstarted requests so we may progress when a controller dies.
> 
> We've since obviated the need: we restart the hw queues to flush entered
> requests to failure, so we don't need that brokenness.

Good, thanks for confirming, Keith. I queued up the patch for 4.11 this
morning.

-- 
Jens Axboe

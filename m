Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC V2 0/3] blk-mq: support runtime PM
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <20180713080602.31602-1-ming.lei@redhat.com>
 <c4147a47-876f-0ced-6c9d-1c3792d09858@kernel.dk>
 <20180714023740.GA8402@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27bc4ec8-dd63-2b6f-84ef-4c4c0fc7f9e9@kernel.dk>
Date: Fri, 13 Jul 2018 20:54:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180714023740.GA8402@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/13/18 8:37 PM, Ming Lei wrote:
> On Fri, Jul 13, 2018 at 08:21:09AM -0600, Jens Axboe wrote:
>> On 7/13/18 2:05 AM, Ming Lei wrote:
>>> Hi Guys,
>>>
>>> Runtime PM is usually enabled for SCSI devices, and we are switching to
>>> SCSI_MQ recently, but runtime PM isn't supported yet by blk-mq, and
>>> people may complain that.
>>>
>>> This patch tries to support runtime PM for blk-mq. And one chanllenge is
>>> that it can be quite expensive to account the active in-flight IOs for
>>> figuring out when to mark the last busy. This patch simply marks busy
>>> after each non-PM IO is done, and this way is workable because:
>>>
>>> 1) pm_runtime_mark_last_busy() is very cheap
>>>
>>> 2) in-flight non-PM IO is checked in blk_pre_runtime_suspend(), so
>>> if there is any IO queued, the device will be prevented from being
>>> suspened.
>>>
>>> 3) Generally speaking, autosuspend_delay_ms is often big, and should
>>> be in unit of second, so it shouldn't be a big deal to check if queue
>>> is idle in blk_pre_runtime_suspend().
>>>
>>>
>>> V2:
>>> 	- re-organize code as suggested by Christoph
>>> 	- use seqlock to sync runtime PM and IO path
>>
>> See other mail on why this is not going to be acceptable.
> 
> OK, I am thinking another idea for addressing this issue.
> 
> We may introduce one logical admin(pm) request queue for each scsi_device,
> and this queue shares tag with IO queue, with NO_SCHED set, and always
> use atomic mode of the queue usage refcounter. Then we may send PM
> command to device after the IO queue is frozen.
> 
> Also PREEMPT_ONLY can be removed too in this way.
> 
> Even in future, all pass-through commands may be sent to this admin queue.
> 
> If no one objects, I will cook patches towards this direction.

Yes, this seems like a fine idea. It's essentially the same as handling
the enter differently, but the abstraction is nicer.

-- 
Jens Axboe

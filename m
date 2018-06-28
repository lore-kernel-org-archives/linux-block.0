Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix a race condition in blk_mq_mark_tag_wait()
To: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180627200212.14435-1-bart.vanassche@wdc.com>
 <20180627232705.GC7583@ming.t460p>
 <1999799b-acb3-f8e5-a214-4888e51dc52a@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <211e1e5d-c3c5-4a84-a150-27e8c19a038f@kernel.dk>
Date: Thu, 28 Jun 2018 09:56:27 -0600
MIME-Version: 1.0
In-Reply-To: <1999799b-acb3-f8e5-a214-4888e51dc52a@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/27/18 6:00 PM, Bart Van Assche wrote:
> On 06/27/18 16:27, Ming Lei wrote:
>> On Wed, Jun 27, 2018 at 01:02:12PM -0700, Bart Van Assche wrote:
>>> Because the hctx lock is not held around the only
>>> blk_mq_tag_wakeup_all() call in the block layer, the wait queue
>>> entry removal in blk_mq_dispatch_wake() is protected by the wait
>>> queue lock only. Since the hctx->dispatch_wait entry can occur on
>>> any of the SBQ_WAIT_QUEUES, the wait queue presence check, adding
>>> .dispatch_wait to a wait queue and removing the wait queue entry
>>> must all be protected by both the hctx lock and the wait queue
>>> lock.
>>
>> Actually we don't need to use hctx->lock for protecting
>> hctx->dispatch_wait, and one new lock of hctx->dispatch_wait_lock is
>> enough, please see the following patch:
>>
>> 	https://marc.info/?l=linux-block&m=152998658713265&w=2
>>
>> Then we can avoid to disable irq when acquiring hctx->lock.
> 
> I think it's more a matter of taste than a technical decision to choose 
> which patch goes upstream.

I do think the split lock is cleaner in this case, since it avoids
making hctx->lock irq disabling.

-- 
Jens Axboe

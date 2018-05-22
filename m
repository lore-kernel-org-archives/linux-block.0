Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180522144636.GS5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com> <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p> <20180522142030.GR5528@localhost.localdomain>
 <CACVXFVNT5qiamN0ydXzNYDWE0szi2fTsAAmyG9Q884LEqUhSdQ@mail.gmail.com> <20180522144636.GS5528@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 22 May 2018 22:57:40 +0800
Message-ID: <CACVXFVNWK-r6FrsNOmmETZXf9MLPQUNR3Nmf_hmDgaOUivpbYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>, Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:46 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Tue, May 22, 2018 at 10:37:32PM +0800, Ming Lei wrote:
>> On Tue, May 22, 2018 at 10:20 PM, Keith Busch
>> <keith.busch@linux.intel.com> wrote:
>> > In the event the driver requests a normal completion, the timeout work
>> > releasing the last reference doesn't do a second completion: it only
>>
>> The reference only covers request's lifetime, not related with completion.
>>
>> It isn't the last reference. When driver returns EH_HANDLED, blk-mq
>> will complete this request on extra time.
>>
>> Yes, if driver's timeout code and normal completion code can sync
>> about this completion, that should be fine, but the current behaviour
>> doesn't depend driver's sync since the req is always completed atomically
>> via the following way:
>>
>> 1) timeout
>>
>> if (mark_completed(rq))
>>    timed_out(rq)
>>
>> 2) normal completion
>> if (mark_completed(rq))
>>     complete(rq)
>>
>> For example, before nvme_timeout() is trying to run nvme_dev_disable(),
>> irq comes and this req is completed from normal completion path, but
>> nvme_timeout() still returns EH_HANDLED, and blk-mq may complete
>> the req one extra time since the normal completion path may not update
>> req's state yet.
>
> nvme_dev_disable tears down irq's, meaing their handling is already
> sync'ed before nvme_dev_disable can proceed. Whether the completion
> comes through nvme_irq, or through nvme_dev_disable, there is no way
> possible for nvme's timeout to return EH_HANDLED if the state was not
> updated prior to returning that status.

OK, that still depends on driver's behaviour, even though it is true
for NVMe,  you still have to audit other drivers about this sync
because it is required by your patch.


thanks,
Ming Lei

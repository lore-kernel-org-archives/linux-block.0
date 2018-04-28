Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180428133514.GB5938@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com> <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain> <20180428035015.GB5657@ming.t460p>
 <20180428133514.GB5938@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 29 Apr 2018 05:39:52 +0800
Message-ID: <CACVXFVMfvLLt7h58W-ifJKbC-s_1oDhCJEx4AqD6wJ+w2AjnYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Apr 28, 2018 at 9:35 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
>> > I understand how the problems are happening a bit better now. It used
>> > to be that blk-mq would lock an expired command one at a time, so when
>> > we had a batch of IO timeouts, the driver was able to complete all of
>> > them inside a single IO timeout handler.
>> >
>> > That's not the case anymore, so the driver is called for every IO
>> > timeout even though if it reaped all the commands at once.
>>
>> Actually there isn't the case before, even for legacy path, one .timeout()
>> handles one request only.
>
> That's not quite what I was talking about.
>
> Before, only the command that was about to be sent to the driver's
> .timeout() was marked completed. The driver could (and did) compete
> other timed out commands in a single .timeout(), and the tag would
> clear, so we could hanlde all timeouts in a single .timeout().
>
> Now, blk-mq marks all timed out commands as aborted prior to calling
> the driver's .timeout(). If the driver completes any of those commands,
> the tag does not clear, so the driver's .timeout() just gets to be called
> again for commands it already reaped.

That won't happen because new timeout model will mark aborted on timed-out
request first, then run synchronize_rcu() before making these requests
really expired, and now rcu lock is held in normal completion
handler(blk_mq_complete_request).

Yes, Bart is working towards that way, but there is still the same race
between timeout handler(nvme_dev_disable()) and reset_work(), and nothing
changes wrt. the timeout model:

- reset may take a while to complete because of nvme_wait_freeze(), and
timeout can happen during resetting, then reset may hang forever. Even
without nvme_wait_freeze(), it is possible for timeout to happen during
reset work too in theory.

Actually for non-shutdown, it isn't necessary to freeze queue at all, and it
is enough to just quiesce queues to make hardware happy for recovery,
that has been part of my V2 patchset.

But it is really simple and clean to run the recovery(nvme_dev_disable and
reset_work) in one same context for avoiding this race, and the two
parts should have been done together for making our life easier, that is why
I was trying to work towards this direction.

Thanks,
Ming

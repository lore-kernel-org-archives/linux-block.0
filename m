Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f583aa94-578c-493d-f863-2fcc67e5d848@intel.com>
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
 <1494506343-28572-4-git-send-email-ulf.hansson@linaro.org> <f583aa94-578c-493d-f863-2fcc67e5d848@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 May 2017 16:05:20 +0200
Message-ID: <CAPDyKFqmvksL=bLR0FOfR=Q7B4TNa6oy0XZwFvkoT7nxLW4JBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mmc: core: Allow mmc block device to re-claim the host
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 12 May 2017 at 10:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/05/17 15:39, Ulf Hansson wrote:
>> The current mmc block device implementation is tricky when it comes to
>> claim and release of the host, while processing I/O requests. In principle
>> we need to claim the host at the first request entering the queue and then
>> we need to release the host, as soon as the queue becomes empty. This
>> complexity relates to the asynchronous request mechanism that the mmc block
>> device driver implements.
>>
>> For the legacy block interface that we currently implements, the above
>> issue can be addressed, as we can find out when the queue really becomes
>> empty.
>>
>> However, to find out whether the queue is empty, isn't really an applicable
>> method when using the new blk-mq interface, as requests are instead pushed
>> to us via the struct struct blk_mq_ops and its function pointers.
>
> That is not entirely true.  We can pull requests by running the queue i.e.
> blk_mq_run_hw_queues(q, false), returning BLK_MQ_RQ_QUEUE_BUSY and stopping
> / starting the queue as needed.

I am not sure how that would work. It doesn't sound very effective to
me, but I may be wrong.

>
> But, as I have written before, we could start with the most trivial
> implementation.  ->queue_rq() puts the requests in a list and then the
> thread removes them from the list.

That would work...

>
> That would be a good start because it would avoid having to deal with other
> issues at the same time.

...however this doesn't seem like a step in the direction we want to
take when porting to blkmq.

There will be an extra context switch for each an every request, won't there?

My point is, to be able to convert to blkmq, we must also avoid
performance regression - at leas as long as possible.

>
>>
>> Being able to support the asynchronous request method using the blk-mq
>> interface, means we have to allow the mmc block device driver to re-claim
>> the host from different tasks/contexts, as we may have > 1 request to
>> operate upon.
>>
>> Therefore, let's extend the mmc_claim_host() API to support reference
>> counting for the mmc block device.
>
> Aren't you overlooking the possibility that there are many block devices per
> host. i.e. one per eMMC internal partition.

Right now, yes you are right. I hope soon not. :-)

These internal eMMC partitions are today suffering from the similar
problems as we have for mmc ioctls. That means, requests are being I/O
scheduled separately for each internal partition. Meaning requests for
one partition could starve requests for another.

I really hope we can fix this in some way or the other. Probably
building upon Linus Walleij's series for fixing the problems for mmc
ioctls [1] is the way to go.

Then, when we have managed to fix these issues, I think my approach
for extending the mmc_claim_host() API could be a possible
intermediate step when trying to complete the blkmq port. Then we can
continue to try to remove/re-work the claim host lock altogether as an
optimization task.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-block/msg12677.html

Return-Path: <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 3/3] mmc: core: Allow mmc block device to re-claim the
 host
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
 <1494506343-28572-4-git-send-email-ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <f583aa94-578c-493d-f863-2fcc67e5d848@intel.com>
Date: Fri, 12 May 2017 11:36:06 +0300
MIME-Version: 1.0
In-Reply-To: <1494506343-28572-4-git-send-email-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/05/17 15:39, Ulf Hansson wrote:
> The current mmc block device implementation is tricky when it comes to
> claim and release of the host, while processing I/O requests. In principle
> we need to claim the host at the first request entering the queue and then
> we need to release the host, as soon as the queue becomes empty. This
> complexity relates to the asynchronous request mechanism that the mmc block
> device driver implements.
> 
> For the legacy block interface that we currently implements, the above
> issue can be addressed, as we can find out when the queue really becomes
> empty.
> 
> However, to find out whether the queue is empty, isn't really an applicable
> method when using the new blk-mq interface, as requests are instead pushed
> to us via the struct struct blk_mq_ops and its function pointers.

That is not entirely true.  We can pull requests by running the queue i.e.
blk_mq_run_hw_queues(q, false), returning BLK_MQ_RQ_QUEUE_BUSY and stopping
/ starting the queue as needed.

But, as I have written before, we could start with the most trivial
implementation.  ->queue_rq() puts the requests in a list and then the
thread removes them from the list.

That would be a good start because it would avoid having to deal with other
issues at the same time.

> 
> Being able to support the asynchronous request method using the blk-mq
> interface, means we have to allow the mmc block device driver to re-claim
> the host from different tasks/contexts, as we may have > 1 request to
> operate upon.
> 
> Therefore, let's extend the mmc_claim_host() API to support reference
> counting for the mmc block device.

Aren't you overlooking the possibility that there are many block devices per
host. i.e. one per eMMC internal partition.

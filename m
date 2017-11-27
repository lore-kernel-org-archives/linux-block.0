Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-14-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrA5NVQ2Ei7rf7o7N0iHCHLHkntObnPP9hjToKrLr-TAg@mail.gmail.com> <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Nov 2017 12:36:53 +0100
Message-ID: <CAPDyKFpnKXyhZ6GQymoLzcueUwzPLMP9hC+RuqrhCq3wEByF6Q@mail.gmail.com>
Subject: Re: [PATCH V14 13/24] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>,
	Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>,
	Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>,
	Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>,
	Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>,
	Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

+ Jens, Paolo

[...]

>>> +static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
>>> +                                 struct request *req)
>>> +{
>>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>> +       struct mmc_host *host = mq->card->host;
>>> +       struct request *prev_req = NULL;
>>> +       int err = 0;
>>> +
>>> +       mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
>>> +
>>> +       mqrq->brq.mrq.done = mmc_blk_mq_req_done;
>>> +
>>> +       mmc_pre_req(host, &mqrq->brq.mrq);
>>
>> To be honest, using a queue_depth of 64, puzzles me! According to my
>> understanding we should use a queue_depth of 2, in case the host
>> implements the ->pre|post_req() callbacks, else we should set it to 1.
>>
>> Although I may be missing some information about how to really use
>> this, because for example UBI (mtd) also uses 64 as queue depth!?
>>
>> My interpretation of the queue_depth is that the blkmq layer will use
>> it to understand the maximum number of request a block device are able
>> to operate on simultaneously (when having one HW queue), thus the
>> number of outstanding dispatched requests for the block evice driver,
>> may be as close as possible to the queue_depth, but never above. I may
>> be totally wrong about this. :-)
>
> For blk-mq, the queue_depth also defines the default nr_requests, which will
> be 2 times the queue_depth if there is an elevator.  The old nr_requests was
> 128, so setting 64 gives the same nr_requests as before.
>
> Otherwise the queue_depth is the size of the tag set.
>
> A very low queue_depth might be a problem for I/O schedulers like kyber
> which seems to try to limit the number of tags available for asynchronous
> requests.

You are probably right about this, but it makes no sense to me.

I don't understand why the queue_depth, stated by storage device, has
to do with the number of requests being available for I/O scheduling.

I have looped in Jens and Paolo (BFQ), perhaps they can help to spread
some more light on this.

>
>>
>> Anyway, then if using a queue_depth of 64, how will you make sure that
>> you not end up having > 1 requests being prepared at the same time
>> (not counting the one that may be in transfer)?
>
> We are currently single-threaded since every request goes through
> hctx->run_work when BLK_MQ_F_BLOCKING and nr_hw_queues == 1.  It might be
> worth adding a mutex to ensure that never changes.
>
> This point also answers some of the questions below, since there can be no
> parallel dispatches.
>

Yeah it does, again thanks!

[...]

Kind regards
Uffe

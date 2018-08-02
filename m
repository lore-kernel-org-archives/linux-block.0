Return-Path: <adrian.hunter@intel.com>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
To: Ming Lei <ming.lei@redhat.com>, Peter Geis <pgwipeout@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
 <20180728133654.GA8047@ming.t460p>
 <4284a9b0-2d90-3ffa-0172-9ec5d8f6f8af@gmail.com>
 <20180731013848.GA6740@ming.t460p>
 <da1eeaf2-e682-c0ed-d8fb-245770e0151c@gmail.com>
 <20180731162518.GA18025@ming.t460p>
 <8550a541-5cf6-f1ff-025e-67c6b404dd0d@intel.com>
 <20180802103353.GA6520@ming.t460p>
 <d6a3ea57-3f67-a63a-2b3d-8753071cb4b4@intel.com>
 <20180802110907.GC6520@ming.t460p>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <cfa5c337-12f3-e007-78c8-0d275246a37b@intel.com>
Date: Thu, 2 Aug 2018 14:23:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180802110907.GC6520@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/08/18 14:09, Ming Lei wrote:
> On Thu, Aug 02, 2018 at 01:47:29PM +0300, Adrian Hunter wrote:
>> On 02/08/18 13:33, Ming Lei wrote:
>>> On Thu, Aug 02, 2018 at 01:09:31PM +0300, Adrian Hunter wrote:
>>>> On 31/07/18 19:25, Ming Lei wrote:
>>>>> Hi Peter,
>>>>>
>>>>> On Tue, Jul 31, 2018 at 08:47:45AM -0400, Peter Geis wrote:
>>>>>> Good Morning,
>>>>>>
>>>>>> On 07/30/2018 09:38 PM, Ming Lei wrote:
>>>>>>> Hi Peter,
>>>>>>>
>>>>>>> Thanks for collecting the log.
>>>>>>>
>>>>>>> On Mon, Jul 30, 2018 at 02:55:42PM -0400, Peter Geis wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 07/28/2018 09:37 AM, Ming Lei wrote:
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> [   10.887209] systemd--112     0.n.1 2411122us : blk_mq_make_request: make
>>>>>>>> rq -1
>>>>>>>> [   10.890274] kworker/-98      0...1 2411506us : blk_mq_free_request:
>>>>>>>> complete: rq -1
>>>>>>>> [   10.893313] systemd--107     0...1 2412025us : blk_mq_make_request: make
>>>>>>>> rq -1
>>>>>>>> [   10.896354] systemd--107     0.... 2412323us : mmc_mq_queue_rq: queue rq
>>>>>>>> -1, 0
>>>>>>>> [   10.899388] systemd--107     0.... 2412327us :
>>>>>>>> blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
>>>>>>>> [   10.902463] (direxec-111     1...1 2413829us : blk_mq_make_request: make
>>>>>>>> rq -1
>>>>>>>> [   10.905513] systemd--114     1...1 2415159us : blk_mq_make_request: make
>>>>>>>> rq -1
>>>>>>>
>>>>>>> Above is the most interesting part in the log. MMC sets hw queue depth
>>>>>>> as 1, and you are using none scheduler, that means the max number of
>>>>>>> in-flight requests should be one, but the above log shows that there may
>>>>>>> be 3 in-flight requests.
>>>>>>
>>>>>> That's odd, I have CFQ set as the default, is something changing this during
>>>>>> boot?
>>>>>> CONFIG_CFQ_GROUP_IOSCHED=y
>>>>>> CONFIG_DEFAULT_IOSCHED="cfq"
>>>>>
>>>>> No, now mmc has been converted to blk-mq, and the default mq io sched
>>>>> should have been mq-deadline for mmc, but not sure why it is none in
>>>>> your case.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> That seems really weird, but it shouldn't be related with my two patches,
>>>>>>> which won't change the tag allocation behaviour at all. However, what matters
>>>>>>> may be that the patch speeds up the request dispatch. Maybe one bug
>>>>>>> in lib/sbitmap.c block/blk-mq-tag.c.
>>>>>>>
>>>>>>> Unfortunately rq->tag wasn't shown in the log because I forget to dump
>>>>>>> it in the debug patch, so could you apply the following new debug patch and
>>>>>>> provide us the log again? BTW, please attach the ftrace log in the reply
>>>>>>> mail directly, then it may be parsed/looked easily.
>>>>>>
>>>>>> I have resynced to the latest linux-next and applied your new patch.
>>>>>> The log is attached.
>>>>>>
>>>>>> Of note, it took several boots this time before it would progress to where I
>>>>>> could grab the log.
>>>>>> Instead it was blocking the moment RW was requested.
>>>>>> Also of note, it seems only the emmc is affected, the SD card (mmcblk2) does
>>>>>> not trigger any errors.
>>>>>
>>>>> >From the log you captured, seems there are three requests(33, 34, 60) blocked,
>>>>> which should have been inside mmc, but still need to confirm, could you apply the
>>>>> following one-line patch against the last debug patch and collect the log again?
>>>>>
>>>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>>>> index d35f265cd5e0..ac2ffc5a8ed4 100644
>>>>> --- a/drivers/mmc/core/queue.c
>>>>> +++ b/drivers/mmc/core/queue.c
>>>>> @@ -321,6 +321,8 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>>                                    !host->hold_retune;
>>>>>         }
>>>>>
>>>>> +       if (blk_queue_debug(q))
>>>>> +               trace_printk("mmc before issue rq %d %d\n", req->internal_tag, req->tag);
>>>>>         blk_mq_start_request(req);
>>>>>
>>>>>         issued = mmc_blk_mq_issue_rq(mq, req);
>>>>>
>>>>>
>>>>> Also see comments in mmc_mq_queue_rq():
>>>>>
>>>>> 	/*
>>>>> 	 * We use BLK_MQ_F_BLOCKING and have only 1 hardware queue, which means requests
>>>>> 	 * will not be dispatched in parallel.
>>>>> 	 */
>>>>>
>>>>> which isn't correct, given blk-mq has multiple sw queue and mmc sets the queue depth
>>>>> as > 1, and requests may be dispatched to the unique hw queue in parallel.
>>>>>
>>>>> Adrian, Ulf Hansson and anyone, could you take a look at the warning of WARN_ON(host->cmd)
>>>>> in sdhci_send_command()? Seems you only allow to queue one command, but not sure how you
>>>>> guarantee that.
>>>>
>>>> We didn't guarantee it, but it didn't happen before "blk-mq: issue directly
>>>> if hw queue isn't busy in case of 'none'".
>>>
>>> OK, thanks for clarifying that, and as I mentioned what matters is the
>>> timing change.
>>>
>>>> We did consider adding a mutex, refer
>>>> https://lore.kernel.org/lkml/CAPDyKFr8tiJXSL-weQjGJ3DfRrfv8ZAFY8=ZECLNgSe_43S8Rw@mail.gmail.com/
>>>>
>>>> However the following might do, do you think?
>>>
>>> If dispatch in parallel isn't supported, just wondering why not set hw
>>> queue depth as 1? That way should be simple to fix this issue.
>>
>> First, it isn't 1.  It is 2 for devices with no command queue because we
>> prepare a request while the previous one completes.  Otherwise it is the
>> command queue depth.
> 
> Could you share where the prepare function is? What does the prepare
> function do?

The prepare function is mmc_pre_req().

The prepare function is to let the host controller DMA map the request.  On
some architectures that is sufficiently slow that there is a significant
performance benefit to doing that in advance.

> 
> If the device has no command queue, I understand there is only one
> command which can be queued/issued to controller. If that is true, the queue
> depth should be 1.
> 
>>
>> Secondly, we expect an elevator to be used, and the elevator needs a decent
>> number of requests to work with, and the default number of requests is
>> currently tied to the queue depth.
> 
> There are two queue depth, we are talking about hw queue depth, which
> means how many commands the controller can queue at most. The other one
> is scheduler queue depth, which is 2 times of hw queue depth at default.
> 
> We may improve this case a bit, now if hw queue depth is 1, the scheduler
> queue depth is set as 2 at default, but this default depth isn't good, since
> legacy sets scheduler queue depth as 128, even though the minimized
> depth is 4.
> 
>>
>>>
>>>>
>>>>
>>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>>> index 648eb6743ed5..6edffeed9953 100644
>>>> --- a/drivers/mmc/core/queue.c
>>>> +++ b/drivers/mmc/core/queue.c
>>>> @@ -238,10 +238,6 @@ static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
>>>>  	mmc_exit_request(mq->queue, req);
>>>>  }
>>>>  
>>>> -/*
>>>> - * We use BLK_MQ_F_BLOCKING and have only 1 hardware queue, which means requests
>>>> - * will not be dispatched in parallel.
>>>> - */
>>>>  static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>  				    const struct blk_mq_queue_data *bd)
>>>>  {
>>>> @@ -264,7 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>  
>>>>  	spin_lock_irq(q->queue_lock);
>>>>  
>>>> -	if (mq->recovery_needed) {
>>>> +	if (mq->recovery_needed || mq->busy) {
>>>>  		spin_unlock_irq(q->queue_lock);
>>>>  		return BLK_STS_RESOURCE;
>>>>  	}
>>>> @@ -291,6 +287,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>  		break;
>>>>  	}
>>>>  
>>>> +	/* Parallel dispatch of requests is not supported at the moment */
>>>> +	mq->busy = true;
>>>> +
>>>>  	mq->in_flight[issue_type] += 1;
>>>>  	get_card = (mmc_tot_in_flight(mq) == 1);
>>>>  	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
>>>> @@ -333,9 +332,12 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>  		mq->in_flight[issue_type] -= 1;
>>>>  		if (mmc_tot_in_flight(mq) == 0)
>>>>  			put_card = true;
>>>> +		mq->busy = false;
>>>>  		spin_unlock_irq(q->queue_lock);
>>>>  		if (put_card)
>>>>  			mmc_put_card(card, &mq->ctx);
>>>> +	} else {
>>>> +		WRITE_ONCE(mq->busy, false);
>>>>  	}
>>>>  
>>>>  	return ret;
>>>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
>>>> index 17e59d50b496..9bf3c9245075 100644
>>>> --- a/drivers/mmc/core/queue.h
>>>> +++ b/drivers/mmc/core/queue.h
>>>> @@ -81,6 +81,7 @@ struct mmc_queue {
>>>>  	unsigned int		cqe_busy;
>>>>  #define MMC_CQE_DCMD_BUSY	BIT(0)
>>>>  #define MMC_CQE_QUEUE_FULL	BIT(1)
>>>> +	bool			busy;
>>>>  	bool			use_cqe;
>>>>  	bool			recovery_needed;
>>>>  	bool			in_recovery;
>>>
>>> Sorry, I am not familiar with mmc code, so can't comment on the above
>>> patch.
>>
>> Right, but if we return BLK_STS_RESOURCE to avoid parallel dispatch, do we
>> need to worry about ensuring the queue gets run later?
> 
> Yeah, blk-mq can cover that.

Peter, could you test if the diff I sent also fixes your original regression?

Return-Path: <pgwipeout@gmail.com>
Return-Path: <pgwipeout@gmail.com>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
From: Peter Geis <pgwipeout@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ming Lei <ming.lei@redhat.com>
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
 <cfa5c337-12f3-e007-78c8-0d275246a37b@intel.com>
 <4e545134-ec7a-8097-edb9-a6d1f631b4bf@gmail.com>
Message-ID: <c383c852-83aa-8ae3-442c-9ef446261289@gmail.com>
Date: Fri, 3 Aug 2018 21:46:10 -0400
MIME-Version: 1.0
In-Reply-To: <4e545134-ec7a-8097-edb9-a6d1f631b4bf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>




>>>>>>> Adrian, Ulf Hansson and anyone, could you take a look at the 
>>>>>>> warning of WARN_ON(host->cmd)
>>>>>>> in sdhci_send_command()? Seems you only allow to queue one 
>>>>>>> command, but not sure how you
>>>>>>> guarantee that.
>>>>>>
>>>>>> We didn't guarantee it, but it didn't happen before "blk-mq: issue 
>>>>>> directly
>>>>>> if hw queue isn't busy in case of 'none'".
>>>>>
>>>>> OK, thanks for clarifying that, and as I mentioned what matters is the
>>>>> timing change.
>>>>>
>>>>>> We did consider adding a mutex, refer
>>>>>> https://lore.kernel.org/lkml/CAPDyKFr8tiJXSL-weQjGJ3DfRrfv8ZAFY8=ZECLNgSe_43S8Rw@mail.gmail.com/ 
>>>>>>
>>>>>>
>>>>>> However the following might do, do you think?
>>>>>
>>>>> If dispatch in parallel isn't supported, just wondering why not set hw
>>>>> queue depth as 1? That way should be simple to fix this issue.
>>>>
>>>> First, it isn't 1.  It is 2 for devices with no command queue 
>>>> because we
>>>> prepare a request while the previous one completes.  Otherwise it is 
>>>> the
>>>> command queue depth.
>>>
>>> Could you share where the prepare function is? What does the prepare
>>> function do?
>>
>> The prepare function is mmc_pre_req().
>>
>> The prepare function is to let the host controller DMA map the 
>> request.  On
>> some architectures that is sufficiently slow that there is a significant
>> performance benefit to doing that in advance.
>>
>>>
>>> If the device has no command queue, I understand there is only one
>>> command which can be queued/issued to controller. If that is true, 
>>> the queue
>>> depth should be 1.
>>>
>>>>
>>>> Secondly, we expect an elevator to be used, and the elevator needs a 
>>>> decent
>>>> number of requests to work with, and the default number of requests is
>>>> currently tied to the queue depth.
>>>
>>> There are two queue depth, we are talking about hw queue depth, which
>>> means how many commands the controller can queue at most. The other one
>>> is scheduler queue depth, which is 2 times of hw queue depth at default.
>>>
>>> We may improve this case a bit, now if hw queue depth is 1, the 
>>> scheduler
>>> queue depth is set as 2 at default, but this default depth isn't 
>>> good, since
>>> legacy sets scheduler queue depth as 128, even though the minimized
>>> depth is 4.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>>>>> index 648eb6743ed5..6edffeed9953 100644
>>>>>> --- a/drivers/mmc/core/queue.c
>>>>>> +++ b/drivers/mmc/core/queue.c
>>>>>> @@ -238,10 +238,6 @@ static void mmc_mq_exit_request(struct 
>>>>>> blk_mq_tag_set *set, struct request *req,
>>>>>>       mmc_exit_request(mq->queue, req);
>>>>>>   }
>>>>>> -/*
>>>>>> - * We use BLK_MQ_F_BLOCKING and have only 1 hardware queue, which 
>>>>>> means requests
>>>>>> - * will not be dispatched in parallel.
>>>>>> - */
>>>>>>   static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>>>                       const struct blk_mq_queue_data *bd)
>>>>>>   {
>>>>>> @@ -264,7 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct 
>>>>>> blk_mq_hw_ctx *hctx,
>>>>>>       spin_lock_irq(q->queue_lock);
>>>>>> -    if (mq->recovery_needed) {
>>>>>> +    if (mq->recovery_needed || mq->busy) {
>>>>>>           spin_unlock_irq(q->queue_lock);
>>>>>>           return BLK_STS_RESOURCE;
>>>>>>       }
>>>>>> @@ -291,6 +287,9 @@ static blk_status_t mmc_mq_queue_rq(struct 
>>>>>> blk_mq_hw_ctx *hctx,
>>>>>>           break;
>>>>>>       }
>>>>>> +    /* Parallel dispatch of requests is not supported at the 
>>>>>> moment */
>>>>>> +    mq->busy = true;
>>>>>> +
>>>>>>       mq->in_flight[issue_type] += 1;
>>>>>>       get_card = (mmc_tot_in_flight(mq) == 1);
>>>>>>       cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
>>>>>> @@ -333,9 +332,12 @@ static blk_status_t mmc_mq_queue_rq(struct 
>>>>>> blk_mq_hw_ctx *hctx,
>>>>>>           mq->in_flight[issue_type] -= 1;
>>>>>>           if (mmc_tot_in_flight(mq) == 0)
>>>>>>               put_card = true;
>>>>>> +        mq->busy = false;
>>>>>>           spin_unlock_irq(q->queue_lock);
>>>>>>           if (put_card)
>>>>>>               mmc_put_card(card, &mq->ctx);
>>>>>> +    } else {
>>>>>> +        WRITE_ONCE(mq->busy, false);
>>>>>>       }
>>>>>>       return ret;
>>>>>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
>>>>>> index 17e59d50b496..9bf3c9245075 100644
>>>>>> --- a/drivers/mmc/core/queue.h
>>>>>> +++ b/drivers/mmc/core/queue.h
>>>>>> @@ -81,6 +81,7 @@ struct mmc_queue {
>>>>>>       unsigned int        cqe_busy;
>>>>>>   #define MMC_CQE_DCMD_BUSY    BIT(0)
>>>>>>   #define MMC_CQE_QUEUE_FULL    BIT(1)
>>>>>> +    bool            busy;
>>>>>>       bool            use_cqe;
>>>>>>       bool            recovery_needed;
>>>>>>       bool            in_recovery;
>>>>>
>>>>> Sorry, I am not familiar with mmc code, so can't comment on the above
>>>>> patch.
>>>>
>>>> Right, but if we return BLK_STS_RESOURCE to avoid parallel dispatch, 
>>>> do we
>>>> need to worry about ensuring the queue gets run later?
>>>
>>> Yeah, blk-mq can cover that.
>>
>> Peter, could you test if the diff I sent also fixes your original 
>> regression?
>>
> 
> Good Morning,
> I apologize for the delay in returning the log with the latest debug 
> patch, but I encountered a new bug with the io scheduler enabled that I 
> was trying to work around.
> Apparently with the io scheduler enabled, while it got rid of the 
> warnings, I was still getting cache corruption after a period of time.
> This manifested itself as ENOMEM errors whenever accessing files that 
> had been recently written, and those files showed up as ??????? when ls 
> -al was run.
> After a reboot those files were available without issue, until written 
> again.
> 
> I have attached the log from the latest test.
> 
> Break.
> 
> Adrian,
> Your patch appears to have corrected the errors, and it boots without 
> issue.
> I will have to run an extended test to ensure the bug I just mentioned 
> above does not manifest either.
> 
> Thanks everyone!

Adrian,

Long term testing appears to show this bug as resolved by your patch.

If you submit it, please respond with the commit and I'll attach it to 
the bug report as the resolution.

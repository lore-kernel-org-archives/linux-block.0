Return-Path: <pgwipeout@gmail.com>
Return-Path: <pgwipeout@gmail.com>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
To: Ming Lei <ming.lei@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
 <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
 <20180728133654.GA8047@ming.t460p>
 <4284a9b0-2d90-3ffa-0172-9ec5d8f6f8af@gmail.com>
 <20180731013848.GA6740@ming.t460p>
 <da1eeaf2-e682-c0ed-d8fb-245770e0151c@gmail.com>
 <20180731162518.GA18025@ming.t460p>
From: Peter Geis <pgwipeout@gmail.com>
Message-ID: <70ded6be-165d-8bca-bf50-5bda2b9c120a@gmail.com>
Date: Tue, 31 Jul 2018 13:51:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180731162518.GA18025@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 07/31/2018 12:25 PM, Ming Lei wrote:
> Hi Peter,
> 
> On Tue, Jul 31, 2018 at 08:47:45AM -0400, Peter Geis wrote:
>> Good Morning,
>>
>> On 07/30/2018 09:38 PM, Ming Lei wrote:
>>> Hi Peter,
>>>
>>> Thanks for collecting the log.
>>>
>>> On Mon, Jul 30, 2018 at 02:55:42PM -0400, Peter Geis wrote:
>>>>
>>>>
>>>> On 07/28/2018 09:37 AM, Ming Lei wrote:
>>>
>>> ...
>>>
>>>> [   10.887209] systemd--112     0.n.1 2411122us : blk_mq_make_request: make
>>>> rq -1
>>>> [   10.890274] kworker/-98      0...1 2411506us : blk_mq_free_request:
>>>> complete: rq -1
>>>> [   10.893313] systemd--107     0...1 2412025us : blk_mq_make_request: make
>>>> rq -1
>>>> [   10.896354] systemd--107     0.... 2412323us : mmc_mq_queue_rq: queue rq
>>>> -1, 0
>>>> [   10.899388] systemd--107     0.... 2412327us :
>>>> blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
>>>> [   10.902463] (direxec-111     1...1 2413829us : blk_mq_make_request: make
>>>> rq -1
>>>> [   10.905513] systemd--114     1...1 2415159us : blk_mq_make_request: make
>>>> rq -1
>>>
>>> Above is the most interesting part in the log. MMC sets hw queue depth
>>> as 1, and you are using none scheduler, that means the max number of
>>> in-flight requests should be one, but the above log shows that there may
>>> be 3 in-flight requests.
>>
>> That's odd, I have CFQ set as the default, is something changing this during
>> boot?
>> CONFIG_CFQ_GROUP_IOSCHED=y
>> CONFIG_DEFAULT_IOSCHED="cfq"
> 
> No, now mmc has been converted to blk-mq, and the default mq io sched
> should have been mq-deadline for mmc, but not sure why it is none in
> your case.

Thanks, you just answered the question.
It would be helpful if CONFIG_MQ_IOSCHED_DEADLINE=y is set.

Would you like to continue tracking down why if that is unset or the 
module is unavailable the whole thing breaks?

> 
>>
>>>
>>> That seems really weird, but it shouldn't be related with my two patches,
>>> which won't change the tag allocation behaviour at all. However, what matters
>>> may be that the patch speeds up the request dispatch. Maybe one bug
>>> in lib/sbitmap.c block/blk-mq-tag.c.
>>>
>>> Unfortunately rq->tag wasn't shown in the log because I forget to dump
>>> it in the debug patch, so could you apply the following new debug patch and
>>> provide us the log again? BTW, please attach the ftrace log in the reply
>>> mail directly, then it may be parsed/looked easily.
>>
>> I have resynced to the latest linux-next and applied your new patch.
>> The log is attached.
>>
>> Of note, it took several boots this time before it would progress to where I
>> could grab the log.
>> Instead it was blocking the moment RW was requested.
>> Also of note, it seems only the emmc is affected, the SD card (mmcblk2) does
>> not trigger any errors.
> 
>  From the log you captured, seems there are three requests(33, 34, 60) blocked,
> which should have been inside mmc, but still need to confirm, could you apply the
> following one-line patch against the last debug patch and collect the log again?
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d35f265cd5e0..ac2ffc5a8ed4 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -321,6 +321,8 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                     !host->hold_retune;
>          }
> 
> +       if (blk_queue_debug(q))
> +               trace_printk("mmc before issue rq %d %d\n", req->internal_tag, req->tag);
>          blk_mq_start_request(req);
> 
>          issued = mmc_blk_mq_issue_rq(mq, req);
> 
> 
> Also see comments in mmc_mq_queue_rq():
> 
> 	/*
> 	 * We use BLK_MQ_F_BLOCKING and have only 1 hardware queue, which means requests
> 	 * will not be dispatched in parallel.
> 	 */
> 
> which isn't correct, given blk-mq has multiple sw queue and mmc sets the queue depth
> as > 1, and requests may be dispatched to the unique hw queue in parallel.
> 
> Adrian, Ulf Hansson and anyone, could you take a look at the warning of WARN_ON(host->cmd)
> in sdhci_send_command()? Seems you only allow to queue one command, but not sure how you
> guarantee that.
> 
> 
> Thanks,
> Ming
> 

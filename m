Return-Path: <axboe@kernel.dk>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
Date: Thu, 27 Jul 2017 10:26:29 -0600
MIME-Version: 1.0
In-Reply-To: <1501166846.2516.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/27/2017 08:47 AM, Bart Van Assche wrote:
> On Thu, 2017-07-27 at 08:02 -0600, Jens Axboe wrote:
>> The bug looks like SCSI running the queue inline from IRQ
>> context, that's not a good idea. Can you confirm the below works for
>> you?
>>
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index f6097b89d5d3..78740ebf966c 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -497,7 +497,7 @@ static void scsi_run_queue(struct request_queue *q)
>>  		scsi_starved_list_run(sdev->host);
>>  
>>  	if (q->mq_ops)
>> -		blk_mq_run_hw_queues(q, false);
>> +		blk_mq_run_hw_queues(q, true);
>>  	else
>>  		blk_run_queue(q);
>>  }
> 
> Hello Jens,
> 
> scsi_run_queue() works fine if no scheduler is configured. Additionally, that
> code predates the introduction of blk-mq I/O schedulers. I think it is
> nontrivial for block driver authors to figure out that a queue has to be run
> from process context if a scheduler has been configured that does not support
> to be run from interrupt context.

No it doesn't, you could never run the queue from interrupt context with
async == false. So I don't think that's confusing at all, you should
always be aware of the context.

> How about adding WARN_ON_ONCE(in_interrupt()) to
> blk_mq_start_hw_queue() or replacing the above patch by the following:

No, I hate having dependencies like that, because they always just catch
one of them. Looks like the IPR path that hits this should just offload
to a workqueue or similar, you don't have to make any scsi_run_queue()
async.

-- 
Jens Axboe

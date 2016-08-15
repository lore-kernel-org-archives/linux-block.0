Return-Path: <axboe@kernel.dk>
Subject: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Bart Van Assche <bart.vanassche@sandisk.com>,
 Jinpu Wang <jinpu.wang@profitbricks.com>, linux-block@vger.kernel.org
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
 <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3a22a49b-9382-710e-028e-f64a9b6f5a27@kernel.dk>
Date: Mon, 15 Aug 2016 11:15:34 -0600
MIME-Version: 1.0
In-Reply-To: <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/15/2016 09:53 AM, Bart Van Assche wrote:
> On 08/02/2016 10:21 AM, Jens Axboe wrote:
>> On 08/02/2016 06:58 AM, Jinpu Wang wrote:
>>> Hi Jens,
>>>
>>> I found in blk_mq_register_disk, we blk_mq_disable_hotplug which in
>>> turn mutex_lock(&all_q_mutex);
>>>   queue_for_each_hw_ctx(q, hctx, i) {
>>>                 ret = blk_mq_register_hctx(hctx);
>>>                 if (ret)
>>>                         break; /// if about error out, we will call
>>> unregister below
>>>         }
>>>
>>>         if (ret)
>>>                 blk_mq_unregister_disk(disk);
>>>
>>> In blk_mq_unregister_disk, we will try to disable_hotplug again, which
>>> leads to dead lock.
>>>
>>> Did I miss anything?
>>
>> Nope, your analysis looks correct. This should fix it:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=6316338a94b2319abe9d3790eb9cdc56ef81ac1a
>
> Hi Jens,
>
> Will that patch be included in stable kernels? I just encountered a
> deadlock with kernel v4.7 that looks similar.

Sure, we can push to stable, it's a pretty straight forward patch. Can
you reproduce at will? Would be nice to know if it hit the error case,
which is where it would hang.

-- 
Jens Axboe

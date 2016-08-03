Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Wed, 3 Aug 2016 10:02:37 +0200
Message-ID: <CAMGffE=em4JAZVX0aW1vJhiy975hPg_gT47=FCQxWpc6SGUMuA@mail.gmail.com>
Subject: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 2, 2016 at 7:21 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 08/02/2016 06:58 AM, Jinpu Wang wrote:
>>
>> Hi Jens,
>>
>> I found in blk_mq_register_disk, we blk_mq_disable_hotplug which in
>> turn mutex_lock(&all_q_mutex);
>>   queue_for_each_hw_ctx(q, hctx, i) {
>>                 ret =3D blk_mq_register_hctx(hctx);
>>                 if (ret)
>>                         break; /// if about error out, we will call
>> unregister below
>>         }
>>
>>         if (ret)
>>                 blk_mq_unregister_disk(disk);
>>
>> In blk_mq_unregister_disk, we will try to disable_hotplug again, which
>> leads to dead lock.
>>
>> Did I miss anything?
>
>
> Nope, your analysis looks correct. This should fix it:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3D6316338a=
94b2319abe9d3790eb9cdc56ef81ac1a
>
>
> --
> Jens Axboe
>
Thanks Jens, looks good to me!


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Best Regards,

Jack Wang

Linux Kernel Developer Storage
ProfitBricks GmbH  The IaaS-Company.

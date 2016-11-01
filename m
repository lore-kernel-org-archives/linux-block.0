Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH 4/7] lightnvm: drop reserve and release LUN callbacks
To: Jens Axboe <axboe@kernel.dk>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <jg@lightnvm.io>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
 <1477591299-26504-5-git-send-email-javier@cnexlabs.com>
 <c22e65f3-5570-6042-a434-f84bf4db3c5a@lightnvm.io>
 <9fc12698-de1b-b535-f8c4-d283a29a6099@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <846de705-2c2f-c636-39bd-e0ffc877ecaa@lightnvm.io>
Date: Tue, 1 Nov 2016 01:38:23 +0100
MIME-Version: 1.0
In-Reply-To: <9fc12698-de1b-b535-f8c4-d283a29a6099@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/31/2016 09:22 PM, Jens Axboe wrote:
> On 10/31/2016 07:08 AM, Matias Bjørling wrote:
>> On 10/27/2016 08:01 PM, Javier González wrote:
>>> From: Javier González <javier@javigon.com>
>>>
>>> On target initialization, targets use callbacks to the media manager to
>>> configure the LUNs they use. In order to simplify the flow, drop this
>>> callbacks and manage everything internally on the media manager.
>>>
>>> By making use of the newly introduce LUN management structure, the media
>>> manager knows which target exclusively owns each target and can
>>> therefore allocate and free all the necessary structures before
>>> initializing the target. Not exclusively owned LUNs belong to the media
>>> manager in any case.
>>>
>>> Adapt rrpc to not use the reserve_lun/release_lun callback functions.
>>>
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>  drivers/lightnvm/gennvm.c | 68
>>> ++++++++++++++++++++++++++++++++++++-----------
>>>  drivers/lightnvm/rrpc.c   | 12 +--------
>>>  include/linux/lightnvm.h  |  5 +---
>>>  3 files changed, 55 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
>>> index 8bff725..a340685 100644
>>> --- a/drivers/lightnvm/gennvm.c
>>> +++ b/drivers/lightnvm/gennvm.c
>>> @@ -35,6 +35,50 @@ static const struct block_device_operations
>>> gen_fops = {
>>>      .owner        = THIS_MODULE,
>>>  };
>>>
>>> +static int gen_reserve_luns(struct nvm_dev *dev, int lun_begin, int
>>> lun_end,
>>> +                struct nvm_target *t)
>>> +{
>>> +    struct gen_dev *gn = dev->mp;
>>> +    struct gen_lun *lun;
>>> +    int i;
>>> +
>>> +    for (i = lun_begin; i <= lun_end; i++) {
>>> +        if (test_and_set_bit(i, dev->lun_map)) {
>>> +            pr_err("gennvm: lun %d is already allocated\n", i);
>>> +            goto fail;
>>> +        }
>>> +
>>> +        lun = &gn->luns[i];
>>> +        lun->tgt = t;
>>> +        lun->vlun.priv = lun->mgmt;
>>> +    }
>>> +
>>> +    return 0;
>>> +fail:
>>> +    while (--i > lun_begin)
>>> +        clear_bit(i, dev->lun_map);
>>> +
>>> +    return 1;
>>
>> return -EINVAL;
> 
> -EBUSY?
> 
>> Lad os lige snakke lidt om dette her senere også :)
> 
> And probably keep the public emails in English :-)
> 

Haha, will do. Good to spice up the mailing list a bit :)

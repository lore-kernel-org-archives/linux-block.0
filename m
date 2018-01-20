Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5a072f16-d82a-a25c-2ee9-fa75ac096a01@kernel.dk>
References: <20180110163633.GA24230@bogon.didichuxing.com> <CAA70yB5Ai+iG95=bVuE5Gaw0=n9xmbm0T5P2nYhDabnMVWO_XA@mail.gmail.com>
 <5a072f16-d82a-a25c-2ee9-fa75ac096a01@kernel.dk>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 20 Jan 2018 08:09:24 +0800
Message-ID: <CAA70yB5Xw09S-vfXnx-PHi5Pphid+VS_ZFacpQPDMuBCWAtiYA@mail.gmail.com>
Subject: Re: [PATCH v2] bdi: show error log when fail to create bdi debugfs entry
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, Bart Van Assche <Bart.VanAssche@wdc.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2018-01-20 3:54 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
> On 1/19/18 10:36 AM, weiping zhang wrote:
>> 2018-01-11 0:36 GMT+08:00 weiping zhang <zhangweiping@didichuxing.com>:
>>> bdi debugfs dir/file may create fail, add error log here.
>>>
>>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>>> ---
>>> V1->V2:
>>> fix indentation and make log message more clear
>>>
>>>  mm/backing-dev.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>> index b5f940c..0a49665 100644
>>> --- a/mm/backing-dev.c
>>> +++ b/mm/backing-dev.c
>>> @@ -885,7 +885,9 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>>>         cgwb_bdi_register(bdi);
>>>         bdi->dev = dev;
>>>
>>> -       bdi_debug_register(bdi, dev_name(dev));
>>> +       if (bdi_debug_register(bdi, dev_name(dev)))
>>> +               pr_warn("blkdev %s: creation of bdi debugfs entries failed.\n",
>>> +                       dev_name(dev));
>>>         set_bit(WB_registered, &bdi->wb.state);
>>>
>>>         spin_lock_bh(&bdi_lock);
>>> --
>>
>> Hi Jens,
>>
>> madam has no permission to create debuts entry if SELINUX is enable at
>> Fedora and Centos,
>> and we have revert 6d0e4827b72 Revert "bdi: add error handle for
>> bdi_debug_register", that is to say
>> bdi debugfs is not the key component of block device, this patch just
>> add warning log.
>
> Have we fixed the case where we know it will trigger?

The reason is that mdadm has no permission to create dir/file under
/sys/kernel/debug/
, I think we can solve it in two possible ways.

1.Add proper SELINUX policy to allow mdadm create
/sys/kernel/debug/bdi/xxx, but not
every user add this allowance, so kernel show a warning for this case.

2.Split mdadm into 2 part, Firstly, user proccess mdadm trigger a
kwork and wait a event
done, secondly kwork will create gendisk)and then wake up event. But
it is more likely a
hack, and it may break SELINUX mechanism, so I give up this way.
https://marc.info/?l=linux-mm&m=151456540928231&w=2

> --
> Jens Axboe
>

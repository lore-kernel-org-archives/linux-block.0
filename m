Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1515600645.2745.2.camel@wdc.com>
References: <20180110151822.GA19852@localhost.didichuxing.com> <1515600645.2745.2.camel@wdc.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 11 Jan 2018 00:29:15 +0800
Message-ID: <CAA70yB4ifEdYi+niSKVAzRc26=ubDY+gfrOj-akwoXCxbfT6ig@mail.gmail.com>
Subject: Re: [PATCH] bdi: show error log when fail to create bdi debugfs entry
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "zhangweiping@didichuxing.com" <zhangweiping@didichuxing.com>, "jack@suse.cz" <jack@suse.cz>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2018-01-11 0:10 GMT+08:00 Bart Van Assche <Bart.VanAssche@wdc.com>:
> On Wed, 2018-01-10 at 23:18 +0800, weiping zhang wrote:
>> bdi debugfs dir/file may create fail, add error log here.
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> ---
>>  mm/backing-dev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index b5f940c..9117c21 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -885,7 +885,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>>       cgwb_bdi_register(bdi);
>>       bdi->dev = dev;
>>
>> -     bdi_debug_register(bdi, dev_name(dev));
>> +      if (bdi_debug_register(bdi, dev_name(dev)))
>> +              pr_warn("blkdev %s create bdi debugfs failed\n", dev_name(dev));
>>       set_bit(WB_registered, &bdi->wb.state);
>>
>>       spin_lock_bh(&bdi_lock);
>
> The indentation of the if-statement is inconsistent. Have you verified this
> patch with checkpatch before submitting it?
>
> Additionally, the error message is hard to understand. Please make it more clear,
> e.g. as follows: "%s: creation of bdi debugfs entries failed.\n".
>
OK, fix them at V2, thanks a lot
> Thanks,
>
> Bart.

Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <C7E01FF1-7311-449B-A410-E5F5C7369B9A@linaro.org>
References: <20170830184211.12471-1-bart.vanassche@wdc.com>
 <20170830184211.12471-4-bart.vanassche@wdc.com> <C7E01FF1-7311-449B-A410-E5F5C7369B9A@linaro.org>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 2 Sep 2017 01:37:38 +0800
Message-ID: <CAA70yB7tzAmCmxjc=JmcQt8xZ7xMbYoQKsfkxU+uUvtBt5SUEA@mail.gmail.com>
Subject: Re: [PATCH 3/5] bfq: Check kstrtoul() return value
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-09-02 1:14 GMT+08:00 Paolo Valente <paolo.valente@linaro.org>:
>
>> Il giorno 30 ago 2017, alle ore 20:42, Bart Van Assche <bart.vanassche@wdc.com> ha scritto:
>>
>> Make sysfs writes fail for invalid numbers instead of storing
>> uninitialized data copied from the stack. This patch removes
>> all uninitialized_var() occurrences from the BFQ source code.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Paolo Valente <paolo.valente@linaro.org>
>
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>

Hi Bart,

how about using simple_strtoul  which was used in cfq/mq-iosched.c
*var = simple_strtoul(p, &p, 10);

if invalid string came from sysfs, this function just return 0,
and there are validations after every calling bfq_var_store.

Thanks

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: add verifier for cmdline partition
To: Caizhiyong <caizhiyong@hisilicon.com>, Wang YanQing <udknight@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiangheng <jiangheng@hisilicon.com>
References: <20180503111748.GA904@udknight>
 <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3267b3ec-0500-5772-949e-49570395085d@kernel.dk>
Date: Fri, 4 May 2018 08:20:08 -0600
MIME-Version: 1.0
In-Reply-To: <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/4/18 1:07 AM, Caizhiyong wrote:
>> -----Original Message-----
>> From: Wang YanQing [mailto:udknight@gmail.com]
>> Sent: Thursday, May 03, 2018 7:18 PM
>> To: axboe@kernel.dk
>> Cc: gregkh@linuxfoundation.org; pombredanne@nexb.com;
>> tglx@linutronix.de; Caizhiyong <caizhiyong@hisilicon.com>; linux-
>> block@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] block: add verifier for cmdline partition
>>
>> I meet strange filesystem corruption issue recently, the reason
>> is there are overlaps partitions in cmdline partition argument.
>>
>> This patch add verifier for cmdline partition, then if there are
>> overlaps partitions, cmdline_partition will return error and log
>> a error message.
>>
> 
> Partition overlap was intentionally designed in this cmdline partition.
> some time, the cmdline partition save raw data(not filesystem), the overlap makes data  access very convenient.
> 
> reference  http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html

Might make sense to warn about it at least, it can be very surprising if
it happens inadvertently.

-- 
Jens Axboe

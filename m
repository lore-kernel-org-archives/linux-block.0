Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block,bfq: Disable writeback throttling
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <0ab03bba5e4abc062712e230e942cd18@natalenko.name>
Date: Tue, 19 Sep 2017 09:03:38 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>
Message-Id: <074F0872-7B5C-450C-835D-8869DE1F17B4@linaro.org>
References: <0ab03bba5e4abc062712e230e942cd18@natalenko.name>
To: oleksandr@natalenko.name
List-ID: <linux-block@vger.kernel.org>


> Il giorno 14 set 2017, alle ore 09:14, oleksandr@natalenko.name ha scritto:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
>> Similarly to CFQ, BFQ has its write-throttling heuristics, and it
>> is better not to combine them with further write-throttling
>> heuristics of a different nature.
>> So this commit disables write-back throttling for a device if BFQ
>> is used as I/O scheduler for that device.
>> Signed-off-by: Luca Miccio <lucmiccio@gmail.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-iosched.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)

Hi Jens,
did you have time to look into this?

Thanks,
Paolo

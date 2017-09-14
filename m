Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 14 Sep 2017 09:14:54 +0200
From: oleksandr@natalenko.name
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Miccio <lucmiccio@gmail.com>
Subject: Re: [PATCH] block,bfq: Disable writeback throttling
Message-ID: <0ab03bba5e4abc062712e230e942cd18@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

> Similarly to CFQ, BFQ has its write-throttling heuristics, and it
> is better not to combine them with further write-throttling
> heuristics of a different nature.
> So this commit disables write-back throttling for a device if BFQ
> is used as I/O scheduler for that device.
> 
> Signed-off-by: Luca Miccio <lucmiccio@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

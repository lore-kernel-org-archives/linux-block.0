Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: add mapping show for hw queue to cpu
To: weiping zhang <zhangweiping@didichuxing.com>
References: <20170712165400.GA9696@localhost.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d9e4984e-07f1-c1bd-07be-4e0a4b2a71df@kernel.dk>
Date: Wed, 12 Jul 2017 10:57:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170712165400.GA9696@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/12/2017 10:54 AM, weiping zhang wrote:
> A mapping show as following:
> 
> hctx		cpus
> hctx0		  0   1
> hctx1		  2
> hctx2		  3
> hctx3		  4   5

We already have that information in the /sys/block/<dev>/mq/X/cpu_list

where X is the hardware queue number. Why do we need it in debugfs as
well, presented differently?

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] null_blk: zone support
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>, loberman@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bart.VanAssche@wdc.com, Damien.LeMoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
Date: Mon, 9 Jul 2018 10:34:26 -0600
MIME-Version: 1.0
In-Reply-To: <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/9/18 1:54 AM, Matias Bjørling wrote:
> For fio, you can use the zone support here:
> 
>    https://github.com/bvanassche/fio
> 
> It is in the process of being upstreamed.

In the spirit of making some progress on this, I just don't like how
it's done. For example, it should not be necessary to adjust what
comes out of the block generator, instead the block generator should
be told to do what we need on zbc. This is a key concept. The workload
should be defined as such that it works for zoned devices.

The trim as zone resets seems odd. What happens if you end up with a
zoned flash device in the future?

The support code looks fine.

-- 
Jens Axboe

Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH BUGFIX V2 0/2] block, bfq: fix two memory leaks related to
 cgroups
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 162996@studenti.unimore.it
References: <20180109092759.5454-1-paolo.valente@linaro.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <b06b9171-4429-d98f-b9bc-260570a77bb0@applied-asynchrony.com>
Date: Tue, 9 Jan 2018 16:30:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180109092759.5454-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/09/18 10:27, Paolo Valente wrote:
> [There was a mistake in the subject of the second patch, sorry]
> 
> Hi Jens,
> these two patches fix two related memory leaks, the first reported in
> [1], and the second found by ourselves while fixing the first.
> 
> Thanks,
> Paolo
> 
> [1] https://www.mail-archive.com/linux-block@vger.kernel.org/msg16258.html
> 
> Paolo Valente (2):
>   block, bfq: put async queues for root bfq groups too
>   block, bfq: release oom-queue ref to root group on exit
> 
>  block/bfq-cgroup.c  | 7 +++++--
>  block/bfq-iosched.c | 3 +++
>  2 files changed, 8 insertions(+), 2 deletions(-)

Gave this a try and can't reproduce the leak anymore, so for both patches:

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers!
Holger

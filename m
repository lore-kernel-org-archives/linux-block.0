Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: compile group put for oom queue
 only if BFQ_GROUP_IOSCHED is set
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180110145856.4040-1-paolo.valente@linaro.org>
 <20180110145856.4040-2-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b1fcbfe2-e8da-5a6f-b62e-cd8dc4bf2b6f@kernel.dk>
Date: Wed, 10 Jan 2018 08:23:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180110145856.4040-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 7:58 AM, Paolo Valente wrote:
> Commit ("block, bfq: release oom-queue ref to root group on exit")
> added a missing put of the root bfq group for the oom queue. That put
> has to be, and can be, performed only if CONFIG_BFQ_GROUP_IOSCHED is
> defined: the function doing the put is even not defined at all if
> CONFIG_BFQ_GROUP_IOSCHED is not defined. But that commit makes that
> put be invoked regardless of whether CONFIG_BFQ_GROUP_IOSCHED is
> defined. This commit fixes this mistake, by making that invocation be
> compiled only if CONFIG_BFQ_GROUP_IOSCHED is actually defined.

I already fixed that up yesterday:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.16/block&id=8abef10b3de1144cfe968f454946f13eb1ac3d0a

-- 
Jens Axboe

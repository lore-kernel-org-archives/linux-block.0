Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: use pointer entity->sched_data only if
 set
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170509093727.2595-1-paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <884a6d3c-40aa-c2a6-9981-82d48148429b@kernel.dk>
Date: Tue, 9 May 2017 08:53:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170509093727.2595-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/09/2017 03:37 AM, Paolo Valente wrote:
> In the function __bfq_deactivate_entity, the pointer
> entity->sched_data could happen to be used before being properly
> initialized. This led to a NULL pointer dereference. This commit fixes
> this bug by just using this pointer only where it is safe to do so.

Added, thanks.

-- 
Jens Axboe

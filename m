Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: lower-bound the estimated peak rate to
 1
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 khlebnikov@yandex-team.ru
References: <20180326140624.2295-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5035d1cf-f9ff-013f-87d8-19891d5e8df0@kernel.dk>
Date: Mon, 26 Mar 2018 10:18:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180326140624.2295-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/26/18 8:06 AM, Paolo Valente wrote:
> If a storage device handled by BFQ happens to be slower than 7.5 KB/s
> for a certain amount of time (in the order of a second), then the
> estimated peak rate of the device, maintained in BFQ, becomes equal to
> 0. The reason is the limited precision with which the rate is
> represented (details on the range of representable values in the
> comments introduced by this commit). This leads to a division-by-zero
> error where the estimated peak rate is used as divisor. Such a type of
> failure has been reported in [1].
> 
> This commit addresses this issue by:
> 1. Lower-bounding the estimated peak rate to 1
> 2. Adding and improving comments on the range of rates representable

Applied for 4.17, thanks.

-- 
Jens Axboe

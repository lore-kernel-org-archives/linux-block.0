Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: stress that low_latency must be off to
 get max throughput
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170509105423.3672-1-paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c59a2d1-6c09-3041-8643-cfb18941f1f9@kernel.dk>
Date: Tue, 9 May 2017 08:54:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170509105423.3672-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/09/2017 04:54 AM, Paolo Valente wrote:
> The introduction of the BFQ and Kyber I/O schedulers has triggered a
> new wave of I/O benchmarks. Unfortunately, comments and discussions on
> these benchmarks confirm that there is still little awareness that it
> is very hard to achieve, at the same time, a low latency and a high
> throughput. In particular, virtually all benchmarks measure
> throughput, or throughput-related figures of merit, but, for BFQ, they
> use the scheduler in its default configuration. This configuration is
> geared, instead, toward a low latency. This is evidently a sign that
> BFQ documentation is still too unclear on this important aspect. This
> commit addresses this issue by stressing how BFQ configuration must be
> (easily) changed if the only goal is maximum throughput.

Added, thanks.

-- 
Jens Axboe

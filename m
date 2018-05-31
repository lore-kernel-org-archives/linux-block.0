Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENTS 0/4] bfq: fix regressions on slow
 virtual machines
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 sapienza.dav@gmail.com, 177992@studenti.unimore.it
References: <20180531144508.3927-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e19f92d-5319-f023-7f4c-89ee81c58348@kernel.dk>
Date: Thu, 31 May 2018 08:56:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180531144508.3927-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/31/18 8:45 AM, Paolo Valente wrote:
> Hi,
> we have bumped into some BFQ latency regressions on slow virtual
> machines. The patches in this series fix all these regressions, apart
> from the first patch, which provides an indirect contribution, by
> improving the description of the mechanisms affected by these
> regressions.

Pulled for 4.18, thanks Paolo.

-- 
Jens Axboe

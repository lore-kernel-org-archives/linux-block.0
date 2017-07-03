Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: fix bug causing crashes
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org
References: <20170703080010.1709-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b7680e6e-b416-3cf9-c3ef-313da76950a5@kernel.dk>
Date: Mon, 3 Jul 2017 16:49:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170703080010.1709-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/03/2017 02:00 AM, Paolo Valente wrote:
> Hi Jens,
> I'm writing this short cover letter to hopefully help you decide what
> to do with this patch, in this late phase of the development
> cycle. This patch fixes a bug causing kernel crashes for at least
> one year. Crashes apparently affect only a minority of users, but are
> systematic for them (a crash every few tens of minutes for some).

By the time you wrote that email, 4.12 was already released for hours.
So there's really no choice this time but to queue it up for 4.13.

-- 
Jens Axboe

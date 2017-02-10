Return-Path: <axboe@kernel.dk>
Subject: Re: [WIP PATCHSET 1/4] blk-mq: pass bio to blk_mq_sched_get_rq_priv
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
 <20170207172446.4528-2-paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd21f422-3077-5c33-7ef3-7fddc18a66f8@kernel.dk>
Date: Fri, 10 Feb 2017 09:10:14 -0700
MIME-Version: 1.0
In-Reply-To: <20170207172446.4528-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/07/2017 10:24 AM, Paolo Valente wrote:
> bio is used in bfq-mq's get_rq_priv, to get the request group. We could
> pass directly the group here, but I thought that passing the bio was
> more general, giving the possibility to get other pieces of information
> if needed.

I applied this one, thanks Paolo.

-- 
Jens Axboe

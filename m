Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: fix asymmetric scenarios detection
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 Federico Motta <federico@willer.it>
References: <20181024171325.7154-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7023bec4-f0dc-2238-25ca-4b76edfeb0f1@kernel.dk>
Date: Thu, 25 Oct 2018 08:18:29 -0600
MIME-Version: 1.0
In-Reply-To: <20181024171325.7154-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/18 11:13 AM, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
> detection"), a scenario is defined asymmetric when one of the
> following conditions holds:
> - active bfq_queues have different weights
> - one or more group of entities (bfq_queue or other groups of entities)
>   are active
> bfq grants fairness and low latency also in such asymmetric scenarios,
> by plugging the dispatching of I/O if the bfq_queue in service happens
> to be temporarily idle. This plugging may lower throughput, so it is
> important to do it only when strictly needed.
> 
> By mystake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
> scenarios detection") the num_active_groups counter was firstly
> incremented and subsequently decremented at any entity (group or
> bfq_queue) weight change.
> 
> This is useless, because only transitions from active to inactive and
> vice versa matter for that counter. Unfortunately this is also
> incorrect in the following case: the entity at issue is a bfq_queue
> and it is under weight raising. In fact in this case there is a
> spurious increment of the num_active_groups counter.
> 
> This spurious increment may cause scenarios to be wrongly detected as
> asymmetric, thus causing useless plugging and loss of throughput.
> 
> This commit fixes this issue by simply removing the above useless and
> wrong increments and decrements.

Applied for 4.20, thanks.

-- 
Jens Axboe

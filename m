Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: fix bug related to the burst_size
 counter
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lee.tibbert@gmail.com,
 oleksandr@natalenko.name, angeloruocco90@gmail.com, philm@manjaro.org
References: <20171009111123.2961-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d12493f9-97a5-2004-dce4-eca32c458823@kernel.dk>
Date: Mon, 9 Oct 2017 09:55:58 -0600
MIME-Version: 1.0
In-Reply-To: <20171009111123.2961-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/09/2017 05:11 AM, Paolo Valente wrote:
> Hi Jens,
> unfortunately, the patch "block, bfq: decrease burst size when queues
> in burst exit", queued for 4.15 [1] introduces a bug, described in
> detail in the commit message of this patch. If triggered, this bug may
> cause loss of control on I/O-request service order.

Applied, but please remember to add a Fixes line when you have a patch
that fixes a problem introduced by a previous patch. For this one,
I added:

Fixes: 7cb04004fa37 ("block, bfq: decrease burst size when queues in burst exit")

-- 
Jens Axboe

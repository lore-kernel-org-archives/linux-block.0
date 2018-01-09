Return-Path: <axboe@kernel.dk>
Date: Tue, 9 Jan 2018 08:41:32 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, broonie@kernel.org,
	linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name, 162996@studenti.unimore.it
Subject: Re: [PATCH BUGFIX 0/2] block, bfq: fix two memory leaks related to
 cgroups
Message-ID: <20180109154131.GB5512@kernel.dk>
References: <20180109091727.5262-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180109091727.5262-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09 2018, Paolo Valente wrote:
> Hi Jens,
> these two patches fix two related memory leaks, the first reported in
> [1], and the second found by ourselves while fixing the first.

Thanks, applied for 4.16, thanks.

-- 
Jens Axboe

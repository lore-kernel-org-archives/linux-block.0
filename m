Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/2] block, bfq: two pending patches
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180113110518.2519-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <55d37f66-019d-2ded-2559-16930466d644@kernel.dk>
Date: Thu, 18 Jan 2018 08:23:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180113110518.2519-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/13/18 4:05 AM, Paolo Valente wrote:
> Hi Jens,
> here are again the two pending patches you asked me to resend [1]. One
> of them, fixing read-starvation problems, was accompanied by a cover
> letter. I'm pasting the content of that cover letter below.
> 
> The patch addresses (serious) starvation problems caused by
> request-tag exhaustion, as explained in more detail in the commit
> message. I started from the solution in the function
> kyber_limit_depth, but then I had to define more articulate limits, to
> counter starvation also in cases not covered in kyber_limit_depth.
> If this solution proves to be effective, I'm willing to port it
> somehow to the other schedulers.

It's something we've been doing in the old request layer for tagging for
a long time (more than a decade), so a generic (and fast) solution that
covers all cases for blk-mq-tag would indeed be great.

For now, I have applied these for 4.16, thanks.

-- 
Jens Axboe

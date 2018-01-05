Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH IMPROVEMENT] block, bfq: consider recent past to reduce
 soft-real-time false positives
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 angeloruocco90@gmail.com, bfq-iosched@googlegroups.com
References: <20171215062312.1836-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7d611782-5750-6faf-fac6-8709c75a66ca@kernel.dk>
Date: Fri, 5 Jan 2018 09:31:44 -0700
MIME-Version: 1.0
In-Reply-To: <20171215062312.1836-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/14/17 11:23 PM, Paolo Valente wrote:
> Hi,
> this patch reduces false positives in the detection of bfq_queues
> associated with soft real-time applications. As such, this patch
> reduces the damages caused by these false positives to other
> applications. The patch proved to be very effective, as detailed in
> the commit message. A sort of counterpart of this patch should follow
> soon, this time for false positives in the detection of cooperating
> processes (processes doing I/O close to each other).
> 
> I guess it is evidently too late for 4.15, so, Jens, please consider
> this patch for 4.16. Of course if the patch turns out to be ok.

Added for 4.16, thanks.

-- 
Jens Axboe

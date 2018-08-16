Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement
 related to I/O control
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180816165118.17402-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
Date: Thu, 16 Aug 2018 13:10:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/16/18 10:51 AM, Paolo Valente wrote:
> Hi Jens,
> 
> while working a little bit on cgroups I/O control, I found two nasty
> bugs in bfq. They break bandwidth control in simple configurations
> with one-process groups. These bugs are fixed by the first two patches
> in this series.
> 
> These fixes improved I/O control so much, that I could reduce the
> write overcharge factor, used by bfq to counter write-induced
> issues. This reduction is performed by the third patch.
> 
> The fourth patch contains a little code improvement I made in a
> function that has to do with I/O control.
> 
> I hope we are still in time for 4.19.

Patches look fine to me. You are in fact several weeks late for 4.19, I
need to have anything that's going in to 4.19 by -rc6 or -rc7 time
(depending on whether we have an -rc8 or not). This is to ensure that it
gets plenty of time in linux-next as well. I've queued up patches this
time (since they were small), but please send them in in due time next
time.

-- 
Jens Axboe

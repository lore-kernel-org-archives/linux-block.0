Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT] block, bfq: improve and refactor
 throughput-boosting logic
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lucmiccio@gmail.com
References: <20170803164818.10562-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <056bf889-3d05-8dac-e049-a2a7fd5eebd2@kernel.dk>
Date: Thu, 3 Aug 2017 10:51:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170803164818.10562-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 10:48 AM, Paolo Valente wrote:
> When a queue associated with a process remains empty, there are cases
> where throughput gets boosted if the device is idled to await the
> arrival of a new I/O request for that queue. Currently, BFQ assumes
> that one of these cases is when the device has no internal queueing
> (regardless of the properties of the I/O being served). Unfortunately,
> this condition has proved to be too general. So, this commit refines it
> as "the device has no internal queueing and is rotational".
> 
> This refinement provides a significant throughput boost with random
> I/O, on flash-based storage without internal queueing. For example, on
> a HiKey board, throughput increases by up to 125%, growing, e.g., from
> 6.9MB/s to 15.6MB/s with two or three random readers in parallel.
> 
> This commit also refactors the code related to device idling, for the
> following reason. Finding the change that provides the above large
> improvement has been slightly more difficult than it had to be,
> because the logic that decides whether to idle the device is still
> scattered across three functions. Almost all of the logic is in the
> function bfq_bfqq_may_idle, but (1) part of the decision is made in
> bfq_update_idle_window, and (2) the function bfq_bfqq_must_idle may
> switch off idling regardless of the output of bfq_bfqq_may_idle. In
> addition, both bfq_update_idle_window and bfq_bfqq_must_idle make
> their decisions as a function of parameters that are used, for similar
> purposes, also in bfq_bfqq_may_idle. This commit addresses this issue
> by moving all the logic into bfq_bfqq_may_idle.

This should be split into two patches - do one refactor patch that
doesn't change anything, then your functional change on top of that.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/3] three bfq fixes restoring
 service guarantees with random sync writes in bg
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, mgorman@techsingularity.net,
 lee.tibbert@gmail.com, oleksandr@natalenko.name
References: <20170831064631.2223-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <da37f9a6-4954-3e70-f807-3b3daa7d9dd3@kernel.dk>
Date: Thu, 31 Aug 2017 08:21:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170831064631.2223-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/31/2017 12:46 AM, Paolo Valente wrote:
> [SECOND TAKE, with just the name of one of the tester fixed]
> 
> Hi,
> while testing the read-write unfairness issues reported by Mel, I
> found BFQ failing to guarantee good responsiveness against heavy
> random sync writes in the background, i.e., multiple writers doing
> random writes and systematic fdatasync [1]. The failure was caused by
> three related bugs, because of which BFQ failed to guarantee to
> high-weight processes the expected fraction of the throughput.
> 
> The three patches in this series fix these bugs. These fixes restore
> the usual BFQ service guarantees (and thus optimal responsiveness
> too), against the above background workload and, probably, against
> other similar workloads.

Applied for 4.14, thanks Paolo.

-- 
Jens Axboe

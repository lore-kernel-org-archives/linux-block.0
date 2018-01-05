Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH IMPROVEMENT] block, bfq: increase threshold to deem I/O as
 random
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 angeloruocco90@gmail.com, bfq-iosched@googlegroups.com
References: <20171220162736.5067-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eb614d97-c11b-214f-3f03-fe21c36de906@kernel.dk>
Date: Fri, 5 Jan 2018 09:24:15 -0700
MIME-Version: 1.0
In-Reply-To: <20171220162736.5067-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/20/17 9:27 AM, Paolo Valente wrote:
> If two processes do I/O close to each other, i.e., are cooperating
> processes in BFQ (and CFQ'S) nomenclature, then BFQ merges their
> associated bfq_queues, so as to get sequential I/O from the union of
> the I/O requests of the processes, and thus reach a higher
> throughput. A merged queue is then split if its I/O stops being
> sequential. In this respect, BFQ deems the I/O of a bfq_queue as
> (mostly) sequential only if less than 4 I/O requests are random, out
> of the last 32 requests inserted into the queue.
> 
> Unfortunately, extensive testing (with the interleaved_io benchmark of
> the S suite [1], and with real applications spawning cooperating
> processes) has clearly shown that, with such a low threshold, only a
> rather low I/O throughput may be reached when several cooperating
> processes do I/O. In particular, the outcome of each test run was
> bimodal: if queue merging occurred and was stable during the test,
> then the throughput was close to the peak rate of the storage device,
> otherwise the throughput was arbitrarily low (usually around 1/10 of
> the peak rate with a rotational device). The probability to get the
> unlucky outcomes grew with the number of cooperating processes: it was
> already significant with 5 processes, and close to one with 7 or more
> processes.
> 
> The cause of the low throughput in the unlucky runs was that the
> merged queues containing the I/O of these cooperating processes were
> soon split, because they contained more random I/O requests than those
> tolerated by the 4/32 threshold, but
> - that I/O would have however allowed the storage device to reach
>   peak throughput or almost peak throughput;
> - in contrast, the I/O of these processes, if served individually
>   (from separate queues) yielded a rather low throughput.
> 
> So we repeated our tests with increasing values of the threshold,
> until we found the minimum value (19) for which we obtained maximum
> throughput, reliably, with at least up to 9 cooperating
> processes. Then we checked that the use of that higher threshold value
> did not cause any regression for any other benchmark in the suite [1].
> This commit raises the threshold to such a higher value.

Applied for 4.16, thanks.

-- 
Jens Axboe

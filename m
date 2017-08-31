Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	mgorman@techsingularity.net,
	lee.tibbert@gmail.com,
	oleksandr@natalenko.name,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/3] three bfq fixes restoring service guarantees with random sync writes in bg
Date: Thu, 31 Aug 2017 08:10:17 +0200
Message-Id: <20170831061020.4426-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
while testing the read-write unfairness issues reported by Mel, I
found BFQ failing to guarantee good responsiveness against heavy
random sync writes in the background, i.e., multiple writers doing
random writes and systematic fdatasync [1]. The failure was caused by
three related bugs, because of which BFQ failed to guarantee to
high-weight processes the expected fraction of the throughput.

The three patches in this series fix these bugs. These fixes restore
the usual BFQ service guarantees (and thus optimal responsiveness
too), against the above background workload and, probably, against
other similar workloads.

Thanks,
Paolo

[1] https://lkml.org/lkml/2017/8/9/957

Paolo Valente (3):
  block, bfq: make lookup_next_entity push up vtime on expirations
  block, bfq: remove direct switch to an entity in higher class
  block, bfq: guarantee update_next_in_service always returns an
    eligible entity

 block/bfq-iosched.c |  4 +--
 block/bfq-iosched.h |  4 +--
 block/bfq-wf2q.c    | 91 ++++++++++++++++++++++++++++++++---------------------
 3 files changed, 60 insertions(+), 39 deletions(-)

--
2.10.0

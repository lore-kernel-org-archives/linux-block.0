Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	angeloruocco90@gmail.com,
	bfq-iosched@googlegroups.com,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH IMPROVEMENT] block, bfq: consider recent past to reduce soft-real-time false positives
Date: Fri, 15 Dec 2017 07:23:11 +0100
Message-Id: <20171215062312.1836-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
this patch reduces false positives in the detection of bfq_queues
associated with soft real-time applications. As such, this patch
reduces the damages caused by these false positives to other
applications. The patch proved to be very effective, as detailed in
the commit message. A sort of counterpart of this patch should follow
soon, this time for false positives in the detection of cooperating
processes (processes doing I/O close to each other).

I guess it is evidently too late for 4.15, so, Jens, please consider
this patch for 4.16. Of course if the patch turns out to be ok.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: consider also past I/O in soft real-time detection

 block/bfq-iosched.c | 115 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 34 deletions(-)

--
2.10.0

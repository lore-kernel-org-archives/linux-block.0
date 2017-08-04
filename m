Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	lucmiccio@gmail.com,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 0/2] block, bfq: improve and refactor throughput-boosting logic
Date: Fri,  4 Aug 2017 07:35:09 +0200
Message-Id: <20170804053511.2389-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
these two patches improve throughput-boosting logic in two
aspects. The first patch refactors the parts of the device-idling
logic, related to throughput boosting, that are still scattered across
the source file bfq-iosched.c. The patch concetrates all the logic in
one function. The second patch fixes/improves device idling for
flash-based devices that have no internal queueing of I/O requests.

The contribution in the first patch has been triggered by that in the
second patch: finding the change made by the second patch has been
more difficult than it had to be, because the logic that decides
whether to idle the device is scattered across three functions.

The second patch provides a significant throghput boost, for random
I/O with flash-based non-queueing devices. For example, on a HiKey
board, throughput increases by up to 125%, growing, e.g., from 6.9MB/s
to 15.6MB/s with two or three random readers in parallel.

Thanks,
Paolo

Paolo Valente (2):
  block,bfq: refactor device-idling logic
  block, bfq: boost throughput with flash-based non-queueing devices

 block/bfq-iosched.c | 144 ++++++++++++++++++++++++++++------------------------
 block/bfq-iosched.h |  12 ++---
 2 files changed, 85 insertions(+), 71 deletions(-)

--
2.10.0

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
Subject: [PATCH IMPROVEMENT/BUGFIX 0/4] remove start-up time outlier caused by wrong detection of cooperating processes
Date: Wed, 20 Dec 2017 12:38:30 +0100
Message-Id: <20171220113834.2578-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
the main patch in this series ("block, bfq: let a queue be merged only
shortly after starting I/O") eliminates an outlier in the application
start-up time guaranteed by BFQ. This outlier occurs more or less
frequently, as a function of the characteristics of the system, and is
caused by a wrong detection of so-called cooperating processes
(details in the commit message).  This main patch is preceded by two
patches that fix two bugs found while working on this problem.  The
patch is then followed by a further, optimization patch, that removes
an operation made superfluous by the main patch.

Jens, I've not forgotten our decision to make a patch that enables
blkio stats (related to proportional-share policy) to not be enabled
at boot, or when CFQ or BFQ modules are loaded. Just, we have already
prepared the present patches, plus a few other patches for improving
BFQ and fixing bugs, and I'd like to clear this backlog first.

In this respect, after a patch for boosting throughput more reliably
with cooperating processes, I'll send out a patch to solve an
important read starvation problem. If I'm not making a blunder, this
problem affects every I/O scheduler in blk-mq. As a first step, I'll
propose a fix for BFQ. If the fix is ok, I'm willing to port it to the
other schedulers.

Thanks,
Paolo

Angelo Ruocco (2):
  block, bfq: check low_latency flag in bfq_bfqq_save_state()
  block, bfq: remove superfluous check in queue-merging setup

Paolo Valente (2):
  block, bfq: add missing rq_pos_tree update on rq removal
  block, bfq: let a queue be merged only shortly after starting I/O

 block/bfq-iosched.c | 98 ++++++++++++++++++++++++++++++-----------------------
 block/bfq-iosched.h |  2 ++
 block/bfq-wf2q.c    |  4 +++
 3 files changed, 61 insertions(+), 43 deletions(-)

--
2.15.1

Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/3] bfq: one fix and two important improvements for throughput
Date: Fri, 14 Sep 2018 16:23:06 +0200
Message-Id: <20180914142309.6789-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
the second and third patch in this series provide two important
improvements in bfq's ability to boost throughput with random I/O. The
benefits of the second patch concern I/O control, and are described in
detail in this LWN article [1] (and briefly in the commit message
itself). The benefits of the other patch should be
straightforward. Finally, the first patch fixes an I/O-control bug,
found while making the second patch.

These patches modify somehow core operations of bfq, so, before
submitting them, I have tested them a lot, and have had them tested by
other people too. In particular, during these months, they have been
tested in systems ranging from PCs to development platforms.

Thanks,
Paolo

[1] https://lwn.net/Articles/763603/

Paolo Valente (3):
  block, bfq: correctly charge and reset entity service in all cases
  block, bfq: inject other-queue I/O into seeky idle queues on NCQ flash
  blok, bfq: do not plug I/O if all queues are weight-raised

 block/bfq-iosched.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h | 26 ++++++++++++++++++
 block/bfq-wf2q.c    | 13 ++++++---
 3 files changed, 106 insertions(+), 11 deletions(-)

--
2.16.1

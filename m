Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/4] bfq: fix bugs breaking bandwidth guarantees occasionally
Date: Mon, 25 Jun 2018 21:48:02 +0200
Message-Id: <20180625194806.7619-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
during some bandwidth tests, I found some occasional but severe
malfunctions (losses of bandwidth control). The first three patches in
this series fix the bugs that caused these malfunctions. The last
patch is a fix/improvement of the name of one of the functions
involved with these bugs.

I guess these patches are appropriate for next kernel release.

Thanks,
Paolo

Paolo Valente (4):
  block, bfq: add/remove entity weights correctly
  block, bfq: do not expire a queue that will deserve dispatch plugging
  block, bfq: fix service being wrongly set to zero in case of
    preemption
  block, bfq: fix service being wrongly set to zero in case of
    preemption

 block/bfq-iosched.c | 131 +++++++++++++++++++++++++++++++++++++++++++---------
 block/bfq-iosched.h |   7 ++-
 block/bfq-wf2q.c    |  30 ++++++------
 3 files changed, 128 insertions(+), 40 deletions(-)

--
2.16.1

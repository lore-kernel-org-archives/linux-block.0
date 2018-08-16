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
Subject: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement related to I/O control
Date: Thu, 16 Aug 2018 18:51:14 +0200
Message-Id: <20180816165118.17402-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

while working a little bit on cgroups I/O control, I found two nasty
bugs in bfq. They break bandwidth control in simple configurations
with one-process groups. These bugs are fixed by the first two patches
in this series.

These fixes improved I/O control so much, that I could reduce the
write overcharge factor, used by bfq to counter write-induced
issues. This reduction is performed by the third patch.

The fourth patch contains a little code improvement I made in a
function that has to do with I/O control.

I hope we are still in time for 4.19.

Thanks,
Paolo

Paolo Valente (4):
  block, bfq: readd missing reset of parent-entity service
  block, bfq: always update the budget of an entity when needed
  block, bfq: reduce write overcharge
  block, bfq: improve code of bfq_bfqq_charge_time

 block/bfq-iosched.c | 54 +++++++++++++++++++++++++++++++++++++++--------------
 block/bfq-wf2q.c    | 22 +++++++++++-----------
 2 files changed, 51 insertions(+), 25 deletions(-)

--
2.16.1

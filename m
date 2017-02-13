Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] attempt to fix wrong scheduler selection
Date: Mon, 13 Feb 2017 22:01:06 +0100
Message-Id: <20170213210107.4848-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
if, at boot, a legacy I/O scheduler is chosen for a device using
blk-mq, or, viceversa, a blk-mq scheduler is chosen for a device using
blk, then that scheduler is set and initialized without any check,
driving the system into an inconsistent state.

The purpose of this message is, first, to report this issue, and,
second, to propose a possible fix in case you do consider this as a
bug.

Thanks,
Paolo

Paolo Valente (1):
  block: make elevator_get robust against cross blk/blk-mq choice

 block/elevator.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--
2.10.0

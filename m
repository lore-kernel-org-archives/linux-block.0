Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: fix bug causing crashes
Date: Mon,  3 Jul 2017 10:00:09 +0200
Message-Id: <20170703080010.1709-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
I'm writing this short cover letter to hopefully help you decide what
to do with this patch, in this late phase of the development
cycle. This patch fixes a bug causing kernel crashes for at least
one year. Crashes apparently affect only a minority of users, but are
systematic for them (a crash every few tens of minutes for some).

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: don't change ioprio class for a bfq_queue on a service
    tree

 block/bfq-iosched.c | 14 ++++++++++----
 block/bfq-iosched.h |  3 ++-
 block/bfq-wf2q.c    | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 10 deletions(-)

--
2.10.0

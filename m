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
	162996@studenti.unimore.it,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/2] block, bfq: fix two memory leaks related to cgroups
Date: Tue,  9 Jan 2018 10:17:25 +0100
Message-Id: <20180109091727.5262-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
these two patches fix two related memory leaks, the first reported in
[1], and the second found by ourselves while fixing the first.

Thanks,
Paolo

[1] https://www.mail-archive.com/linux-block@vger.kernel.org/msg16258.html

Paolo Valente (2):
  block, bfq: put async queues for root bfq groups too
  bfq-sq, bfq-mq: release oom-queue ref to root group on exit

 block/bfq-cgroup.c  | 7 +++++--
 block/bfq-iosched.c | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

--
2.15.1

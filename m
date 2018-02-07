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
	alban.browaeys@gmail.com,
	ming.lei@redhat.com,
	ivan@ludios.org,
	169364@studenti.unimore.it,
	holger@applied-asynchrony.com,
	efault@gmx.de,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 0/1] block, bfq: handle requeues of I/O requests
Date: Wed,  7 Feb 2018 19:00:49 +0100
Message-Id: <20180207180050.5639-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
fixed version, after bug reports and fixes in [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2018/2/5/599


Paolo Valente (1):
  block, bfq: add requeue-request hook

 block/bfq-iosched.c | 109 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 25 deletions(-)

--
2.15.1

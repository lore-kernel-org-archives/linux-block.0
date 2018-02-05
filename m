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
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: handle requeues of I/O requests
Date: Mon,  5 Feb 2018 20:05:09 +0100
Message-Id: <20180205190510.5499-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
just a note: the most difficult part in the implementation of this
patch has been how to handle the fact that the requeue and finish
hooks of the active elevator get invoked even for requests that are
not referred in that elevator any longer. You can find details in the
comments introduced by the patch. This note is just to point out this
unexpected fact (for me), in case it is not intentional.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: add requeue-request hook

 block/bfq-iosched.c | 101 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 25 deletions(-)

--
2.15.1

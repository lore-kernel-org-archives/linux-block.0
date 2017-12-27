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
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH IMPROVEMENT/BUGFIX 0/1] block, bfq: address starvation caused by tag consumption
Date: Wed, 27 Dec 2017 13:15:06 +0100
Message-Id: <20171227121507.4280-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens, all,
here's the patch I anticipated in my last email. It addresses
(serious) starvation problems caused by request-tag exhaustion, as
explained in more detail in the commit message. I started from the
solution in the function kyber_limit_depth, but then I had to define
more articulate limits, to counter starvation also in cases not
covered in kyber_limit_depth.

If this solution proves to be effective, I'm willing to port it
somehow to the other schedulers.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: limit tags for writes and async I/O

 block/bfq-iosched.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/bfq-iosched.h | 12 +++++++++
 2 files changed, 89 insertions(+)

--
2.15.1

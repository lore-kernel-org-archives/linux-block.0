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
Subject: [PATCH BUGFIX/IMPROVEMENT 0/2] block, bfq: two pending patches
Date: Sat, 13 Jan 2018 12:05:16 +0100
Message-Id: <20180113110518.2519-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
here are again the two pending patches you asked me to resend [1]. One
of them, fixing read-starvation problems, was accompanied by a cover
letter. I'm pasting the content of that cover letter below.

The patch addresses (serious) starvation problems caused by
request-tag exhaustion, as explained in more detail in the commit
message. I started from the solution in the function
kyber_limit_depth, but then I had to define more articulate limits, to
counter starvation also in cases not covered in kyber_limit_depth.
If this solution proves to be effective, I'm willing to port it
somehow to the other schedulers.

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg21586.html

Paolo Valente (2):
  block, bfq: limit tags for writes and async I/O
  block, bfq: limit sectors served with interactive weight raising

 block/bfq-iosched.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++---
 block/bfq-iosched.h |  17 ++++++
 block/bfq-wf2q.c    |   3 +
 3 files changed, 169 insertions(+), 9 deletions(-)

--
2.15.1

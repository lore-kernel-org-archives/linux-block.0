Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	jeremywh7@gmail.com,
	lnicola@dend.ro,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/2] doc, block, bfq: improve documentation on how to to properly configure bfq
Date: Thu, 31 Aug 2017 20:00:29 +0200
Message-Id: <20170831180031.3747-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Many users have reported the lack of an HOWTO for properly configuring
bfq as a function of the goal one wants to achieve (max
responsiveness, max throughput, ...). The second patch in this
two-patch series addresses this issue by improving the file
bfq-iosched.txt in such a way that it also provides some guidance on
this task. The first patch fixes some issues that I have found while
working on the file.

Thanks,
Paolo

Paolo Valente (2):
  doc, block, bfq: fix some typos and remove stale stuff
  doc, block, bfq: better describe how to properly configure bfq

 Documentation/block/bfq-iosched.txt | 144 ++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 80 deletions(-)

--
2.10.0

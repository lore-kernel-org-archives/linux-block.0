Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	lee.tibbert@gmail.com,
	oleksandr@natalenko.name,
	angeloruocco90@gmail.com,
	philm@manjaro.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX]  block, bfq: fix bug related to the burst_size counter
Date: Mon,  9 Oct 2017 13:11:22 +0200
Message-Id: <20171009111123.2961-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
unfortunately, the patch "block, bfq: decrease burst size when queues
in burst exit", queued for 4.15 [1] introduces a bug, described in
detail in the commit message of this patch. If triggered, this bug may
cause loss of control on I/O-request service order.

Please queue this fix right after the patch introducing the bug.

Thanks,
Paolo

[1] https://lkml.org/lkml/2017/9/21/144

Paolo Valente (1):
  block, bfq: fix unbalanced decrements of burst size

 block/bfq-iosched.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

--
2.10.0

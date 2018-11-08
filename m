Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541694626.196084.220.camel@acm.org>
Subject: Re: [PATCH 2/2] blk-mq: provide a helper to check if a queue is busy
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date: Thu, 08 Nov 2018 08:30:26 -0800
In-Reply-To: <20181108160609.27568-4-axboe@kernel.dk>
References: <20181108160609.27568-1-axboe@kernel.dk>
	 <20181108160609.27568-4-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
+AD4 +-static bool blk+AF8-mq+AF8-check+AF8-busy(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct request +ACo-rq,
+AD4 +-			      void +ACo-priv, bool reserved)
+AD4 +-+AHs
+AD4 +-	/+ACo
+AD4 +-	 +ACo If we find a request, we know the queue is busy. Return false
+AD4 +-	 +ACo to stop the iteration.
+AD4 +-	 +ACo-/
+AD4 +-	if (rq-+AD4-q +AD0APQ hctx-+AD4-queue) +AHs
+AD4 +-		bool +ACo-busy +AD0 (bool +ACo) priv+ADs

I think the +ACI(bool +ACo)+ACI cast can be left out. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

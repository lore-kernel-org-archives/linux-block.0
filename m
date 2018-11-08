Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541694515.196084.218.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether
 to continue or not
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date: Thu, 08 Nov 2018 08:28:35 -0800
In-Reply-To: <20181108160609.27568-3-axboe@kernel.dk>
References: <20181108160609.27568-1-axboe@kernel.dk>
	 <20181108160609.27568-3-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
+AD4 --- a/block/blk-mq-debugfs.c
+AD4 +-+-+- b/block/blk-mq-debugfs.c
+AD4 +AEAAQA -424,13 +-424,15 +AEAAQA struct show+AF8-busy+AF8-params +AHs
+AD4   +ACo Note: the state of a request may change while this function is in progress,
+AD4   +ACo e.g. due to a concurrent blk+AF8-mq+AF8-finish+AF8-request() call.
+AD4   +ACo-/
+AD4 -static void hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4 +-static bool hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4  +AHs

Please update the kdoc header above hctx+AF8-show+AF8-busy+AF8-rq() such that it reflects
the new behavior. I'm referring to the +ACI-will be called for each request+ACI part.
Otherwise this patch looks fine to me.

Bart.

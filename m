Return-Path: <viro@ftp.linux.org.uk>
Date: Thu, 25 Jan 2018 02:58:11 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL
 in blk_mq_sched_assign_ioc
Message-ID: <20180125025811.GT13338@ZenIV.linux.org.uk>
References: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 25, 2018 at 10:46:26AM +0800, Jia-Ju Bai wrote:
> The function ioc_create_icq here is not called in atomic context.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.

Umm...  Some human-readable analysis would be welcome.  FWIW, I've tried to
put a proof together, but...
	struct blk_mq_ops->timeout = nvme_timeout
	nvme_timeout()
		nvme_alloc_request()
			blk_mq_alloc_request_hctx()
				blk_mq_get_request()
					blk_mq_sched_assign_ioc()
... and while I have not traced the call chain further, the look of that
function (nvme_timeout()) strongly suggests that it *is* meant to be
called from bloody atomic context.

"My tool has found that place/put together a proof" is nice, but it
doesn't replace the proof itself...

Return-Path: <BATV+0f69485e8eba9f9d9296+5085+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 26 Jul 2017 10:34:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org
Subject: Re: [BUG] nvme driver crash
Message-ID: <20170726173443.GA25527@infradead.org>
References: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 25, 2017 at 03:24:08PM -0700, Shaohua Li wrote:
> Disable CONIFG_SMP, kernel crashes at boot time, here is the log.

I can reproduce the issue.  Unfortunately the addresss in the bug
doesn't make any sense to me when resolving it using gdb, as t just
points to the line where blk_mq_init_queue calls
blk_alloc_queue_node.

Can you check if you get better results in your build?

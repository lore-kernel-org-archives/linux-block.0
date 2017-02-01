Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 1 Feb 2017 11:07:41 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/4] blk-mq-debugfs: Add missing __acquires() /
 __releases() annotations
Message-ID: <20170201190741.GA2299@vader>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
 <20170201182059.25601-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201182059.25601-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 01, 2017 at 10:20:56AM -0800, Bart Van Assche wrote:
> This patch avoids that sparse complains about lock imbalances.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)

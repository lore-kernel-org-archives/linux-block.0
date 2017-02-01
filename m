Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 1 Feb 2017 11:08:27 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq-debug: Make show() operations interruptible
Message-ID: <20170201190827.GC2299@vader>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
 <20170201182059.25601-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201182059.25601-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 01, 2017 at 10:20:58AM -0800, Bart Van Assche wrote:
> Allow users to interrupt show operations instead of making a user
> space process unkillable if ownership of q->sysfs_lock cannot be
> obtained.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)

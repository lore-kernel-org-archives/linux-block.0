Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 1 Feb 2017 11:08:11 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/4] blk-mq-debug: Avoid that sparse complains about
 req_flags_t usage
Message-ID: <20170201190811.GB2299@vader>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
 <20170201182059.25601-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201182059.25601-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 01, 2017 at 10:20:57AM -0800, Bart Van Assche wrote:
> Avoid that sparse reports the following complaints:
> 
> block/elevator.c:541:29: warning: incorrect type in assignment (different base types)
> block/elevator.c:541:29:    expected bool [unsigned] [usertype] next_sorted
> block/elevator.c:541:29:    got restricted req_flags_t
> 
> block/blk-mq-debugfs.c:92:54: warning: cast from restricted req_flags_t

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 3 ++-
>  block/elevator.c       | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

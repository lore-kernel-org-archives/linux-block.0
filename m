Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 10 Nov 2017 14:04:37 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: improve tag waiting setup for non-shared tags
Message-ID: <20171110220437.GA5449@vader.DHCP.thefacebook.com>
References: <3649d84b-978d-ce1b-a8bc-5735b07296a7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3649d84b-978d-ce1b-a8bc-5735b07296a7@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 04:00:09PM -0700, Jens Axboe wrote:
> If we run out of driver tags, we currently treat shared and non-shared
> tags the same - both cases hook into the tag waitqueue. This is a bit
> more costly than it needs to be on unshared tags, since we have to both
> grab the hctx lock, and the waitqueue lock (and disable interrupts).
> For the non-shared case, we can simply mark the queue as needing a
> restart.
> 
> Split blk_mq_dispatch_wait_add() to account for both cases, and
> rename it to blk_mq_mark_tag_wait() to better reflect what it
> does now.
> 
> Without this patch, shared and non-shared performance is about the same
> with 4 fio thread hammering on a single null_blk device (~410K, at 75%
> sys). With the patch, the shared case is the same, but the non-shared
> tags case runs at 431K at 71% sys.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

The best of both worlds.

Reviewed-by: Omar Sandoval <osandov@fb.com>

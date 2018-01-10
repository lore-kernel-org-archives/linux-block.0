Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 10 Jan 2018 10:41:28 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, bart.vanassche@wdc.com
Subject: Re: [PATCH 2/4] block: add accessors for setting/querying request
 deadline
Message-ID: <20180110184128.GB30831@vader.DHCP.thefacebook.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515544167-10751-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09, 2018 at 05:29:25PM -0700, Jens Axboe wrote:
> We reduce the resolution of request expiry, but since we're already
> using jiffies for this where resolution depends on the kernel
> configuration and since the timeout resolution is coarse anyway,
> that should be fine.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         |  2 +-
>  block/blk-timeout.c    | 14 ++++++++------
>  block/blk.h            | 15 +++++++++++++++
>  include/linux/blkdev.h |  4 +++-
>  4 files changed, 27 insertions(+), 8 deletions(-)
> 

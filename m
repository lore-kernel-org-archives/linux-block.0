Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 1 Feb 2017 11:08:59 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 4/4] blk-mq-debug: Introduce debugfs_create_files()
Message-ID: <20170201190859.GD2299@vader>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
 <20170201182059.25601-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201182059.25601-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 01, 2017 at 10:20:59AM -0800, Bart Van Assche wrote:
> Replace the two debugfs_create_file() loops by a call to the new
> debugfs_create_files() function. Add an empty element at the end
> of the two attribute arrays such that the array size does not have
> to be passed to debugfs_create_files().

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

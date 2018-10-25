Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 25 Oct 2018 14:08:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] blktest: remove instances of null_blk queue_mode=1
Message-ID: <20181025210846.GA29982@vader>
References: <dbede61b-13fb-5b5e-3827-fd4b831f9004@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dbede61b-13fb-5b5e-3827-fd4b831f9004@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 25, 2018 at 03:03:30PM -0600, Jens Axboe wrote:
> This is no longer supported in recent kernels, get rid of
> any testing of queue_mode=1. queue_mode=1 tested the legacy
> IO path, which is going away completely. As such, there's
> no point in doing anymore testing with it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks, applied this squashed it with the one removing block/022.

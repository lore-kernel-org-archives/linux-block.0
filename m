Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Thu, 23 Aug 2018 11:32:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] blk-wbt: don't maintain inflight counts if disabled
Message-ID: <20180823153251.qwjnpvfxlnn6ft3m@destiny>
References: <504f587c-681b-5502-30e3-9a3c4ed6c8fe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <504f587c-681b-5502-30e3-9a3c4ed6c8fe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 23, 2018 at 09:15:27AM -0600, Jens Axboe wrote:
> A previous commit removed the ability to have per-rq flags. We used
> those flags to maintain inflight counts. Since we don't have those
> anymore, we have to always maintain inflight counts, even if wbt is
> disabled. This is clearly suboptimal.
> 
> Add a queue quiesce around changing the wbt latency settings from sysfs
> to work around this. With that, we can reliably put the enabled check in
> our bio_to_wbt_flags(), since we know the WBT_TRACKED flag will be
> consistent for the lifetime of the request.
> 
> Fixes: Fixes: c1c80384c8f ("block: remove external dependency on wbt_flags")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Sorry about that,

Josef

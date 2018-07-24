Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: allow max_discard_segments to be stacked
To: Mike Snitzer <snitzer@redhat.com>
Cc: hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20180720185738.11646-1-snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ba30bcde-3d3c-f1ea-ac61-cf483073f999@kernel.dk>
Date: Tue, 24 Jul 2018 13:47:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180720185738.11646-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/20/18 11:57 AM, Mike Snitzer wrote:
> Set max_discard_segments to USHRT_MAX in blk_set_stacking_limits() so
> that blk_stack_limits() can stack up this limit for stacked devices.
> 
> before:
> 
> $ cat /sys/block/nvme0n1/queue/max_discard_segments
> 256
> $ cat /sys/block/dm-0/queue/max_discard_segments
> 1
> 
> after:
> 
> $ cat /sys/block/nvme0n1/queue/max_discard_segments
> 256
> $ cat /sys/block/dm-0/queue/max_discard_segments
> 256

Applied, thanks Mike.

-- 
Jens Axboe

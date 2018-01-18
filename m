Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/3] Avoid that blk_{un,}register_queue() trigger lock
 inversion
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180117194810.26583-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <599f1862-3733-7eb7-1a7c-b5bb1b0b275e@kernel.dk>
Date: Thu, 18 Jan 2018 12:55:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180117194810.26583-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 12:48 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> The three patches in this series are what I came up with after having
> analyzed a lockdep complaint triggered by blk_unregister_queue(). Please
> consider these patches for kernel v4.16.

Thanks Bart, applied.

-- 
Jens Axboe

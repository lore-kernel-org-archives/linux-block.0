Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/9] blk-mq: Enable runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <66179785-ef05-794a-c455-c9802ec5a8b5@kernel.dk>
Date: Thu, 2 Aug 2018 15:25:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/2/18 12:29 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> This patch series not only enables runtime power management for blk-mq but
> also fixes a starvation issue in the power management code for the legacy
> block layer. Please consider this patch series for kernel v4.19.

Looks good to me, but would be nice to get Tejun onboard with the percpu
change. We'll need his ack to get this applied.

-- 
Jens Axboe

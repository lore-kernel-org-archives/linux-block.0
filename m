Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: fix deadline elevator drain for zoned block
 devices
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
References: <20180927015513.24020-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <11986d01-4c59-8b62-d67d-db154f72516d@kernel.dk>
Date: Wed, 26 Sep 2018 19:57:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180927015513.24020-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/26/18 7:55 PM, Damien Le Moal wrote:
> When the deadline scheduler is used with a zoned block device, writes
> to a zone will be dispatched one at a time. This causes the warning
> message:
> 
> deadline: forced dispatching is broken (nr_sorted=X), please report this
> 
> to be displayed when switching to another elevator with the legacy I/O
> path while write requests to a zone are being retained in the scheduler
> queue.
> 
> Prevent this message from being displayed when executing
> elv_drain_elevator() for a zoned block device. __blk_drain_queue() will
> loop until all writes are dispatched and completed, resulting in the
> desired elevator queue drain without extensive modifications to the
> deadline code itself to handle forced-dispatch calls.

Dropped the previous one and added this one.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: fix deadline elevator drain for zoned block
 devices
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20180926073037.29563-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <28521211-5bc3-9330-6a81-e582a0e448bf@kernel.dk>
Date: Wed, 26 Sep 2018 08:30:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180926073037.29563-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/26/18 1:30 AM, Damien Le Moal wrote:
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

Applied for 4.19, thanks Damien.

-- 
Jens Axboe

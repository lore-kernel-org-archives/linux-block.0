Return-Path: <hch@lst.de>
Date: Wed, 1 Aug 2018 16:55:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Patrick Steinhardt <ps@pks.im>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Tomas Janousek <tomi@nomi.cz>, Przemek Socha <soprwa@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] block: really disable runtime-pm for blk-mq
Message-ID: <20180801145545.GD28668@lst.de>
References: <20180730120219.24164-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730120219.24164-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 08:02:19PM +0800, Ming Lei wrote:
> Runtime PM isn't ready for blk-mq yet, and commit 765e40b675a9 ("block:
> disable runtime-pm for blk-mq") tried to disable it. Unfortunately,
> it can't take effect in that way since user space still can switch
> it on via 'echo auto > /sys/block/sdN/device/power/control'.
> 
> This patch disables runtime-pm for blk-mq really by pm_runtime_disable()
> and fixes all kinds of PM related kernel crash.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

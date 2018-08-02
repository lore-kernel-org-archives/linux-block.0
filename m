Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: really disable runtime-pm for blk-mq
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Patrick Steinhardt <ps@pks.im>, Bart Van Assche <Bart.VanAssche@wdc.com>,
 Tomas Janousek <tomi@nomi.cz>, Przemek Socha <soprwa@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
References: <20180730120219.24164-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b6b2902d-2c16-cdf5-8fb4-d8ea31ae5b20@kernel.dk>
Date: Thu, 2 Aug 2018 10:36:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180730120219.24164-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/30/18 6:02 AM, Ming Lei wrote:
> Runtime PM isn't ready for blk-mq yet, and commit 765e40b675a9 ("block:
> disable runtime-pm for blk-mq") tried to disable it. Unfortunately,
> it can't take effect in that way since user space still can switch
> it on via 'echo auto > /sys/block/sdN/device/power/control'.
> 
> This patch disables runtime-pm for blk-mq really by pm_runtime_disable()
> and fixes all kinds of PM related kernel crash.

Applied, thanks Ming.

-- 
Jens Axboe

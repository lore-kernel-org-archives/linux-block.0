Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only alloc hctx point as many as nr_hw_queues
To: weiping <zhangweiping@didichuxing.com>
References: <20170713161020.GA10325@bogon.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e03b2bfa-15d3-3d27-15cf-07e65882fc25@kernel.dk>
Date: Thu, 13 Jul 2017 10:14:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170713161020.GA10325@bogon.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/13/2017 10:10 AM, weiping zhang wrote:
> one hw queue only has one hctx, reduce it's number same as nr_hw_queues.

What happens if a device registers with eg 4 hw queues, then later
calls blk_mq_update_nr_hw_queues()?

-- 
Jens Axboe

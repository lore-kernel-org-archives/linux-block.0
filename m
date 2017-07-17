Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:1861 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdGQLVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 07:21:03 -0400
Date: Mon, 17 Jul 2017 12:20:56 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/6] xen-blkfront: quiesce/unquiesce queue instead of
 start/stop queues
Message-ID: <20170717112056.ysdtuugo5ipayv7e@MacBook-Pro-de-Roger.local>
References: <20170714231601.14444-1-ming.lei@redhat.com>
 <20170714231601.14444-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170714231601.14444-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jul 15, 2017 at 07:15:56AM +0800, Ming Lei wrote:
> stopping queue may cause race and may not stop the queue really
> after the API returns, and we have improved quiescing
> interface and it really can block dispatching once it returns.
> 
> So switch to quiesce/unquiece like what we did on other drivers
> (NVMe, NBD, mtip32xx, ...)
> 
> The blk_mq_stop_hw_queues() and blk_mq_start_stopped_hw_queues()
> used in blkif_queue_rq() and blkif_interrupt() are for congestion
> control, we leave it as it is since it is safe for this usage.

Again I yet don't understand the difference between those two, neither
why start/stop is not fixed instead of introducing quiesce/unquiece.
Not to mention that start/stop is not documented, which makes all this
even more fun.

Anyway I would like to ask, is the way to re-start a stopped queue the
same way to unquiece?

If not I would rather prefer that start/stop or quiece/unquiece is
used exclusively, in order to not make the code even more complex. It
seems fairly easy to mess up and call "start" on a "quiesced" queue
(or the other way around).

Roger.

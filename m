Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdFFMsc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 08:48:32 -0400
Date: Tue, 6 Jun 2017 20:48:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v4 10/11] blk-mq: clarify dispatch may not be
 drained/blocked by stopping queue
Message-ID: <20170606124806.GB13877@ming.t460p>
References: <20170605155925.7896-1-ming.lei@redhat.com>
 <20170605155925.7896-11-ming.lei@redhat.com>
 <1496706919.2623.36.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496706919.2623.36.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 05, 2017 at 11:55:20PM +0000, Bart Van Assche wrote:
> On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> > +/*
> > + * We do not guarantee that dispatch can be drained or blocked
> > + * after blk_mq_stop_hw_queue() returns. Please use
> > + * blk_mq_quiesce_queue() for that requirement.
> > + */
> 
> Hello Ming,
> 
> This is comment explains what blk_mq_stop_hw_queue() should not be used for
> and may leave the reader wondering what it is useful for. How about mentioning
> first that this function is useful to pause .queue_rq() calls as long as the
> block driver it will have to return BUSY if .queue_rq() is called?

OK, will make that as one example.


Thanks,
Ming

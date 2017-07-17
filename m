Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.eu.citrix.com ([185.25.65.24]:24427 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdGQQGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 12:06:51 -0400
Date: Mon, 17 Jul 2017 17:02:27 +0100
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
Message-ID: <20170717160227.x5cmghxgqgyx2ye6@dhcp-3-128.uk.xensource.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
 <20170714231601.14444-2-ming.lei@redhat.com>
 <20170717112056.ysdtuugo5ipayv7e@MacBook-Pro-de-Roger.local>
 <20170717150621.GB26571@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20170717150621.GB26571@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 17, 2017 at 11:06:28PM +0800, Ming Lei wrote:
> On Mon, Jul 17, 2017 at 12:20:56PM +0100, Roger Pau Monn� wrote:
> > On Sat, Jul 15, 2017 at 07:15:56AM +0800, Ming Lei wrote:
> > > stopping queue may cause race and may not stop the queue really
> > > after the API returns, and we have improved quiescing
> > > interface and it really can block dispatching once it returns.
> > > 
> > > So switch to quiesce/unquiece like what we did on other drivers
> > > (NVMe, NBD, mtip32xx, ...)
> > > 
> > > The blk_mq_stop_hw_queues() and blk_mq_start_stopped_hw_queues()
> > > used in blkif_queue_rq() and blkif_interrupt() are for congestion
> > > control, we leave it as it is since it is safe for this usage.
> > 
> > Again I yet don't understand the difference between those two, neither
> > why start/stop is not fixed instead of introducing quiesce/unquiece.
> 
> There are two usages covered by start/stop now:
> 
> - congestion control for handling queue busy(BLK_STS_RESOURCE), now
> only xen-blkfront and virtio-blk use that
> 
> - other usages, such as in xlvbd_release_gendisk(), for blocking
> IO to driver/device
> 
> For the 1st case, it is usually fine to use stop/start
> 
> For the 2nd case, stop queue isn't enough, and we can't guarantee 
> no IO is dispatched to device/driver after returning from stop queue,
> for details. Most of this usage have been fixed by  Sagi Grimberg:

OK, so basically after calling stop the queue might still be running.

> We can't use quiesce/unquiesce for replacing stop/start in the
> case of BLK_STS_RESOURCE, because quiesce may sleep, and we needn't
> block IO for this usage actually.

Do you mean that quiesce/unquiesce cannot be used while holding a
spinlock?

> 
> > Not to mention that start/stop is not documented, which makes all this
> > even more fun.
> 
> Did you read comment of blk_mq_stop_hw_queue() and
> blk_mq_stop_hw_queues() in linus tree?

OK, this has been added very recently.

> > 
> > Anyway I would like to ask, is the way to re-start a stopped queue the
> > same way to unquiece?
> 
> I don't know what your exact question, but it is definitely that
> unquiesce is counter part of quiesce, and quiesce/unquiesce doesn't
> depend on 'stopped' state any more if you take a look at the code.
> 
> > 
> > If not I would rather prefer that start/stop or quiece/unquiece is
> > used exclusively, in order to not make the code even more complex. It
> 
> I do not think the code becomes more complex, please see the line change
> of this patch:

Before this patch blkfront used:
blk_mq_stop_hw_queues
blk_mq_start_stopped_hw_queues
blk_mq_kick_requeue_list

After the patch it uses:
blk_mq_quiesce_queue
blk_mq_unquiesce_queue
blk_mq_stop_hw_queues
blk_mq_start_stopped_hw_queues
blk_mq_kick_requeue_list
blk_mq_run_hw_queues

It's not about line changes, but the amount of interfaces blkfront has
to use. Apart from introducing the quiesce/unquiesce, you also
introduce a call to blk_mq_run_hw_queues, which is not documented in
the commit message.

> > seems fairly easy to mess up and call "start" on a "quiesced" queue
> > (or the other way around).
> 
> Definitely it shouldn't be worried because start/stop is removed
> in this patchset.

Hm, how is that? I haven't seen any patch to blkfront to remove the
usage of start/stop, am I missing something?

Roger.

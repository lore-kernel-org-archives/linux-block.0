Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752251AbdD1Xts (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 19:49:48 -0400
Date: Sat, 29 Apr 2017 07:49:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH ] block: don't call blk_mq_quiesce_queue() during
 switching mq sched
Message-ID: <20170428234933.GA29628@ming.t460p>
References: <20170428073250.9579-1-ming.lei@redhat.com>
 <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
 <1493395159.2767.5.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1493395159.2767.5.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 03:59:20PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-28 at 07:42 -0600, Jens Axboe wrote:
> > On 04/28/2017 01:32 AM, Ming Lei wrote:
> > > We have freezed queue already, not necessary to call
> > > blk_mq_quiesce_queue() any more, so remove it.
> > 
> > Are you sure? It ensures that we also aren't in the middle of
> > blk_mq_make_request(), we need a stable view of the sched
> > status throughout that.
> 
> Hello Jens,
> 
> My understanding is that blk_mq_freeze_queue() provides stronger guarantees
> than�blk_mq_quiesce_queue(). The former waits until all pending requests have
> finished while the latter only waits until pending .queue_rq() calls have
> finished. blk_mq_freeze_queue() also causes new blk_get_request() calls to
> wait until blk_mq_unfreeze_queue() is called while�blk_get_request() can
> still succeed after blk_mq_quiesce_queue() returned and before
> blk_mq_start_stopped_hw_queues() is called.
> 
> Regarding blk_mq_make_request(): I think that the blk_queue_enter() call in
> generic_make_request() prevents that blk_mq_make_request() gets called after
> a queue has been frozen.

Jens & Bart, so I understand you don't object to this patch any more,
then I will post a v1 for covering blk_mq_update_nr_requests().

Thanks,
Ming

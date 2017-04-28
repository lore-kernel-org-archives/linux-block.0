Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28448 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163916AbdD1P7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:59:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH ] block: don't call blk_mq_quiesce_queue() during
 switching mq sched
Date: Fri, 28 Apr 2017 15:59:20 +0000
Message-ID: <1493395159.2767.5.camel@sandisk.com>
References: <20170428073250.9579-1-ming.lei@redhat.com>
         <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
In-Reply-To: <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-28 at 07:42 -0600, Jens Axboe wrote:
> On 04/28/2017 01:32 AM, Ming Lei wrote:
> > We have freezed queue already, not necessary to call
> > blk_mq_quiesce_queue() any more, so remove it.
>=20
> Are you sure? It ensures that we also aren't in the middle of
> blk_mq_make_request(), we need a stable view of the sched
> status throughout that.

Hello Jens,

My understanding is that blk_mq_freeze_queue() provides stronger guarantees
than=A0blk_mq_quiesce_queue(). The former waits until all pending requests =
have
finished while the latter only waits until pending .queue_rq() calls have
finished. blk_mq_freeze_queue() also causes new blk_get_request() calls to
wait until blk_mq_unfreeze_queue() is called while=A0blk_get_request() can
still succeed after blk_mq_quiesce_queue() returned and before
blk_mq_start_stopped_hw_queues() is called.

Regarding blk_mq_make_request(): I think that the blk_queue_enter() call in
generic_make_request() prevents that blk_mq_make_request() gets called afte=
r
a queue has been frozen.

Bart.=

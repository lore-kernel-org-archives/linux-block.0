Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968087AbdD1PiV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:38:21 -0400
Date: Fri, 28 Apr 2017 23:38:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH ] block: don't call blk_mq_quiesce_queue() during
 switching mq sched
Message-ID: <20170428153803.GD25592@ming.t460p>
References: <20170428073250.9579-1-ming.lei@redhat.com>
 <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

On Fri, Apr 28, 2017 at 07:42:05AM -0600, Jens Axboe wrote:
> On 04/28/2017 01:32 AM, Ming Lei wrote:
> > We have freezed queue already, not necessary to call
> > blk_mq_quiesce_queue() any more, so remove it.
> 
> Are you sure? It ensures that we also aren't in the middle of
> blk_mq_make_request(), we need a stable view of the sched
> status throughout that.

After blk_mq_freeze_queue() returned, no requests belonging to this queue
can be in use, so there shouldn't be any .queue_rq() running for this
queue.

Or you mean any .queue_rq()(even not belongs to this queue) can't be
running during mq scheduler switch? If yes, per-hctx srcu can't guarantee
that too for BLOCKING case.

Thanks,
Ming

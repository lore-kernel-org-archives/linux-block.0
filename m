Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59261 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdHXHOn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:14:43 -0400
Date: Thu, 24 Aug 2017 15:14:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 14/20] blk-mq-sched: improve IO scheduling on SCSI
 devcie
Message-ID: <20170824071426.GO12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-15-ming.lei@redhat.com>
 <1503435090.2508.22.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503435090.2508.22.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 08:51:32PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > This patch introduces per-request_queue dispatch
> > list for this purpose, and only when all requests
> > in this list are dispatched out successfully, we
> > can restart to dequeue request from sw/scheduler
> > queue and dispath it to lld.
> 
> Wasn't one of the design goals of blk-mq to avoid a per-request_queue list?

Yes, but why does scsi device have per-request_queue depth?

Anyway this single dispatch list won't hurt devices which doesn't have
per-request_queue depth.

For scsi device which has q->queue_depth, if one hctx is stuck, all
hctxs are stuck actually, the single dispatch list just fits this
kind of use case, doesn't it?

-- 
Ming

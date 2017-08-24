Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbdHXGjv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 02:39:51 -0400
Date: Thu, 24 Aug 2017 14:39:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 08/20] blk-mq-sched: use q->queue_depth as hint for
 q->nr_requests
Message-ID: <20170824063937.GI12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-9-ming.lei@redhat.com>
 <1503433217.2508.17.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503433217.2508.17.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 08:20:20PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > SCSI sets q->queue_depth from shost->cmd_per_lun, and
> > q->queue_depth is per request_queue and more related to
> > scheduler queue compared with hw queue depth, which can be
> > shared by queues, such as TAG_SHARED.
> > 
> > This patch trys to use q->queue_depth as hint for computing
>              ^^^^
>              tries?

Will fix it in V3.

> > q->nr_requests, which should be more effective than
> > current way.
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

Thanks!

-- 
Ming

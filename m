Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdITDSZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 23:18:25 -0400
Date: Wed, 20 Sep 2017 11:18:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 00/14] blk-mq-sched: improve SCSI-MQ performance
Message-ID: <20170920031810.GA24489@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170919192515.GC31219@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919192515.GC31219@vader.DHCP.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 19, 2017 at 12:25:15PM -0700, Omar Sandoval wrote:
> On Sat, Sep 02, 2017 at 11:17:15PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > In Red Hat internal storage test wrt. blk-mq scheduler, we
> > found that I/O performance is much bad with mq-deadline, especially
> > about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
> > SRP...)
> > 
> > Turns out one big issue causes the performance regression: requests
> > are still dequeued from sw queue/scheduler queue even when ldd's
> > queue is busy, so I/O merge becomes quite difficult to make, then
> > sequential IO degrades a lot.
> > 
> > The 1st five patches improve this situation, and brings back
> > some performance loss.
> 
> Sorry it took so long, I've reviewed or commented on patches 1-6. When
> you send v5, could you just send patches 1-6, and split the rest as
> their own series?

Sure, no problem.

Thanks for your review!

-- 
Ming

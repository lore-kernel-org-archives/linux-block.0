Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:47894 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdISTZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 15:25:17 -0400
Received: by mail-pf0-f172.google.com with SMTP id u12so317483pfl.4
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2017 12:25:17 -0700 (PDT)
Date: Tue, 19 Sep 2017 12:25:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 00/14] blk-mq-sched: improve SCSI-MQ performance
Message-ID: <20170919192515.GC31219@vader.DHCP.thefacebook.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170902151729.6162-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 02, 2017 at 11:17:15PM +0800, Ming Lei wrote:
> Hi,
> 
> In Red Hat internal storage test wrt. blk-mq scheduler, we
> found that I/O performance is much bad with mq-deadline, especially
> about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
> SRP...)
> 
> Turns out one big issue causes the performance regression: requests
> are still dequeued from sw queue/scheduler queue even when ldd's
> queue is busy, so I/O merge becomes quite difficult to make, then
> sequential IO degrades a lot.
> 
> The 1st five patches improve this situation, and brings back
> some performance loss.

Sorry it took so long, I've reviewed or commented on patches 1-6. When
you send v5, could you just send patches 1-6, and split the rest as
their own series?

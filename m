Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdFGCuu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 22:50:50 -0400
Date: Wed, 7 Jun 2017 10:50:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5 02/12] blk-mq: fix direct issue
Message-ID: <20170607025028.GA5582@ming.t460p>
References: <20170606152210.22806-1-ming.lei@redhat.com>
 <20170606152210.22806-3-ming.lei@redhat.com>
 <1496764970.2692.7.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496764970.2692.7.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 06, 2017 at 04:02:52PM +0000, Bart Van Assche wrote:
> On Tue, 2017-06-06 at 23:22 +0800, Ming Lei wrote:
> > If queue is stopped, we shouldn't dispatch request into driver and
> > hardware, unfortunately the check is removed in bd166ef183c2(blk-mq-sched:
> > add framework for MQ capable IO schedulers).
> > 
> > This patch fixes the issue by moving the check back into
> > __blk_mq_try_issue_directly().
> > 
> > This patch fixes request use-after-free[1][2] during canceling requets
> > of NVMe in nvme_dev_disable(), which can be triggered easily during
> > NVMe reset & remove test.
> 
> Although I'm not convinced that this patch fixes [2], the patch itself looks

The .q_usage_counter will be leaked once request is double free.

Thanks,
Ming

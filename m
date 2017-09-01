Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdIAMdy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Sep 2017 08:33:54 -0400
Date: Fri, 1 Sep 2017 20:33:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH 4/9] blk-mq: only run hw queues for blk-mq
Message-ID: <20170901123339.GA20709@ming.t460p>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-5-ming.lei@redhat.com>
 <20170901081634.gliggrnp3wlrysrv@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170901081634.gliggrnp3wlrysrv@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 01, 2017 at 10:16:34AM +0200, Johannes Thumshirn wrote:
> Hi Ming,
> 
> On Fri, Sep 01, 2017 at 01:27:23AM +0800, Ming Lei wrote:
> > -		blk_mq_run_hw_queues(q, false);
> > +		if (q->mq_ops)
> > +			blk_mq_run_hw_queues(q, false);
> 
> What speaks against putting the if (q->mq_ops) directly into
> blk_mq_run_hw_queues() so we can't accidently call it from the sq path?
> 
> Just an idea, no hard preferences here.

Given it is the only case that blk_mq_run_hw_queues() is run on
!q->mq_ops now, I suggest to check q->mq_ops outside, otherwise
it can be a bit overkill.

-- 
Ming

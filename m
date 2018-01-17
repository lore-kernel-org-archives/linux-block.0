Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeAQMe4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 07:34:56 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: two patches related with CPU hotplug
Date: Wed, 17 Jan 2018 20:34:42 +0800
Message-Id: <20180117123444.18393-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

The 1st one fixes one regression caused by 20e4d81393 ("blk-mq: simplify
queue mapping & schedule with each possisble CPU").

The 2nd one add commens about current race, and convert the WARN_ON
into printk(KERN_WARN) since this warning is harmless.

Thanks,

Ming Lei (2):
  blk-mq: make sure hctx->next_cpu is set correctly
  blk-mq: convert WARN_ON in __blk_mq_run_hw_queue to printk

 block/blk-mq.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

-- 
2.9.5

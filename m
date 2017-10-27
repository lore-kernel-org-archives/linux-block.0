Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdJ0Enl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 00:43:41 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Fri, 27 Oct 2017 12:43:28 +0800
Message-Id: <20171027044330.11921-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
by itself, and not necessary to waste CPU to do the expensive RESTART.
And Roman Pen reported that this RESTART cuts half of IOPS in his case.

The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.


Ming Lei (2):
  blk-mq: don't handle TAG_SHARED in restart
  blk-mq: don't restart queue when .get_budget returns BLK_STS_RESOURCE

 block/blk-mq-sched.c | 123 ++++-----------------------------------------
 block/blk-mq-sched.h |   2 +-
 block/blk-mq.c       |   8 +---
 3 files changed, 27 insertions(+), 106 deletions(-)

-- 
2.9.5

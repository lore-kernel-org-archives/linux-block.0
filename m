Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752233AbdKWEsS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 23:48:18 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] block: fix queue freeze and cleanup
Date: Thu, 23 Nov 2017 12:47:58 +0800
Message-Id: <20171123044800.25251-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

The 1st patch runs queue in blk_freeze_queue_start() for fixing one
regression by 055f6e18e08f("block: Make q_usage_counter also track legacy
requests").

The 2nd patch drians blkcg part of request_queue for both blk-mq and
legacy, which can be a fix on blk-mq's queue cleanup.

V2:
	- follow Bart's suggestion to use run queue instead of drain queue
	- drians blkcg part of request_queue for blk-mq

thanks,
Ming

Ming Lei (2):
  block: run queue before waiting for q_usage_counter becoming zero
  block: drain blkcg part of request_queue after queue is frozen

 block/blk-core.c | 3 +--
 block/blk-mq.c   | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.9.5

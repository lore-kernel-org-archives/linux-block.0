Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdGQIjf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 04:39:35 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq-sched: use q->queue_depth as hint for q->nr_requests
Date: Mon, 17 Jul 2017 16:39:21 +0800
Message-Id: <20170717083923.22014-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This two patches improves computation of default queue depth of
scheduler queue by using q->queue_depth.


Ming Lei (2):
  blk-mq-sched: introduce blk_mq_sched_queue_depth()
  blk-mq-sched: use q->queue_depth as hint for q->nr_requests

 block/blk-mq-sched.c |  8 +-------
 block/blk-mq-sched.h | 23 +++++++++++++++++++++++
 block/blk-mq.c       | 27 +++++++++++++++++++++++++--
 block/blk-mq.h       |  1 +
 block/blk-settings.c |  2 ++
 5 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.9.4

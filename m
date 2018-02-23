Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Omar Sandoval <osandov@fb.com>,
	oleksandr@natalenko.name,
	holger@applied-asynchrony.com,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: kyber: fix domain token leak during requeue
Date: Fri, 23 Feb 2018 23:36:55 +0800
Message-Id: <20180223153657.17376-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This two patch fixes domain token leak on kyber scheduler, and actually
fixes one IO hang issue.

Thanks,

Ming Lei (2):
  blk-mq: don't call io sched's .requeue_request when requeueing rq to
    ->dispatch
  block: kyber: fix domain token leak during requeue

 block/blk-mq.c        | 4 +++-
 block/kyber-iosched.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.9.5

Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] micro-optimize irq-poll
Date: Sun, 13 Nov 2016 01:02:32 +0200
Message-Id: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Some useful patches I came up with when working
on nvme irq-poll conversion (which still needs some
work).

Sagi Grimberg (3):
  irq-poll: Remove redundant include
  irq-poll: micro optimize some conditions
  irq-poll: Reduce local_irq_save/restore operations in irq_poll_softirq

 lib/irq_poll.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.7.4

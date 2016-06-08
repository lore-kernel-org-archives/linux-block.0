Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60156 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425802AbcFHTtD (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 15:49:03 -0400
From: Ming Lin <mlin@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH 0/2] check the number of hw queues mapped to sw queues
Date: Wed,  8 Jun 2016 15:48:10 -0400
Message-Id: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lin <ming.l@samsung.com>

Please see patch 2 for detail bug description.

Say, on a machine with 8 CPUs, we create 6 io queues(blk-mq hw queues)
    
echo "transport=rdma,traddr=192.168.2.2,nqn=testiqn,nr_io_queues=6" \
            > /dev/nvme-fabrics
    
Then actually only 4 hw queues were mapped to CPU sw queues.
    
HW Queue 1 <-> CPU 0,4
HW Queue 2 <-> CPU 1,5
HW Queue 3 <-> None
HW Queue 4 <-> CPU 2,6
HW Queue 5 <-> CPU 3,7
HW Queue 6 <-> None

Back to Jan 2016, I send a patch:
[PATCH] blk-mq: check if all HW queues are mapped to cpu
http://www.spinics.net/lists/linux-block/msg01038.html

It adds check code to blk_mq_update_queue_map().
But it seems too aggresive because it's not an error that some hw queues
were not mapped to sw queues.

So this series just add a new function blk_mq_hctx_mapped() to check
how many hw queues were mapped. And the driver(for example, nvme-rdma)
that cares about it will do the check.

Ming Lin (2):
  blk-mq: add a function to return number of hw queues mapped
  nvme-rdma: check the number of hw queues mapped

 block/blk-mq.c           | 15 +++++++++++++++
 drivers/nvme/host/rdma.c | 11 +++++++++++
 include/linux/blk-mq.h   |  1 +
 3 files changed, 27 insertions(+)

-- 
1.9.1


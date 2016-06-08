Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60164 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425804AbcFHTtE (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 15:49:04 -0400
From: Ming Lin <mlin@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
Date: Wed,  8 Jun 2016 15:48:12 -0400
Message-Id: <1465415292-9416-3-git-send-email-mlin@kernel.org>
In-Reply-To: <1465415292-9416-1-git-send-email-mlin@kernel.org>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lin <ming.l@samsung.com>

The connect_q requires all blk-mq hw queues being mapped to cpu
sw queues. Otherwise, we got below crash.

[42139.726531] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[42139.734962] IP: [<ffffffff8130e3b5>] blk_mq_get_tag+0x65/0xb0

[42139.977715] Stack:
[42139.980382]  0000000081306e9b ffff880035dbc380 ffff88006f71bbf8 ffffffff8130a016
[42139.988436]  ffff880035dbc380 0000000000000000 0000000000000001 ffff88011887f000
[42139.996497]  ffff88006f71bc50 ffffffff8130bc2a ffff880035dbc380 ffff880000000002
[42140.004560] Call Trace:
[42140.007681]  [<ffffffff8130a016>] __blk_mq_alloc_request+0x16/0x200
[42140.014584]  [<ffffffff8130bc2a>] blk_mq_alloc_request_hctx+0x8a/0xd0
[42140.021662]  [<ffffffffc087f28e>] nvme_alloc_request+0x2e/0xa0 [nvme_core]
[42140.029171]  [<ffffffffc087f32c>] __nvme_submit_sync_cmd+0x2c/0xc0 [nvme_core]
[42140.037024]  [<ffffffffc08d514a>] nvmf_connect_io_queue+0x10a/0x160 [nvme_fabrics]
[42140.045228]  [<ffffffffc08de255>] nvme_rdma_connect_io_queues+0x35/0x50 [nvme_rdma]
[42140.053517]  [<ffffffffc08e0690>] nvme_rdma_create_ctrl+0x490/0x6f0 [nvme_rdma]
[42140.061464]  [<ffffffffc08d4e48>] nvmf_dev_write+0x728/0x920 [nvme_fabrics]
[42140.069072]  [<ffffffff81197da3>] __vfs_write+0x23/0x120
[42140.075049]  [<ffffffff812de193>] ? apparmor_file_permission+0x13/0x20
[42140.082225]  [<ffffffff812a3ab8>] ? security_file_permission+0x38/0xc0
[42140.089391]  [<ffffffff81198744>] ? rw_verify_area+0x44/0xb0
[42140.095706]  [<ffffffff8119898d>] vfs_write+0xad/0x1a0
[42140.101508]  [<ffffffff81199c71>] SyS_write+0x41/0xa0
[42140.107213]  [<ffffffff816f1af6>] entry_SYSCALL_64_fastpath+0x1e/0xa8

Say, on a machine with 8 CPUs, we create 6 io queues,

echo "transport=rdma,traddr=192.168.2.2,nqn=testiqn,nr_io_queues=6" \
		> /dev/nvme-fabrics

Then actually only 4 hw queues were mapped to CPU sw queues.

HW Queue 1 <-> CPU 0,4
HW Queue 2 <-> CPU 1,5
HW Queue 3 <-> None
HW Queue 4 <-> CPU 2,6
HW Queue 5 <-> CPU 3,7
HW Queue 6 <-> None

So when connecting to IO queue 3, it will crash in blk_mq_get_tag()
because hctx->tags is NULL.

This patches doesn't really fix the hw/sw queues mapping, but it returns
error if not all hw queues were mapped.

"nvme nvme4: 6 hw queues created, but only 4 were mapped to sw queues"

Reported-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lin <ming.l@samsung.com>
---
 drivers/nvme/host/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4edc912..2e8f556 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1771,6 +1771,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	int hw_queue_mapped;
 	int ret;
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
@@ -1819,6 +1820,16 @@ static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 		goto out_free_tag_set;
 	}
 
+	hw_queue_mapped = blk_mq_hctx_mapped(ctrl->ctrl.connect_q);
+	if (hw_queue_mapped < ctrl->ctrl.connect_q->nr_hw_queues) {
+		dev_err(ctrl->ctrl.device,
+			"%d hw queues created, but only %d were mapped to sw queues\n",
+			ctrl->ctrl.connect_q->nr_hw_queues,
+			hw_queue_mapped);
+		ret = -EINVAL;
+		goto out_cleanup_connect_q;
+	}
+
 	ret = nvme_rdma_connect_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
-- 
1.9.1


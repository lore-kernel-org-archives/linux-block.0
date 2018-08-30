Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:40048 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeH3W5l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Aug 2018 18:57:41 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 30 Aug 2018 12:53:46 -0600
Message-Id: <20180830185352.3369-8-logang@deltatee.com>
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and check support for requests
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
supports targeting P2P memory.

When a request is submitted we check if PCI P2PDMA memory is assigned
to the first page in the bio. If it is, we ensure the queue it's
submitted to supports it, and enforce REQ_NOMERGE.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-core.c       | 14 ++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c282efb..cc0289c7b983 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2264,6 +2264,20 @@ generic_make_request_checks(struct bio *bio)
 	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
 		goto not_supported;
 
+	/*
+	 * Ensure PCI P2PDMA memory is not used in requests to queues that
+	 * have no support. This should never happen if the higher layers using
+	 * P2PDMA do the right thing and use the proper P2PDMA client
+	 * infrastructure. Also, ensure such requests use REQ_NOMERGE
+	 * seeing requests can not mix P2PDMA and non-P2PDMA memory at
+	 * this time.
+	 */
+	if (bio->bi_vcnt && is_pci_p2pdma_page(bio->bi_io_vec->bv_page)) {
+		if (WARN_ON_ONCE(!blk_queue_pci_p2pdma(q)))
+			goto not_supported;
+		bio->bi_opf |= REQ_NOMERGE;
+	}
+
 	if (should_fail_bio(bio))
 		goto end_io;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..7bf80ca802e1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,6 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PCI_P2PDMA  30	/* device supports pci p2p requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -731,6 +732,8 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
+#define blk_queue_pci_p2pdma(q)	\
+	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.11.0

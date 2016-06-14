Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.opengridcomputing.com ([72.48.136.20]:41566 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789AbcFNPXP (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 11:23:15 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Sagi Grimberg'" <sagi@lightbits.io>, <axboe@kernel.dk>,
	<keith.busch@intel.com>, "'Ming Lin'" <ming.l@ssi.samsung.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	"'Jay Freyensee'" <james.p.freyensee@intel.com>,
	"'Armen Baloyan'" <armenx.baloyan@intel.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de> <1465248215-18186-5-git-send-email-hch@lst.de> <5756B75C.9000409@lightbits.io> <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com> <20160614143132.GA17800@infradead.org> <00ea01d1c64f$64db8880$2e929980$@opengridcomputing.com>
In-Reply-To: <00ea01d1c64f$64db8880$2e929980$@opengridcomputing.com>
Subject: RE: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
Date: Tue, 14 Jun 2016 10:23:17 -0500
Message-ID: <00eb01d1c650$ad232520$07696f60$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Either
> > > nvmet should reject and destroy the cm_id, or it should do neither and
> > > return non-zero to the RDMA_CM to reject/destroy.
> >
> > Can you just send a patch?
> 
> Yes, I'll send it out in a separate email.

Before I do, what do you think of this (untested)?

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b1c6e5b..6f0c335 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1255,7 +1255,8 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,

        switch (event->event) {
        case RDMA_CM_EVENT_CONNECT_REQUEST:
-               ret = nvmet_rdma_queue_connect(cm_id, event);
+               if (nvmet_rdma_queue_connect(cm_id, event))
+                       rdma_destroy_id(cm_id);
                break;
        case RDMA_CM_EVENT_ESTABLISHED:
                nvmet_rdma_queue_established(queue);


Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57C23F384
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689850; cv=none; b=A4OORC5j5JUsSLmdSgU473OSdwUFBroONbR/fPSD6CMopnvw1ixzi7phCGBjQ9xV+n+YVZOqOnEf+KJsJb/kPjTKeI/A0fZ2etP5bd34LfFPi9vxJS1ZRbIa86t3oFI/ABfiq4UnORm71GwbeWYz3t6B7eMkCDjR8clgKf92xLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689850; c=relaxed/simple;
	bh=V/8yzlzSQwzG4hlLjx8C1beV8wQX1kn+h5Nq6Xl7qMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7a+rM+Jvmaj9RNlv/wtFA6vCK4bayGDF5MX9QoygsH0sFjuWiWc/O4XbFlWF7UaF0Db2kuu8GPYrwh89MdpXO3uwusQeCbRHc+P6xo12Qp6azz4rLQafYGjgPoXSr+hQWXeDiCzOHKomlFA9WPaj7IQRKFZfW92chL9WMSaWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZhYxbg1T; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZhYxbg1T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689848; x=1773225848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/8yzlzSQwzG4hlLjx8C1beV8wQX1kn+h5Nq6Xl7qMs=;
  b=ZhYxbg1THQwRGzMljw+hntkc+F3kYU2slaQKE2EePoNFjAp1lviMA/Yg
   dkkDIsxpePQEsrAIBOWTmV58ic7F6D6XaNGrlhyUy8bF6DZSYw5XIQY/c
   VROD2uQNURIS7s7wTEuDEPXfm1o0KOiYl4j62bugVg1Kz7k8pkbnqAl2G
   oEqesXj3GJd+yPprw3Xvlf+ynxNxnirRSA0lRhck+4Kt34kfKdIedqnK1
   KzeTPraLPdO+jQMBNYe8FP0LbHb/11BRz3wF6tbDhFqOYRC/I8paLvUJO
   7ZdOtQ6AzwDh7tIzY+2Br1ZaRmd2KTEdDWrmuN3fMnAHGkUPwoDJTDYfz
   Q==;
X-CSE-ConnectionGUID: XO5KSnucQsm0bB4ZB1bN1Q==
X-CSE-MsgGUID: JZgCSUVZQM2uV+Jes75gDQ==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="47078904"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:08 +0800
IronPort-SDR: 67d00622_IIa7wE+bo8kmS/qazk7RLASDEZsiyNSmx10T4xyfLpLpe2u
 aPpF2px51BnDtMCWT0aI4BUWk1BJ2xKY9vTGYLw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:44:05 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third argument type to bool
Date: Tue, 11 Mar 2025 19:43:59 +0900
Message-ID: <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") modified the evaluation criteria for the third argument,
'ioerror', in the blk_mq_add_to_batch() function. Initially, the
function had checked if 'ioerror' equals zero. Following the commit, it
started checking for negative error values, with the presumption that
such values, for instance -EIO, would be passed in.

However, blk_mq_add_to_batch() callers do not pass negative error
values. Instead, they pass status codes defined in various ways:

- NVMe PCI and Apple drivers pass NVMe status code
- virtio_blk driver passes the virtblk request header status byte
- null_blk driver passes blk_status_t

These codes are either zero or positive, therefore the revised check
fails to function as intended. Specifically, with the NVMe PCI driver,
this modification led to the failure of the blktests test case nvme/039.
In this test scenario, errors are artificially injected to the NVMe
driver, resulting in positive NVMe status codes passed to
blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
batch. Hence the failure.

To correct the ioerror check within blk_mq_add_to_batch(), make all
callers to uniformly pass the argument as boolean. Modify the callers to
check their specific status codes and pass the boolean value 'is_error'.
Also describe the arguments of blK_mq_add_to_batch as kerneldoc.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 11 ++++++++---
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..fdc7a0b2af10 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1549,8 +1549,8 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
-					blk_mq_end_request_batch))
+		if (!blk_mq_add_to_batch(req, iob, cmd->error != BLK_STS_OK,
+					 blk_mq_end_request_batch))
 			blk_mq_end_request(req, cmd->error);
 		nr++;
 	}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6a61ec35f426..91cde76a4b3e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1207,11 +1207,12 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
+		u8 status = virtblk_vbr_status(vbr);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-						virtblk_complete_batch))
+		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
 
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a060f69558e7..8971aca41e63 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -599,7 +599,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	}
 
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
 				 apple_nvme_complete_batch))
 		apple_nvme_complete_rq(req);
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b21728..75de86e235ad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1130,8 +1130,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
-					nvme_pci_complete_batch))
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
+				 nvme_pci_complete_batch))
 		nvme_pci_complete_rq(req);
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 71f4f0cc3dac..d904e870e72d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -855,9 +855,14 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
 /*
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
+ *
+ * @req: The request to add to batch
+ * @iob: The batch to add the request
+ * @is_error: Specify true if the request failed with an error
+ * @io_comp_batch: The completaion handler for the request
  */
 static inline bool blk_mq_add_to_batch(struct request *req,
-				       struct io_comp_batch *iob, int ioerror,
+				       struct io_comp_batch *iob, bool is_error,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
@@ -865,7 +870,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	 * 1) No batch container
 	 * 2) Has scheduler data attached
 	 * 3) Not a passthrough request and end_io set
-	 * 4) Not a passthrough request and an ioerror
+	 * 4) Not a passthrough request and failed with an error
 	 */
 	if (!iob)
 		return false;
@@ -874,7 +879,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	if (!blk_rq_is_passthrough(req)) {
 		if (req->end_io)
 			return false;
-		if (ioerror < 0)
+		if (is_error)
 			return false;
 	}
 
-- 
2.47.0


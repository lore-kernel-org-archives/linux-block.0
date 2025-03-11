Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B71E7640
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660915; cv=none; b=Os9mGsmvz0zSFJol//NnSyZEJdPqQEyhpwofkdXmSMXJUH38C1MkjDVDC+uVf7RHMIas6bjzZ4jxWsAzimJ6lzUYU5+pXuC2fxqcUPOIOeRS8OaQLvVhsPBY2sftxfTmBee6Hu5a+o3USTLrBXZzCJDdCdKvs261VoQOBKNc4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660915; c=relaxed/simple;
	bh=e6UhlVmTtUiepJzwKIgd3jyQ2yt2Kpy2YLUjWKStxqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPkY6ve6TcNm0GuJ/cX3571Mo5crNJtKWRuRNwXa9NxvAlBYuKTAOr9EfSF60buThtY7wyc0lz8S2Geu2quIo3t7+cEBtSTpLvpilDAbUvq4GoK4XP3nlAkriwGVOSz046+dXN3zRjG0rUZe7Ne4/7TR3gswjECD1AQIKAL68l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LG7F5Y2v; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LG7F5Y2v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741660914; x=1773196914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6UhlVmTtUiepJzwKIgd3jyQ2yt2Kpy2YLUjWKStxqc=;
  b=LG7F5Y2v70BQzyetyyzjjQ/WW6PQrKQ+7RLXYbgbpcKmCa9E+kyy+Jt3
   prDhEezrewcTgLmn5oAiYBsfoNFKRkwwbpe6dloUnaD0cKdunqbZSoy1V
   /XosZXFQNZHA0X5xsrG6ATJa2AxjdXk+ZVVR5+aVBHA0HqnzBY3+aQih9
   TK5ZqI8CTMlqX6Q+bqI4rAAjFt7FBv90xoAE5BvxAENOu1hHpRIqH66JE
   euIYSbtxk2J9BJqwZ8pkJVy803SdGhqtIwKrX/wj+7m6Nbr3QF/BTh3pE
   4peyxvSQaJk/MJUMfa7F39BayxINUpDW1JY/DedjMDgLSCq1b8RmuBCPv
   Q==;
X-CSE-ConnectionGUID: kpl/wYpXS8q2RLar3TJUWg==
X-CSE-MsgGUID: oRx+aswHQ1mRYqYFrZ8uQA==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="45125165"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 10:41:53 +0800
IronPort-SDR: 67cf951c_aFtwdXDpXxvM4LM8nf0BhzUrCX88CD1sRQ2VKzX0XOI2Gll
 AL0DqNrma7JE5by9TpsdVpAvOaHsOtG0m0lZvWg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2025 18:42:52 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2025 19:41:51 -0700
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
Subject: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument type to blk_status_t
Date: Tue, 11 Mar 2025 11:41:44 +0900
Message-ID: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
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
callers to uniformly pass the argument as blk_status_t. Modify the
callers to translate their specific status codes into blk_status_t. For
this translation, export the helper function nvme_error_status(). Adjust
blk_mq_add_to_batch() to translate blk_status_t back into the error
number for the appropriate check.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 2 +-
 drivers/block/virtio_blk.c    | 5 +++--
 drivers/nvme/host/apple.c     | 3 ++-
 drivers/nvme/host/core.c      | 3 ++-
 drivers/nvme/host/nvme.h      | 1 +
 drivers/nvme/host/pci.c       | 5 +++--
 include/linux/blk-mq.h        | 5 +++--
 7 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..31f23f6a8ed0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1549,7 +1549,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
+		if (!blk_mq_add_to_batch(req, iob, cmd->error,
 					blk_mq_end_request_batch))
 			blk_mq_end_request(req, cmd->error);
 		nr++;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6a61ec35f426..74f73cb8becd 100644
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
+		    !blk_mq_add_to_batch(req, iob, virtblk_result(status),
+					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
 
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a060f69558e7..ae859f772485 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -599,7 +599,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	}
 
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_error_status(nvme_req(req)->status),
 				 apple_nvme_complete_batch))
 		apple_nvme_complete_rq(req);
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8359d0aa0e44..725f2052bcb2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -274,7 +274,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
-static blk_status_t nvme_error_status(u16 status)
+blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
@@ -315,6 +315,7 @@ static blk_status_t nvme_error_status(u16 status)
 		return BLK_STS_IOERR;
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_error_status);
 
 static void nvme_retry_req(struct request *req)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..4e166da4aa81 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -904,6 +904,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
+blk_status_t nvme_error_status(u16 status);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b21728..873564efc346 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1130,8 +1130,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
-					nvme_pci_complete_batch))
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_error_status(nvme_req(req)->status),
+				 nvme_pci_complete_batch))
 		nvme_pci_complete_rq(req);
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 71f4f0cc3dac..9ba479a52ce7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -857,7 +857,8 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
  * ->end_io handler.
  */
 static inline bool blk_mq_add_to_batch(struct request *req,
-				       struct io_comp_batch *iob, int ioerror,
+				       struct io_comp_batch *iob,
+				       blk_status_t status,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
@@ -874,7 +875,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	if (!blk_rq_is_passthrough(req)) {
 		if (req->end_io)
 			return false;
-		if (ioerror < 0)
+		if (blk_status_to_errno(status) < 0)
 			return false;
 	}
 
-- 
2.47.0


Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B2381EB6
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746767; cv=none; b=q7ocWyZOstjjAp/3DpVhCUN+HElFyavkQs0XFQ3q7YNRGnNz4N0kGWQN2Se6mfvv3SJNlKjx5JdmhtI9mabjmmquvzP/xpRddeHoIszPMBvQ/j6HokHCeKhhObUhwyhFXt6bkUwDCKckKtVUHUG3Kbxek0Dyj7Tc1dbajx230lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746767; c=relaxed/simple;
	bh=PFyLWHE9pTJ4175QPKDcNHyfOtGQRFYQNlkqnpPL1lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDsh/k6SyV0ythyKiIGfb/HBLFZrnee6kxTpZ0eG1a4Pp1tAQy6M8Z8CgjcPabZYWxXOc4Yxbvxgqm3irsRELHgW0pih6TLATPtYHMGDt2xoiNSpxHklhnp1ElXeybz5xmMAq3daJfEwpk4U+ejP08waAoFMlrsGvCnxxybWwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=gFkA1PYc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="gFkA1PYc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f6de72faso45306235e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746759; x=1785351559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyX4ma10pC/frHu+Y/NUZniwvhp9EvBkdSwrv0doV3k=;
        b=gFkA1PYcdgJBj7Vk0LpWIXQdy5xoIr7JDJ4V6i5w+Cvel3qWwN8RjqopjcOvvtLeMM
         uBqArxT30CfTjh0676/kjNn2ppFN731beeq9rT71vPCEeMveVlDaadsU54BS0g55Vd9i
         rAYDk044Y5AnWmYPGvtkJtk3GSJ8Yr8SRmpRQK1DkmZEcGTlkXrF5dLRlooBfwJI5eLH
         6fsDprOXAb51C2TyF8cYKU5NK5+jJi4SjQq5AYe0ragqMg7YykVIzzSw9P39yIym5uVr
         1aK+008mvyyLPI8ftiReDk5SFbPVFZ2UnJ09yY1ZYjvjB1rVitvOviOPkHiza7yzEJeV
         WKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746759; x=1785351559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyX4ma10pC/frHu+Y/NUZniwvhp9EvBkdSwrv0doV3k=;
        b=E8j3OgMUAVa5NHhbHSCHXhN3LOszlBZteLm+vHNrKet7nYMBN9pGXdCN4s53CC9hQD
         78S7ZEG/OGGbFdTN80sh6HFtlvrEyYZuGVinEGYlIs+fkjDKLDe1fUZ/leQmd2rfnMJ/
         RxVDZZwp6mEZh81+cYUm7MSN+03Fxeyzjzx8/zuCwA7sN5T64IfihXUt0VAsxVU/Bu1W
         MJzPN8prDKpRJqtFnnlx5Wym0rY6XJZUNfRUlvYiToJtfdS/UaAOwtWa5eeG3IpjP6gM
         KVNPg9Nha6MHUcAA+pPIu8/PyvgFFnTpyM6bFAQO4bx0qPspWriJPh/Cj99JUPY/4uPS
         F/gg==
X-Forwarded-Encrypted: i=1; AHgh+RpWvq667tItZqGPnrk6o9C/BhJKumyOSsP6jU7UIwVxKdrq0eJNurWxkJLIQKWKqJwpvSON6csO1GZqiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAYgHptt/ELeBT++qzcVfh0FX6bpm8DxfMDor0sVCNFaOlrSn
	7+D6pbtLm5xHla9mVLUS8r51T6uCdKnUTtwdqq0Tjs881Ii0H5tEkRx6RmgqKecYCuuFRJXio0b
	FZulLZA==
X-Gm-Gg: AR+sD13HH0pOUbQ7vAaH19HrNgzhFDDg/GgY9yB2C1t2FQ+yLaDOw2fn2LeQWmR/e/l
	1vszHx5u3YaRAGrAxJfQxjemQpya22XcJeyU7d/iKNAmDJ9ij4eyipY03OEbIW4g9xVpN6HfJ5m
	Tz4F3k7rgvM172veisoQ1Nt79YUqjMK/si7Xj8Q8ToVsmH7ESefxyjRXLmy0C0X0fc745d9cr3+
	sR9vJroVqqZeIyDg19IJl7bAFX9Hu0T/vh/axj2ehqEfdli6cRyS7iyOkPGRz9eOY92ZvBM1c3r
	40zEpNwnvxkwRL/dVnlvsLQiFccGizcQirlnfPnIOrBfLQXxgcwbQWNC5PLddkz5vbrnUcJWYZE
	TxJ8FJV5NKqXkPP4BvunYWtewi0G1Vns/ncHTYMe0JzDxdUwv4ubBvbBEGqupgY02sLbtvt/Xv8
	yN4/OsPEfBYIF1ijsnVh8s91omO2Cr3GCLhZ2fuSk9AMb4nIs=
X-Received: by 2002:a05:600c:6610:b0:492:6f5c:fd8c with SMTP id 5b1f17b1804b1-4956a511b49mr53704175e9.15.1784746758682;
        Wed, 22 Jul 2026 11:59:18 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:18 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 9/9] nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
Date: Wed, 22 Jul 2026 20:58:41 +0200
Message-ID: <20260722185841.449934-10-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PCIe topology cannot route a P2P transfer between two devices,
the DMA layer fails the mapping with -EREMOTEIO, but ib_dma_map_sg()
returns 0 and the error is lost. nvme-rdma then fails the I/O with a
retryable status, so multipath requeues it forever and a single path
wastes its whole retry budget on an I/O that can never succeed.

Map the data and metadata scatterlists with ib_dma_map_sgtable_attrs(),
which preserves the error, and translate -EREMOTEIO to the new
BLK_STS_P2PDMA status so the request fails fast instead of being
retried. While at it, call nvme_start_request() only after mapping
succeeds and ratelimit the map-failure message.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..2f50509a7a61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
-		ret = -EIO;
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret))
 		goto out_free_table;
-	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1504,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
-			ret = -EIO;
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
@@ -2026,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2039,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
-		dev_err(queue->ctrl->ctrl.device,
-			     "Failed to map data (%d)\n", err);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "Failed to map data (%d)\n", err);
 		goto err;
 	}
 
+	nvme_start_request(rq);
+
 	sqe->cqe.done = nvme_rdma_send_done;
 
 	ib_dma_sync_single_for_device(dev, sqe->dma,
@@ -2063,6 +2066,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		ret = nvme_host_path_error(rq);
 	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
+	/* Peer memory unreachable from this device: don't retry. */
+	else if (err == -EREMOTEIO)
+		ret = BLK_STS_P2PDMA;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.52.0


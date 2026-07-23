Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC047FAE5
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839407; cv=none; b=ciSGtAQPRGAxEJo74lvbi2Q0lKo1l359VEMhtpFi6zUej+LDWjaY4kTnMO6ClzdOhEUnFwG+V4jDwmoCVddQ2Giujg6xw2OlqFBgK4l/7NDC1t4yR6rrMV/Y0yLqWoQGztyPtULJpFLsAU7XIoFn9kOWo/ql4glsaGFwsvLUeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839407; c=relaxed/simple;
	bh=eshNG+SSpxeB0R+uSz5ejlLdh8nbo3X4lM9abX04Wkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqpCZ/kzSkV3kMIq9V+DjHQ3CNTLhkyoBqQnNBTd6jwRslNLtpYoABC4Q0Vw8kx2x0F7ojQTo8s1XXW4JsyoqrkX7bHRLalTvSAdj+ZiZO4oUPuwrzuXhXXOpo2+YnS4MsVK82KcLkJoYkVOEyvdtYpWSVrc08mzIYsM1k2sodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=JP/MQufB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="JP/MQufB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4728c12ba97so667243f8f.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839396; x=1785444196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cyyjdg8Mj0TLFiupy7K/HZDk4131Cjbb/1b/0iFmC/s=;
        b=JP/MQufBS8sYRNFsRJke4HbFtOcpynWXtaii0Nkh9nxYLvzmUkC6+/GW1vBl/FFYJz
         AZE/zDqNW7APG7+P6BvOApXLNTZ3KmfN4wFnysPIK0fYliRydP5641HFHHZRnchU0HSQ
         gSNGgLH2DJ5n4O4XPaD+42bdczIO1eYe5oHPyVNZ8kOF8Pb6V2l46scxhzbRFw27SDI6
         clHHVUIVYeoUpMokIUlcCa8ZI0YHJfA/IltHet7Geu3r0sgWp3BfePaXf6w0JiUCLTLt
         LUCnkQitN0ajMKyxO7mvooDh9rgQy0cPHV5auaFHzJGSoX5MigM3RBC6OsypKZy7ZWWs
         cTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839396; x=1785444196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cyyjdg8Mj0TLFiupy7K/HZDk4131Cjbb/1b/0iFmC/s=;
        b=Cw9maBwZu7HqDj47pcze8/gA/az0CIICEg2lzLgjT6ieeIoZaMjK39mbFzil8Dz0B/
         d/UIunqSFwDdMbAOz1v0nzBrwOQWNiV+LqrfyKjXnn0ZLIyXtl0s33f49UUDg7sXpkjI
         Mxe3BxCNaM3J20q4uGa1qXSQXVmZ9pPWLCjEx+bYnPuXim+Ddt4tIxnH+aAPSmAcirtG
         W2WHgZEHQZoGC+KrKYf5B+SVcZxidh+rNa3fhSQbGngSd9krE1vfXSqwjbAghFRIMqMK
         z8tMGuRODPh6ciL32MilG38E3JUE1zgoug9+4wXfMi5AzDSDNaOqU0Wi5KcBXB+mx8CY
         GHuw==
X-Forwarded-Encrypted: i=1; AHgh+RryyO4zgJN2U6EoZ9afAhCuC+475kuWT+Caz6irlBVAcD87OMgALwIORAvE33YBbF4ag/oLHToyjCeyoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQim8/jGUiVQ/IwHmn0MLgEI6TpRr2QJHuy2SJ6eB7IdXiMzSY
	jnCXmfW1QRhy4HQukZ6xVkEhsI0SHIMoS9dLuT0HaG2FHqq660Z6kJMzT/xa5FWhYA==
X-Gm-Gg: AR+sD12No8eBBFPpkpU2FX86i5Ol2VhSHzONFyynFHBwt+mHHg9LmCWtTnqI8mRjkDw
	jlCfwVjsKMjsh1ipKBzXvFF7vo8T6LLghbKjMzs93pQ/rkIF3b6JfV+rxBIHdaT53/NaRh2sHg0
	FjkZ1OvkffCC5t65hh9o4qvew7Gs64m9IuEABrpYc1/xvAlJf6REyJgdy0l4p6aH2s0vxop1n85
	khwNgoG33vz4ty+H4ep+QsI31Zf/ZsxWCyVu+mheox6OMox74VLQy47NHxQInLwcnL3iqnOzBzH
	ZS5qKlBiIGsvTPSN7+ChNcDI/y+u7Rw/vYKtcO6f8rA4/lhy+o7KVV6gB9pJ+tBGs7aU2IAfGpz
	cJw4deCMw4jnrEJGubaD0BubA7dAduaGbtZGJgkBWAxXaKES+VmxG+fKOV50hLuoAyDdIV306gC
	RFv03p5FZV8ZwYMgDJ99e7OEGMVKtlEwpoLZeiWLnCAxo68DH4vnCKrNr++4TVKO1kbxz2fYIF8
	vbHwqVjIV8a2ZJUYC0hiAf+lMr/5kP4wZa5a45GUg==
X-Received: by 2002:a05:6000:25fb:b0:47f:9446:95a1 with SMTP id ffacd0b85a97d-47f944696b0mr1793960f8f.25.1784839396094;
        Thu, 23 Jul 2026 13:43:16 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:15 -0700 (PDT)
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
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 10/10] nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
Date: Thu, 23 Jul 2026 22:42:06 +0200
Message-ID: <20260723204206.76930-11-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A P2P transfer the PCIe topology cannot route fails DMA mapping
with -EREMOTEIO.  nvme-rdma folds every mapping error into -EIO, a
retryable host-path error: multipath requeues the I/O forever, a
single path burns its whole retry budget.

Propagate the real error code and return the unroutable case as the
non-retryable BLK_STS_P2PDMA.  As in nvme-pci, -ENOMEM now requeues
(BLK_STS_RESOURCE) and -EINVAL fails (BLK_STS_IOERR); -EIO stays a
retryable host-path error.  While at it, start the request only
after mapping succeeds -- nvme-pci's order -- and ratelimit the
map-failure message.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1: requires "nvme-rdma: use ib_dma_map_sgtable_attrs()"
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 63830334c73e..2f50509a7a61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1486,10 +1486,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		.orig_nents	= req->data_sgl.nents,
 	};
 	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-	if (unlikely(ret)) {
-		ret = -EIO;
+	if (unlikely(ret))
 		goto out_free_table;
-	}
 	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
@@ -1511,10 +1509,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 			.orig_nents	= req->metadata_sgl->nents,
 		};
 		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-		if (unlikely(ret)) {
-			ret = -EIO;
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
 		*pi_count = sgt.nents;
 	}
 
@@ -2033,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2046,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
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
@@ -2070,6 +2066,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
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


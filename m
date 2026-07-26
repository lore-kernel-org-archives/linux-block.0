Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45A3AFCE8
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065585; cv=none; b=lxSspzCRrk+Mh30/JDrd03MQasSreta6qCEhPCIOI0WDslpNTN/EqlBCbfiro5gfno1oVTxlU9/JFLugEnM9CDv03Qc7CA186tzZ8HzeRDgkWQG6KdBxxTmw8YeoX4QO5C1q8w9FzSeannOSxzWMFsK+3M9hH4m7aC83KAzCxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065585; c=relaxed/simple;
	bh=H9P5Xbuz/sTn32viro02mVv351LoCChcVH807+lKGhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlPio67FO3LIh+rFq6pKUecbMVQmhPtQw0ao5Qx0UDhxyi0QtInU+yU1XWClXSoN5YseL57e/Fi8qQqWz/2FJCUlSH/tVzjiyh1aVUiOJvw9jMdO7vsYp0nwGjOi+4gRMiS/nzitqiEB4YMESQscAohD6jhi1VID93+MAyoOxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=YTGLQV5z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="YTGLQV5z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49557167508so18396615e9.1
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065582; x=1785670382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=YTGLQV5zeW+uWE5H5f45Ba8jX453Zgmqv7NyXudf1gGa5hHvageH3GW27rUl69YSyP
         aH6aGIJIWVAbAFy9c7kgR8jUCVT2QyPJr2mvA9UMR+tjrbyTP5+Ly2eY7FNIYKCu8Eti
         PSgR0rKjktTrKpZNbvXv36SYcssiPLsSEw6owHID6d5NZkG2WflkK/TGKvvcqc3HxzJ1
         Zhi9eacNWuIJVltTn0T2H7uIpVSAr/gqyvZcHt87/TXppnkValvnNhjapQeBjYDSGAuU
         XmL6bLNp2qtAAr9dKqjTsyDAd5+NhNJm9cVxBjy/XH4UOLGp+kQlIro+Q3HOlJIv1IgC
         HH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065582; x=1785670382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=DOeBjGZR1ZC2WmP9IEZEbr2d/VKEVj5yUODgcbr/o9/9en+jIreUP3ZaqRbxPSh48D
         7enLO7rJhEEt9uWcTbCYXX8yn3N0zc8m5+sH2Yq1TUfTFA7TmQarYVVWGys1c2Jw/2vD
         TM8oaJsO6TO9KeLHt+ygwFvSGX1qPsKVAxS2OLJk0mTxGlm18n1N/KpckWY6Sxtu7fLT
         5m65z0HmmzmQs14bA7j2ibdT3L+SqJm+74rvxnR+Y7HlWLElpk+XWZRTOpGHrUadgfIA
         lGWRPDHbrC3xKqdUinVM5pw+OE2voaphXoc4xi9DlnndzhlbQmIC0tH30KV5S6K2IFTK
         ORUw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2B7cXAsjjpBz1PTrGNn8D/uZ1j6nAcdr56x2RGivYn2iCaP+r3MqgXmZbtTDArtsFtFaOR5XQ/Lcf+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwylPzyjpcTOW2fCw9/hM3xaRDFD29sbmFKnFF+BdTwixf+jyCp
	uex+sUJz46dqDazFuQELFMh/lQOOP+KRPdtrx2kvt85wSl+w71noXWyWH5SjxrhztA==
X-Gm-Gg: AR+sD11KTzU0SWU7D/5SDvUmnT9dg8zbWs6R6xpHmyuKYklOIzqmRI9capBxCorNFeY
	40rSNpWHbtHq4sbVaqLNK5OBQxTtmu4C5LPottb/1KTs+9y7e8bFJMLmr27AWVcpG3yAK4LFyJI
	uq3PLTn89Z00MxVQ8tloelkuYInLqEgYXw6sOPnkH6WA90wQ8EwhvLQ+3Ir1nE50sx54bFlKH3U
	CcdbXxlK6SjH3pVFSLiaCN7Do5YTckeNs8eTtEj/+R0TOauJzEQkciITnPfMmfuAK4U+OnIeBu2
	ldlNkmOHY5evMlXpsFRJDWiF3bPow+vPbQ/zMqRawMDATHo55rCtgrOENX+qiH1yvp3rX1BBIn/
	Tzud0jzZaK3xJtwHiOmv/jNFpYaVsSq6aN3uyqbMV7Drq9pfIHEbfeIp+zbFaHfDAGLLe4CsdCH
	/z1tnHYTzUjVxsfOCfioDzKiwX5oG2lIxcUhWI0P318zzGoFKgQ1oIwVe7J7AoHgvLkUt+sKgtZ
	8xcCb2k/WkC4hq2OsH4OJh3YGtP2AtR7AyOYrJXh3o1NmcrCESlRlCIio0V3LY7PT0iHA492lSe
	1a1wB1tU7osZJnb8s04IuSJq
X-Received: by 2002:a05:600c:46cb:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-496b76164b3mr52698745e9.18.1785065581534;
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 12/12] nvme-rdma: factor out the scatterlist DMA mapping helper
Date: Sun, 26 Jul 2026 13:32:29 +0200
Message-ID: <20260726113229.2154269-13-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data and the metadata mapping do the same thing: describe the
segments blk_rq_map_sg() produced in a local sg_table -- the embedded
one's orig_nents is the allocated size, not the valid-segment count --
map that, and hand back the DMA-mapped count.  Fold both into a
helper.

No functional change.

Suggested-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2f50509a7a61..525e5aea65a1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1465,11 +1465,33 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	return -EINVAL;
 }
 
+/*
+ * Map the segments blk_rq_map_sg() produced.  They are described by a local
+ * sg_table because the embedded one's orig_nents is the allocated size, not
+ * the number of valid segments; rdma_rw_ctx_init() does the same.
+ */
+static int nvme_rdma_dma_map_sgl(struct ib_device *ibdev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, int *count)
+{
+	struct sg_table sgt = {
+		.sgl		= sgl,
+		.orig_nents	= nents,
+	};
+	int ret;
+
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, dir, 0);
+	if (unlikely(ret))
+		return ret;
+
+	*count = sgt.nents;
+	return 0;
+}
+
 static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1481,14 +1503,10 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	sgt = (struct sg_table) {
-		.sgl		= req->data_sgl.sg_table.sgl,
-		.orig_nents	= req->data_sgl.nents,
-	};
-	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	ret = nvme_rdma_dma_map_sgl(ibdev, req->data_sgl.sg_table.sgl,
+				    req->data_sgl.nents, rq_dma_dir(rq), count);
 	if (unlikely(ret))
 		goto out_free_table;
-	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1504,14 +1522,12 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		sgt = (struct sg_table) {
-			.sgl		= req->metadata_sgl->sg_table.sgl,
-			.orig_nents	= req->metadata_sgl->nents,
-		};
-		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		ret = nvme_rdma_dma_map_sgl(ibdev,
+					    req->metadata_sgl->sg_table.sgl,
+					    req->metadata_sgl->nents,
+					    rq_dma_dir(rq), pi_count);
 		if (unlikely(ret))
 			goto out_free_pi_table;
-		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0


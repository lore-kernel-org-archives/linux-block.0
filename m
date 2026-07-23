Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06A4823D9
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839403; cv=none; b=tMsp3o93eQpib6/HkqQBcOIHaCXlU/EFNn1bf766aUmgcxqxO0/SFS0RR2QSWENBjskbKzUR9IDXWDkTPOqrVbmHcKYWW/i0lpqt3Kv44DBbhaQuepsl0bogCjv0yaKa99L2hL1MZM7qzFrUBZL4d6AEwnRKyg9Rkg5aQuwpYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839403; c=relaxed/simple;
	bh=sQcSSX/jufOA+fic/HSdeMNwwQDiSrn4ZEB0dsr0Z0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTRvrB+BgSX33VAVJ1gikM4TNwm0FHLGEbF34HC0EFtPoI9NWC7bfhfERCpe7j2uxVuKDM0wkvvG4Bg3L22gWAVlbkZucHepdDUEwq3RFtUzyPJIJUSFzBBc8obUbQ5KeZ2jap6GsaTQtQ2pbgC4Cl0U1kwkp61Jp4Y6OsL+yxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=A0PhEHmn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="A0PhEHmn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so785186f8f.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839393; x=1785444193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=A0PhEHmnTJ9+QVVolXbcvu7kUytNNzkuhnHI49ebvWjAT6aQC68XJXaZrWn7EYoFv5
         UIO5jsHccWyUmv7Nv/1ttGqpO6WGslxxl0LC7v3d2+kqu8O6A4jeX57CmWsLOJU5+l07
         JUMPQJJdBfPptyNw5ZmEZpCs6++PzJKMUNnrMRAA6hdTyIF/T/F4TH/OpLZvYP8EtPdH
         axSjIMMIRo/9Qv11/Sq3CpM7Sp/JMxKM93gVOS9NxH9ur9U9e2WTf5uKUKO+kc1gb6gb
         DoXu81Q0TiGqj9JO1cZDqx/lBMgNGlBkDNSOWle9RU93/xX2Cd5Xm0D106GZydDPVLmQ
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839393; x=1785444193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=sd38QTcOEJuh5tCtTfvgP2MtwUZ8xd7Stxx9n5H5t3Axvd83F8UITFlJqUwKI+/q+W
         hdW5uYp2JMoZqGp1iLGpoprNeSg0kHAPgM9ly+qx7Quq+5I7MZX9I+f+qCQkS0zvXGFh
         pO1rdKBqiySpZFCBXI/CaWs/RdQgs5uIOd0Hq2szluenjY+TC9I3vdilvSqatE/K0jGM
         DRGE5zdrrxkgX8ODO/ijoHkR3USWKgjqDiShI0GQcdqL/05ZyEbsolpjLB62YZCB4xVs
         4uy7v261bBz159aZPxDR1pDf0HJgfb8/hHpX9jMxVAmtj4c4bPOc59ocaNZHKK60QqPj
         qmxg==
X-Forwarded-Encrypted: i=1; AHgh+RoUh5hlduyEVH1hVOh6lOKZSmNzjjRVdm7srd/wNEcHcgJHQa7FK9NV4LZatTQMH8MngPJJC+1p3Are0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2lD5+KunZegn1+kf4EijSOzvphakg6mNvBQ4zDuBmw/UXCZx
	EmNgtwqejZg2OEjltbpbYEJwMK09pjehSkAN7gXCQyluGJh8OLsg76mTZk0f/s0pHw==
X-Gm-Gg: AR+sD12ERSVDJhRJLLS66lTqq/BZZ4WUsSuXqk20eKHx70IY8By58c5ZsBjey5IhTmg
	voo8+II0ljvVvfBPZSTrdNrC5/ZWA3WaGYO45pzEPu0+0AlvvHW1cRTimxC6zujn6YWzSffrhx7
	zydrUXlXzyj9MSwjmPu3QQyPPIzX5NDzsv9sn03MzXuVGV0GuPjylO0W00yhJdwJLTVvHhx6lUI
	TzWQK63BnRqrhM9cAJFDJOUFbqq4o+0KDx/d6E4x6iwsyNjPXz4tr/9m/HwwWkE690ibvGxoPCG
	cZ4n/T/G3b3CuA9nxHZKPhZmkd5igzIoQgr4xZu01YnKPMSNbAiMx26o/u6za0sfbuTH51xOdw0
	qJ3UCC03z50XIFND4nnhC2CcgdR4MiudeOoWrfjMcqDYz+3zpdtd5aVSk85BUIyCiN9672ZUQG7
	RbnZjU5CYtVzB8zYPayN01QD6aDork6Aa1E8gOFgHkXqDaXY9U+8N7VIgr0kdWSF4vQ91fWvBJI
	u/EldBVhhr/DVURYdjdp0Ctu6010Ufz8gQO5aY6nA==
X-Received: by 2002:a05:6000:4203:b0:47f:7b75:61a with SMTP id ffacd0b85a97d-47f8d71f494mr6221114f8f.15.1784839392888;
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
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
Subject: [PATCH v5 09/10] nvme-rdma: use ib_dma_map_sgtable_attrs()
Date: Thu, 23 Jul 2026 22:42:05 +0200
Message-ID: <20260723204206.76930-10-mykola@meshstor.io>
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

ib_dma_map_sg() folds every mapping error into a zero return, losing
the DMA layer's error code.  Switch both scatterlist mappings to
ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
act on.  No behavior change: failures are still reported as -EIO.

A local sg_table is needed: dma_map_sgtable() maps orig_nents
entries, and the embedded table's orig_nents is the allocated count,
not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
same.

Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..63830334c73e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1506,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0


Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F2292B54
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938320; cv=none; b=Pn7JHDSYVTdQbTmSkzatB+ng+7EoTqq/sAK3eZOg58EVHAC1A5bNAmp7+ulsrk8k96rUyx+jI5ix106reQ7cynsPKAgqX8D+23gNY42n4vbx1tMhup3BRJnkU7nNK4G1HyiIEsmOjOFuG0GTdjBNyEgw+hxeIyCCstNmrKFaZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938320; c=relaxed/simple;
	bh=UXMDuvciehfdM/JpQpcfknw3TaZdhJajBPgetayGTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssOf82HMZgKGh9LuQilYqdrt5cWhdKPHtkar+pCBdTdLjiCDrXkpPijpJvITm0UnQL5K9mS+beJckbCYtjA5D1YC8Vn/wj+mX9xGb/4xII2S3xpThCZBKTwVHjuUhOtaWRt0tL9BUDGHRJjBy/7t/YFsWPAztpiQy3/N8kViJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSdY/1KA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSdY/1KA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c8632fcbso2222127f8f.1
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938316; x=1764543116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aczXTymWXQPIGDaXnf/nBr9xYQNzFFU48NeAsCHNOPA=;
        b=mSdY/1KA049Dl+KwP552oSPQcLPG8jtb1WMtsdNe3I0iIAxyVIukExEx1SRjVM5Ier
         tRSAL8ACfC7NdWhEI7NrX6jJbBxKyNwSJfElCoUTdQ9n8bo1SRQcznuakYQ4oLioPzix
         hTzAgWjv9vd0knKSstQ2hUFCkz0ocA2SDp32HjBS07ZBP9XbElMN0+3/PEEIm/GP6OCp
         Azcye8vZnEgeF7XBgJQHariw/VvI90NBbIja/657GD7/clhJE2t5KIzbfVtFbEplbBb7
         nndgyeDZ4n67flVCYVvn6WC/n9J3lwvQFUwJkSZZaxpozVFeUnfNPAWEOvfJM6tx0W7p
         C7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938316; x=1764543116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aczXTymWXQPIGDaXnf/nBr9xYQNzFFU48NeAsCHNOPA=;
        b=Mrhg+3cTh7sxBS9qu33SHvXi3KP7d0AI1tucjtj3gbGZfLuokdEMUSt0aoH6cIb+Cc
         OvSvE0OHim4tWOBKQrkWJoQ7eKhmfFb8W08MEEynqf6Grn1A78NFLVRNTySQedLqFUms
         qRKlTO0oPZXZXv+ExGzRLKrz3uqqHJPyOjhd6hu+kqhv55CT0OVZtx9+IVShVs2nj+Ye
         Zfq/cJor+HQ6Vi7h2uN7AO+ub6zmV6WCHjr5Pwn9U4bQ55wi84Ifu09JvKP0JhHI7+PH
         FvQcLtVXh/M2ajAyYVDR3K9wawJPa9+nNyggs2dXBUK0CMeyKw4EztS6Ha/IfhVct6V6
         6TEw==
X-Gm-Message-State: AOJu0YxghdRYm1ln0BJCJOHbruX1FJ1FcIdUQM4WPBu4WwBq3HOCXFX5
	pk592s7NLvLFMf0tdXx/gPVJedTG0dNpudrdqcwQmbue9K+wXh2BerCBFntY6g==
X-Gm-Gg: ASbGncsDOJ2gQpmvtEkBJg1OkMjTlbwZuE6fF1yOAbdZX7KnPzIeDBYIGHkRWd3GutR
	qudknnP4jsNzr2mIXSUe873RuHdMqxUhyDAxuik8iJS3WQTQrqtNlCu1KkIEOySHZ8apgMnMKh9
	elq20P7L0TgxdC8HpZpMCSeUKPWZ4oGsE8q6CdRjzH7jIdUmV6OFeiVPlF1zQxm6PSoE0cEiB61
	QHIehY1owXtgVVnQX6lh3E4SdsxcLskbnHAzU6/mGYS6lonm7lmbcOC4HyBjfGTxK31VWStO72E
	cwhx6zRZwoCziD+Mx00Fwx4jbPKPwz7ayg/8+cAZCXM3bDET1nLMIy3r7Plv1VmGN3X7Uw7LyDU
	KXvfsne0uqUNTsCF1JBhehCIK+2OfaGOxg5gVCDPGaiRvBsGkZMa58nSpvli4bIh0Ov0q8Dn7Jg
	kNE8ImWcZkAOPDYA==
X-Google-Smtp-Source: AGHT+IEhsmDeavDDsXXTdPeMYswvjoeFYMEcGIVgrZUZIxbXidFIxZRmwhVPCPHioGiavOVUtI6phA==
X-Received: by 2002:a05:6000:2893:b0:42b:55f3:6196 with SMTP id ffacd0b85a97d-42cc1ab89b3mr10647235f8f.4.1763938316187;
        Sun, 23 Nov 2025 14:51:56 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:54 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 07/11] nvme-pci: implement dma_token backed requests
Date: Sun, 23 Nov 2025 22:51:27 +0000
Message-ID: <a86bbe2d8d105ed2c342749cd46ece2d1c537821.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable BIO_DMA_TOKEN backed requests. It requires special handling to
set up the nvme request from the prepared in advance mapping, tear it
down and sync the buffers.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 126 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 63e03c3dc044..ac377416b088 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -797,6 +797,123 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static void nvme_sync_dma(struct nvme_dev *nvme_dev, struct request *req,
+			  enum dma_data_direction dir)
+{
+	struct blk_mq_dma_map *map = req->dma_map;
+	int length = blk_rq_payload_bytes(req);
+	bool for_cpu = dir == DMA_FROM_DEVICE;
+	struct device *dev = nvme_dev->dev;
+	dma_addr_t *dma_list = map->private;
+	struct bio *bio = req->bio;
+	int offset, map_idx;
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
+
+	while (length > 0) {
+		u64 dma_addr = dma_list[map_idx++];
+
+		if (for_cpu)
+			__dma_sync_single_for_cpu(dev, dma_addr,
+						  NVME_CTRL_PAGE_SIZE, dir);
+		else
+			__dma_sync_single_for_device(dev, dma_addr,
+						     NVME_CTRL_PAGE_SIZE, dir);
+		length -= NVME_CTRL_PAGE_SIZE;
+	}
+}
+
+static void nvme_unmap_premapped_data(struct nvme_dev *dev,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (rq_data_dir(req) == READ)
+		nvme_sync_dma(dev, req, DMA_FROM_DEVICE);
+	if (!(iod->flags & IOD_SINGLE_SEGMENT))
+		nvme_free_descriptors(req);
+}
+
+static blk_status_t nvme_dma_premapped(struct request *req,
+				       struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int length = blk_rq_payload_bytes(req);
+	struct blk_mq_dma_map *map = req->dma_map;
+	u64 dma_addr, prp1_dma, prp2_dma;
+	struct bio *bio = req->bio;
+	dma_addr_t *dma_list;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	int i, map_idx;
+	int offset;
+
+	dma_list = map->private;
+
+	if (rq_data_dir(req) == WRITE)
+		nvme_sync_dma(nvmeq->dev, req, DMA_TO_DEVICE);
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	offset &= (NVME_CTRL_PAGE_SIZE - 1);
+
+	prp1_dma = dma_list[map_idx++] + offset;
+
+	length -= (NVME_CTRL_PAGE_SIZE - offset);
+	if (length <= 0) {
+		prp2_dma = 0;
+		goto done;
+	}
+
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		prp2_dma = dma_list[map_idx];
+		goto done;
+	}
+
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
+		return BLK_STS_RESOURCE;
+
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
+	prp2_dma = prp_dma;
+	i = 0;
+	for (;;) {
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			__le64 *old_prp_list = prp_list;
+
+			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
+					GFP_ATOMIC, &prp_dma);
+			if (!prp_list)
+				goto free_prps;
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			i = 1;
+		}
+
+		dma_addr = dma_list[map_idx++];
+		prp_list[i++] = cpu_to_le64(dma_addr);
+
+		length -= NVME_CTRL_PAGE_SIZE;
+		if (length <= 0)
+			break;
+	}
+done:
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
+	return BLK_STS_OK;
+free_prps:
+	nvme_free_descriptors(req);
+	return BLK_STS_RESOURCE;
+}
+
 static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -875,6 +992,11 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (req->bio && bio_flagged(req->bio, BIO_DMA_TOKEN)) {
+		nvme_unmap_premapped_data(nvmeq->dev, req);
+		return;
+	}
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -1154,8 +1276,8 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
-	if (req->bio && bio_flagged(req->bio, BIO_DMA_TOKEN))
-		return BLK_STS_RESOURCE;
+	if (req->dma_map)
+		return nvme_dma_premapped(req, nvmeq);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.52.0


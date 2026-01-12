Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA19313E30
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226536; cv=none; b=tyShvLbn+NaGNJxKY+ffeO9IQ3QimOpJvR5kQ+qjP/VpQ01foh8iJKPmBvNhyPstx3/W2GJOu80Q1/HPQWq7mi60oh2GC7r8Ak77KSszk8qfSzxRjXcnadAN8FKlT+6cVUhQqvZfXQssoqS+jjQFGyrYS0r3Qs2E+0oal9/p6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226536; c=relaxed/simple;
	bh=gpy8VJ5E4l4WTyGUooT1shmrQ7wwVpsA6QmIlYHeDZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=li2oAkurmmBc/rK7bsf00STMim3DDNQHuKw6KcuCIKme2HaPZFCiQT2hEvKeEA8E7wbkDCxjhKa/Qb2HxR5jnS8jgnIUxvojCoCUGzgeW9JW/P+aQLuv1uXq8UoaVv2wIlmUA2TgbInQrC1AJMLZFQI9AW+xUu/9X2XtatnKFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TgJMsC+9; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TgJMsC+9"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260112140210epoutp016c9b8ee19405ecbb29f8597bb1c045c7~KAKk1oLS00730907309epoutp01b
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260112140210epoutp016c9b8ee19405ecbb29f8597bb1c045c7~KAKk1oLS00730907309epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768226530;
	bh=F8XIfRGmzdb5XWDs6wzAnnRSl2u/PNPN8Ha1qyK76Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgJMsC+9MrSRiaIWGKRtv9yZ1FTj9wU0jqNftNmvU/q0jpR4gitZvcc+IeWGJBgiN
	 7ApUvmmGIO0hvEjZGqWqj1ZeE77WiYu21fWcLoRO/SfThpYd8wIqcKT5J6A8QZZcAL
	 OAm5wTWpVopxxAtf66lhAy/11LpPeNI58qBfx+AQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112140209epcas5p34a75489e5b704a71f6f1e2d5abfe17f3~KAKkHukyi3268932689epcas5p3c;
	Mon, 12 Jan 2026 14:02:09 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dqYwJ75Pqz6B9m6; Mon, 12 Jan
	2026 14:02:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d~KAKiseA2t2139421394epcas5p4s;
	Mon, 12 Jan 2026 14:02:08 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112140203epsmtip102e49e4a80ba13f22199a3e119f3dc9b~KAKeY6_X02303823038epsmtip1h;
	Mon, 12 Jan 2026 14:02:02 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using iova
 state
Date: Mon, 12 Jan 2026 19:27:35 +0530
Message-Id: <20260112135736.1982406-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112135736.1982406-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
	<CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>

DMA IOVA state is not used inside blk_rq_dma_map_iter_next

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3b528369f5454..065555576d2f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 
 	if (iter->len)
 		return true;
-	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
+	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
@@ -1010,8 +1010,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		}
 		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
-	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
-				iter));
+	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
 	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
 	if (unlikely(iter->status))
-- 
2.39.5


Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133F263F5E
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228956; cv=none; b=T/peDPtEd9SFguo0UidHz2QxRHixyRGrapcRheYWJuIr6kZ1vp3WswmA8feuJhbrhr02lYeU7AX+JNa7QQjOoMoW1IGek9UX6T38VZ9/fUqotxYaC83plPR+1wr+zYulzTTm6AK2nYy0s7jjtA0pb2YiGxoVICv6GOTiE1HaHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228956; c=relaxed/simple;
	bh=QJwpMSN6xVz9/Ut89v7uxmuH+qwHcm3ZA8rRKtvfReI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=RVO+6alwSmrMW2WUyyabGdFjvtEGpiuJFKHr60rcmcavuT1GvVg8C/SPBeSVpaBaIeofNIjA6ML6mEFGEzx1VShrDPRvl8vgZjs+4gW2YcPKxhCwzTCK0BoKxY6cKE/+gs0eEFsreK1nKGdVm4MyjKguiQf2XkYqItXNtOCHRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PwMQznoF; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PwMQznoF"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260112144232epoutp0240b2f7e4803ba2495695004bc20accf9~KAt0ViniL0134501345epoutp02E
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:42:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260112144232epoutp0240b2f7e4803ba2495695004bc20accf9~KAt0ViniL0134501345epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768228952;
	bh=1Nwy38gzNTR9aM/4Tkn5EF8sUONjKB4ojmLE6vwCAvk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PwMQznoF7DhOkSKRckq31O4FWCHTUf/uEXpbUZeZ5nEIZkBg8wHYC+EnCBNfOqDqh
	 mp7unvcMOqwZX3K4PqAmPOX3eyDU/4EE2kX3Z1oTUdozE4Rw/gHnyH8PkGn2tTaeCu
	 YcDED1qZi7FNlxV++SKwS3Y9WsgZrVYl3Uf4wlCc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260112144231epcas5p4f7f81ae95ac8bd20631d34a53cb7a215~KAtz6gsGa1469114691epcas5p4L;
	Mon, 12 Jan 2026 14:42:31 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dqZpt6B18z3hhT3; Mon, 12 Jan
	2026 14:42:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18~KAtyQ4Juy2690926909epcas5p3j;
	Mon, 12 Jan 2026 14:42:30 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112144228epsmtip1781bb113d9d4b9fdc8aba7f85b6ad24b~KAtxDr_lZ1455814558epsmtip1x;
	Mon, 12 Jan 2026 14:42:28 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] block, nvme: remove unused dma_iova_state function
 parameter
Date: Mon, 12 Jan 2026 20:08:08 +0530
Message-Id: <20260112143810.2046599-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18
References: <CGME20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18@epcas5p3.samsung.com>

DMA IOVA state is not used inside blk_rq_dma_map_iter_next

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq-dma.c         | 3 +--
 drivers/nvme/host/pci.c    | 5 ++---
 include/linux/blk-mq-dma.h | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 752060d7261cb..3c87779cdc19d 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -233,7 +233,6 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * blk_rq_dma_map_iter_next - map the next DMA segment for a request
  * @req:	request to map
  * @dma_dev:	device to map to
- * @state:	DMA IOVA state
  * @iter:	block layer DMA iterator
  *
  * Iterate to the next mapping after a previous call to
@@ -248,7 +247,7 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * returned in @iter.status.
  */
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter)
+		struct blk_dma_iter *iter)
 {
 	struct phys_vec vec;
 
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
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index cb88fc791fbd1..214c181ff2c9c 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -28,7 +28,7 @@ struct blk_dma_iter {
 bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter);
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter);
+		struct blk_dma_iter *iter);
 
 /**
  * blk_rq_dma_map_coalesce - were all segments coalesced?
-- 
2.39.5


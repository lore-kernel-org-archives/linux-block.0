Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCC19AD8C
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232980; cv=none; b=Ts2a83aOMIbMIraZEWmGV+cRWHi9UH+iXMfj4wD7JE7qKL8uJNUgEW3waSQoydkl6Zck9+rQ1za4w1By3evj+iY/RxsmzfeH6FgUiLpqlj07SAjUCgWY9OiTMH0P2EgZQMhGxvB4PByNaOyBfS/0MXFOk5qhiHvCzF2XHH4qWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232980; c=relaxed/simple;
	bh=pmXhEueMNzAmHMwK12n9FqH3biM5NMxUPCzFTJngV/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb4WjwrxxGrmgZZOj0T5VC3synQQnmrMv46lsvRWLSHZEQ15qXlSgE1iNnVTZHwdcov0Zsy6FL+OtAwa8cI7YiaV+I/HYfXGkwMsDYIJAh7+5VgjXLhP9KBY1jL9mEx1ncy+fM08KBIKbmCAZARmvOsKkx4zGxVUvAtmZUYqGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dPPDtMlS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPPDtMlS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kMw2Cuaxlh63EApH3U8Zzz8V0/T8t6iiXh5U9SCMTV8=; b=dPPDtMlSh5EqVajpXacOLoNTjV
	I7tSbj6jbKVE4jcKv9BK2qHvuyX4cn3MbdIfbA6QrGtpr1W749P4iWc+3VXIQOBz/fJX9rv1Ve5N4
	JoaF2SedFuiIMlJW1dzHAgMNO5YGOJPwMvKqd0NMklDXNlGFyZREGbZPX81xugyI/QZOhlYkKWfls
	I1gKVVijHJxQesPG/MARoLNhpR7gupNZtW2EK0cv5itXDZY0S40jLTz05Vi4jVACLFgFIV7qeYO6R
	Go8qL12Cn5fRs/SSmktNh/5gCU7TiblPWuH459zjgecLd+v7QqXJ1rUY4su/oHWMKrdLC67AthFgM
	REvLHUsw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaBqA-0000000Eao9-431W;
	Fri, 11 Jul 2025 11:22:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Date: Fri, 11 Jul 2025 13:22:50 +0200
Message-ID: <20250711112250.633269-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Not only do IOVA mappings no need the separate dma_vec tracking, it
also won't free it and thus leak the allocations.

Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Klara Modin <klarasmodin@gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6af184f2b73b..3290fd922efb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -745,7 +745,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
 		return false;
-	if (dma_need_unmap(dma_dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -763,7 +763,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
-	if (dma_need_unmap(nvmeq->dev->dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
 		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
 				GFP_ATOMIC);
 		if (!iod->dma_vecs)
-- 
2.47.2


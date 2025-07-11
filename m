Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1873223327
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222785; cv=none; b=UFy6c+zceyN8pXipCoiI0tcxIo5IfXxpeLKHMmKAl/urCLerAGNnUFf6aixWL0LSjk1I6FRLqE6nMwdKFyTWCVbmaLLIfF3Ul1EY7b6uIB+gnxWccQlyKBPRofxWrPwMt8Mzq0BQb/Tyao3kpHu8BCfUdCNrV5fgVHF7UHX7JIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222785; c=relaxed/simple;
	bh=stGUIRd1Y/G8Js0YPDAizDGdtjdbmqWx6dk508/Jtso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE6wqYBZp/YptGEaL1Gf23Lvmdok3kbu1SuX26vQ8UvXKh3P7oag7WsKEHDK1k5sh7eZSg4qxrLveAfpwPSiZVDd3jUdP/PemJ9mFTpazBK9EPPmfqPIUKvBJqsuuXeS2Ki/VfctFyZCvGGMiMUJxaEaRnDJxnFYyNMd9TZn3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6642168AFE; Fri, 11 Jul 2025 10:32:52 +0200 (CEST)
Date: Fri, 11 Jul 2025 10:32:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <20250711083251.GA6931@lst.de>
References: <20250707125223.3022531-1-hch@lst.de> <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Klara,

can you try the attached patch?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6af184f2b73b..ac3b90d31380 100644
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

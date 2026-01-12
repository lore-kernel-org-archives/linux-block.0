Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4D314A65
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226528; cv=none; b=j4aD5knljKOkzM3Q0M1SAP7JNcIxsKx0tSA2BDS7vE8h/tfKdpuTYySi1aIcMOEaqdscemuleNK6y2IIxryXshBQEtlNDPFs64oUag0VEFXFMf/XybE2MRsrPcP3MBEM8MaLN8QbwtiQfJBWBhW/Qnf5bC6ZCL1pvVr9Gb3Ld/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226528; c=relaxed/simple;
	bh=YG5xsu9lT3Vkrte2hwC+/EukHsuTF1MxA25pRth/3RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=PzQDunDbZNqaEQazy94nvPjykRYX6FfXOuqIEs3Bj6T1VN2ej8CtO32Q3AbRZur577BjrlXqnEcYJGnqwZDrc1qIFBSChZsG4YOp79WDQ9wia9w5NhSLcqxOaKKTgAg7+GNwgxQ8j2nYS8/5e1Pa30T6b4MuxWfjJF3cANDDVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YjrbOqC3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YjrbOqC3"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260112140201epoutp023ad371c2f9757e8ee56b262ab18668d0~KAKcc7aa90174501745epoutp026
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260112140201epoutp023ad371c2f9757e8ee56b262ab18668d0~KAKcc7aa90174501745epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768226521;
	bh=aDUZi0sW5KpVk8O9w7PsuWUSSr4NALJUTKZn+c+CrZ4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YjrbOqC3TLl8Sff/JNY29mWhOL7uX30swfkGCPEFv7q/ksbgZDnn96OCY9PyrCBey
	 xYcaadZqP/u8jZ0L7HRuJxGsgD/ojCIKCi2iWrkEgKvSWQBu7FCJUjCNMqUvDrwG4p
	 rqKiW3pZwOesHnBoDcudUEIcs4ppuh2eLWJ729s8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112140201epcas5p3842bfa747589247bb0e86c3f67670439~KAKcFJlIa1186011860epcas5p3l;
	Mon, 12 Jan 2026 14:02:01 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dqYw80p4rz2SSKZ; Mon, 12 Jan
	2026 14:02:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40~KAKaWWzx_1186011860epcas5p3g;
	Mon, 12 Jan 2026 14:01:59 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112140158epsmtip1345f77e91c55ddbd72c57a69f44e0368~KAKZgQDIy2301023010epsmtip1d;
	Mon, 12 Jan 2026 14:01:58 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] block: remove unused dma_iova_state function parameter
Date: Mon, 12 Jan 2026 19:27:34 +0530
Message-Id: <20260112135736.1982406-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40
References: <CGME20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40@epcas5p3.samsung.com>

DMA IOVA state is not used inside blk_rq_dma_map_iter_next

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq-dma.c         | 3 +--
 include/linux/blk-mq-dma.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

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


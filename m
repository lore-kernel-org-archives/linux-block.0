Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450E488D8D
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868097; cv=none; b=D5iCLV92sbb0Kj4EDqDPdL4VcQu6RKwBbs4dK58rnzgScDMmWB6UkR9jLLiz+8SYa2grt3FPG+/gDRoyLTYSdjws6Ek39d5Ehjpyxg7Y5TvLQOFR5xqOTkOUxz7A2DRqK4RnUqwH7TrvrhxgUn2fDNYWm55NPlofDSGFSHwH5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868097; c=relaxed/simple;
	bh=PxKJxAVT8ZV2k62tddqpwmMf9x3R049yuGI5FocTb98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=lZs+o5NHqWpk0V6a9R1C2/W5iIL3VPMQ64JKx7c10CxH4u+C6cPGkW0yKQJWOM/yP/3R1v27BqTxYZVmClT6nDmkf7t4f2efJA239r6WbsRev+K2oXOHuZwavz23faBpalQpxTuhNCqgRlx26uM2fJ8t30ad86ICCABW3hWu5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GWJFiL1n; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GWJFiL1n"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261013050808epoutp02501aa0b746478b273b1927a0dea62a7f~d-ohpxbqY1441214412epoutp02R
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 05:08:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261013050808epoutp02501aa0b746478b273b1927a0dea62a7f~d-ohpxbqY1441214412epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791868088;
	bh=THJxaWnF5FzDDKJspqdxJBm/POp1h+fVWGjbIIHr+a4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GWJFiL1n785igSoqecsf0BB9cYedtetwos0z8n4JjHtWysz5JozDpfUeMyP3LQ8oj
	 LKvJf84v8t0jyxYzlVKGavaAb7kH+RadR5KG/oWC+CD3q3BpcY8k9zF+PBHDVy27GN
	 BLv93Kk5Kj5gopM8EoWE4V+OBUkwiHfWtfKsfKRk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261013050808epcas5p2382f7017d47301be86b92c5fae2be794~d-ohQu57m2964229642epcas5p2P;
	Tue, 13 Oct 2026 05:08:08 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4j3j5g0wq1z6B9m7; Tue, 13 Oct
	2026 05:08:07 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261013050806epcas5p3634b06c8d362752032afe1cd1acf0781~d-of4dic70173901739epcas5p3K;
	Tue, 13 Oct 2026 05:08:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013050805epsmtip2d243470071a5eaadbf1fcf36a8d74b35~d-oe7jHCO1564415644epsmtip2V;
	Tue, 13 Oct 2026 05:08:05 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: asml.silence@gmail.com, axboe@kernel.dk, hch@infradead.org,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH] block: reject dma-buf I/O on integrity checksum devices
Date: Tue, 13 Oct 2026 10:37:23 +0530
Message-Id: <20261013050723.55577-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261013050806epcas5p3634b06c8d362752032afe1cd1acf0781
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261013050806epcas5p3634b06c8d362752032afe1cd1acf0781
References: <CGME20261013050806epcas5p3634b06c8d362752032afe1cd1acf0781@epcas5p3.samsung.com>

A dma-buf bio stores its map in the union with bi_io_vec, which integrity
checksum generation and verification walk as a bvec array. Combining the
two can cause invalid memory access.

Reject dma-buf registration and I/O submission on devices with integrity
checksums.

Fixes: 738881239a91 ("block: add dma-buf support for raw bdev")
Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-mq.c | 6 ++++++
 block/fops.c   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..7fff1305b492 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3138,6 +3138,12 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
+		     bdev_has_integrity_csum(bio->bi_bdev))) {
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
+		goto queue_exit;
+	}
+
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
diff --git a/block/fops.c b/block/fops.c
index aeb91465c4c5..49ae0302f123 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -944,6 +944,8 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
 		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
+	if (bdev_has_integrity_csum(bdev))
+		return -EOPNOTSUPP;
 	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
 }
 
-- 
2.25.1


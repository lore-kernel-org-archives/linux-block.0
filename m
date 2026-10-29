Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265054;
	b=eEhzNBD8VeCbiHkqPCb7dv8AivAaVcgtUOm3Fnt26p8x68zKrVmD/cATljIsmhSBM7nA
	 VjvG9sM+iEk7zgZ2wKEt1zWes/kr2eRtAySqOFT+V9DfAkTI0xAp+Oppw2IXMXwXnT8x0
	 XYyaMOkwIdgI+RJfgHlpnWBAHNnrPql59vDBv6pP8j8ZMC45qbO5m8nKAOYbQ4yuTIzMn
	 +BrkTwi5e+jzQhIBUcwA7zrPuLPoqZcbzzVaWCmVsjdEO/0mCOp//mP/Yk0SKYXB6Kamn
	 zQHrPWTe7pLiaVImIlQ7i0Xf3IdE7n3Vieupx71IEic5FstyAeCycxGkb3ivmcLc7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265054;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A0CT1CLM4FHtwJoACcLaBHTfFpgwkIVkpL+ZZSHF4jA=;
	b=V4UMn2Ql4mOs94WSdSC86qIZ+hJLn4lHhtFtEqfypUzXJuZW0bTczWUlqxD80WEnqP0w
	 rCPSOCKQk3I/82PHwfBGyB2x01lTaDEqINOs9IFl1eGwRRhQNTCSu7ABX/IS7Q9OfrrR/
	 qf8dU7WpfMX75oPKo68xbC+y645peAsPSDCz/lRj32Df+sf264q6xlMtC//P5ndNtWPdD
	 TO0+rzopUks4gbiq4PyR9avIheAUzZIl0WRtZEKF/c2NHxQz9V/iJlJs1XAvEWLwzESZr
	 WK0+NkoEdliG/HQLCQhGzTRZtqxU/FIbA54RIzntgu1BCYr0XmofObUqnmjbjgtPjZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="pQSN/qAc";
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07348606A31D;
	Thu, 29 Oct 2026 09:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07348606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pQSN/qAc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pQSN/qAcDUwHZ+L5/sRulkwNFjisW6ibm/NMyBwvfR/4mlIoCa+UZly4f8qgscKzuSo+WqDiOlsO+
	 n6GAFCR2MVmySrGt/i560oYO6hszeFUnyM3V6gLzURsE2G55SID69Lwsr50gdAaMQLQaYGQoexgZHu
	 oOSn3fJQ8BO1vPog=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ae30d98a35-0929d;
	Thu, 29 Oct 2026 17:10:48 +0800 (CST)
X-RM-TRANSID:2ee86ae30d98a35-0929d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from VM-32-23-ubuntu.. (unknown[124.156.110.139])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae30d97793-62905;
	Thu, 29 Oct 2026 17:10:48 +0800 (CST)
X-RM-TRANSID:2ee46ae30d97793-62905
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c
Date: Thu, 29 Oct 2026 17:10:47 +0800
Message-ID: <20261029091047.3085558-1-wuyuehong@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make W=1 reports excess kernel-doc parameters for bio_copy_kern()
and blk_rq_integrity_dma_map_iter_next():

  block/blk-map.c:366: warning: Excess function parameter 'op' description in 'bio_copy_kern'
  block/blk-mq-dma.c:379: warning: Excess function parameter 'state' description in 'blk_rq_integrity_dma_map_iter_next'

bio_copy_kern() derives the operation from @rq and has no @op argument,
and blk_rq_integrity_dma_map_iter_next() lost its @state argument in
commit 91e1c1bcf0f2 ("block, nvme: remove unused dma_iova_state function
parameter").  Drop the stale parameter descriptions.

While at it, fix the "ft" typo in the return value description of
blk_rq_dma_map_iter_start() and blk_rq_dma_map_iter_next().

Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
 block/blk-map.c    | 1 -
 block/blk-mq-dma.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 81cba3af4e9c..e0c2b8236513 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -356,7 +356,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
- *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
  *
  *	copy the kernel address into a bio suitable for io to a block
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 88fd9cbc951f..efe16943de15 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -213,7 +213,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
  * at unmap time, @iter is only needed at map time.
  *
  * Returns %false if there is no segment to map, including due to an error, or
- * %true ft it did map a segment.
+ * %true if it did map a segment.
  *
  * If a segment was mapped, the DMA address for it is returned in @iter.addr and
  * the length in @iter.len.  If no segment was mapped the status code is
@@ -243,7 +243,7 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * arguments.
  *
  * Returns %false if there is no segment to map, including due to an error, or
- * %true ft it did map a segment.
+ * %true if it did map a segment.
  *
  * If a segment was mapped, the DMA address for it is returned in @iter.addr and
  * the length in @iter.len.  If no segment was mapped the status code is
@@ -361,7 +361,6 @@ EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
  * 					 a request
  * @req:	request to map
  * @dma_dev:	device to map to
- * @state:	DMA IOVA state
  * @iter:	block layer DMA iterator
  *
  * Iterate to the next integrity mapping after a previous call to
-- 
2.43.0




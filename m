Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94142175A4
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586665; cv=none; b=Hj2r7CaJr6mdBSD2axtsOyLFA6n4TBu1PhoHaXjbecYE7bTr7dqErrPsNfNwelLtHpQZg3VU7umiAsMVJVedKgeegDjv/nWdQMVucj+wn3phPxodBYWeDDd0iKmoOoW2nqP6Ns/RmaI69VkoTx+10KB/eXtmrDBX7Rg5svmFFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586665; c=relaxed/simple;
	bh=htyvJj+g9bTQyuHGt7YYBD4/zUbsHS36ItWMplXpXf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kR61NspYszamPHEBay5AYO4ax1wPf9JAfILjVHbjOZIuEryhLFVRBV02n/jH3VtIf+FeP5XVQTv1N+KL5H1cD7KO8evZHQFBF7DiiRkRT0D8yggqDRV1H93UKf/+0e9LzFDYdQohIFqkvxz8huGVWiDxkHX/hoVs4+JlRXS62HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vFn9qwWE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFn9qwWE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iZVt+4PHBEup3fys/3++8LkDhk2PlaRb6Zd/R2NR/Ws=; b=vFn9qwWEpaxHLnL3TQErmJlZ+r
	X9rDaFlotZde6HwNYWfcuJBdUZ0AQ9iMsFqDKTIplmjpz4UTI8m0qStBnIFhZ3VFzWDHTZAMzcLHM
	EQ9CK/bWyzmfObh1WuWUOudXQzqTJ1U6qx/nnpScl042sCea508EwG/pUifHyhMEQG2lir5z7b9pj
	aZBBS+05iB8RA542BetS6kgezoNDikV3vgHBA2FEMbKU/RQaqtlapYlvQ8YxIH1TscnAiOc7ICx6o
	cRPoowVy1wPauhNy5QXet5NCnGfZLMuGeOkOYyWKzDh6TIyGvHCMrnEv6uJ0FefRCrCPhtffH7fDV
	Y+j3HY8A==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RN-00000003ncd-2Usl;
	Thu, 22 Feb 2024 07:24:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/7] ubd: remove the ubd_gendisk array
Date: Thu, 22 Feb 2024 08:24:11 +0100
Message-Id: <20240222072417.3773131-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

And add a disk pointer to the ubd structure instead to keep all
the per-device information together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 48e11f073551b4..b203ebb1785125 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -125,9 +125,6 @@ static const struct block_device_operations ubd_blops = {
 	.getgeo		= ubd_getgeo,
 };
 
-/* Protected by ubd_lock */
-static struct gendisk *ubd_gendisk[MAX_DEV];
-
 #ifdef CONFIG_BLK_DEV_UBD_SYNC
 #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 1, .c = 0, \
 					 .cl = 1 })
@@ -165,6 +162,7 @@ struct ubd {
 	unsigned no_trim:1;
 	struct cow cow;
 	struct platform_device pdev;
+	struct gendisk *disk;
 	struct request_queue *queue;
 	struct blk_mq_tag_set tag_set;
 	spinlock_t lock;
@@ -922,7 +920,6 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out_cleanup_disk;
 
-	ubd_gendisk[n] = disk;
 	return 0;
 
 out_cleanup_disk:
@@ -1014,7 +1011,6 @@ static int ubd_id(char **str, int *start_out, int *end_out)
 
 static int ubd_remove(int n, char **error_out)
 {
-	struct gendisk *disk = ubd_gendisk[n];
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
@@ -1030,10 +1026,9 @@ static int ubd_remove(int n, char **error_out)
 	if(ubd_dev->count > 0)
 		goto out;
 
-	ubd_gendisk[n] = NULL;
-	if(disk != NULL){
-		del_gendisk(disk);
-		put_disk(disk);
+	if (ubd_dev->disk) {
+		del_gendisk(ubd_dev->disk);
+		put_disk(ubd_dev->disk);
 	}
 
 	err = 0;
-- 
2.39.2


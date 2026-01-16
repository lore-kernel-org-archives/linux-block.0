Received: from out30-86.freemail.mail.aliyun.com (out30-86.freemail.mail.aliyun.com [115.124.30.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402731354C;
	Fri, 16 Jan 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529735; cv=none; b=cKPE7mCiq9XAuJ5fxtqIByPGJyDdbQYJ5d/U9+pPTF/Xpd2mL5H6bhBmzcGHzHXuHEGHu2ghBdnoIQMwEYW8dlUQs8342Vr3lo03zimrHVvqioTL/NGClw2oXRm02gvW4qYT59n++eHowx8OaEdzeSZXs72Okq47po3Zf29e/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529735; c=relaxed/simple;
	bh=6JEjGbKc8HC4IOF6v8y177zH9zKivJz4uxgOoyPtHE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iB/7VxEpC8+wQKyyrsYY72Cn1dA9CtRVX4n5+gR1OUTDNEaUWVorFcAD3ZR8DyJsb+Uuu0V5l3ZmYjUClRZSfhNt7fy9bV77lF3xRFnG91DbtYiCi5TWksShoD2qdaMwT+Gxbn2B1yy0XcvMdDIzmbaZZo/r+pJT0GorYXYBWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=GXNziPcR; arc=none smtp.client-ip=115.124.30.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="GXNziPcR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1768529731; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zOvYSuruqjXWcfD4dSZhtL95h6cZLGWBWlsA74j96GY=;
	b=GXNziPcRBqF3gKFwDUh6y3CcrdvPlqBPkUV1hVQiUY11hHmBw3SCGtQHkFfHi3e1KEc9eMKWjsfxwp05BV3JP2tDTsRBT8bwTHngdddMKPkCIAnZLKrGMoP8kJl9l9O3SuKNNOkUqtQYqsX7enhYG1CwElU6Ds+7wshQzSJKcOQ=
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0Wx8E6AD_1768529727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 Jan 2026 10:15:30 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH] block: remove the boring judgment in blk_rq_map_bio_alloc()
Date: Fri, 16 Jan 2026 10:15:24 +0800
Message-ID: <20260116021524.776322-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to check the return value of bio_alloc_bioset().

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 block/blk-map.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4533094d9458..f95b07ec3b88 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -46,14 +46,8 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 		unsigned int nr_vecs, gfp_t gfp_mask)
 {
 	struct block_device *bdev = rq->q->disk ? rq->q->disk->part0 : NULL;
-	struct bio *bio;
 
-	bio = bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
-				&fs_bio_set);
-	if (!bio)
-		return NULL;
-
-	return bio;
+	return bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask, &fs_bio_set);
 }
 
 /**
-- 
2.43.7


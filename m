Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119A28751F
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270938; cv=none; b=GXKB69Mbkol5Cr+BvfiFI8SwG3TXshh5B0Bz/0Fg8g2e2ChU/4bixEgl4Nnx6Tg/AyOdviFqNovnghQvlIZnUJKUfIEaUqwhsW3kAYftx4ObuNgKSs/lAPJ6wdW2BFqPvo9jjbXh7/MZZcOCUkHt23lJCqL0DqwpXpqaw5Hi8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270938; c=relaxed/simple;
	bh=4CeP8091EqjUK9CskNSlEn27rcVvsb9klIf5F54UFj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3gm4VzsB7u8fuNijkm9b7CqNMHP8VXCK1sqM5GUnDMxaPlFaRnyohIVYIVql7VU9CKQbRmuh5sMyeR76fLQcGbv/rEWvh14Zj4ONlzcxHieciAraSrEXDHVX9hh49B/Lq2LCG8Z1uwXuiFnQWISZB0bIgBoN/ZdTvyZFGHnKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U92gp+DN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U92gp+DN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29558061c68so65468165ad.0
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 01:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270936; x=1765875736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDKxCQi4WubAv8KgzENdDuZ74b0CZmQcA4s08IiUA3A=;
        b=U92gp+DNB8aTeJFSPPcFW8Df4V6N3KpXKzI/GvYks6SIJvxKwcc80tWL4mLkisWHBt
         eCRq+aaula5gnIpnnxwtzbAp9mF1TJ7+V4bKqooWAwb/SeninyaQRUPg5Mdr//IUeLSU
         o2dUxc/iPw+x+iaapBdd/mgRcOQ5Zg2CSil/WPOdxi2DeMH0OElgOyFem/icwi9Ux1JQ
         m1K6Qm2keAuKEJkALmQCx72EmnSq3d6/kwNVDx6GaNw7irCoh/H6nXrlY1Gmg2RF8xnm
         LTFayombFysbwPamMoNl5Oq8HMg/KLR1R8w1ecwdCHX7/rbO+hUvvmeaOmG9gMgcIjVL
         hlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270936; x=1765875736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDKxCQi4WubAv8KgzENdDuZ74b0CZmQcA4s08IiUA3A=;
        b=w5jsBH+d2m5WbFBQ2B9MfygPErwK7rlTgrZ/jP4eIsB/qeWdbr3txuzyZDUBeW+Alg
         mhJDXig4d8sgA0YF0XnAtqPjkC1TRZaOv1g8depcGFXRwpuubWUvhALsRbtdoyNw1hb/
         1ej0X/w07Q3Zkp81ym1JldCEsahj44O6YrT85n8/1ZCStp0mAKFhXWO0ZObLxGSIWBC5
         bj7O9x7w6568Z8iy3w1Agp7q4kQZeLZ8qcE75K8yG9QEyxgQ1ByVALziLzF2uwgsZHkL
         QB2Sp6mxcgW0njxcWTLvZmybKqOzzi5NXI1VtB4Ir2N/3pPtILuONvw6uD6c8+QF/nc2
         BDzw==
X-Gm-Message-State: AOJu0Yy3KdypIoMtPv/GTqBXGmU7t61jWjoLHd3XCL2bu/KG9DtK8MNi
	7RznA/tmhRCJduWT9iRLqSlX9bGlF3wzZCURDAKQioANoocxFLAcMbO9
X-Gm-Gg: ASbGncuZOhchG9SdNoP2f43d/X9bsCpr9kaXH8xh7wdPLs/nYihU/zsUHfDwU+Sm3fk
	Jr8R62tzDMRsOXVvnYpDI4Px7mDqEmf3tfV6Vbmd/TzvRJfQ/CvXS5X3BTaV2ZVZdUQmACVuLFy
	i96uSwrnI/RdZw8UY3DA1J6gZWLa5/o7+8MnYWDwCptboYLmiNDS+5q+QBK3VVZIAZZXQF57f2r
	YYggw4lJWrASgdtcc6eyLbYLX72UXJg4SkK5tdh5wPWedR4RZu284MnvvFETwuosGpi//zytAp4
	2YIp3QPzji/YL7O3UeGq9d9dt7b31OThaikeeb+M6Dg7kqFEtIZ3UG0CTf/mBLATjeY50NUUCoq
	Ms5snM01DN7M95/pWWNZzXop3QYOpBuDkhyJTrMx91GgSBFClTaqwcBVytUMkQFncbbwvh3b8Vu
	UxKMz0pQq5tPWa0/gZ8Firc1Z9Ng==
X-Google-Smtp-Source: AGHT+IH8UlmlQXv3ttCFRjc372AUW0Jx64eBzRuhm6/sFfQMDcgq/zQ1pavi1pYW8AOCCBSPo+vrzQ==
X-Received: by 2002:a05:7022:239c:b0:11b:9386:a3cf with SMTP id a92af1059eb24-11e032ef6f6mr8436937c88.48.1765270936449;
        Tue, 09 Dec 2025 01:02:16 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm69700982c88.4.2025.12.09.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:02:16 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 2/2] block: prohibit calls to bio_chain_endio
Date: Tue,  9 Dec 2025 17:01:57 +0800
Message-Id: <20251209090157.3755068-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209090157.3755068-1-zhangshida@kylinos.cn>
References: <20251209090157.3755068-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..d236ca35271 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/*
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	BUG();
 }
 
 /**
-- 
2.34.1


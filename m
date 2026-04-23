Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D5263C7F
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915093; cv=none; b=cPMGnOPI71xujQCv4RBFqjvIREDhLTelawyN9JGvoml93N0fEPC66E94Mbe39sIAdmdoanwHL2eYDiIolNf3BXUHgc4ksBMJ/CfyXnlLjzpi5MFW783Kr/AuKpM3Jyymr7SlQQSCGB7UtZAdFoe6huNNReApw+tcjWKpRDtv9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915093; c=relaxed/simple;
	bh=Tlym/BuiCXxXe4rASUkGMpNn5QNGafm+J2yGFAPteuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRXQ7bTnYvbWbkb8XXD8JVY55ACjNWZGn1s6KlO+fiYDmK3NOVq0S2eXOH3lW0XFqPfvSQMRJj3aSM2KByX9/LufM1zeQJ9oT15TX3W7CwgYJdt9lhH4riFgPaRGQHO9h7R8+KkHEdPIk6djlRllOUUhVy8+4UZissm+TiDCNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuu4w2Pw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuu4w2Pw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4890098abbaso44771695e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776915090; x=1777519890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqkWEW7FAJ483AshcSe1FxdXbuXuiEWPFo40pxLiXHM=;
        b=Tuu4w2PwMJfw2JPNs/BvIyRCzV6kjfORiu17jbU+DH+alj7u9mxt0RFGXUUIEhZFYA
         acTHjxn4spndKmeWOeAxKnXX94qiI7cNnowMFf9tJegxgSEvbbavLQgcBUn5jAX5ChgG
         h11vxRTT8lYdq+RO4NMczsNieJImVP7S/uxNLh0oAHhM3+YOekzFZXEb+Hpp4AClY4Cd
         kglapT0e8MlAnKE0qkjBFPR37X/6KLZGQFQH6czyHaZWK+ZPal6SgdK8q4JLxXe1klp+
         kEnNxGNd3mVwCL/F18dTyRnwAIg1ygw1k+PjYRp/9Vd6fzDk/Iy8AmU80R5zYtW8Ok3H
         DoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915090; x=1777519890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqkWEW7FAJ483AshcSe1FxdXbuXuiEWPFo40pxLiXHM=;
        b=kaAhMn+shJPjRqJA0pyVSh9FXg8I78zXBClzVqrUY0PJS7EuYrSPIHuEmfj4bLAd2K
         NWcW+0e1a5Unpl/Ypa1PdvQclUoAGaFAIvGJXHT+URRDPEBAqvCDKYTPPlRa78WzSmpv
         /n0PvGjpIldt/3Z7J7fF7ZVYna9vkQT/wAUTYlKD7lpok7FFSb8wKdnmEmbOdX9oChRb
         RMRLHparAPKRLJ9u966U9wX4q39T8svuqiIByT/QX+adT6UQWaVEU3nlzFweOsGRDuCk
         vMxpPQpb3lQEaAkz4wPMPdYQsx2X85VGF94bYYGwxuSsOKJbRTQl53YmJqEyzcKjXHhf
         qqtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RzTm//NIw3BYGsf4RAPdtmiw88DmoWmuFxTwJFcuuwJp6blDWZm92I1J99eBgV74A1GUZzL5+EHFPVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPqiRi8VqoNGcfK4i/SyfN6DxjQpOc1CfOxHvyPYnC3QbF/qi
	/eE1OGfMke67dXIC6UoVS0/mg8GJ8siXoVov0b0oOodlL38+Wbh15zPU
X-Gm-Gg: AeBDiesgMd3NeKO3qTJ2W7qj+Z78xXjKU85T3pqgdR7JY535pRbs9mvdVUBS+1Shoxl
	uGkTt9abLHnxhmcnTaA8StTWTr5xucqFE27fIAu2Syez7fnzNt0+aMXXQ5W6r+Mf+RByuHLDufg
	J4C3MKywfn/ePW4bI9+bNt2UkMQmLaV699CjrNZhuQPLnc5EHUnoaUnkbeDnFXJDFb3VvURTRyF
	M8M5VCiGMN9qfZKbhaSQAAU0WEzSuynpvS318CnzomcHRjseVyQ86bJtYzH//MHoPny+LiEYisu
	2cLMoGaK1/0YBE0C6aLquE0ZH3CsW14fh06R8/D0HEj22jeJNE0qcq/nzPSNxrxfPmKxKxDJz7G
	64Uavyb+/1XNHplr8VXyIILEULgQ8VaAl0BScuLuImEMO+vXgIy/Iwyqh4Gq6q7ikvg9R/QkrXF
	7nm+M3BKSrH3kIsiMGf1kbmOTjyYWj0VHoPIOzZlQRa/1Sy0+ZgEltFTy1Gj9MNxfCIo4Oas+xb
	RfHDceMZAhRD/9/GqY=
X-Received: by 2002:a05:600c:2d09:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-4890c5778ffmr144327345e9.27.1776915090274;
        Wed, 22 Apr 2026 20:31:30 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm104438085e9.2.2026.04.22.20.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:31:29 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 2/3] ublk: refactor common helper ublk_shmem_remove_ranges()
Date: Thu, 23 Apr 2026 11:30:57 +0800
Message-ID: <20260423033058.2805135-3-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423033058.2805135-1-tom.leiming@gmail.com>
References: <20260423033058.2805135-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the shared walk+erase+unpin+kfree loop into
ublk_shmem_remove_ranges(). When buf_index >= 0, only ranges matching
that index are removed; when buf_index < 0, all ranges are removed.

Also extract ublk_unpin_range_pages() to share the page unpinning
loop.

Convert both __ublk_ctrl_unreg_buf() and ublk_buf_cleanup() to use
the new helper.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 69 +++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e8d71617fbda..6edc65af250d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5404,18 +5404,40 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	return ret;
 }
 
-static int __ublk_ctrl_unreg_buf(struct ublk_device *ub, int buf_index)
+static void ublk_unpin_range_pages(unsigned long base_pfn,
+				   unsigned long nr_pages)
+{
+#define UBLK_UNPIN_BATCH	32
+	struct page *pages[UBLK_UNPIN_BATCH];
+	unsigned long off;
+
+	for (off = 0; off < nr_pages; ) {
+		unsigned int batch = min_t(unsigned long,
+					   nr_pages - off, UBLK_UNPIN_BATCH);
+		unsigned int j;
+
+		for (j = 0; j < batch; j++)
+			pages[j] = pfn_to_page(base_pfn + off + j);
+		unpin_user_pages(pages, batch);
+		off += batch;
+	}
+}
+
+/*
+ * Remove ranges from the maple tree matching buf_index, unpin pages
+ * and free range structs. If buf_index < 0, remove all ranges.
+ */
+static int ublk_shmem_remove_ranges(struct ublk_device *ub, int buf_index)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
-	struct page *pages[32];
 	int ret = -ENOENT;
 
 	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
-		unsigned long base, nr, off;
+		unsigned long base, nr;
 
-		if (range->buf_index != buf_index)
+		if (buf_index >= 0 && range->buf_index != buf_index)
 			continue;
 
 		ret = 0;
@@ -5423,16 +5445,7 @@ static int __ublk_ctrl_unreg_buf(struct ublk_device *ub, int buf_index)
 		nr = mas.last - base + 1;
 		mas_erase(&mas);
 
-		for (off = 0; off < nr; ) {
-			unsigned int batch = min_t(unsigned long,
-						   nr - off, 32);
-			unsigned int j;
-
-			for (j = 0; j < batch; j++)
-				pages[j] = pfn_to_page(base + off + j);
-			unpin_user_pages(pages, batch);
-			off += batch;
-		}
+		ublk_unpin_range_pages(base, nr);
 		kfree(range);
 	}
 	mas_unlock(&mas);
@@ -5455,7 +5468,7 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 
 	memflags = ublk_lock_buf_tree(ub);
 
-	ret = __ublk_ctrl_unreg_buf(ub, index);
+	ret = ublk_shmem_remove_ranges(ub, index);
 	if (!ret)
 		ida_free(&ub->buf_ida, index);
 
@@ -5465,31 +5478,7 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 
 static void ublk_buf_cleanup(struct ublk_device *ub)
 {
-	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
-	struct ublk_buf_range *range;
-	struct page *pages[32];
-
-	mas_lock(&mas);
-	mas_for_each(&mas, range, ULONG_MAX) {
-		unsigned long base = mas.index;
-		unsigned long nr = mas.last - base + 1;
-		unsigned long off;
-
-		mas_erase(&mas);
-
-		for (off = 0; off < nr; ) {
-			unsigned int batch = min_t(unsigned long,
-						   nr - off, 32);
-			unsigned int j;
-
-			for (j = 0; j < batch; j++)
-				pages[j] = pfn_to_page(base + off + j);
-			unpin_user_pages(pages, batch);
-			off += batch;
-		}
-		kfree(range);
-	}
-	mas_unlock(&mas);
+	ublk_shmem_remove_ranges(ub, -1);
 	mtree_destroy(&ub->buf_tree);
 	ida_destroy(&ub->buf_ida);
 }
-- 
2.53.0


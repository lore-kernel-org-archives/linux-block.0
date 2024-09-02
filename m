Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8318A6C4
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269111; cv=none; b=bwz+72wQzDxCGevjRmyFIMt7lUvJjlQt/zglKnZrKLl3CTI19AAfXL3jYlhbY/1sX+9J1BaMnewUf9HWut8Zy8NowGI3l1KSIWc7LkiFfojk9wZCaFgV75ojWFrsjCVFW8ipjr2yiN8pAJYmSfRToh625NZ4OXX+WNPZTpBlT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269111; c=relaxed/simple;
	bh=hC/76uv1mgTWLVOKF3McCa797RcOQWA8z1Q+ampNA70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ni14mmAFuJtxE/mzP/XNHySSfjVOWZVyKnqdTN+JPHqQak8lhoc9k97HPaOTa+EMUyyGKuzLaVwWm3mlzvbzEbxclV9sYqSSI+NrK3rFxg5yH3OuwbcKl5Owo111zmZidFum51G/yX4x1pyXHw6awrsY+2DI6Z/OVqmKdzBKcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZL48cUEg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZL48cUEg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2704d461058so2164688fac.0
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2024 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725269108; x=1725873908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0LiR1Okca6vVLH1p6UsMUxJH88RK8865fVAaDxese8=;
        b=ZL48cUEg6cgX7knVKoOUSLBDFhJEdAr9B3fKCVWdcEbsfHWT0QkEAVGETtpPhyeCSN
         lwZvmDEnkDmqN10JsdnjV8999xlTZ3AjbB935gosvS64kb27yhshx8yNQiLJPkMMNmfN
         vjlbxzDfN5w8eRxNg14/sbfdEWfannEQQceDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269108; x=1725873908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0LiR1Okca6vVLH1p6UsMUxJH88RK8865fVAaDxese8=;
        b=O1pMavvNFxtNJYzJwyUMzcRGIcsSrK/Ifkt3NSIpX4AhRsp9iGtaPC5U3raxD/Ybwt
         ceqK5TAxtrqa91AfuMZk8U8N2j3gVn2zamvJpN1RC3GjBhsdqg0FhfXvlYTrJ5GnYc7T
         T2FdgCUSEdMqShAAsAdfLm2zXq4Wa5eQmvHXEoWijrpsldooPUw0HRBcWR4UCeO+MUqB
         6/xeIBeYjWhQfE6D1xP4shtcelhi5+IiV//ewbzahaddBtjrrLSBeiW3LR3Q14jqicaa
         nsbM9WqxFPwsGu/pnqckBRJBTUCQMDwjwugC+SGiiCkr1MKjufbprrMtrbFBZO4pVntd
         TWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgYETzKmOrWZ6JnFkElPvknQgAocExw9xrvB0DYpV714Mc3uj3LYfJy3NsL6yEynpvAKOu8LONWMtILg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHj78qseAgrce5pI3C9G5HbN5Moird0I79ZW6hhX7Ukjle82Vk
	RAPcIOIDVfNtKnDcnwxlOgMvzwOBUuBHwUxzKhGK683t1AziGSQlNuAArWO9Cw==
X-Google-Smtp-Source: AGHT+IFbXmwGyvqj8OjVfSqw+t9YYclw5JmzSzE+/zNkckVyVa3MDG8sPwlrwBXXD7/eizaudPkBjg==
X-Received: by 2002:a05:6871:ca52:b0:261:1b66:5ab1 with SMTP id 586e51a60fabf-2779013817amr14310066fac.21.1725269108527;
        Mon, 02 Sep 2024 02:25:08 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d7dc5sm6100493a12.77.2024.09.02.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:25:07 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v4.19-v5.10] block: initialize integrity buffer to zero before writing it to media
Date: Mon,  2 Sep 2024 02:24:59 -0700
Message-Id: <20240902092459.5147-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f ]

Metadata added by bio_integrity_prep is using plain kmalloc, which leads
to random kernel memory being written media.  For PI metadata this is
limited to the app tag that isn't used by kernel generated metadata,
but for non-PI metadata the entire buffer leaks kernel memory.

Fix this by adding the __GFP_ZERO flag to allocations for writes.

Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20240613084839.1044015-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/bio-integrity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a4cfc9727..499697330 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -216,6 +216,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
 	blk_status_t status;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -238,12 +239,20 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
 	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
 
 	/* Allocate kernel buffer for protection data */
 	len = intervals * bi->tuple_size;
-	buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
+	buf = kmalloc(len, gfp | q->bounce_gfp);
 	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
-- 
2.39.4


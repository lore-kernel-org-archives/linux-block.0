Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EB2773E3
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406907; cv=none; b=TmUVgzPMqf9fO2YzPakptpNhi5+ZAG+iqheeUM68KoGGFQpTkvqA6cQKQB2bmDxBswg2AvQjVYftjKtz2xcrYcQyoRhLg1SjytdICf5u6rE629PZps+LN3zZsyMIGLw395SdGlWzGQK23BrCrxgkzN4Ao80dyfpy0dc17LjoSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406907; c=relaxed/simple;
	bh=jExYI2jaoXiycbQo0Q43ubPRMYOXkZVZRm5nOe4POx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOhfgU8rKMSNITWGp7ETCvyF/pT4pYDWX1iqkU16LmIkrhIrdVUj2VbL+HFx+uX70r4ogWH//S2eTNyJWU1fIo3fEi2FCa3j+vaPXUj/yyMyVe2/ZF9fISyr7TJCe57N+GdeYNlBiFmrEGQm5SCKj9YRTxzcllrqzVM+z8lQVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvRXDnxg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvRXDnxg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ba92341f83so4052736b3a.0
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406905; x=1765011705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06c4CDfEOBNFQOCEh49v+FDqCuxNhXoe5zY9J+9QjgY=;
        b=TvRXDnxgYMTshHKZhCkNuQ8FV3gg1bdYMVAug+4q2m7RRIJFZP3bof47t8xMRAwQlt
         sfyTFiIZZuuha8Hz8Ne2dkWvL2hUjjM63zPUh8CuJYHc3B/Uteja/oe46MPZWoA3yZzB
         3LMMCQ/5opwPbW7tW1owwPc0eBfi+cxKVM2bujQFczwpyMq2T6/EULqBvibxevSUXKKz
         J9z7FyBAcYtD0q2gOfX6TLpbPu8zbiHkT5Pv7rnd0vqwnhda/51Qx5yEy9bse7VGr3ze
         ydw9cmZkHB2ELAbaa/CMzlg+Q7Q7MTh075eQ77AxuBGoXv01GceI/QVGQ4zUXSCDHSyT
         AhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406905; x=1765011705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06c4CDfEOBNFQOCEh49v+FDqCuxNhXoe5zY9J+9QjgY=;
        b=o6PsbEL3J3WNK36pvDFNlZeFy9g5xgPcl7q+J2vgMGN1KuBWkZx0bMQwgw5pnmT0pj
         kmFJkYfu1p/q3zHr5nrILrCKHRrAkHPB7Ztw+78JVGjaitZihj8fb688eE32dR2vtgta
         hkpw1ICCGPhEmvFqsF0jIzg4wjeZ8PnmMzFzZzNHIVqlvKhrYl8kZ2Ou6we3qDhXI1NU
         h5QydK7cZeUppJAuDOnzLQvi3Af+Q+S09Ges8AHQNN8yqLqRccgGwfjCh7o6+TCT3sXR
         srTY/YqYsc7Ld1c7qlU4c+ii2x7MSW0rbAQZJ6jTbSZbpa6KV091fShx9ytTmRGqhYB+
         da/w==
X-Gm-Message-State: AOJu0Yyz/hf9vy+pULQtRFAtJV8nSZNm7pOaNorcmyGuUmE2b9TaoQTb
	YF1FDSuJrLNuNVpGbm8aIDCYjps66lIlCdiB5lIt28DsJww4iejS5rTI
X-Gm-Gg: ASbGnctI95i/fGDjnjQCKPe5qxZ8O7/N65TKom/V2xa4kZF5zXuiE+Ffx3UV8xPrAsD
	p6jE01PsAeVTaBaTIsZUgdOOeZw3ejzYQ6mlVTJc78JI3vjLfvoNuZ26X9OL8IfFKnnXYwCN+A9
	dNFpTXIaxX8hJiOxXu+m4OBYIZFTQsDhtlJQAVAW7mSZZJ36NQT0X8I1UVYdKkujL0yfHEpkisq
	WD790v2qhLhmhWBG3EqyYwu9I9vN2dcjFmY660pJ/HJSG1coYO+T6UUHQxPZd32dKPVq5pGpxUg
	xZetaS2NiSlqmRmqzPDzMiZ9zF9Q25w5WzSvNMd3vg3fglNmdMlX9GYRUOCpyDA6mvxfq/vcDKq
	s6EiOBU595eqkUS07SFgPKEP/KudGDfqtWdA4yznDtfV+mNAFOESF35Tijx3QOblNmf8n3Ml2S+
	LIBx1UHxyw1B93ynMyzA0lYXXwOA==
X-Google-Smtp-Source: AGHT+IEFFhMF6u7tNXXwfE6dPq1pkaM+HsOKRV95Dom9e3MOSpru2Keq8NWtpHMva0MzTN1ZATf4vQ==
X-Received: by 2002:a05:7022:62aa:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-11cbba4ab67mr12173129c88.38.1764406904816;
        Sat, 29 Nov 2025 01:01:44 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:44 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 2/9] block: prohibit calls to bio_chain_endio
Date: Sat, 29 Nov 2025 17:01:15 +0800
Message-Id: <20251129090122.2457896-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
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
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..1b5e4577f4c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	BUG_ON(1);
 }
 
 /**
-- 
2.34.1


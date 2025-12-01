Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1262FD693
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579909; cv=none; b=ATyVwYZxq2u9BWBHxtdSyVeB3ZUeL+ZIZk9AWtJNMLMkET9UWL3QwXxBFwlt2FSyuIYfRb+tuWujbJuSaFN9h5jHvHJs10fM0CJl6mbo9dTjQF+UjtyFaV76krZfx0tn40NzhYJspYge3pI/KSOVaLa7Z48qiyrOOJBXCcO8M1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579909; c=relaxed/simple;
	bh=9o7pMGLR+wHFQD17nhkv0K8NYO8+CXCbWzvTdLvv3IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCxdQlMrIQgEig8Kxt/zlr7dYITLgMxqXTmVFlMuIP6TYK9UfdZ4eULdh34wCZ8oPIRl546p2zR/B97CK8QBj70eP6puVqKY+bsX61iMdvQ11lJhmCV4z2t+HmAKa9hE541HiUX3eGdo4ThKj6eVK29jkDjHcJEjjUJ3bhQJKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vhl5GEBa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhl5GEBa"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aace33b75bso3839302b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579904; x=1765184704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw316iKTX/2VGJbIgc6JIwbU4eBfsa9UZDP5Ykz1NQ8=;
        b=Vhl5GEBa/6ceMPeelPbR6icywBTHZ0JJO6fJqxpJzIO/diC4ORggfcoswFxs5vsOIW
         GAxx9OV4MCvj3sWngrfu2LeSS3yzdvZxnaEZGgVa58E++ecYOwBnXomQK2yc7UYJMoz2
         82AZAuHRCIAMoa6uXMxkRsZgaoAqrfKbZ30T3XgmpUpMRlrZDi9bsZBd0jL38v5H1CUy
         FTTzWNaZiwYy/6wMYsDqGDyWPgXpY7qsVAcb5bR4ij73OW2EJM/xN0gLW9BrHJr/hYkF
         GC7HlFyjgg8qUr7VfOMLsHJvP+pUtGJOV7YgpA2EbVp4QWhMdA5kIiGdX5rWRlQATsbw
         J19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579904; x=1765184704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aw316iKTX/2VGJbIgc6JIwbU4eBfsa9UZDP5Ykz1NQ8=;
        b=mjY3RuvFCgWWh+YFsKaFtbdkhZajfhPkYJmo5/FHRg+bFC7Uoxca9TgJHvkfSw/mef
         sYaGSG2RqwW+nOYBM8gdlBrN/KKZgSjfEyU3clnBTynt7hWwGLBCr+Zo20nx0MMEZHtX
         TlP+guFWDssSMtb0hV9U7SyeM22lTJTJj2Ee4uPyORZKjBW3KhXajj6haDb+CmijvHE4
         Namkm9bivgPeaPUcP3tpESp2w0H5sGlcEIoTn60XfqQh0MABd73vPewX6VOwNVFaEMeu
         Vy/C0/tVOCBIBM2l7lsG9hiwppGcqkBKSluoOu5DOtRT6eXORMf6hZ1sOYDNJrgpd11t
         YepQ==
X-Gm-Message-State: AOJu0Yx7b9VVWM6JXpEpyOKRayFrilo6LClnmtR0Jh1AdYXI+/6f6bSa
	NwZQG+TEHx11E0SQcCTm4ijOQ07LllOiFoFKwJj3eGKuElqPwDM/ClwO
X-Gm-Gg: ASbGnct5E/Od55cusXxYu8F5AkeKguGJZa5GEV29nu0TunF79wu815AZ1rdP24aPKHJ
	D+YtJuCsJpzKNGepqJMKlreVgq7fqHcWQ+RP7ZTxULsqMSTbgMfm8bbWWtPrlZcFkYef52vwe/0
	2NrcejRCYG9h8eDSCJPlKHsb4vvgldz/889X0Ung/iUC+lFNDEUpFbC3XhJUrtuVMDP1fJrhGe1
	ssPxMxDibtoKFBACMpPUgNBxbRcemEECIli+L+kgiN3ions61MVdDsJdtRN+HUnmn+KQavTzkyA
	mwLr/goG3AA+g/wvCDxSWVlr9BH0We7Ctzq0m1hXz4toHl+irXU2BdaaLRVnwij4E7LVvSSn2aH
	x64gAlKFt/5GXrtlyYYG804Ox3iNiXetIL7M7cRu02ORL1VLUBUgjD6hhbOlE8obKQ5h+PnG/dH
	fkUzfafxbMAZT3CjU1rx65mV7hqA==
X-Google-Smtp-Source: AGHT+IGoGR2vvfoyHhoCGadAIM1tRSK0aixyW3oTcQUZl+ZTkQaaORwlprV0B52obn6Pxd8CCBZOyg==
X-Received: by 2002:a05:7022:e80e:b0:119:e569:f624 with SMTP id a92af1059eb24-11c9d84bf9fmr17998389c88.29.1764579903743;
        Mon, 01 Dec 2025 01:05:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm54908307c88.0.2025.12.01.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:05:03 -0800 (PST)
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
Subject: [PATCH v4 2/3] block: prohibit calls to bio_chain_endio
Date: Mon,  1 Dec 2025 17:04:41 +0800
Message-Id: <20251201090442.2707362-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201090442.2707362-1-zhangshida@kylinos.cn>
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
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


Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B41F30A9
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315883; cv=none; b=lsAEcpIDWnovqNhEXKP7sZsoxxzBtObOW0VaVjWk/DgkZfCqkX91KfnVcIeMlYg0LG46I76zdoGO/newU6+GKQDUyrj0O/oXaGIACQiEUB7Bs84aCBBQMbLOo7MJin1LN6P7evS/2K3uQd14ZxMMmdtAMXjtDDHR7dKYy4DEEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315883; c=relaxed/simple;
	bh=EGZh2EvswD4Wb/NBe749kVHHN8RXr0d5bf9D1e7clrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeKiYrgxkB1PB+cEaNnXTjx6qkArVRB4K7Xb8cuE4yiUxpzlur0OHGLSM+9m/UvPaGfjDqx7mYPp+Y/WlM00nT8oAV67RDnJUfd6dm/HC0FO1I/yH9I2YDmLz0dV2PXHcXj29e+M4ZnYI3CjguuktTAUaqOF+4IJDuP/mMYkpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dShUBaym; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dShUBaym"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5942bac322dso3556983e87.0
        for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 03:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766315880; x=1766920680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=dShUBaymkcB5o4HMf1RVrBi/KLS+seFGaWivqeo2Tp12WoP9bBGif/H+4eoZVMAWX2
         +iO2lIGIgtMlcxHkyRhdE1CJVhnZMMcQuK6jxZylOFOOiv6jtHGWbLMCkM0yTWBzL38t
         RAFoWByJ756/C7cBGVShbki90anvwPry0HQbpdRVx6OGA77YPvOWj6HrJ+tmSFgTg+CO
         anaCnS160Ybd6Ab72jghoTsMia+pVPlyVAirDN+QLj17F5WQWoU7Y6wADsR1EQzazvkq
         Rj6fDug9X6Wp4bGJFIaNdfrmOyCOrECih7blYoD0TE4TspAmK4O8YaRz3Sd7bhG1/FLH
         nx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766315880; x=1766920680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=vxA8wMeaVTCRZtnPjNT5cewgF2hohrSFc6XS9xvSiVNmf+T+0Rt3xilGo4nOdK6ikj
         LlWdWz+1u/3RT9HWPp3JsfU2xwhG3dEnLqBFanSMFz4p47t1VIY3AdPqG9WddYgNP+Qz
         n5X9KjffZ5bWcTh8Yc5Jg/bv33LGbYMQRZodCG1tOkldArAqoM6qsKew7VWosAEDO841
         ue5nqXeA/ouKp0DcPvAbHlelQvbRfdpHK7tutXsWK6da3pGNDd2ewAV2WGYT9L1xKq4N
         duUREsCINX39tXex5ChyaNpfLvtv/PrZzzpp34SgAFnXde11UNcm0I/0doAZz2WIr6+N
         41Bg==
X-Gm-Message-State: AOJu0YwkMII0fNr+WZJ/tvpqxf+t/FbNZMG5q1kYxXoM+7QkticUkNRW
	ciln/LRUFu46GJzAbhsoCGGbVLo+a4LJRieFq2x9kvt9A1lzjgcPd6LA9m5/CHZZHLU=
X-Gm-Gg: AY/fxX69t5FF9MdVnaaJrUVXFlCdwYmXuPGlpNKdUdEVNd3TQCnQ9cvYUFq9NazuNuK
	UgdXaOfSA15q/jboQKeEVilWKV5zOWfE6vfQbsW5/n0RE4DdZBV05G64a3ESzz+FlGCnibzOaLC
	lF4VydotyFkckeUFt55RKzi66+9Y8eZBJaUFpBNlP9aU/Z1WeTGwu+zfOVdyaoNSVljTMigkj7o
	9AK3UlUgzhSULBR15RpIa/pXZ8Md6hCm4zGubrzfc7GGIWCgrcCBMk67LwPaFLh76jZSIyEmkNQ
	zdiWnAMwqifu+WBru2vTWe/CImmhfgwxt8yOxetDqaia1iOhkgFHMaDVi53bbnFuobxtAPE3XRY
	nQWWXMb1UokjPRrsaR0/ItnMaW7EW0H8e9VxeVIHASrCZ7R9IGVKohcDXM12flSArqDJcUupZV9
	KA4EBeuibR1bk3B/oj0eKizZ0TvxC8+QDbg2ejdV24YXwC
X-Google-Smtp-Source: AGHT+IH6d4JJLvxJFsfU8GDWtEpaAdLJtPwCBVEJ7tqIIbHP6cYFV8AmeGI+MWfAbrGcvYKoAAskIg==
X-Received: by 2002:a05:6512:238c:b0:594:768d:c3ef with SMTP id 2adb3069b0e04-59a17d3c40emr3003521e87.30.1766315879363;
        Sun, 21 Dec 2025 03:17:59 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18628388sm2283132e87.99.2025.12.21.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 03:17:59 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sun, 21 Dec 2025 14:17:25 +0300
Message-ID: <20251221111725.19141-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It contradicts NVMe specification where alignment is only required when atomic
write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..5467d710108d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	size_t len = iov_iter_count(iter);
-
 	if (!iter_is_ubuf(iter))
 		return -EINVAL;
 
-	if (!is_power_of_2(len))
-		return -EINVAL;
-
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


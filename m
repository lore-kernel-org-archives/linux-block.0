Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326E155322
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766323464; cv=none; b=fl+QY4Ng/X/jxfHkY8bSWK9YiLjHXyZ3ixj1nVpd2PHwgGzuBS+ja/ZnLildZvnJZzBZwnDKwA2R2KAP8PDTKFwizED9oxKnM17yRAGl83YfmtSPHGp2rkLqf3doOGmZpr6cDxDwXmpnEFbGgNOvQYR2Zfo+DBna6z0G868R7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766323464; c=relaxed/simple;
	bh=EGZh2EvswD4Wb/NBe749kVHHN8RXr0d5bf9D1e7clrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiMTMNFemI83JgX/ugl2EOd7lSZrWx4qNJg8G7DjQHrtY7EhYPX/XqEzLe7GETbIHpcS2g6rmoffk6vK+N3vSqgD3alY4C5O0Bh4BWzVBGfFlvPSlRMEEKRCRoCl4ygMZ9bkRbaZtiPEUdCCHesCQk9zIfy3J6aHYWJgsS4QS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9J3PjSi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9J3PjSi"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-598eaafa587so3480489e87.3
        for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766323460; x=1766928260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=H9J3PjSiu/9SRIlcxoff0YzcufU0Q+ViSlwgSBFThsCqqk+Ss/FgGiZ7UllVQ32X/L
         8EU4W8Y60mnYcdsKil7pkq0Hswv2fSR0lDs7SmvBcsjrBein/F35Hgdjb7+i8FO5U/VV
         iA3LCsseEjloU99ePKlz1/hV/Nz1KnOrJjmjs5H7Qnmc8/pPwh3AImGyyLQULeU8XIYX
         o/9E2aJdWZPOap56TSv0mztNsGSI9HXdGMho54bxkqp5JwcoH696B34Td5DLWv8VAB99
         GKHkUxITHN0E6A9NYFXwNqujLrVqQ2FloVz0wl3bErQXWsih5xlF74WhBtgtuDxWYqrm
         yZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766323460; x=1766928260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=gXFvZ4tHdIEP4ImDucFX9Rkb0CFYNOLbWX3GHMGzFCfyB4Kz9JXcs5lQMCjnS1USp5
         s1D86pzx2Br9itGu1hnkKn6jbt48EAO3J0UkU89xVLVPWe8bms7CK9MA9oDAvFbhYOYb
         QZG9bNlPNHt9v3kUwIXIVfcCSCFHCNflnUb+PQH/7d4eag0HQPJQ9jzGQxtpyear1+Xn
         C5sM6SDXYHK3H9HW3T9Sr80fby6tRgEIpa8ROcM68vpCMgjpphmVmo+Rilq7xE5JCqH2
         Q8+ycN3Bm6crnMBMReYvoClIdw9A5pCNXR14a0i8v7XxxStihDtogH5WmEP/gwFiCg4c
         c15Q==
X-Gm-Message-State: AOJu0YxyksVTKwe5YQBBBbz1IXhTkz/ug95Dp5Bs3KzH5uYwk32gtVHw
	TxKsPALOwYtdz52ZY+mq/L0m69Yc6ZVQu2Jd/ZFXslk5Q59AwvdUOgbGW1kHtB+tG9E=
X-Gm-Gg: AY/fxX6xujwlxs83TNs74v259nDzARc5k8AlEDD+TejAjpNtivEddx3gZdziePsyAjq
	OpVv7UZBYPiDrha1XaUhskV5Sv5oeA+cDbeYoHR+MPDyt6Q6HGUmI329qS4gnqY+b6EjdtpYM5a
	m4OJT76IKZxW6wo50dc2nBdFPQwswnZUTxvPWscVXZuZnNJB0gOJ+Gw+wgFXRtKTE/gyg/ae8WL
	NEOBtcL7KrPb7KiA54nZox2gftlQw8+RvxMw+Te0+Hprum+sWAt92lr/yxQC7SkVVbJcyqgVRrK
	FFI2tJlE7+S9PYRP6Y/6AB5cKVgmfsHpBBqHJChxgQ9z6nkNJ5T2ABrF3HCBcgqcWIQysT6qmfH
	34anqf14DbeJ8mtG70D8jp/jKGLo5bpDSSjwgv9mHKFVrwE7uHZB8VzpCD0A/KNcIJDKdqEfuSE
	l0esIDPxllUMdUj/7g4Vmm7sMBKZZcHo/c7FMw9hbbkquR5WSd9eIQlIw=
X-Google-Smtp-Source: AGHT+IGrUPswrGfWjOqQP3snzEfw2F7MfyIrcGhl52qtlVj8tDCZHAWezyXnpr2il7RjW0E0QZrKOg==
X-Received: by 2002:a05:6512:4006:b0:59a:1238:2f52 with SMTP id 2adb3069b0e04-59a17de2c27mr3232118e87.27.1766323459996;
        Sun, 21 Dec 2025 05:24:19 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dda8dsm2306800e87.41.2025.12.21.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:24:19 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH v2] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sun, 21 Dec 2025 16:24:02 +0300
Message-ID: <20251221132402.27293-1-vitalifster@gmail.com>
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


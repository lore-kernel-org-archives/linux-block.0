Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD118027
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766252325; cv=none; b=ptmIsbvCtKAcNDEfDqnXDdeugRSthvlpwUUdKVXgS+jJWZUmEE1KwJVkgORv1VgSO/Qeukw4PywL8RlzUL9zZDr2wHy+rQQ/68c5QN4L7oTx0Y9ZMbsUwd2OT8YUUgfbi670Nx/4ABUb7XDY2G+BmaUyF/+ZRLuNXtoMqcPDhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766252325; c=relaxed/simple;
	bh=Y/voH7GOaY1vIvvLBz/nsReHQcaB9yvd5oju4+dtb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYcYTkpFrjlmsjIKWamQMkFnzYd0Z3i2J7ilvDpQmb+2qgLJw/g0baj4X86qeMprKkNqTM0ZB0KtIm/GvbgT+W5dC5oW6cbsFc3HRaXLqc4wOLGJ1CR3duxniHLdnE7qCPlPqq2TAZs5nbxV+/gWICQliwnfh0/t6ErujT7KsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eipv0gmi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eipv0gmi"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37fccf7035aso21916201fa.1
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766252321; x=1766857121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWVHQnXJHLnZGKwql2taywHS0CwUooADxiatSjOPg0c=;
        b=eipv0gmiHguAPhVAm5bSjlU/J7mmVpej8dQO2X62izc2EVlYbGsivihg1anrjbr2n1
         hMMJv5TChKqqjioP1c2fySgM+9ZTSJIgkIfalnlNefuK2YSo7p5FOSrGRMDsSNVACq9A
         eL85BRTUyRVyVpYIEr5niD+GBp09XEcYmiTowL2kjQswYQWho+3wLzQ7OjP8WZZr+Fqj
         IRGkYquAudq+JPEfw4QUeRtCMrnnkhYDYVpuuHnsMIlycDVTJVAdDl5pyV+4eiy49myS
         R0lPYwKBEOF3tuxDJ9cDmh1c6N2sz777N9xZftkXqQjK40T8w+X9K+Oc68m+eBm1pTSN
         gxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766252321; x=1766857121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWVHQnXJHLnZGKwql2taywHS0CwUooADxiatSjOPg0c=;
        b=W8K2ogBexX39Rbv54VJt/OqMMZJzIPbBFbT43XQgno8gPsSc6FubsnQ9stpNafKw+c
         GKg7lXAOmPaERYv34+H1qnFTUGO9wxElFzJZZXr0+Wz1OYNeBE5lZDE0LslZOrQ0kECz
         klpJl4HC3Ag71SnYoyeTTHCvGx2+bfqsdxr8nI7DRAPVaEbCNSyFle5lQJSvTgFgvCiz
         BM/Wb9xzEPQbkbfFxgO6Kys9zPaStWIk+gtRyTvveZjc4XA/4KyJUczbzXiB5ovYha9I
         IDZfvGyRcBjyL8pkm+PqcFxe0+8gZgys0QvBYZz/elrXC4Ve/nnSucoQkyY7dpVpaOeb
         wSmg==
X-Gm-Message-State: AOJu0Yyuqt4nsCq5Ae4NX5LdlFtOlvrGv3BqfcFvQtLFqQdUdyNE03jh
	72YQARjQuAW/mO5WR8hHW5Z/jYt6QERjH4hwiypFv5Nh2jE7G7rTZidjc0r/8g5/BUE=
X-Gm-Gg: AY/fxX4o0T4H2F8zyku02kqfCVSaXXO3JcbB5fW/GVEQk/0ULWiU9cxJ8HUKeJyM91p
	pNLKzl8D8bQF2DN9j0f0daij919L45WszI9S+7Zq3kml6/w1IKG14uqX9Q3cb1LXAc/ok/zQrB6
	JhnRzYhSAsyn3ms5XTXz5CRMzKOsjfrsgc86/IQYq0jKKXNd/cSks+1mjkQD08Isp6Q1I53eYU+
	ULGBVQmVlHJOPZX6k4a7gkFV6h3arrNzrp3Wc1UMrkTIoYlqFMrLHniEHcdBNnx8sxe3LOirmyc
	i6PtTFz7bKwLVAjauHlofG8lzo0tjhgG5hmGDwaF7zxh9Mib6uyW18rw4/NbkWBbLGp/zwfkyZf
	HAxooZd8IZjWdVzBMB2L87cB5c7bLHo+27RfiBV8vR1eR/Jo+IJq08pcEbnLXXL01LU8qvv8MyM
	dVCTQkEOdI2IrgCDgwRAo0z5aJBiNCJE1S/9Y8Zqq6SZOW
X-Google-Smtp-Source: AGHT+IF4oZaM2X0MjOhaWnNrJhiLDqITwDIXbBo4fYLLk5BmYfUmhvV6jmaDiuDNjWd2FalLYanAKw==
X-Received: by 2002:a05:651c:41c6:b0:37b:9ab6:a071 with SMTP id 38308e7fff4ca-3812162d6a9mr21438191fa.28.1766252321190;
        Sat, 20 Dec 2025 09:38:41 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812269da5esm12685351fa.50.2025.12.20.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 09:38:40 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sat, 20 Dec 2025 20:38:33 +0300
Message-ID: <20251220173833.71176-1-vitalifster@gmail.com>
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
 fs/read_write.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..8b901be75a9f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1807,12 +1807,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
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


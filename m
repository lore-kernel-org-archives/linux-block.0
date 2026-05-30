Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C81E1E04
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103595; cv=none; b=U7ybM+4fsfO/J4vDNu7y4YUV81J3TcF8y2NhCJivsnzPiFyC4ZImNwt1Clj3HADkVOwo8SW7JpZjv8mKbQ2+DcZqmqTy8l+vtKk8unVcSJdg17UTQ0oO3tZdlb655uCM00uTGiToWmhR/czIIlxgWd/BMjbkQKj/5t2WtDtzMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103595; c=relaxed/simple;
	bh=3UnX09p/RsUwab1+mBzMfqmj167P9iLQdXjXopkWBnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvKOx7rb961VUHkJ9Xf6HDe/JeY+VpeBG/2kr3FRKY8XOWXG80ithFjgRbPkKiSjzXjpCcw23LhzrwnkUqO4K0UQGIkr9zpGd8Ayj+6TOycyJ4V5y6YxhCZU6dGha9voiDRfhGLiK3+Oc/y4ktxvuew+Se2U3PGKFFeEGpon3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPOkTn8y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPOkTn8y"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so246636b3a.1
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103594; x=1780708394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwoi+zIOmB8T48lEoYYS1b4s148mrV/1IF4tO/5dMRA=;
        b=FPOkTn8yJwu4bPVA57zcs9Yzn91joNCncit+xAQ+c5ci0GXwwegZjtz59imDFM6fVK
         Z8yqdEdubHX+xdlx2Ev9CpG2RrQAUmzYWqENSbrPtlmJf58SWqBSyILgz0vb1Kvy8wR1
         a1e8icgMMh/l7GZbDCQrnFg32L0lyU+dHvWlVQB/76WpGSn5qsWpE3XZMTctpRIGaQuC
         5GeFKBx12WWQdemtueEQiSC+5XvNfPWgf07J0Gp24Kgf87tR9ZDOQwMwP05jiF6lBYt0
         qdar0+59TjX8R/evpm2CZzgdvY4oZOo0pEahjd8s4PnTjKFWZRavtNrNNfIl+t8fyNle
         VV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103594; x=1780708394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwoi+zIOmB8T48lEoYYS1b4s148mrV/1IF4tO/5dMRA=;
        b=eX2G4WKDCMQBTtMRMScR2/uCP9uoC+IY9ozaT0INBXAilE54PG7FDyLk6ddaaCFjAz
         JfmsZ9KK9Ba/QPqxGDQSjdsiDQbg2okUmBcebkdXVjtm0lmJlm87D87soDUmCzk/KEbO
         d6SpUsjhCccofHkpgRsCu4omncsFlfrq6xnGiDLuGP0BmSVPPsMC21Seb+Z9HoftEcM4
         k9v2ZZdxzlOi8FVGdZvOpLa1TjI3ZQ8JhRFXDUCoT6fSn9ZnsUqiA+lkgrePjdF1vKbE
         klNR1VSgBhTL5tg+54oBl5O1dJottgkt5sWxY99v/Hrzc1uT4QMlGCdjoKjXdFmCmx9N
         fz9Q==
X-Gm-Message-State: AOJu0YzkG+SLBeqw5YBjUXaD9m9I92UAPie6HGsI2E6FDuG7w3np3CyT
	D4D56aqtXQSxS5vyGY9cVGNUimUfXnkc7COqDVSpfMdWJhAY8XpsTbmB0SpZPr3v
X-Gm-Gg: Acq92OHu1FMdY55KYVjyilOdtLzkDo7+Wo1qNPUDQNh1U2gQliX5kaInZU0dS8x4xnU
	j7yZgEolICRy2kkmspVgkOY1BtIuIVlnnIZPgRTFiJJ56cU3DEzmCX90FDK/w/DBBrzdMZa1dVm
	paq/eLGRxRjoKhgH90HP58ZZWo1QqvsvmPBr2JujCKr0mo4CRwOyyuupFLHX2pdxpGlFzG+bdhJ
	hhsdaNp/gWka7ulDfpdIIfxT6Swf36k8WWGIi8JhLlXin39l9BqTOJLGIBPKIPiQQjOoNR98/aK
	kYMXl988V/Usd9zJpL1LpG7it8evM+5YGjeydKJxr8OJ99VFg0yG2GHOqvqO6OnHpzrl+Ah7tmF
	pFf3ORg2n5Kbi1O5VLEhArLFgmhkZUMIi8DK8JZY2f++bhLerepPq/jIsuCFbd34EPOOzSI8N8+
	O8rqF4WPHtUR0YGtgv2wU5xnnkQlsgQXU8rZdP1GgX32DRpQ529Q4mLX91EGiWLBpqiA2JkGDWh
	NXBHlgFKN5QZwSIHlCX4P2UcmudhQOJkiDGRE891AUe4Q==
X-Received: by 2002:a05:6a00:9099:b0:82f:721f:10ea with SMTP id d2e1a72fcca58-8422578d9cbmr1736790b3a.18.1780103594025;
        Fri, 29 May 2026 18:13:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cba602sm3230843b3a.40.2026.05.29.18.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:13:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	ceph-devel@vger.kernel.org (open list:RADOS BLOCK DEVICE (RBD)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] rbd: check snap_count against RBD_MAX_SNAP_COUNT
Date: Fri, 29 May 2026 18:12:55 -0700
Message-ID: <20260530011255.52916-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snap_count is u32 but the comparison is against a SIZE_MAX-derived value
(~2^61 on 64-bit), which clang flags as always false with
-Wtautological-constant-out-of-range-compare.

The proper check here should be that snap_count does not go over
RBD_MAX_SNAP_COUNT.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/block/rbd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94709466ad19..25215c209484 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6075,12 +6075,9 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
 
 	/*
 	 * Make sure the reported number of snapshot ids wouldn't go
-	 * beyond the end of our buffer.  But before checking that,
-	 * make sure the computed size of the snapshot context we
-	 * allocate is representable in a size_t.
+	 * beyond the end of our buffer.
 	 */
-	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
-				 / sizeof (u64)) {
+	if (snap_count > RBD_MAX_SNAP_COUNT) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.54.0


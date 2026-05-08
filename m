Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9542375F88
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220538; cv=none; b=MSf8HzZEBFzFhJjNy0ImakwcpzEUfj4UBlaDoVsi9aik0suTWQ03nfdN7pw4iHzBFkySNIXTBUZhIuaS8vwhuy0sNlAWS25q/D9mjfsT+oPRHXe31PwKrJCc2O230gY/dtJJfZhB4sFWHtjeh4xRmc9htY9sEZRM0Jd3sMR1YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220538; c=relaxed/simple;
	bh=SvrLVwrtLzVKQiQQgO56qCvdjLHcnaINUCgpfFTOyjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTXvszJFZgZXNtNbTMLF+kCkMnSCzRrxKnT0iR5C9Bx0V9hwyEWWPswdMZ8bNYio61OQJXR9o5ncFpRpA+TRlLHkzwR5ano+DcUFMV3DXOiE1nR7rYqTHU0aCLEvnlERznXjC/vWa3PduMUzj5fK8MJhOs3ibc0vN/7+AfuNByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfJUfGiY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfJUfGiY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366139223e4so994319a91.0
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220528; x=1778825328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYRirjFTjUvafOj+0puY9l5IWTCm5/8QMipbtzzjFcI=;
        b=RfJUfGiY2opvt5Qy6ZHH4g++pvIOLkEE8ACFgd7fvUDbLFn1HNh8jhoQT+YQsdu5mb
         Cj7opou6xaZLwb3ZQKGcbimxnUS5HdtJuUkS4a0KPMN3C6f5uFxOuirvEMlPk2c0T93e
         npAFkjAU/KULLcjKY10KwqyLaLykBeSOhCX5p/2GLV5j1o2gsxSE5UTgQMGfSa209DlK
         cX46FxiWL1Vnswa0Luk5btm+1fNIQ6FfTbsbwNCAlhonN56vZjEmrpEg0hS/Mu/LNPAs
         VJ73pE+/n1+PKwnyeNC12ndWEcgVTDaJI4hdDY4x5xCSjxD0nV4kSJcC3jsByZ6O/nZV
         WWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220528; x=1778825328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYRirjFTjUvafOj+0puY9l5IWTCm5/8QMipbtzzjFcI=;
        b=lI3kxMyakPf8rtjYIW+a9YE57tKkKat6/h5Brf5Xn04zixhIScMG3ccLd4mUhUijD+
         MtmOjZ0c4OSUHFoNvaWiSLn3Bs+tjszF1C5IKMt2nBJKPj3+5XSsOkku9O3Fhj/892VF
         fH0vf7h5GFfajdvQN00OBVC/hpmKZ/eEBYCepLd/HlZeWzxayTj42vtY7Np2pbPNN9Ny
         38lnvRiPh5BdwljWY6GlRczUvDZbcxLdUnpIN1/0qRVVFjSxL2y6mhMUzCGMIuRMPZy5
         /97xbyOBjeehZ+oX9UtLfi/lJNTbszTOjfu+sDQV1MoLuXmkcsyOSy32q/2S0t4hwmof
         d8Aw==
X-Forwarded-Encrypted: i=1; AFNElJ+cztuUK9S20v6nA5uN9pdircCJ+gM9v2JT2gXQwksJHc6H4p4Sb/kGj334JPO30vThHUtt4wtErM1pCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMCHSFnHHZGNBJAfX7aGXUv0RCKkpeW3DEyC7y92BXyn6ux7X
	q1110zfJvAcmFF/X+ZHhyoULW+LDkUJqEq5BgjyddSDNtTx2a+hPMnvnX1/P2UTj
X-Gm-Gg: Acq92OETlryDw0k5+q04fmaH0zcsboRMtxaneLC1Zew0vrwut+MbNRkHdPN/CqsnWBG
	jSJdQD4NkO/y8ihPVeeIoiFlQEyj7nZxGDvU6KTlzg3XC5LgkBS8lgParzj6H1fowm8yOSAQFFT
	FmG0TkpZ1sxAR5hTlp7A0CKQuOrU9ejZYhBHpw4qB+OBtwEj8NkQs5NrSRfVF3j8XSYKizefoMS
	abt63mbtOz4Pfa8O/4rRJfA+pA9AmrVgHlYZwjLyFKKPGF0x4pJbX9sMD1iIQ50k5lo1Xbycesy
	oGBriStEu9+UZjzjJBNaOxp1l/WOOMY0xGhMQWL5yBl1Vv/ZpRG1Uo2B2Aac8KYgn09+GiFFVcD
	2WBEj5nok68AFsZ5XaE6c3krZMminOF8FrBu2py7uNwxLmnoQ6/jOKqvg/WtM8Ls+QbVQJaRQoM
	RGcgglW5vvKX9dXojSIIiyUlTP+uwAtADm4FNOCA==
X-Received: by 2002:a17:90b:3805:b0:35e:b017:da6a with SMTP id 98e67ed59e1d1-365aa73cc81mr11744580a91.0.1778220528288;
        Thu, 07 May 2026 23:08:48 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm673651a91.1.2026.05.07.23.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:08:47 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v3 4/4] zram: batch clear flags in slot_free with single write
Date: Fri,  8 May 2026 14:07:24 +0800
Message-Id: <20260508060724.3810904-5-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508060724.3810904-1-haowenchao@xiaomi.com>
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace four separate flag clear operations in slot_free() with a
single mask write. This reduces redundant read-modify-write cycles
on the same flags word.

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 5 +----
 drivers/block/zram/zram_drv.h | 6 ++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0d07f0901e55..b1a565d35567 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2011,10 +2011,7 @@ static void slot_free(struct zram *zram, u32 index)
 	zram->table[index].attr.ac_time = 0;
 #endif
 
-	clear_slot_flag(zram, index, ZRAM_IDLE);
-	clear_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
-	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
-	set_slot_comp_priority(zram, index, 0);
+	zram->table[index].attr.flags &= ~ZRAM_SLOT_FREE_CLEAR_MASK;
 
 	if (test_slot_flag(zram, index, ZRAM_HUGE)) {
 		/*
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 08d1774c15db..89a7e39a2f4b 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -57,6 +57,12 @@ enum zram_pageflags {
 	__NR_ZRAM_PAGEFLAGS,
 };
 
+#define ZRAM_SLOT_FREE_CLEAR_MASK	(BIT(ZRAM_IDLE) | \
+					 BIT(ZRAM_INCOMPRESSIBLE) | \
+					 BIT(ZRAM_PP_SLOT) | \
+					 (ZRAM_COMP_PRIORITY_MASK << \
+					  ZRAM_COMP_PRIORITY_BIT1))
+
 /*
  * Allocated for each disk page.  We use bit-lock (ZRAM_ENTRY_LOCK bit
  * of flags) to save memory.  There can be plenty of entries and standard
-- 
2.34.1


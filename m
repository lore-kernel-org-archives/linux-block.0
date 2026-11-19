Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061652;
	b=I0kOb+LyhTvXeHIk3qTgZH7axWBv/fiR4TOQdnjBfFF1PIuXSiCUp2OJZZaw4u2vY+Zq
	 owShgSyhPB0qp1nolwgUvyuZPb3cMB0gZ7kqq/Dy/lDH99C7PyqlK9eARRmsMLhYKR/7A
	 Ww28xplqJ8bCnhnTjJbBNlV/MLJ5mlEklRRIGh4l9GKE909PPDN/c5seaNOEu0voNwMN1
	 r/xqdd3+N14Esp9p/1iInCS0BDakFZRg7JLZ3310eQbPeQSFRWT9Y96Ltg3ffE3dps5YS
	 2gzR9irtGkCkHCTeLVDfBc1mZhQGu5ZlP99Aj2n7pfLoVY5fdhKKRwFL7zpD+COGTfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GikVTWoTtBeNiGifZTjdMmvaA9rmr+argKFGtvFCNYM=;
	b=Bofxn9aGsGf0aEOxsKHq/eUzreABH+hrsc/GcTAhSZ9LOiOHclI7LFR4lIl3nVYljwIc
	 hqlWehSzqbMAN0gDNNxHHSzhmsednGUYvdiOPQ06h49rm0SvfAD+ADcGvgxEVusd+hIvJ
	 LVbPsSxwk2GLdqTT79+QaF7osLGfTETcZIaoc92nyP1tEwX1XOyXJ1f1c6wIirn5LiuqX
	 HvG2AN2dtsDb+O73l1ALBc55bYClpqwfyofodf0xSckKwNT504z5g3BnEI6Wa2GA4C5O5
	 EL+rwgrZtk9TO/eSylWMvJwhqtscQmaUbxgRtRCg1Nob4UWFxCoZD4PD85lqhv7O6zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QhqFOgim;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04A606A32F
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 04:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C04A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QhqFOgim
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso1072971a91.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 20:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795061652; x=1795666452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GikVTWoTtBeNiGifZTjdMmvaA9rmr+argKFGtvFCNYM=;
        b=QhqFOgimL0a6Fj+Kd6AaRM+UXj0uP39fHE6FIzbjjkc+D7442cjcWow5zrqBfF4dgK
         CmTpJ6F0+frwACH2E0nmfJaA0ADIlHqA4m+zE1L6YFawz/T75Kwh/qmas4h3EgI4hamg
         hbKGLuECa5dYtyk6yMxrmSYwJvNRmytIWLP0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795061652; x=1795666452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GikVTWoTtBeNiGifZTjdMmvaA9rmr+argKFGtvFCNYM=;
        b=uoRwvK9bthLCeUrr8X/HcEALQXcMRwEp3i3jlyDGQz3yxlGL7euK5edX3AheElsfKY
         3hUZTYiKOppkvT/OYkbGCCARVYyp+eFBP5xyUUoF+RebHjr7U+d/3YWTMqOdYuVlX0w7
         /usKgXnvxAtdc+CWJKHTl3JlhvdGx0LlW1zgzN48ndeFAFRZtxFgEs+b2x+u43Pn/bhN
         Y76pPfAY8eN2FcL72GwkKdJv0duCQyo5Rp9VbhlKwnkkNTM642JVD9N8AIjuZdgiLwJf
         7NGbQQ4jwMz9966kbTHOo8AOgtkbiSjjlGLcV3MLc6eJrIhiRJrKrmA/hct3Pw8t+HpV
         yipA==
X-Forwarded-Encrypted: i=1; AL+hErEL8aK6IKt5eijAwIMJKiuFvEAtBxBTliY1BU28tpDBxKR8SEBD+xJC+LwbS52tbdBf0xoSmCdPkfOrGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kPVbQRPBWQLCaKf4B7Il2fuiNzkVbri/S/Giu8TxvprW8lydZ
	tHsEh6MvghmOHrljDfbrTHtuFvLcHLmnDlaxCjZkjHvF7Qqp3FggmXVddQ0/uS/jWw==
X-Gm-Gg: AZFdTZc4jQWZKbeXIGqW1atmRZ7RFI6Yn/7/9eDhWlZ1EMb2SbjfN5HGvRaC3j8ID9t
	LVaGf/cALu42r+yicJ78gX9urO52s/JAbuDR/Qosf6gPQOnMJnXG5yGIg+AQ8MsBe3ip8x2D3YV
	wB5Z1WJBKkABBibR+YDnkPMJG2WY2UlGubD2l2qdPYDSl6qEzbrLiz4W+gqJaJecrG9YGc3ehs1
	lxFnP2ufRvwbVypls7xLCh9RgjN3vPwzD0XCmhDLPnwH3gZizM6OgctDKWYwrmGKkd9fjj/SoAt
	JYOfLCPnXEDIhzzYoHTjDWOlzqvh0soPYx+KWUSuY6XpHLcWRLGakwGL6z3LkFHUAqPil0MoWSG
	WZbz2gJF+wgyDksSnHoD3X6Abiwew108i6CQiVby/dptUPy0nLLX86pQ+N9wn6QYR+DWEwtkVz/
	ckwR2tJjPdxinog9ZGdEYIszZZTySyx23bPwflh3idG2ZKEc0uLwdcr7VmHQEFKaOhzcHHTV0yX
	47p2hwOO0lgsBYcsL/JGF+Sk+eCPWOcGELqDtgnJGux84sd/VDb7PQ7k+E4gpzwT4+87FaDkaS3
	re6H+jK/HPDkElhteKwLgBa1wPrr4enmkxZem+Bjg9pCXs3MVS67sCQw+eBFMzmGS46UH+t8+nR
	sdK5wcgOx1oYyr2f6UA==
X-Received: by 2002:a17:90b:3f88:b0:3ac:a203:e0a1 with SMTP id 98e67ed59e1d1-3b3d07a9f77mr4492120a91.37.1795061651613;
        Wed, 18 Nov 2026 20:14:11 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9297:4989:4c44:dad6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40593719esm438795a91.13.2026.11.18.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 20:14:11 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zsmalloc: fix SPDX license identifier
Date: Thu, 19 Nov 2026 13:13:51 +0900
Message-ID: <39f6056e0c8834fc3eca2001fcb44f3b6048f74d.1795061575.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsmalloc is released under MODULE_LICENSE("Dual BSD/GPL") so
the existing SPDX license identifier is incorrect.

Use the matching identifier, (GPL-2.0-only OR BSD-3-Clause),
and drop the license text that it replaces.  The copyright
notices stay as they are.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h | 7 +------
 mm/zsmalloc.c            | 8 +-------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 8971eef333ba..3232bc9c33b2 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -1,14 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /*
  * zsmalloc memory allocator
  *
  * Copyright (C) 2011  Nitin Gupta
  * Copyright (C) 2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the license that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
  */
 
 #ifndef _ZS_MALLOC_H_
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 4a6ec43f418b..f571b3c9e9ca 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1,16 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 
 /*
  * zsmalloc memory allocator
  *
  * Copyright (C) 2011  Nitin Gupta
  * Copyright (C) 2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the license that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.56.1.708.g77570a6a1d-goog


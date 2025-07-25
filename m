Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD74685;
	Fri, 25 Jul 2025 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416579; cv=none; b=idUI1l/sNQtS/cZyudcu2jVDg5tvzNXRgJsz03rHKGnC2PkU/L+EqxTGvnNNKYhtzbbIpAoyK1VAd838dmCLoOSvi9GlYY/VMcpfxfyQB2RrgIIhOaB04vPnusKwfuf2SJqieKsoLFgrdP6OAfPO0RVZY7XIm3SkoGK9mnNQkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416579; c=relaxed/simple;
	bh=XxDGUkrMFJiNDhqUvg5aHCm2kl7/spgyYrSDd3NdfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kp7UyBgtbBIbtRZB0jZoeElynAjISoLdtMfm+zW9kZstO6ycewpZx/Y8tsq0s6d59ICwqBJdhkcHiTsidbDpnxFj6FTyPaxQ3yshPAHDeqTKbjUt3vzzg3pv71PBn+UOSaIPjqzWEGj0sxmc/o7ojc6yVsWGvG6unlP0D8SZOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miZZYpaV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miZZYpaV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23aeac7d77aso16680105ad.3;
        Thu, 24 Jul 2025 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416578; x=1754021378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q37ArcK3Ir4ZnLTNtMBmYNTmQ3qGIz1H0dNVEu2W9HE=;
        b=miZZYpaVN1luvW5RJNBH6XaZn/B4EgbveYizRhsQJLJyga5nc9fAkkCX2ZFqk7GovX
         jqOT/4fsUSx1f5ozuCvHBu/i5GPlmm0foA5JoCKNt3BrwlnOC4QAdf/dekdZys4MRVhj
         PMDLnzdYyVPtv0y023QZ1RudOwy0JL6uHke9PrKAN7YFxAyyk2aWUm5DF1GJLB4fH9pv
         bFxDSKREDb9QE/1Fqa/bPfdUo/deuAAC+OEQsHMrvM3vCg9pMQmyiMAU8Mh4ZgGnm5Xp
         leN7EzaLPdXZ+RgOnnyxmevvbVzJzYaJS+fa8pqIBAmnj5Ha8fK66vMp2ma2BV3odGgQ
         e/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416578; x=1754021378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q37ArcK3Ir4ZnLTNtMBmYNTmQ3qGIz1H0dNVEu2W9HE=;
        b=sxuE41mFolN247oO+YM0lFtyFD64EHml6gWF3LVWgc7Lttb96RIjKRYGY8t19ogOQw
         JygyEUNz27xyIJiS+5Z6D0bp258iOkHB7nBYJYeyDv8SUsh3TLT39CYjOqJNKidiPwUG
         4MkmseAYEfa3J2VlEogHiB+YN0rtv45NgQbylON4kSV+bW8QPucO2r8NgSitS4XfX3Lc
         C2LH9A2oCt85Mn0Esf/Bub3AzWxXNUCKqWxtbyErDqTo2k8xRb/+nsnNGrh5s7u4VAlG
         Nvr6AAlbGfpgWrXzenWrCzeyvge22k6cZXDnP77iBMentJQXlya2y/+z/UfC//ro1PF6
         1W0A==
X-Forwarded-Encrypted: i=1; AJvYcCV5dDiT6ficxspBCBKmPKww408ZasNEsIFwV7SaUFng9jldryXliqajXMmZ9/wLwA6KrXU9NA2m5qa0HpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJceCRGCrR6AF6NLI7+BfYbmGV/YTqvsyhzA6mTOY4hXYKiN2l
	askGgAFD4WCNnfqRW1EqYUwJDscnIemAFhoK0ZW5vD4GeUgaWfYRB5m8yFUfIHUSfD4=
X-Gm-Gg: ASbGncv945XJhHIAcFDhuR5lXoKARgblTwD7Je9RGR/ZGKw+ERu5GaEZEk9YgPOro1A
	PDwnqSzi/CKUYgCJbZyy1Lh26gSJ/sJYRWwSyRxeCAqU7XdIBpi5sCw3cQqeqBPvOMDUboW5D4w
	03V5yTscLPUovxUyzdR7ZleNiNZgdUHk23pd7ZmrbIIk8XWTRX47tfz++9Ls6PU2RF4hGGLGqAp
	SFuQe1Dn5Qqi5bi9mboVj3Q0tjpr5oo0jOTnxYcM1GsEEAyEdDWYlmVUmgEEHD+fhD+NXpoEzkT
	fNeoCGfQAGRNoHlxYTDeh4ae19JBUFggQe2JeaYrwx1f8sbMlOqrHphjNctk5xFFSZrqUXaxa/i
	BV85NJSl2QLaLpoqfNeSHo5q8oI+dIHPWClr5irvq0OABkqikGvZDrg8OtBVl5UzxiWg=
X-Google-Smtp-Source: AGHT+IFdlq8xw5dVfuTzq3rQd0zTyf1mnP9Y0n6hBZT9UejI+JarkslbpU/s1YN5CjCDgvhiDecBpA==
X-Received: by 2002:a17:903:22d2:b0:224:76f:9e4a with SMTP id d9443c01a7336-23fb308363emr5415315ad.14.1753416577882;
        Thu, 24 Jul 2025 21:09:37 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dcb39sm26681675ad.144.2025.07.24.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:09:37 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] block: Fix typo 'prefered' -> 'preferred'
Date: Fri, 25 Jul 2025 00:09:39 -0400
Message-ID: <20250725040939.73175-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b1d818396..5457c0e1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2361,7 +2361,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 /*
- * Return prefered queue to dispatch from (if any) for non-mq aware IO
+ * Return preferred queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
-- 
2.50.1


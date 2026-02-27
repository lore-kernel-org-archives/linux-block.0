Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF303290AB
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180509; cv=none; b=Ry73Qkn8kwxqVUGUkS1C+gMIJWZcshc5kKruH1tQ2taxKkJA9CMgvjMNECp5t9RpmBxfWFI+pNsiIFcZ02WSKCLuBncgkl5bHzwnI6nUWhgDKiIpqEc5MjSCMD2XqMU0JX3GGWRLXqD+SGvYpZazOrfH3JKtlp175FGPGLhaYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180509; c=relaxed/simple;
	bh=Cx/qC5MoShUXYGGHhZSUtmPt9d4cNE7+vL1RivpbCb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWfPY+JXOORalmSMNlBm0t2SE+T+YsdsbZ+7XSDYIlLauTfWLenHnyer3+hdfc+l8nUPS11WzVaYFMB+HMSrrpyJXkHxGG1wmH5FaEnw5MhbMb1TLeSH/qS0FAzCbRJF0CPy9qsjL++R8FKaPy/Oztd+NtGHm8QOqYg063by+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WGphIKC1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGphIKC1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9516a653so8048135ad.0
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772180506; x=1772785306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJq9az6bjggid+ayxEelbSnWqv4WCaON9zJSVCQ7fVc=;
        b=WGphIKC1QHyQQ+e8Fyp8ZCHBZBaEbjXP3nBp4DrC6Uy1+F+RbwCGF+bAv/h+7BhwgN
         BUbvtRPmmuy++3W8eWKTGBpPm+iX62NmswptHfxcEK0IeZ8+H634I1QAG53udxI0tKtN
         ggLRQA8SO1jR2ZW1sJqvJNIUJCCoLfDzgkMfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180506; x=1772785306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJq9az6bjggid+ayxEelbSnWqv4WCaON9zJSVCQ7fVc=;
        b=fERXy7AHwSMxkH4Q+ZRJg5vl8jwnJCX5TUOApxvk7EFNJ2vyrDCifVzN8hL54g+UE8
         HTZ/r1jj/ERLV/aHNhH6iQuJSbTjpwMAAc5oKw+Wmqdu3BUkrpyZIREZ+GVDwkv9uPAz
         AcrbZcYAUr2372MUCwR19ryPiYmt/2FIVfgjjhXYALJ2ckpj85xlFdbBXeTbko+GGwcY
         o7Gw4k962VtWPWB6DcCdHX+NP1WqzZrE0PZDFbaToILJYjsJux5S72vqMbWcv88/UD/f
         zzw01Gvdb5OZVl+pSMiaj8azgykFtZ3cfN7oMBW6PBXUfX7s+eWUMROZK7MZRzwfpgC+
         SY2w==
X-Forwarded-Encrypted: i=1; AJvYcCXrwNX5Kj9vwmZBj34XQ8es46W9THprIBp9meKyaxO0Hcr1l4NPdgwzSwpsA0WQi8Jxh/aCpe9I4rqVRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDdTcPY9xUMuR9pT213uVDOf2Lu07N9UawHd3aRrGvaCsypbm
	PK0RSAB+EvAVzHahWu9GK0xDW5Hi5KKSMie1lDsSwr22jFo+JU/WA+ZIes1KDXUgvA==
X-Gm-Gg: ATEYQzzN8fH5NdFq3bqMoNBJOYQax9QToFpyqBo7yz9IZfZHqdPn4fHz6+0uFjOzvle
	phekGzUbQHQx63Kch5y7TraxvTvf9nIZb+wD5bko6KrIh5iDbpm3H077dVSJ9UZ+ROBfYCpr8jA
	Bz5KEa1UThfpllzC9nnB2JX7OYt/H1qJERM1/qaZCzQWJU1OliNwRDHzt8h30m117C6yzKLFdyj
	Ifj/Avk676SEAfO9+WkqOoY9UBfnUQ9kyfU7yLaEzzVK1LTakaSOyVEoUjMsaS3lSVxggo3xmR7
	7sdsRynrN2b9l8I3Ee1qRoQPpj0xjdv5eTLsMlpRT3OpskoF3ueFZFzhn3JYeOequ1tKo1y9yFa
	UecNIP18vsTVKT1TA4RIAweFeXgR0UwwV69ysUTwgAt+xZppOk838lmYsYyI52t85PKV8ZL/uba
	lVTZNc8HxobGjudSiU+rGbq5hihu7TPl2+FGGD5qi2B6xV4pT/naa28PuxJYTNTErYxW/BLE1mR
	GzkQ3lkJgpuuw==
X-Received: by 2002:a17:902:db0b:b0:2a0:e532:242e with SMTP id d9443c01a7336-2ae2e3e3c6cmr19505095ad.11.1772180506517;
        Fri, 27 Feb 2026 00:21:46 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm48796025ad.45.2026.02.27.00.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:21:45 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Geffon <bgeffon@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/5] zram: do not autocorrect bad recompression parameters
Date: Fri, 27 Feb 2026 17:21:07 +0900
Message-ID: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not silently autocorrect bad recompression priority
parameter value and just error out.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4eaec24a23fe..53e0bbf9d6ec 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2524,19 +2524,16 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
+	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
-	u32 prio, prio_max;
 	struct page *page = NULL;
 	ssize_t ret;
 
-	prio = ZRAM_SECONDARY_COMP;
-	prio_max = zram->num_active_comps;
-
 	args = skip_spaces(buf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
@@ -2586,10 +2583,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (ret)
 				return ret;
 
-			if (prio == ZRAM_PRIMARY_COMP)
-				prio = ZRAM_SECONDARY_COMP;
-
-			prio_max = prio + 1;
+			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 			continue;
 		}
 	}
@@ -2609,7 +2603,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = prio + 1;
+				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 				found = true;
 				break;
 			}
@@ -2627,6 +2621,11 @@ static ssize_t recompress_store(struct device *dev,
 		goto out;
 	}
 
+	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.53.0.473.g4a7958ca14-goog


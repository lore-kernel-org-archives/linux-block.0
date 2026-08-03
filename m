Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87B1DFFB
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766427; cv=none; b=h/z0bEqfYdk1GUYLJ8r2wD0g+0gesK3rNhlziJtMsSExbTqaexwcDW8OQeJmbvNt76rDMNQVaCZpVQO+TqhME76+Oo7WRtf8OxjTPUJ5Wi42x1GAoM62+Z8Sd+PCx59hwgR60u65M7hbCMYQ0wWg8omNnM/x4JW5Tm4uu1z3mUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766427; c=relaxed/simple;
	bh=IuMLjQaPfv4JXSeDcgATZz8vte9WUWSgWRND4Yp1uDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGPeY9lekI9S7wHf+PKUYsCbw2CqQCAik5ufN1Hf+OhnRSsIAbBv8WS+XaJvAcCa39R6Dk2DH8lSnsb+0r6Jf5bQL4zXHK43foonbwC0h1IMv4L++PqISpIUFDyeVDeMOzp8FeP5fJlZ6yWO7qYsVckEh/SQc0G/6kCaM33rcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThLV1SyB; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThLV1SyB"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so1956595a12.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766426; x=1786371226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSnGUH2En7/Tp3ArvxF3zOvp2fk2CBZx8ROlX+KL6MQ=;
        b=ThLV1SyB7tSmgxZIcYkDjMMnhY4p6Uf4vZgm79wgQVPqEm1WP0trBL4UZAH3rM1nQ5
         2HVdXN2S7o3sWnB5+LroAvQE2CqJz4dl/Ernu1KsJcOUl/IhsqOjnaC3fV10lFAkc/Cm
         /NF9mesY7Y0dOfT3tk2ZbUyksCR7aqjHNJzr9FhJRoX7kX+gqwm294gWtXm3K7GtPYIg
         Eq0mAQ1hI+qGSvfgYHgCJcgznWIX1RozZ00XukzPfVw0vWpYPKFoesJ/xCnA2/RKTY6k
         TwlQJJ8oYQGuM2H+MzfKjfTdxhQNkuPiF0NgaRdfyCqmOLfHabyrzI1VkH2eQcbN7oVT
         9tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766426; x=1786371226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSnGUH2En7/Tp3ArvxF3zOvp2fk2CBZx8ROlX+KL6MQ=;
        b=k+AxWF/IuTL0RfF2BB8AWrTC4MGVBJe6tmRGgIKoh+9uPuYWf9CKIfewMF6z7i5q4E
         F/wMiT2xMCYTEme+V+GFbPssBTW+rgeYgjRl/vWaGndNfJtDnppLVftHjcJ+0ZyeTwnm
         UcoMpMoyuPNVOVTFhxPiFZeCc07bsTqGLabjOPFn3hcBb3Yem1GEHEYEkPJZxPePYixM
         YQ1nTJqkx0qKYNvCpNOErJmHcp745U0TsBu0xXBN9Jr6K6xX7cXk5m2m7OGmEHGS4Ew4
         QtEBDAeb/wh7ERRzIEg+ykR+y0tblTICs6+HukuI3GK4bPVrXjxwpmPzPCor1678HcJj
         gUmw==
X-Forwarded-Encrypted: i=1; AHgh+RrvBXA/PAee+SFE8NxC4NB59bCm7XBtzoDK0hqX4Vi2qodk5KeIq8/6iEtnsK7iniYCu1A2yUyFc8Uadg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjpTQcNSpyOs6M+Y806ps99EovYQd44eaWtCnOvCG242S6rkj
	nDHINgWq1CBbbv8AfHVeeuZr/ZMyxk7gXluMMZZnnQ+ynSFJgXbOzXvY
X-Gm-Gg: AR+sD13gWlAE0lXeuQ1UnD+QxLnkdIVbeEKZSkcWnYQ4KTI6GZfwT4iVIKpgtdEDuPW
	E1jCWUycm9EJZFahmXJCeYsJKR3i6JrzHZ4QW3yAmHE4EnkKoQNqZ3PnRwJqAeFk6CPEQA2p1Su
	6o3qm/OjjnD5u//Ydyq6nDClKXTPrQsam6bWhnZwlUP/MRc7Okdul+IVo9FB1rjTVuq3Z4Gm4/e
	kkI3IiD8F3Cz9BWWnb32EUFUO+0Oq5Irxr4F293hL+SRDwh1rO06+WOX4541JF9cR1WTAmQD7eB
	ZfcxCiBaabYkVPBmdRjn0S1fMebxZWMg53V/XD4e8tUimOs+ycFjo0StkyVGmcS2OJzOdKX07Qm
	Y5il+WpDt+PhgXj0m9AgPenkFYsJkgww+WIHPw/AgJHs/3iL/HTy3aGLh/BZCtAz+2e7H4RPqiv
	wUGzMUhw/yfj/g1DSNuQ404yt8jYC15y6SAc253qaKvCQbE0AGHNwUpHi9fVeRiOXBuHPhA5JUl
	3v0bjbuvCEKAP5VIZ+678hhWv7YKA2xcg==
X-Received: by 2002:a05:6a00:94f4:b0:848:2f73:9002 with SMTP id d2e1a72fcca58-84ee493f64fmr9115123b3a.75.1785766425596;
        Mon, 03 Aug 2026 07:13:45 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:cd52:f161:9c8a:ee77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm3818360b3a.30.2026.08.03.07.13.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 07:13:45 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v5 4/4] zram: reset per-priority params when changing algorithm before init
Date: Mon,  3 Aug 2026 22:12:56 +0800
Message-ID: <20260803141256.60599-5-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260803141256.60599-1-haoqinhuang7@gmail.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Parameters validated against one algorithm may be invalid for another
(e.g. lz4 accepts level=65535 but zstd does not).  Although algorithm
changes are blocked after disksize is set, they are allowed before
device initialization.  Reset per-priority params on algorithm change
so that stale parameters do not silently carry over.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 68e60c9eb8b3..cc96b18bf647 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1652,6 +1652,17 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
+static void comp_params_reset(struct zram *zram, u32 prio)
+{
+	struct zcomp_params *params = &zram->params[prio];
+
+	vfree(params->dict);
+	params->level = ZCOMP_PARAM_NOT_SET;
+	params->deflate.winbits = ZCOMP_PARAM_NOT_SET;
+	params->dict_sz = 0;
+	params->dict = NULL;
+}
+
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
 	const char *alg;
@@ -1672,20 +1683,10 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	}
 
 	comp_algorithm_set(zram, prio, alg);
+	comp_params_reset(zram, prio);
 	return 0;
 }
 
-static void comp_params_reset(struct zram *zram, u32 prio)
-{
-	struct zcomp_params *params = &zram->params[prio];
-
-	vfree(params->dict);
-	params->level = ZCOMP_PARAM_NOT_SET;
-	params->deflate.winbits = ZCOMP_PARAM_NOT_SET;
-	params->dict_sz = 0;
-	params->dict = NULL;
-}
-
 static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 			     const char *dict_path,
 			     struct deflate_params *deflate_params)
-- 
2.43.7


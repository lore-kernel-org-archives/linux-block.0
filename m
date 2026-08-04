Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960A432300
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836379; cv=none; b=sUmNemZbb7QesijWoIUJmfy1YohZxjGmVnlX7wSTAGpX5XFFmldjy4UwqVKCy+My9jYLd/cnpzIv4rdjBrbamQ+zJfQP2XdZKmIDf9cS2QKF8Xwc2II6Rj+JUz7A2EF0jdbI6Q7fntRiq2f3Eo+Q7hXsHW1I3ShLriUJv/Nlms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836379; c=relaxed/simple;
	bh=2ObN4/kUPlMIFl22s20V3gSYdrixX5aBCSS+ge+131M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guFqnSEoKC8N+Pb5RNhnZusuCB2eeDilY/GvaN7amzxcIRJUhQVP07X5WFTFVkDbDYc4hlsN+/ro1zTGGfcl5Nt9Adiz5yGzq3Alb45ATiE69xlts8hfh+bT6zKw7gXBwVCsy/CYv5z4+5ezTWLhfdDQ1WmBHamJWa/fCLTx5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g46gRtdl; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g46gRtdl"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381c69ad0d9so2236125a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836377; x=1786441177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpp2vht7dryf40Am3BbMUJZ6cpQjeP9ZW+61UrydBQ8=;
        b=g46gRtdl09Aj1RyxMG3XhMxINAhv6VXjFP+51c06Yw/SaYnUzyC+LfYhCKzNQmSw4p
         Nc90tfdyeMDAtLSuaUsKmqIQ3qwXtcrsOjbgUMzJv2uwaVxamkWDLAVvy53T/21TehAa
         qo/DMs+fdA6kNx/YwWagGxhidtzF0X6CjN/s8Q3jaS8ApUnPI77JQifqhKMxleyjSmpI
         Hgjr/Zzz7amblMbRwn3e7LeTZmsmOdr+QVHFmYBdLRe1++SlGI1x4LOrZGXk6NMBPY7G
         dlJibGrSGUq6wuhj1PwzP7qk0c6/61GrzlCkYrOad4zTFqGDaDOXYa8IHygpgBjJ6262
         pKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836377; x=1786441177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpp2vht7dryf40Am3BbMUJZ6cpQjeP9ZW+61UrydBQ8=;
        b=PkVn2dTmf0NmCsdz/hjFwX11YsNrHMDTh+Ra26HPfiG3WiHni7ty/8awTBu6pd3e3z
         RY/ob4rpQPsN7JbsVlFp7LEXsi9dB4d3lfKbe+LlTs0oUakvzlAoyswuHWqTnjVEOPWR
         W2BNyLC3BTcn6OswdlDdD23ojscIcPb34SgX8VxCHhQMRp+dlU7j/PMebe2JGaeBL3l/
         K+ffexNOqugyKnoxRuSgw3CIqI0CfvWtRxUAbiBe84qy4AB7xmXqBxIHNlEnJw2T9ncR
         3+cUqdSgaC5Pnkz1uY0YmPIajhf8cJbO24lswAuQ0gFcZRKoeFkFC8Bjaxhgv3vZcUos
         VB7w==
X-Forwarded-Encrypted: i=1; AHgh+RoayV5P4kvzWi/hPiy7fGLm2Y7kGzS6z3b8J68NCiK9AfgDpmiuZUR8LehaqfxoeQYKIJmFXm5tXnJrdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eBPstu57AxhWZ2/rf6jVTNbbgUSoEfbYDcqgVsR9ZVjHImWm
	n/K7olROnsdXDA9XeowMFOpQK2AMETrxJkI/nyCMljvLiODnQy/Brcor
X-Gm-Gg: AR+sD11yWYQ6BG9ih+2JuxKLHnIng6EKWsvOb+u31A0qlaRbAa4X+5Z1isOAlU/btLc
	eFh7x1wi7QLdBq7wJZMAFuFM7yXjzZCzaerTzr9cO0ij5byJrvjje4bcBTwF00bD2PEVjpBzSmm
	TM2Q4aaEDBZObtQ95/v1a/0SWjFST6Jzc/OnQi5W2Lzz5GiKecVXapFnhXjWhnyVWKxBnK/mStZ
	qPzEEy469ja4XSah4Gp1E2SeaEupS6Hlij+o+xHcQsfG+d03cn8IcAmQuoxqv3u9KinaWZS9tFk
	oh1EdTXBi+B4DsuEGv1d1zzdiv0iz5pdFFSXZ4riN50gjLo4ZXJ4XAhStUqS5hKROtfoE3C+t4x
	VES9HENo+rLkuY6p6G6XROWDq/BdSaLvRkYX/fu18lnicrIlrF8lELnpW7vW+dFZCs1XEoHwfnj
	2ZkBI7klZF+kmhwHJDXJdt6P3+d9lA3uonHdhZRRnTTP3fCubP46K2XsqalRhqcyKtmfsFwWzXE
	917vX1mBpr9HnQGQvZrLeUsATFw6ocBnA==
X-Received: by 2002:a17:90a:d004:b0:380:873:49cb with SMTP id 98e67ed59e1d1-38fbc4d615emr12723709a91.21.1785836376759;
        Tue, 04 Aug 2026 02:39:36 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.39.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:39:36 -0700 (PDT)
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
Subject: [PATCH v6 5/5] zram: reset per-priority params when changing algorithm before init
Date: Tue,  4 Aug 2026 17:38:41 +0800
Message-ID: <20260804093841.67920-6-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260804093841.67920-1-haoqinhuang7@gmail.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260804093841.67920-1-haoqinhuang7@gmail.com>
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
index f73e30b61067..56183c827e1b 100644
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


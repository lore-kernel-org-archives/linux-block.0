Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205889;
	b=3zqSphmVOrFTJHdz0V4O0GWzARG5aVqvyNgPBJICBizzlQppdznhdm8/yjTcpOQni7p3
	 5KEIlJC+tBrIMDqZByAg5P5NXX0RBL7RNsu3Zs9AMDjmyPs0/5qk1rYVxG6uSmL7rga6Q
	 /UR9aNz83npPC+J2pynnuKQW1M+dtN9hv7wiTdTP9xwAq01WhALKrkNYlfPqOCvlFoksP
	 ZqXQ9EgAHY150c/lcuFpKa+aIaIhxTkViwwmv1ZUGDXI3sOkI/3U4Ubs/z7Q4qVna2tGx
	 KfwJ+GLk1mL2uUOGHFhcTawa9RZIbgNCrsnsX3hJ0cwgIqt2SjH32GEw7hiKg821Khg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lSmG/TBo6oOcV6VMCCsZ32JLyLY87Y+JAe3VgVxLTmU=;
	b=ZOSZwf8e4NZnHxZGD7B+Iis7mYucuGyWoYtWXhimAArhMwGBVRt/3mlObOIRufht5Jli
	 Mr5QSvDQg5so/mwW3c1VNiKVHV40sShJzd7XCKi3eI9u6orGgEqnjGkna/hUUTASZf9iI
	 /zX6CIGHJHBvGP48U7VVqsyItGjzzVXTxs2EeWq1E25j7VWWEjCTN7IUigi/XVAEMPq7+
	 d2Vk7KIZ8OfnbPbz4xLF4gfoC4wvtao+QqoHp2wsxey7w/xHAfSRXbbR4Q8JIVANhUNbb
	 dxIj1VR48yhOur0ieLEp9xCO4Sbw1mVWrPYEsWq4a7U1b7qSChgs5Hgiuz8p3yNUv8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K4NxZIPT;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C24606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K4NxZIPT
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8470d7d430fso575725a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205888; x=1793810688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSmG/TBo6oOcV6VMCCsZ32JLyLY87Y+JAe3VgVxLTmU=;
        b=K4NxZIPTPFN6K8Iwm4kxduHKwWfc4Mpy+EhHol594nEGA8pF5nedftQAExMTB+f1w/
         JXReFI1s0y5jgWrA+4bbAxBHCzDSMjq5QvOzmYUu/8DwkJUEWH+R8UecDK+YI6zSvh0Y
         PVKzOwjhfgGEZ9c+CZ92cI/J6/shkLTTVNcOXINk7HtwPzZ3TJyCWBjGmHSU9DIIzdr7
         eFfBTA1lmfb3kklFOKchIb7vqJWi0CWg38Ly9q9UaDL6q+6m0rgEctWVNTrExz00/WT8
         5EWlG3ylbnbdiq76gmvGlnZ4RRE/samGNLO+u8o7cRRkQPWtp/jKGuMQ3fX590ijkNjV
         E67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205888; x=1793810688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSmG/TBo6oOcV6VMCCsZ32JLyLY87Y+JAe3VgVxLTmU=;
        b=akmLJ9MXoD3qJmbOY7qJ04/OqietPjsTCkxmKv+xBLDmvyJAwjiMaZxagt8r7J2XzU
         QXMI/X2aibd/BkoYHB4QpvnDEHdvnsGcF/OsUGNQBbSgOy0pEbaZlMiwSjefqMQ4bxCq
         O8DpIvKNQ9V8Ah8PJSrj9oT65pkCjxSH5SH9JtriG9V1XWEs6mCV0zROlvsX+iykpc3Z
         tyVLma/o9yXxhBdLwlcNvXn4OLgmoMEGZiBO3JFYkc2HSxKs3NR/58FdJddAOaH/JNlj
         DEg62Yw7vLnKaKa+W75P8jEkLVyCRJcV5GZyn4eBx1IFC5GrZBNKjGvwUhZIDMnAmXxo
         +w5A==
X-Gm-Message-State: AFq9FYI44yxyK/4rlJ+11E5sb3j1ujQJBBXK6wkQ2Jfunh56TSZai8Ct
	gthLaNRQUFmmpmfhJvPnYt/x+CllqhdEwodcFbiZDnvzPUV8xEhA/u4xUOn3xprhYqke4jL1EU3
	hREpsa0M=
X-Gm-Gg: AYBFou2y/6liEKa9OatJHre/4rREY0x1XIn61Kii7XlDQ0hvj6OGtvS3Fv7yI7qk01W
	osDXS/ANXISrkMOaLhNRNzheaLl9tviIhGYo9VNErzcKw25DU1Y32bqyaMKI5293GtKfH1UD8dp
	zsHojPMT5+ZHhAqPAHnnpYRPmHG4HiSRc4TtBQwJF+TH8VNVJCNhGQkS3tuWW4TZc2FZ5P/qehI
	lbD8VJE6y45Y/A+6xkiiRYJ7rZXZDWcJMtl25sfw1wiisbfQv5OlbftMeaDe2xUOXGBzF6J3j/r
	+qfDSQ+HDIn4Q0Zz/DFiNzZ9Z18+527lABRw3Voto05W0RtjqkfMgzIgnlId/HYkGQZZn0RXccf
	JwRlQEaar7sdk12nZZID/Bzt1bg4qWXfuX5SbaUx4fahV4NXKwWkpliAWr1SdvH2iNsV4tZJgNi
	YQO+F9io0niQhuylqjzMgmhX50Iq9GopFXf1xtyjM1XyncWIUI9laL/hSIWFJzWObnf/7E4kPYz
	My/2rm0YEFs5TNcMDdJhr3nT5ri6ZeVhX7hR4ueISTFbzaRkhz5ipwkfHkdEqv1MnBgmyCrsmjW
	8a6hqW6ljEgRRWy8E4Tr0BrSfeuSVQ/idtRDVsbmH+LbUFLvE895US0xFpTNRo82gnFBIHGghEM
	=
X-Received: by 2002:a05:6830:2e10:b0:835:63b5:8b7b with SMTP id 46e09a7af769-85ab9873be4mr2565946a34.10.1793205888400;
        Wed, 28 Oct 2026 09:44:48 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 24/98] zram: accept lz4 dictionaries of more than 64 KiB
Date: Wed, 28 Oct 2026 10:41:27 -0600
Message-ID: <20261028164415.1262013-25-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

LZ4_loadDict() and LZ4_loadDictHC() only use the last 64KiB of a
dictionary and return how much they used, which the zram backends take
for an error. Expect that instead.

Fixes: fb4f644ee8da ("zram: add dictionary support to lz4")
Fixes: 1e673c8cf7f9 ("zram: add dictionary support to lz4hc")
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/zram/backend_lz4.c   | 4 +++-
 drivers/block/zram/backend_lz4hc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1e4ad31d39a6..15db3292e19e 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -4,6 +4,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -48,7 +49,8 @@ static int lz4_setup_params(struct zcomp_params *params)
 
 	ret = LZ4_loadDict(dict_stream,
 			   params->dict, params->dict_sz);
-	if (ret != params->dict_sz) {
+	/* Only the last 64 KiB of a dictionary are of use */
+	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
 		kfree(dict_stream);
 		return -EINVAL;
 	}
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258f..d163ff0ae8ae 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -4,6 +4,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -96,7 +97,8 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 		LZ4_resetStreamHC(zctx->cstrm, params->level);
 		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
 				     params->dict_sz);
-		if (ret != params->dict_sz)
+		/* Only the last 64 KiB of a dictionary are of use */
+		if (ret != min_t(size_t, params->dict_sz, SZ_64K))
 			return -EINVAL;
 		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
 					       req->src_len, req->dst_len);
-- 
2.56.0


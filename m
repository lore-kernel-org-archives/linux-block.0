Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740256;
	b=ICG1I14L8EcWQAUrgU2PneD9OVWY4t05lGXj4eo/IPHKh9jZVAFnVrV0BD9aDcOWdc5U
	 c7uzvBXpPDaBjyMc3/g+rB15U6jj9vGXWag/NpDPtf66rGrXVm3ju4fpl53CRHuefsJq6
	 djpWhxe+2Dv6OCXqUhHEJEH9daAN2rRPMXjfTmiiFZURuJLmp8dWdaEfOFSOH9h29xr5M
	 w+UjqvDotzabaeJ8Ts4TCHOdnZs5AHt/bvdYNbDgPbneA1gxkaHQsG3in9HrVUTMmVggs
	 yyYGmRRXxMsEl9Zkfy592e/tSS0Ct8I7EeOPEClD7dvNSRn547qTRzHfsxNkseJCpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5BhoDhUWCXvxES6P2SRNLdbuhC6XbJmVLMpNmgfMiH0=;
	b=IbYyHSSwOGZu+MEztXzLNO0DaqQvnWVr3d751fi84cl9Zytifr97jJs4i4JesgA2wD9y
	 djXVnVsPXW7u/evY0mXDbPjryWJaw8yxQXkluWOnyBfJsTBBrwyj9qzQHMyM+IP7KQNFR
	 pfGswU4ff/22IkYGR3mqW+Sm1/RhUhPEW6gr0lzY9LSjK8H7AnSiHuxVurmQt50VpLAN1
	 FR6V4VKvD1sm+Ytqui41Xr+hCXYESjeeZU64cBDAu4dvx9HKhkfepdCf008IqnzqaopaL
	 Gkj3+3R3DxYLW8SPf8j5V5fJDD1FqMb2XYO7JrLxwaCHSCnfpc/l2GvbWh3YKhuurQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YdojfcN9;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD08606A31E
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YdojfcN9
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b439e37813so3904542a91.3
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795740255; x=1796345055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5BhoDhUWCXvxES6P2SRNLdbuhC6XbJmVLMpNmgfMiH0=;
        b=YdojfcN99XJY6bVMYCvqTSaKN/CKxMLX1l2MW9xbE50iyGFHt6ZjHTYRrnhoVCBywy
         Xorz8vOkP5ORSZSMW8R0qLsu1uFrgRire5CqM/ly0ss8gfGyUoFjpTNJu121HOKNhsFW
         3/7jJs01CkIdOErM9SX/3Wi/Bpk1VsbT+9/DBAuFUCmY/aq0CMaPKkHFvz4T0eeZKvvM
         mLvWu0tTWtUafUayIbHpWv/ZsF7m8Jp0PYstLGgDj08cd3dhgLHuyrHvaB/D2QlsHCrE
         wwytiH7x4FTlGoVDBo2RMQ7lw/SUhlK1QjhnmeHWa7gPHy5Pe1N8MWy3Heodd2TzgrL7
         n+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795740255; x=1796345055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5BhoDhUWCXvxES6P2SRNLdbuhC6XbJmVLMpNmgfMiH0=;
        b=PbTB+gwZh5GG4khpaTDQ1PM4pOm8aisyxeRMjIxE7m/0OR+z0sYLk6myx6HStzvQiC
         sMsQY/4jR5LzWQ6Hr0jNqPHCap1zubuqwe4ljG+fN73xW6sbOP7huCC6wM8g2O7B3jjk
         3MxTpVFNZU08mEtqFN6O3M4/Ym2jtXlwmRsMXMa0AiPkw94m/PL+pPSpsozcydAbr0ql
         bHwEk0EJjOR9NvxbbwZc78CEkNOf1siqmT8jv3dsky37luH2dp6+UBkCXA5GYUI229Ot
         j1NcRK0BNyNQ7qYMwQJfavukPRhP1+IjQmVVleqjecn0nmAAQi/rwmIgbA05c2SLJ2z9
         30/g==
X-Forwarded-Encrypted: i=1; AL+hErHbBtKI+JZ1a7W42UMsb6BRD6hLQEdLDAPqJRNMv6NoJTeURsvDndJsthGV6fEfBK8IObC0MMOWk4t+kA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9T+fysRruJN8Q6xgjiEsWaB5nowR9Muy4tuH7S7MBAVKHqkLNE
	PiDaEMPkqlYSJqRRAcmkvOO6aRUFc/8R4qSviiIbPwObIYwywA8udgp0
X-Gm-Gg: AZFdTZcfhdBbUF6q5fIeslG4lOOY71UtoNA1P+lZLGHBPcPqtxz9eGG1/NCWlIy1gjK
	BoNi8tf3O3eXhUytWMbDYzC8FMLVbYxsmSXlNwQhqpGbm5QhpnebRuxB2tNV7sAfvdDOvYoJ+1d
	Ga/nNqWm19v4B8Lc0F1ZVhPsBj+u2UOuaigtnGJXPN8ZuQHawe0//JT2urlv5AZizdraAlNTEiV
	hGgXLtmbFGWlzRji6aJXM9lqGcrRKtqJzmAneIJjymplAocbQRlSZFI/myFWGks7czlGbdEeRnE
	ZWXWM/eyfIn4Dau0Ju/7JJk1F+xexPRe3YmIqKUmKrhMUmJw1iZi3qL/2pRZ1S+W72KkMjQC5mQ
	jZNm8lvIedYFxNQSVF8rfHgN9CqmNCEPt3S4dX2XsIF4NmSnAMsSlsNKuHkgrIHil8eHeY/8t+C
	I0Iiul1OgqaGmRZ/8DvcrVr8I8rfbTx4tt4zlyrtzLGxvMOfe4j+nfAa5fu7G53WoWrVAwcFNMa
	9/A9gOtc51wCs/fJTlqP0k+0pAJnceMSYSp6v5DhGWADcI8/7z+x8I86T+a4yaBCM4eX98dM9uH
	5CuYhVQixrapO8Q+we7Gn0yGcs00OvlUEz55hVFEJITWpDtIvw==
X-Received: by 2002:a17:90b:268f:b0:3b3:afdc:2e5 with SMTP id 98e67ed59e1d1-3b41c9cf56bmr17169964a91.30.1795740254579;
        Thu, 26 Nov 2026 16:44:14 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm19113711a91.5.2026.11.26.16.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:44:14 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] zram: validate decompressed page size
Date: Thu, 26 Nov 2026 18:44:11 -0600
Message-ID: <20261127004411.109585-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Several zram compression backends do not update dst_len after
decompression, leaving it at the destination buffer capacity
rather than reporting the actual decompressed size.

Update the 842, DEFLATE, LZ4, LZ4HC and Zstandard backends to
record the decompressed length. Afterwards reject successful
decompression operations that do not produce exactly PAGE_SIZE
bytes;

Prevents zram from accepting decompressed data whose size
does not match the expected page size.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/block/zram/backend_842.c     | 6 +++++-
 drivers/block/zram/backend_deflate.c | 1 +
 drivers/block/zram/backend_lz4.c     | 1 +
 drivers/block/zram/backend_lz4hc.c   | 1 +
 drivers/block/zram/backend_zstd.c    | 1 +
 drivers/block/zram/zcomp.c           | 2 ++
 drivers/block/zram/zcomp.h           | 1 +
 7 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 3846a04c69d7..aa6ca77333c9 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -56,8 +56,12 @@ static int decompress_842(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req)
 {
 	unsigned int dlen = req->dst_len;
+	int ret;
 
-	return sw842_decompress(req->src, req->src_len, req->dst, &dlen);
+	ret = sw842_decompress(req->src, req->src_len, req->dst, &dlen);
+	if (!ret)
+		req->dst_len = dlen;
+	return ret;
 }
 
 const struct zcomp_ops backend_842 = {
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f71b11bcac78..54638d2c119e 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -155,6 +155,7 @@ static int deflate_decompress(struct zcomp_params *params,
 	if (ret != Z_STREAM_END)
 		return -EINVAL;
 
+	req->dst_len = inflate->total_out;
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1e4ad31d39a6..36401651fce8 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -144,6 +144,7 @@ static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	}
 	if (ret < 0)
 		return -EINVAL;
+	req->dst_len = ret;
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258f..017e08038107 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -128,6 +128,7 @@ static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	}
 	if (ret < 0)
 		return -EINVAL;
+	req->dst_len = ret;
 	return 0;
 }
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 08da3810cffd..31f07ee3797f 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -208,6 +208,7 @@ static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 						  req->src_len, zp->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
+	req->dst_len = ret;
 	return 0;
 }
 
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 028e2f0f587e..72a253adae84 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -185,6 +185,8 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
 	if (src)
 		kunmap_local(src);
+	if (!ret && req.dst_len != PAGE_SIZE)
+		ret = -EINVAL;
 	return ret;
 }
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index f38fd31f9e4e..37af71a7db1a 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -53,6 +53,7 @@ struct zcomp_req {
 	const size_t src_len;
 
 	unsigned char *dst;
+	/* Destination capacity on input, decompressed size on success. */
 	size_t dst_len;
 };
 
-- 
2.56.1


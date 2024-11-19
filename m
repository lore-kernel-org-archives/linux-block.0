Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15F1AA1F1;
	Tue, 19 Nov 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019275; cv=none; b=PyfVUNcLz5bO5AZ9M8QUCkjeBeCmmyizERSV1W0rKnIgY9wet69x1Z2lQrSoFZ7XjQyBzxOkII7pM2VnX2/V+vGS76Ov286laFiVhlPUydQQtqrK4kTWwPvgj9qX00H1KuBbqQzUOZ7CsbMraZYhmQpOH0vpfIOdm3ZMZDzMYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019275; c=relaxed/simple;
	bh=6XpyFTX2IuB5ot3nsoK50HO+wkWs9VGANW6Iz4/OXwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geXfa6o9+zUG1QW+nfr9MD4lhwx3SVsHHiHgtTBoPN9vIPUlqXGP55RPQyT6W06UBM9EGMF5RNbfmjXW0t4+uRhY2EnpPeZo3eJd7YwfnBVcZmSBN3lEKIs9j9oMnQlb+QtDJm3/y9JmZ5Qq31p61JPNsmv/6eftbHxl3OFOYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Z/9OiHK0; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Z/9OiHK0"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 984A210000A;
	Tue, 19 Nov 2024 15:27:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 984A210000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732019263;
	bh=I61/Dpjoy4FuWjLiA71sDLbq/BGk0dF2e0BXKgpFj+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Z/9OiHK0u6mL2CtAGuWRaBNYzE9TdLNpAqSpCQEmXRw0TkbBAJ28o0dbH5wRaVX/V
	 9v+0IeBBB5YyKRgCM8CByRCtBMFlwp5ZMUVz1voeP4qf3DtXly6LSZ5TL8mZnMqLao
	 JhZd1ai3h3w10S8utGaZP/wToYMDW/CmeBiyq0k103LKDqLanAwOMyTMCJdFTHyuPP
	 7XTO0Sy10KdptEdudhCBfIoBN1BtotKGGeCvMYFMn/3HM8+5mhMbcT8X7kEcxBC0EU
	 JTrwRo7hLsOsRHDKwWMCZWKM3JQOrs0dZSUga5hmmpDgCdR4+Wip84nr0PFI268JMG
	 xY4DGehjqGlxg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:27:43 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
	<terrelln@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 1/3] zram: pass zcomp instead of zcomp_params to create_context method
Date: Tue, 19 Nov 2024 15:27:11 +0300
Message-ID: <20241119122713.3294173-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119122713.3294173-1-avromanov@salutedevices.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

This is a more general approach: for some backends, some of the
data needed to create a context can be stored in zcomp structure.
And we also can get zcomp_params structure from zcomp.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/zram/backend_842.c     | 2 +-
 drivers/block/zram/backend_deflate.c | 3 ++-
 drivers/block/zram/backend_lz4.c     | 3 ++-
 drivers/block/zram/backend_lz4hc.c   | 3 ++-
 drivers/block/zram/backend_lzo.c     | 2 +-
 drivers/block/zram/backend_lzorle.c  | 2 +-
 drivers/block/zram/backend_zstd.c    | 3 ++-
 drivers/block/zram/zcomp.c           | 2 +-
 drivers/block/zram/zcomp.h           | 4 +++-
 9 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 10d9d5c60f53..9147feb1e994 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -21,7 +21,7 @@ static void destroy_842(struct zcomp_ctx *ctx)
 	kfree(ctx->context);
 }
 
-static int create_842(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int create_842(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
 	ctx->context = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
 	if (!ctx->context)
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 0f7f252c12f4..10fde82dc5e7 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -46,8 +46,9 @@ static void deflate_destroy(struct zcomp_ctx *ctx)
 	kfree(zctx);
 }
 
-static int deflate_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int deflate_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
+	struct zcomp_params *params = zcomp->params;
 	struct deflate_ctx *zctx;
 	size_t sz;
 	int ret;
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 847f3334eb38..8f7c8f16b6ce 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -37,8 +37,9 @@ static void lz4_destroy(struct zcomp_ctx *ctx)
 	kfree(zctx);
 }
 
-static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int lz4_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
+	struct zcomp_params *params = zcomp->params;
 	struct lz4_ctx *zctx;
 
 	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 5f37d5abcaeb..b0302b8027ab 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -37,8 +37,9 @@ static void lz4hc_destroy(struct zcomp_ctx *ctx)
 	kfree(zctx);
 }
 
-static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int lz4hc_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
+	struct zcomp_params *params = zcomp->params;
 	struct lz4hc_ctx *zctx;
 
 	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c906beaae6b..78e611ea841e 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -15,7 +15,7 @@ static int lzo_setup_params(struct zcomp_params *params)
 	return 0;
 }
 
-static int lzo_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int lzo_create(struct zcomp *params, struct zcomp_ctx *ctx)
 {
 	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 	if (!ctx->context)
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 10640c96cbfc..b0ff72468ea8 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -15,7 +15,7 @@ static int lzorle_setup_params(struct zcomp_params *params)
 	return 0;
 }
 
-static int lzorle_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int lzorle_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
 	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 	if (!ctx->context)
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..b73b975599f4 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -125,8 +125,9 @@ static void zstd_destroy(struct zcomp_ctx *ctx)
 	kfree(zctx);
 }
 
-static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
+static int zstd_create(struct zcomp *zcomp, struct zcomp_ctx *ctx)
 {
+	struct zcomp_params *params = zcomp->params;
 	struct zstd_ctx *zctx;
 	zstd_parameters prm;
 	size_t sz;
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index bb514403e305..be3a31f09344 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -54,7 +54,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	int ret;
 
-	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
+	ret = comp->ops->create_ctx(comp, &zstrm->ctx);
 	if (ret)
 		return ret;
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index ad5762813842..89d32bb13f8c 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -45,13 +45,15 @@ struct zcomp_req {
 	size_t dst_len;
 };
 
+struct zcomp;
+
 struct zcomp_ops {
 	int (*compress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			struct zcomp_req *req);
 	int (*decompress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req);
 
-	int (*create_ctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
+	int (*create_ctx)(struct zcomp *zcomp, struct zcomp_ctx *ctx);
 	void (*destroy_ctx)(struct zcomp_ctx *ctx);
 
 	int (*setup_params)(struct zcomp_params *params);
-- 
2.34.1


Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F037F010
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380026; cv=none; b=lNdYAPFi8nMOdqdEzc5qPsNn0ttyBtgX9MPy9i37SpD+hiR903rIG8oYTN/GpXPI+67QaupNc13ST6JCaIvd7VkA7GiM9JrlzPID5O67A8shFLp6z+aUyRY24HOsItgSosJVYkmM+8mo19B4IC0MFdAPHdP0ac17eDuFCl9qnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380026; c=relaxed/simple;
	bh=IHLiZwgiEnbvO70/7l4v/9pEDEA11dUhG0jc/vqEHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDIKt0xq/PEZoM8B9Vs75oLs13Ug64OXFNJCTOaLGGl+vUTqCKC6CCmjXeiwlriAwAoN4NFREFdsbALEL3CsZRRPtR8k4MTJaLBvu4O28Py2AC0nLKrIMq090+lMZpWOBJYopY8VJzeeGnjGBaz47FtPqk+51QoabDE566f7bKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOKfJc7E; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOKfJc7E"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso14044765ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380025; x=1785984825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEeT1ZayS2HGqb95V5B1HNVM/eFQKSf5xcGB/3d7JfI=;
        b=VOKfJc7Efy9MdRBowHa8Jp071aOEuRHnuac/lwWyRGeHOljyJmnHvCyp2GaUn2BBsL
         dRLFRKiun2a9xkCBhkFepVy7q/q20bYNp5ddJ+UMtSWJmfmSy84dxEcRhk4IByKTZQt+
         QH4qf+MFJw8gMo5i5YrHf7Z1UaVD49B1raTje/9Xee7lPy+QYTKbWYSVfMEWnqPxNcu/
         7/46CiE1+6L0AHf2OC4QC6xmwbGX/G9Uxs6DugFFzM+c4k21aJN4Vf9gfOFhdE++LIFZ
         tSdaZAXCUTD0oWpO9AJLoIXnBJzhacDIRofKeldAKHWmBzIhhi1wMflcv0nEnGrZwk3y
         hywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380025; x=1785984825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oEeT1ZayS2HGqb95V5B1HNVM/eFQKSf5xcGB/3d7JfI=;
        b=P29xlh32JwYah29vEYQxq85VZnzGNxXwlpd1kU911BGq3CvhYc9N2UbBwGP3nPDYOE
         ZprGL2NsZOWTk9x7aOs/7LlUuojzH/Ke7Wvyr21MPe+KXobYRsGllvx0lHlh2N7sYRsA
         DGfHI+zIDjgrl9IoiUrFXFFzAng7vyfPF/ygUdHXbgUEsZkvXsnIHLa5BlBkqoVmLM5V
         Tk3h6a3pyzdDTdmJafWC+XTIa2uGnlDTZ8TpSEzCvrZ8HxebIMU4SSDJvQJZ6/KZ92Px
         Nant+fIWyQB0e3PT3aa98kmW1ESg2VDbWwPBNUKGW1vE9duWL9bCqFKd1TuYYNsCgQ84
         v6tw==
X-Forwarded-Encrypted: i=1; AHgh+RrU6Nbz2CSA29OIr/KBegot2qkfWeMjWT/mKt1cUVMsRu3AEqOSrFxBisUDJhmwQU0Ddn2OdSDvHs/+GA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWfTPL6qWqE9FntXjskPxlT4a37D7qVQrz5QwVObvVZe0rjEm
	CtBmBn96mUK/9HguX3Grt14KfUaaaT41LZDLSfRdve0b3DmgBUTOwj85EaA47YjIemk=
X-Gm-Gg: AR+sD13iIAjSDJ1DcTKn+JxOMA6N27eFxHCjmm7a0qiXGSlnwHgdbSYbffp7PbD27bK
	c4yKv6NAv3NpAIu1/B7LwTZ3qnb/hEySs2F+d5av2mMOBVw8Hkyih5kBYBgiO9s7g1je8CWhJQT
	kqMKJblrY+uCnEdcD9Th7Z1vTr/iSpDT5L6UY52+l+/yWVAuzx0O/ceU3K4TgQR09NokkUSNGUU
	Oz9mUirLkvPDNPsqgSAvQym3PWDrrrAgz1UIrcf34A4nGhh71qE3xlYlIB8j+Y95+MsZyb2C9x3
	lWp+qB2Ec0UlruvTjhLF1klYnseB6Qc1v8fp/cjx7qgZlC4UaeYjyHH/J46NFjWzY/quPy/bM11
	wJGqXpfCeJRDdh3M0LrRwVsf4+GHo/zrx1LSmPMmugoxgr/NH2nAT0GdO5GLT5YlZLBVfay8o38
	XMzsJwmNF7W565Pfrd8HeZtocxFZjykWbRKbkWj861nE2JnQqInMb9N8VVy/3Zu9TyZGVVMUAwL
	2CAp7fmWRXpj7xp8XKYrRRC6VyGBj+Rqg==
X-Received: by 2002:a17:903:b8e:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2d035e3b92dmr8742335ad.47.1785380024485;
        Wed, 29 Jul 2026 19:53:44 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:44 -0700 (PDT)
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
Subject: [PATCH v3 4/5] zram: add per-backend caps and validate parameters early
Date: Thu, 30 Jul 2026 10:52:39 +0800
Message-ID: <20260730025240.17724-5-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730025240.17724-1-haoqinhuang7@gmail.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Dict and level parameters are silently accepted even for backends
that do not support them, e.g. "algo=lzo dict=/data/dict" succeeds
but has no effect. Add per-backend caps and zcomp_validate_params()
to reject invalid parameters with a specific error message before
storing. For zstd, set level_max to -1 as a sentinel since its
maximum level is determined at runtime by zstd_max_clevel().

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_842.c     |  1 +
 drivers/block/zram/backend_deflate.c |  3 +++
 drivers/block/zram/backend_lz4.c     |  3 +++
 drivers/block/zram/backend_lz4hc.c   |  3 +++
 drivers/block/zram/backend_lzo.c     |  1 +
 drivers/block/zram/backend_lzorle.c  |  1 +
 drivers/block/zram/backend_zstd.c    |  3 +++
 drivers/block/zram/zcomp.c           | 27 +++++++++++++++++++++++++++
 drivers/block/zram/zcomp.h           |  7 +++++++
 drivers/block/zram/zram_drv.c        |  7 +++++++
 10 files changed, 56 insertions(+)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 10d9d5c60f53..d796ebda1fa0 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -57,5 +57,6 @@ const struct zcomp_ops backend_842 = {
 	.destroy_ctx	= destroy_842,
 	.setup_params	= setup_params_842,
 	.release_params	= release_params_842,
+	.caps		= 0,
 	.name		= "842",
 };
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f92a52a720d1..cedc3daad33a 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -144,5 +144,8 @@ const struct zcomp_ops backend_deflate = {
 	.destroy_ctx	= deflate_destroy,
 	.setup_params	= deflate_setup_params,
 	.release_params	= deflate_release_params,
+	.caps		= ZCOMP_CAP_LEVEL,
+	.level_min	= Z_DEFAULT_COMPRESSION,
+	.level_max	= Z_BEST_COMPRESSION,
 	.name		= "deflate",
 };
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c449d511ba86..bd1e5ca4d134 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -146,5 +146,8 @@ const struct zcomp_ops backend_lz4 = {
 	.destroy_ctx	= lz4_destroy,
 	.setup_params	= lz4_setup_params,
 	.release_params	= lz4_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= LZ4_ACCELERATION_DEFAULT,
+	.level_max	= 65535,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index f6a336acfe20..0e0d7c68a7d4 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -124,5 +124,8 @@ const struct zcomp_ops backend_lz4hc = {
 	.destroy_ctx	= lz4hc_destroy,
 	.setup_params	= lz4hc_setup_params,
 	.release_params	= lz4hc_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= LZ4HC_MIN_CLEVEL,
+	.level_max	= LZ4HC_MAX_CLEVEL,
 	.name		= "lz4hc",
 };
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c906beaae6b..965f007e2ca8 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -55,5 +55,6 @@ const struct zcomp_ops backend_lzo = {
 	.destroy_ctx	= lzo_destroy,
 	.setup_params	= lzo_setup_params,
 	.release_params	= lzo_release_params,
+	.caps		= 0,
 	.name		= "lzo",
 };
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 10640c96cbfc..757b4598be03 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -55,5 +55,6 @@ const struct zcomp_ops backend_lzorle = {
 	.destroy_ctx	= lzorle_destroy,
 	.setup_params	= lzorle_setup_params,
 	.release_params	= lzorle_release_params,
+	.caps		= 0,
 	.name		= "lzo-rle",
 };
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 6febb366f76e..801ee8ee4ba6 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -217,5 +217,8 @@ const struct zcomp_ops backend_zstd = {
 	.destroy_ctx	= zstd_destroy,
 	.setup_params	= zstd_setup_params,
 	.release_params	= zstd_release_params,
+	.caps		= ZCOMP_CAP_DICT | ZCOMP_CAP_LEVEL,
+	.level_min	= (int)-ZSTD_TARGETLENGTH_MAX,
+	.level_max	= -1,	/* validated by zstd_setup_params() */
 	.name		= "zstd",
 };
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 974c4691887e..149eff4590e1 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -94,6 +94,33 @@ const char *zcomp_lookup_backend_name(const char *comp)
 	return NULL;
 }
 
+int zcomp_validate_params(const char *comp, s32 level, const char *dict_path)
+{
+	const struct zcomp_ops *backend = lookup_backend_ops(comp);
+
+	if (!backend)
+		return -EINVAL;
+
+	if (dict_path && !(backend->caps & ZCOMP_CAP_DICT)) {
+		pr_err("zram: %s does not support dictionary\n", comp);
+		return -EOPNOTSUPP;
+	}
+
+	if (level != ZCOMP_PARAM_NOT_SET) {
+		if (!(backend->caps & ZCOMP_CAP_LEVEL)) {
+			pr_err("zram: %s does not support level\n", comp);
+			return -EOPNOTSUPP;
+		}
+		/* level_max == -1 means validate in .setup_params() */
+		if (backend->level_max >= 0 &&
+		    (level < backend->level_min || level > backend->level_max)) {
+			pr_err("zram: invalid level %d for %s\n", level, comp);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /* show available compressors */
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 {
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 81a0f3f6ff48..366250050d4a 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -7,6 +7,9 @@
 
 #define ZCOMP_PARAM_NOT_SET	INT_MIN
 
+#define ZCOMP_CAP_DICT		BIT(0)	/* dictionary support */
+#define ZCOMP_CAP_LEVEL		BIT(1)	/* adjustable compression level */
+
 struct deflate_params {
 	s32 winbits;
 };
@@ -66,6 +69,9 @@ struct zcomp_ops {
 	int (*setup_params)(struct zcomp_params *params);
 	void (*release_params)(struct zcomp_params *params);
 
+	unsigned int caps;
+	s32 level_min;
+	s32 level_max;
 	const char *name;
 };
 
@@ -81,6 +87,7 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at);
 const char *zcomp_lookup_backend_name(const char *comp);
+int zcomp_validate_params(const char *comp, s32 level, const char *dict_path);
 
 struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
 void zcomp_destroy(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0223fd83bbba..0c804bb4a701 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1797,6 +1797,13 @@ static ssize_t algorithm_params_store(struct device *dev,
 			return -EINVAL;
 	}
 
+	if (zram->comp_algs[prio]) {
+		ret = zcomp_validate_params(zram->comp_algs[prio], level,
+					    dict_path);
+		if (ret)
+			return ret;
+	}
+
 	ret = comp_params_store(zram, prio, level, dict_path, &deflate_params);
 	return ret ? ret : len;
 }
-- 
2.43.7


Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069B41DEE9
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231015; cv=none; b=Gb9Z1oATrlG2ZOBqxoKBS1YSW+y5lE9Vq5LIXQSdSW8hqH5XUfAW042TlTA5vQhwN/MSj/5EO/vGPU7OBa5QsDi99ZUeodLwdCEMRY4FyPP6LhC9wAcxwrTI30mu4306x3EqzRih6o3sv2AIwdY7iYOCWPYogetH7NMJGtDnMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231015; c=relaxed/simple;
	bh=p2KyV1M2I7pW89BPyORLMX0vJRqoCcGVml1ufIQfzm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcFluYB2rak5XKPGveq8M361363gdovRcniQlqPzfBVhWL3ZcKw/rqF/5Fni+WuCuNBK80+CVAs0jLgHGHpJjthfs+4To+xN5REFD96iHv87MmHJcIv6ErEsjo5mDyUOy6nYnJ4rY96J0+vrrpxsPQZf8ZWhQIgS1//fMXjnSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFeH43Vk; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFeH43Vk"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso32735655ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231013; x=1785835813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO8m6+/OzqIxIcBgfk2F3Ds/epW9IkHld/mVwIN+JfU=;
        b=OFeH43VkgaAq9VWvFIep7SiN3pW14SzlLnYTQARHmnaSz+QZKbsBQzJi9EaO9UE+hU
         NlDUsnmpSXQmKKSX2eSuljVLvf7+7bD/9utMdZvrRrRaf7i33D+F8qG78GeYajoW6C4Q
         LyTvAtdFlKl08t+wCVOhrmqCG2QMLE7CU5rkg6ZSySZ/dcPS4GSygD3qkFUUWETBRkza
         uG6wlh6MVA0cr24K5yoKf+t7p5IiItusjeI+BenlYK2FX75JcDYxGpQu6gRFm7sl/BXU
         C7kqIOBZOWdGJzniJFU/FgLXaw92qveOrJhbjI/MIiGyvcw/flgJVMh95hbt0qPVzpOf
         /GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231013; x=1785835813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JO8m6+/OzqIxIcBgfk2F3Ds/epW9IkHld/mVwIN+JfU=;
        b=kx4AnzH+0a75k0xZWkzh03qjkhxIk7FR/Rarx1yRXy/IcHUBA2fATvRSUdS0gLvzI0
         nz4VwDZrbT6LbAEN2GUFJW1I4KC96+LmnLlTxAi7CeHc3oa1ZkRY9cE64JTR3YpQvTu8
         dR484ODd25j1ojCVeNEM2mQbWNx3SvpAuuCqX90N7SAKH2maTDOLYVgHJRmKuLGsPQSz
         QMiFt/owMl/Iv+LEVzRquHgJ3PtBCKkKoqZcQe+ucyfsGxTb3TqdfCIPzgecfOLWQZb8
         DS30HAxsNfgXxQ0CAL/R/Ez9YQ2dvl6xFV1iuTfwrMsxsIU8zxvt1Q8wpH7OAGQe4lXk
         p7XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpshRlvkWdYU2L0PUO74ez5K/PntrHTl0wdOPSoCwUJHI4Y6qXC9cBLWBIllGxbzfZoj7XHyM1WMzdOTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8Swahis2lPqq/IXyspIfHdRViBGQDhLemlRDhz+Tm50TvOGp
	NxZU9XVZfhi5PO++tQDSSRE38kBjXSVRp0s20g+DxBrRC/dBwM0fECtP
X-Gm-Gg: AR+sD131nVBGwu1KIyf3IoYHp7N/ALAcW85QXzFgmo6j7QF6qJaJyAw4dWBq2b9ga9J
	ftkVKyD9KKXTPyEp9v59HPqnocAZxNkP5e184r4bP5fylEXuNIhBc88TA0abohd00G8V0J4u8OH
	DTToili59z0uhf0rMhYXa+ODjrsWLTtJKJt7MGQwD2FYXHtBia+GV1xRoizmqDms/BSUzktIm1m
	CIHoHk94xzGBfPOdQesJHZPNqdpJks+l7Jy/GxNypvGMif8GCc/+N8Em85J7ERI3Vn/i1M//Zl5
	a3CyGmgucptIn23+sUtKiC6xjLbMd09ATD2vaRuFpEg7enqjO+l9bYPoHDYc4dVFDnZn9VGvRfz
	uzmRXTTiLHbF3SsVA1wwD7p3DPE8IFdZ2l1Ka7xAUBCGq/a/tQT8CAe9Xe9NStFRCF3ss7XephD
	WjKw6YKY3zulaotQe2Go16NIfMVrHMKLlRPwt+xknBDCACvO0=
X-Received: by 2002:a17:902:cf41:b0:2c9:97a9:2097 with SMTP id d9443c01a7336-2d01605e5b6mr20073215ad.43.1785231012904;
        Tue, 28 Jul 2026 02:30:12 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm49151225ad.71.2026.07.28.02.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:30:12 -0700 (PDT)
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
Subject: [PATCH v2 2/5] zram: make dict update in comp_params_store() atomic
Date: Tue, 28 Jul 2026 17:29:32 +0800
Message-ID: <20260728092935.31139-2-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

comp_params_store() resets old parameters before reading a new dict,
so if kernel_read_file_from_path() fails the params are left broken
and the actual error is swallowed. Fix by reading into a temporary
buffer first, swapping only on success. Use sz <= 0 to also reject
zero-size dicts.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..9ea7ba9d1ed0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1699,21 +1699,23 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 			     const char *dict_path,
 			     struct deflate_params *deflate_params)
 {
+	void *new_dict = NULL;
 	ssize_t sz = 0;
 
-	comp_params_reset(zram, prio);
-
 	if (dict_path) {
-		sz = kernel_read_file_from_path(dict_path, 0,
-						&zram->params[prio].dict,
-						INT_MAX,
-						NULL,
-						READING_POLICY);
-		if (sz < 0)
-			return -EINVAL;
+		sz = kernel_read_file_from_path(dict_path, 0, &new_dict,
+						INT_MAX, NULL, READING_POLICY);
+		if (sz <= 0) {
+			vfree(new_dict);
+			if (sz == 0)
+				return -EINVAL;
+			return sz;
+		}
 	}
 
+	comp_params_reset(zram, prio);
 	zram->params[prio].dict_sz = sz;
+	zram->params[prio].dict = new_dict;
 	zram->params[prio].level = level;
 	zram->params[prio].deflate.winbits = deflate_params->winbits;
 	return 0;
-- 
2.43.7


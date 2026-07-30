Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194436829D
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380017; cv=none; b=CogY/H+roQOsrBU+Wu2xrK4fnQagXhPqpRfUKraXgK9j9kUhELeiampysRDFUKNsfXI3s4XAmSRmXfFvjYzrhiT6AMhg7c5v1zDvFiBY7ZNFJ2xpwzr6Lfi2S8AmtZgkQZ+u4IWHLIumU+ob7oSzWHU4q3XCMaS/Gy4i4G46HyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380017; c=relaxed/simple;
	bh=OVI3grYltlw8TEMzAc6RccUMxHliopAQ4GJh+tnP7m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7axxOZhbdUOnPINW4F+zkHJXkBlzujH8M00Yeulb+TE5dwvPMJXDA7OZ+TMFUqademhF7t17T4bt07i/jkse2O7ZwASUJ+awLqfGClKVt6BkD6BnXdSIlPgtqhfkeeQoAlSgLb+QvCEA3h0xOa+XgyipB59sibp26EB59n3unM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKK4xkBm; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKK4xkBm"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf41b07aceso7891765ad.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380015; x=1785984815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNqtlK3uwCms2Apl6MmALo5xujwy//J/YyXeEh4+pMI=;
        b=FKK4xkBm/W4YJrU5rYxb9A4nLtakLZZBJeWnxcfeAi0bmoFYSoMbYZf1uOrEqv4Q2+
         +vhfwex5Jqm1ttXePp1k24oYePEmah6yx/LkDl9fdpALLP4hsG1DVJ7mogayRN4cEN87
         BDjDRbIphVaq3oKOUQ/t/gFzvb1R3cm/Ztz08kWE9tgyW2AQ9iL23d9SOjz4XvQ9p56C
         i9xOb/SJ8LBFjPxQvbJTG83F331QO7do3jGAPq0SdTZRmBohFSWgGmr+oMGUZJhNYNIe
         YSrnO3gufV0voH05+eG1KNxSKbruDemr7n4/EHqE+8J6SrUf6HAlwj0cxPYoo4alGddQ
         nkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380015; x=1785984815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNqtlK3uwCms2Apl6MmALo5xujwy//J/YyXeEh4+pMI=;
        b=dVnsQVztaxyN54Ozi4THLOPdxagWZ7mggmYrzMvmtBWzBhUxDtNVZtiow8mqx61hST
         p3t6PM35Moja7hDaYLOJQWKR9H/e0Om14ROJXbKB6/t/4k+mq2+VQ3YD38nR7sZ12Pyc
         frKzMgkqRk14udflj1G6/12EtKqsSLki86kdM6hOr1kKhihW/R/mOGEL7CBtCMV8A2Mq
         Yh3J2HiWZshXMRDwXReGc5czHCeGyHdxpcPq4PS+iqhFCs85uUg++h9r4LyGluFfIwNn
         EQQe32IUU/wvsJYsohCD62GQXdzu3d6hoLkVKZD6UQmKNMyFTQicASABw0HvE8a+MQU1
         /62A==
X-Forwarded-Encrypted: i=1; AHgh+Ro3BNEF014lDAhxR5LeRyvf2CPsSUZgSEGJ31D20v11e4Cvmx5jM9G/6wAK9cSHGp0yBcg85BEJ3bh7RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYezFiBgcbFRAjwZecb444kJJhE+w2AXWamXbN4MLtM4knvnI+
	HaSDfu9/Ciw7LSNVKyEC8y1LmQpWfBcZ8RO1MACqwtqwPZlJZCkd/wmM
X-Gm-Gg: AR+sD12QoNJ3eGPDiigS4GBiKpQ84pUk2XfEKl6Hw+hsW3ESma9ERJjAEYxxtHygMcd
	bcMS3ymALlPFr8B6pgvX696KTVUcvfkm117LYyqqpbDiY6r8TXb+Wlv2oRq0vuYayex2p/GcKfg
	TDu6QWTOqUIOKbABIwlG6AgEu/2ujEn79DKJ3hSLEzYtap3VAeQUb6LAj3jmG89OexwXXCQaNX9
	TbGBUiV4Z8camxFw1lGSlAwUKus4CXUI9VBJUjiyH35dWWEEUym8UdqvuPA9weCl1F/nTNYbqwr
	sozVnYiiJTFpu/99gtCdvkr3jGo4z0s2Fw//wqcNjEkNuQTk1c5zYETOJ/zHpCVKHnJH+EJGrc7
	Qu47YrHPpioQh2vg87imyF6V7zgv2F/to2UWZa47J7fDmjRzshsQ0hoKkeHDtel4wO9K568Y8pj
	/FBJ/xUZCVBgz6A92LXW9CtF8bZvMS3Pmm+phB2FDl3YbKb0wHlNsE1lUM9qrWtlc7hOZEAKq2Y
	xkxSFuaSxO+rC0udSQ/NPH5UUIpBOArtQ==
X-Received: by 2002:a17:902:e88f:b0:2c9:ff29:3f73 with SMTP id d9443c01a7336-2d035ceb3a4mr8278825ad.28.1785380015267;
        Wed, 29 Jul 2026 19:53:35 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:34 -0700 (PDT)
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
Subject: [PATCH v3 2/5] zram: reject zero-size dictionary
Date: Thu, 30 Jul 2026 10:52:37 +0800
Message-ID: <20260730025240.17724-3-haoqinhuang7@gmail.com>
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

kernel_read_file_from_path() already rejects empty files (i_size <= 0)
and returns -EINVAL, but the current implementation only checks for
sz < 0 without logging any information. Use sz <= 0 to cover the
zero-size case and print an error message if dictionary loading fails.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..0223fd83bbba 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1709,8 +1709,11 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 						INT_MAX,
 						NULL,
 						READING_POLICY);
-		if (sz < 0)
+		if (sz <= 0) {
+			pr_err("zram: failed to load dictionary %s (err=%zd)\n",
+			       dict_path, sz);
 			return -EINVAL;
+		}
 	}
 
 	zram->params[prio].dict_sz = sz;
-- 
2.43.7


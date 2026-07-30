Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56427377ABF
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391326; cv=none; b=ccBVrbQQNHji10OvpF7ikcYlcopjf+K77yvlHtXDY4log2Iv5cmOdJc8+k/n46SXenvdAXu4hiMgcefpGhjQ6QVMjAueZvjMIWiGWygw6bUDm5F5TKKoJGpFnLAn3/d6b31aug5dQt0/mgiaGgisr18sZn2pDRb6IAfI+65Gxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391326; c=relaxed/simple;
	bh=OVI3grYltlw8TEMzAc6RccUMxHliopAQ4GJh+tnP7m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVqJRnQAa7aPQu5hTdZ+WBpTZPLMZdbHMPuSlspwmJVLqRJ/idtyIrzw3DeGWpShdudy9vT9EwlZ4IaZGSafhxfcNVFXI3mp/0wbV3OzVKcrL0dh0ZJUA6kZD+wHm1ct5IQVoPzGAMOXg4iQn0E7xQNiQZxAkpn6SVhx7r+5fQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLdfop5+; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLdfop5+"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so993489a91.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391322; x=1785996122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNqtlK3uwCms2Apl6MmALo5xujwy//J/YyXeEh4+pMI=;
        b=DLdfop5+c2tMZORUs2GKfRuE5hROm7HimA/wZe7FF/A1M5zt/NsEHRA44GZBPaWpYT
         90p1KyLGjXFoy9483kF2fHzol+wS9hdljeO7hUtDXGroQqgI1pW7BLo7gQKCAMl4YDP2
         PyK8YJRaAqprb94qsis8kO0dlFfFK+M+cN8ItetSNAH6BWhuHWz1SRlQgKenHByxypkD
         6x4a/0NsQ2Co4Q2818c570VJYw2CkfTxfxtAGWPIyxhWJ81nDPA+/NIfqhNh4yEdaozK
         FS2YiHicbpP1kIRbpXq+GSRLK5vnHGMj5SSw6JIe2C2hOaON21VFFDvkMRE3OuZ9u8s4
         IGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391322; x=1785996122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNqtlK3uwCms2Apl6MmALo5xujwy//J/YyXeEh4+pMI=;
        b=i9E067RHjJ5FyzbCe558cMqd4KBLO2v3kcbJsOzBpu5JVvfBRxFIjWXYf/qZK35Avv
         TZzjzGBaC8L1quG+OFX4r1ou7JLrDJnU5GvS+XRkasVzHfWxuOIDgbhvKbJhtVDmJ5dc
         qgG3ToK9UhA9Mzfnedaob08jy0n0uSV5qLDRrhi3o1QVdojZSaiVvjz/wpsf7ZcxMfh7
         i3ff62nPijGsTAPMEZ6PqdWFgbO2mfS8pEAtp/akytnbiQkUTGTTR3cFDVzqBMCMwI8b
         YqNXw3rZYzAbyky5wB9Xaltkquk7hJpAUb88tpgsoWBKWYVFG9mrNUnTcsF/sNisoP/m
         Nxyw==
X-Forwarded-Encrypted: i=1; AHgh+Rot12jUOsOtqW0SSNUPovOX2LBWB95eJwh8/uJP86ekk0Rlcu708zzlDabBGLj9kkf/aBI5F8zkaf57fA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rpyY4X7DQeQm5TvdQ57g7cDwIv7hBqT4FoikAhaOUCOJMMyj
	iLKJkA95Idx1uEqQg5tneZHym+MVxBpygq2MXz09KNvfYaP78Qkhwypi
X-Gm-Gg: AR+sD12ss+3Y+7mKklHighvdv8ZH0k392yz0QC6EOuJ5lOfmexOCplnNbnIuVjMYJYi
	V/xzR6v8cOhSSws9tUyp7Ik7F1wp/T+HeD/OkxljFhxuOUIlkk6rKvcnUG5vly4lCluZ45bXw4z
	3zKhVJkRqSeYJHnmxN0zH9AZ0hlKX8q4HOI3hRyUroVOOxhxS26+WIa1O+BCXRxdGKto6YR0upY
	mI0GOXKNA8sMSCrbG4cQupOezI1RAkZlgQWPAscjy9PB2GkVHjupU3qTxOM+7I/Z/ERtkslB0ld
	q0iBMG/Dn7BnEFn1V7pTxD24ka80DSd9G2bna/xQvCT6UUbSPKo8t0eraVkN/KJ17470iQ2EhEj
	PABgXBBphexncCkM1tTWlY8rH1IK5E8bdMofg80w6fZk6vZSU12oSC/6vWF15tSSzSgXTTby5q6
	e4hbVgG9CN1SXJa+i8TilTSOfk8JRrzLWgX7oy0/C5fybIBtz/AtPvHcZbdJ1OYvEm6XmMnSmTZ
	DH0cuLWL8mpCABjCEmaqcVOjKxZyiLW146wYg8yAvJs
X-Received: by 2002:a17:90b:3811:b0:38e:79f:76ad with SMTP id 98e67ed59e1d1-38f9bece571mr1204259a91.23.1785391322053;
        Wed, 29 Jul 2026 23:02:02 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d6c8sm430737a91.3.2026.07.29.23.01.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 23:02:01 -0700 (PDT)
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
Subject: [PATCH v4 2/4] zram: reject zero-size dictionary
Date: Thu, 30 Jul 2026 14:01:31 +0800
Message-ID: <20260730060133.80233-3-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730060133.80233-1-haoqinhuang7@gmail.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
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


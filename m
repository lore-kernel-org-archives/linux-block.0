Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E536A377
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766414; cv=none; b=mTjFoRMxZcf+DSxbdvvC2M0lmAJbt0lW7AC/tYHLmSJQjND7jYxRjyZ5OYRMISEZ1/XyDDfEmWPxeMECT4KuDkphMVk5zM2KwoBWfIj/0qvxxhnmiFI1C0poW4AoMBzJ9u0NEF4b3rQFCOdwnmGnZPzMRdn9LGESSqXEPIm3mko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766414; c=relaxed/simple;
	bh=D1O3BtqXhi2bbxwPO54hut6y0QtxHvtDzf+Ku4Ih2rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9vcNX+NQ359/TsJ8Oq2k50GNHDLePm3G6SbMRbs7QkKU/IWpGP4HtbxfpqU3pS0an9fo9BFdqviyWZd6F0R0alYM9Is1zy/Hg1jJ1mH6sYZapHNeQabDdIvp+HnMr56eEzdMs96ciUqzpt/YcMh7+QlHVTTTv4sNmbRiUOKkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxhZZzAn; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxhZZzAn"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cbbc9e6e637so1902043a12.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766413; x=1786371213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vl3fhYiohrdIlS9g/uSFV7y+uIWeNZ5gxUBY7VDbnfU=;
        b=RxhZZzAn6FR1biQ/Lju8tYQBYPReGYQzpK0wljSfF3EQO3VHyEHgxcf/TslfDgO/Kb
         PY6fH6pTl8BgLpq0SC+MWU8za4dby4z+KUSMk5Po/qyz8CzUH5g9df14yIM35L5JwFgf
         6tOCtxSCybRj0BEzklZwsEoZlwh3CApxx7CF5harsNA1OaO8ksI0f+OoSGpkB7wVulJu
         cTKkk0kjVzBJNOiNtVFi7ObRhKV01cQmDD3cROYqzjpAF5XW8kwY3+sTkFsR9Ar6kESC
         3diGKJWxiBUyyeRl3URUpyNsw4ZBj88L5dteJGFk7ML+Epye2y4OvOvBiQULqCE6gQcY
         NrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766413; x=1786371213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vl3fhYiohrdIlS9g/uSFV7y+uIWeNZ5gxUBY7VDbnfU=;
        b=F1Rado7b+IRkuPuCylIyOAiYhURwDgARwOve+N1wb1AuvKvNB6BZm0Zy2p6/TjuGJ2
         YYQ5jo7YkzAAYr2bS03Es2xIVf1BrP72D7C6TLcSGSIfyMKHnEGbsLupzu7e3to0vm3q
         1bF/NLq+exN1wwTWkzeJQWayyJHVIT6sIMOvQhNIdjxOHKXcyh/YcgCD7qeaZ03g6XJD
         vTR9221G10hBzYh7suye+RlHt33SgrsbqyrHzMfjzHUjrxrld5cKWPxkBSvzIagn/fXU
         SkzFEmQ6+Gr2S7RD1t+J2oefrNaq5yFXn6eXKLCgKY2ULXm7Yj3xD1s0i2kbNubk3WN7
         hHgg==
X-Forwarded-Encrypted: i=1; AHgh+RrvtEzsnWsYC5Trz4+vWF4tuSEd7JCB3/P7acydp5YmJcrZuVX/sQBbJt8Z6JM36CF4L58Wa2gpHGofZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmQqReisAnEwSh7XnrSX2LlAPS1iNSw+xlZAmx5JuT32UGzyR
	qFHjuVSI5nRU2poXxTmFyeIhIPnzw5k5aah8+fAeRr9jwVjJ/YS9jWcm
X-Gm-Gg: AR+sD11Yod7LbhBo+Fkvx4aNIJxXyowI9DcivsudRQ5BeQ0m/1a+kvKq6W6ZfMKdXdQ
	sgl640mX6g6oigBjso2mqgmyffgKuitl8n3Q3ZtmcAI+uWQz7Jx3lq1vZaL2lxbZDeReciFJzED
	OpKgvpOQm/gMmp50bU9gDGuBuBhiqf5A70L2uBNMrfHCYyZ/dudH/K1PgIgLSoANBUOy2p4xQhw
	agVAiu7Pt59uckn+0zFpPFq+XGsqMD+utImNTJ0B6sqzzAZrEy2RYKDj9zyN72SQk8ky5fXpVC0
	b6e6Cn5xV2QRvB2PpT6g5eqfz7uT+gViGfhlBnnSTXPLsW1wjPK77VPVinhcWwmcGJ1lNDCMdXu
	tzbkw3MtfJbptf/v8sxE1+xhdOiaOHZx+91jhziAecvb/XJDjrkxrmui4Jy5V+Zawt66qx55B9a
	TiOYsLe+MoZ6BFHJSRl07aSTLcBa+qzZ5TndV47BQX65tqRTM0zzwtvgIFbE9095EsQmaUIQaBv
	7wDCTn0Npt52cu1Y31tAow1acNrwfMblBReVJ8tVj+G
X-Received: by 2002:a05:6a00:1da7:b0:848:2f6e:e537 with SMTP id d2e1a72fcca58-84ee4906dcfmr8420957b3a.75.1785766413022;
        Mon, 03 Aug 2026 07:13:33 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:cd52:f161:9c8a:ee77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm3818360b3a.30.2026.08.03.07.13.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 07:13:31 -0700 (PDT)
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
Subject: [PATCH v5 2/4] zram: reject zero-size dictionary
Date: Mon,  3 Aug 2026 22:12:54 +0800
Message-ID: <20260803141256.60599-3-haoqinhuang7@gmail.com>
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

kernel_read_file_from_path() already rejects empty files (i_size <= 0)
and returns -EINVAL, but the current implementation only checks for
sz < 0 without logging any information. Use sz <= 0 to cover the
zero-size case and print an error message if dictionary loading fails.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cfa98846ac48..68e60c9eb8b3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1700,8 +1700,12 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 						INT_MAX,
 						NULL,
 						READING_POLICY);
-		if (sz < 0)
+		if (sz <= 0) {
+			pr_err("failed to load dictionary %s (err=%zd)\n",
+			       dict_path, sz);
+
 			return -EINVAL;
+		}
 	}
 
 	zram->params[prio].dict_sz = sz;
-- 
2.43.7


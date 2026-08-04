Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CA432300
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836353; cv=none; b=rs/qJDIbjPhfnJk+4AcRp2ZJZoj6w0PxMAAJet0RLXEa7Ircwv7NPW+NSzuf33Ee6dfD+dXtwMRclFyaq8lAvMGAJ0EYetaT+Xj9prULF7iG+CBvFxCeCr7EPoprvLO25bOR4ymLiUApnxdzuMhQWGT2/5kJnh2YoySsRM0LWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836353; c=relaxed/simple;
	bh=W8inotavFgmRWJBzpdKAMjr1lVUyDqfMCcuR/8IwcbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNYWMqW5h8JtA7kAgJJEKkjsBN3NQrWQf8M2ZPJkLKbAG92pXGYI07cOcWzPh3d6gWyypT08MWVfQcpN0U2au3HoIMfvGl8+Ft30fxEIivQZqXQjgB9FIsHCJ5SuHmE4TyvaSym9HOXPSKz0VIwhrM3Q7kayAs6bNS8PTneLUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4a0QQ9b; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4a0QQ9b"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so3270821a91.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836348; x=1786441148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fVLz33rvBmOP7svBk3nIv8hIfpVBo7+Tk4ZL3QQgIw=;
        b=F4a0QQ9bsil1Ic4cn5Cdb+UYSZiLNQd5v7hKXj3t+nhMUq3bCR7AY2r9gV7pch0FUw
         0BmEeSemIP9fXtn6i+TQ16aSgFd41BjUfUBBrBJyG+VYJvP4NQ3vLuOW94EBL4/elbbw
         buaKQYy0AkNfF5Widcpy0IBqu5InyydxFYSfzBv25GeWfUQWwXrJwBktgOY2A4zKLkOm
         pvP9j62LYXugeE77n1vQsPv779IQPizwV2QyLqep7Z+FrAn6qPM9iT+qIGWsizvUxnsJ
         2tFuJr1Z6zJxqGybX5hQAPbxtNYlOlj5eBhamRK9vNQqpygVLRJz5TSv7CpG+h9JbHtb
         4pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836348; x=1786441148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fVLz33rvBmOP7svBk3nIv8hIfpVBo7+Tk4ZL3QQgIw=;
        b=aufqlGlEkT9ZMgTY9lKjg+wyV/uaE60Yt9fu+n2GU9856Fhl30tPSPNjyUvxxUQQti
         zf8dIA4QbLeblyk97KnmMdUg6mP92iC+3/iXyIYSpGLhn2SGegzCTSXSouKw6t598q9g
         ZbQkHyX2BSkmvM8Lo2RFbwDDo0l07it4cMYeZSi3a/T+E3pFzrCOUDpwFFCArIeLTsjf
         ing6xLoeVHk+ozwtg/Ah77VF+ohIrU67spk9p+r1aaa1hWRo4cJnsfrd1kmUCnPjuKxP
         aI+PpHsd2YMihVwKFIsIx1IYnUZkV6PefL80B5i/pgoZjG+yryyMAqX5jl6pMGJirBpz
         rGTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTL+Hss2h8FwVeKR6F8+rlkXGGsCXbdpghUV6gCivo+7O2YAstXlk9uyNn2Vi+E7dj2bKjjkzU+p6pow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQkd1/tIfsC4QzBiGNcF3DeBzEkd1msmN5i2FtoAqSttswi5/
	oRuDYw1geC/2K0O850R/HFXiugZIG1sfQYrOnfaNylOhDltTW5/Wk3YsZkslW4KNbNBFxQ==
X-Gm-Gg: AR+sD10HrGkIQSy/0sNEcE8A5P1uObIsW85GT2dhQPGj8IK58UfEN0gB/ehGMqEKJaq
	NahGxOaH+DaE8kPVeytgDRUsYEJqU0eyPSswRKukdSk/KJII7e4DaNiyLOkyvfJ2mmen1Tr9SVx
	ajyzCiIujzjEzvqgI2jpBYCuaqs7PXkDUog/hGdP3Wq3nwImHIXu4SOG1tdOtRn0SGTgXeKf1tP
	az4rfVmQZyIVQTgVYlA2qsXSBEZBsZxfK9WliNXCbIDbFkFdfrBNG65ZMdFlUx4rF/nhArLD1sU
	He3ae/ehQqhsBfA1uHEK3DwybogmEWv5/77wVxcvPbXQoPO5weeQNTNRyKTPvtUkgXCLRxVYSRa
	Dw4QMhmZKNM/v10zfopje9dnsNyXx7yTyVMM3eISZlhuu+bCs7QDo4m8Kt2WAHrTmAfryYdn6E8
	5N14Ve13Qsa/P2k3/ECRdQaEa7m4fRcpHEWBrZz/+bj8Y/M65azioUSrTuIu8+Tic6yWJC/QZ3s
	Ty7gWuA0ODTAhuJbm+dc1c5wHlQ5YWtJA==
X-Received: by 2002:a17:90a:e704:b0:38d:3ca9:434 with SMTP id 98e67ed59e1d1-38fbc5344a9mr11848731a91.28.1785836347564;
        Tue, 04 Aug 2026 02:39:07 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.39.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:39:07 -0700 (PDT)
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
Subject: [PATCH v6 2/5] zram: reject zero-size dictionary
Date: Tue,  4 Aug 2026 17:38:38 +0800
Message-ID: <20260804093841.67920-3-haoqinhuang7@gmail.com>
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

kernel_read_file_from_path() already rejects empty files (i_size <= 0)
and returns -EINVAL, but the current implementation only checks for
sz < 0 without logging any information. Use sz == 0 to reject the
zero-size case and print distinct error messages for each failure type.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cfa98846ac48..f73e30b61067 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1700,8 +1700,16 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
 						INT_MAX,
 						NULL,
 						READING_POLICY);
-		if (sz < 0)
+		if (sz < 0) {
+			pr_err("failed to load dictionary %s (err=%zd)\n",
+			       dict_path, sz);
+			return sz;
+		}
+		if (sz == 0) {
+			pr_err("failed to load dictionary %s (empty file)\n",
+			       dict_path);
 			return -EINVAL;
+		}
 	}
 
 	zram->params[prio].dict_sz = sz;
-- 
2.43.7


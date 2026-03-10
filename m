Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C3F4FA
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122659; cv=none; b=Lnm7abuf4aLlomCGIuiDm9Vcdxh8IB0aL1N67qSDb2dS0VHE4Tak0Gitjxsx0+Pidq1p8lh0r14eFSbBInhmqnAk/ot6KExwGpWbcsQpR1G1Ozjk6uGfZoIKzII+HH6Jvamp4t1u/zyLwKbCDBGaDv0omwxkuwg9GnAvGg63joo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122659; c=relaxed/simple;
	bh=gdqS+DcKOh995ZwG6L2dod/0Ur7V6FgVG8CLsaUdo+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abiuRTnv3hnfDjfByBmHh33H/QPKfX14U07vO42ophlsErhi+Q4xI/PpJA1wBUwWwX3IiGWwKTjGVmu+1mPHlYmBBbrXK3D2IZtGtJKPDFQpzcIoOwlRQeME/UVxGbXRn4yTRl6CuOjqIsVsqT/6Elh+EoPUEIsIXhP5d+qLo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NG/rKLD+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NG/rKLD+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82995242934so1698160b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773122657; x=1773727457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcMkfkqcCmjFUwCLyfQBIcEGfJ4AtjBgCr7uCX9+Zgs=;
        b=NG/rKLD+ejuoNHN17XeJwwsIDfUh/KcvheuMSaUD6MjfGhTQeHC7SJmvMIdkNSCQ1K
         1MXiYVmcSYB0zsWzrqSL3YgySdoxqhzvRhqyUZr2OCNkNIfkNXyQqMsfmrpfyKCHTh6F
         DDHGhF+/wcuMp9mkWoPyKBZheQOoEOjWpVV7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773122657; x=1773727457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcMkfkqcCmjFUwCLyfQBIcEGfJ4AtjBgCr7uCX9+Zgs=;
        b=Qe2MnAQFMp7sUzK+7ZRHEUe4Ne4VNu5r0XrZ2EiFq8evBSsiK9i3ARaRn9wnLj79IK
         gL8ymxtlEZVYzxFgjNPWjuAdM4cYkoOekIq06Ma4HLDyDiIkkGp5+blzfILpWonUq5Tl
         BNagQeG4oZKOb20mErjyFOLEZ31i0icOpBttXPpw2Mwsp1wiwxGQgxFOdVNRHTwxJAqd
         GRJx3LLkzL3DvYTh05jO9uY3kdRG+3htFgFJZrQj5+kN7PcGba16Xjo1TWFsFI0DIS2Q
         tMBqycS52qadLshqkYzswZmQDeX+Iv67cqPaxo/OMleUoryHszPQSBdtPhT6A9P/9hNp
         uDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJMLDUuBn9K/BMKcyAQAhDMN9XcOmFb9x7wzSM8+r9BDpaVy8FcQ20gc12EbrX5xxWGr1LUFfN45c3CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqpy+dzaKj+K/+11bDCseAPMzNRpsKSFKvaKllVmof1LMOxi7k
	YVMtW/Gql1vf6j2B0//vBPuGPGwpPr2//Qea0cGKzwssfkMbDjWokcb+Jkj2Sv6wYg==
X-Gm-Gg: ATEYQzzSq+/vT8E6Zg2ClwlgXdt+cx06fFdt/Hm+VyF2Xe2PvT++l7WDjQT2mOhIjQ4
	op1FZEZLGjWbD/FZwl6cenirmoWDlYqvxJcdLC6rFasge6zPDT11rFxcgFTLFiyMu79mAkoA6mG
	ORfLlpSq1vBm0tZHRZrh1GxwmHYRweGPhWe2F5sO996+Q/E/41nrEiZF1EmJXbg367ILWYykXSG
	xzTg9unxn5Hkh8f+DBCu5F3RggazX7afw9TildmzhMtG0xTBGb+vNF1s2fhKtYHk7H83RsfdxZ0
	vUJ5s/Orp8+Ryt1vTCfv4jRmIU5UuQjqa1ZvvgKTaCnLpBz/koCtKDIP7qlaxfk3PzclcxdPt5C
	l3Y16xSy/BfB8w84L1BYJKc1Ywh58XPgvJ/Buthwiu4iTa/hsOyLP+GVFSMn1rIBYgJ4WPQAOvG
	Xu4k2tODk6+gzgcusBddBG6OB2FS1ChxhpeteqFL3YjFKWjZM5fUsPC4r2pHYhDuYlNnWp4Azml
	nnYvEiXlHY2Ig==
X-Received: by 2002:a05:6a20:9150:b0:394:4d99:ff56 with SMTP id adf61e73a8af0-398ab2dde40mr2134777637.11.1773122657543;
        Mon, 09 Mar 2026 23:04:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b702sm12184581b3a.20.2026.03.09.23.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:04:17 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	gao xu <gaoxu2@honor.com>
Subject: [PATCH] zram: do not permit params change after init
Date: Tue, 10 Mar 2026 15:01:41 +0900
Message-ID: <20260310060407.1133800-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, algorithm_params_store(), like any sysfs handler,
should grab device init lock.

Second, like any write() sysfs handler, it should grab
device init lock in exclusive mode.

Third, it should not permit change of algos' parameters
after device init, as this doesn't make sense - we cannot
compress with one C/D dict and then just change C/D dict
to a different one, for example.

Fixes: 4eac932103a5d ("zram: introduce algorithm_params device attribute")
Cc: gao xu <gaoxu2@honor.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c41e1257243f..7551c5e664a9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1769,6 +1769,10 @@ static ssize_t algorithm_params_store(struct device *dev,
 	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
+	guard(rwsem_write)(&zram->dev_lock);
+	if (init_done(zram))
+		return -EBUSY;
+
 	ret = comp_params_store(zram, prio, level, dict_path, &deflate_params);
 	return ret ? ret : len;
 }
-- 
2.53.0.473.g4a7958ca14-goog


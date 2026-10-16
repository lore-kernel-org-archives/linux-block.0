Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E013B83F0
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125901; cv=none; b=Rw4ijcIMfyo/yrSDVZKAWi6AKPKn7ubN0yMUUsPMGR7nlWVMtJsIa52LltahNwtbMJwm7E1h8LwS54MB3V4/PYrTXvieJwnXzDTUFeEoVtIUwpsSWWwI7scHECT69f+4bgzyYkwbrfgm3+WFD+4cipQRM4prIxa0AMOAqduPxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125901; c=relaxed/simple;
	bh=2L1l2WEmVkTr1X/Pc9b6FfcxdiaY29ag5fDryoDzPpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxKFU+nwHFMHCt0QQfbvzdgSfDf6LHwzqPnCvb4ROhNopmhBO3c5dYWevcUWJwRt29+73ZXafclxb1H3ZYdHmtrlQJv3Uvu8sY5Ht/BnuvKMYmyinVHhti2g+tISpBQ2gviSr5IFbhY8Ueu06KDZkRr6cBe+UleW0tc0RdIirvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BpF32s5g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BpF32s5g"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e985106c0cso2310095ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125899; x=1792730699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B418+SzCM2Ac+ZkuhfOdHoqL+9AUQAlnO0fG1JXa14=;
        b=BpF32s5gqbqg/ZPBjsS6Oee6K0bRzfY9b+ZoM78Dhoqb3Zk9YrenVMm8a3DJRJOS4V
         vKRCJpLsiO9E+e5QqjYj8FKvRySedcKUlihMwXiYKe2juXC55m5pjxRdtXn92tT9XfFS
         +TLmTo6R03N/5Cc/lmG7bh1T8pAt1+Y2rocBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125899; x=1792730699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6B418+SzCM2Ac+ZkuhfOdHoqL+9AUQAlnO0fG1JXa14=;
        b=VWbj01R8Lc8EmFXNnBdN4hS9tD8S+gGXEW6L5fZtHS4/QqU9fdXnftFS/uGxsUAbA/
         OjssnRgH14s0Vx6Ay9WPn55w7YsehkOERCfY1EJGrwnvgV0Oi8gK66b1rhrG/J2Vfxxo
         sFx+h4Tef5UQ057cT2c9oReifTyjYNPFfr8jubWhLOJRA8QsUXPB2P14fXOHyjLBpvXN
         C5nure6x4akU+TUgssvoPdVxWSHrWgIcvGUx1t7g4D7hLrBreqUQxPFAr/HWeKPIs5VP
         C/L70ne9twS5gqx/4M1LFVMAO5wfUrVDdy5q8wH5auZZT2iH3pCARdMb/pF52WP8vzkr
         kMmA==
X-Forwarded-Encrypted: i=1; AKwUvBxObzqktENei/hj3ZnSA0r/avu5bY5S9WyIce/u1q5PBJAokZuaSLJ8/g94iIIZPcU8BKdjsYJFqYWYWg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKkudXCGFKU+Qn1h3K6mqiQaOER+jzhUip7uXioyje5iE6qNnNF
	1578QI5LxuXQ8yjFUlQy5H5XnPeXSh4zCMme38zSN/jvvsRYgYMLs2nqM7oEPn1X5A==
X-Gm-Gg: AYBFou2Ny5QKOfxfx0mm/VDnIxC0GfdAf1GvAmXtFhRVu6LWXxjvxneO7Xhw1kN5xoD
	RRC5QQ5eIe+XIPa1+TUuuj52L/OR9aY52H6BJD9JMcOjeasl33v2l2YYs+HFoeDwwdEzoi5HXaH
	C3T7sDT8EGvgORmwXKr931MeylTmYdYvbloIcQyQDHuDHosIOlR/qR4y4lhEwdkt99JSj2Qm7eN
	oQ/F0a0ZA2O544RaxgQO1gzdMDslfwqvYEUwBQFHAruviixP5wSnrvtDPwf71xfPUU0MU8tUouA
	AL7EOONKDEvTQX1dNxxBZM/QnuZjAvLRXajCFG4Q8vK+eNIz6I8M/I9ewA87PshYOhb26XyNhZF
	fdojjs7pgOIB3IQTi/OxzjWxoLe9wdzdqGqUB3JYCt2j9d8EFYoluH/nyObqgmQXSXlfRZzbE43
	wQWYkURwA61EoFpYZAOJ3NDj+vGWBSVyn0ZU4UppjZE4sirXImcmgcGffkuFBrNGcVedKKCTToZ
	1gR/NxoIM+ZolBCByE/sqL8KqvoKbygdYjuPVZ6T93qnReSiUJuICmv44AA3vKv1RLDIG7Bbw==
X-Received: by 2002:a17:903:2a8b:b0:2e9:4f7b:affd with SMTP id d9443c01a7336-2e94f7bb5bdmr57755475ad.6.1792125898232;
        Thu, 15 Oct 2026 21:44:58 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 08/12] zram: reset writeback state in zram_reset_device()
Date: Fri, 16 Oct 2026 13:44:13 +0900
Message-ID: <20261016044429.1304561-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset all writeback state to its initial defaults on device reset.
We used to keep writeback related data in zram->stats, which
zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
writeback fixes and cleanup") moved it (along with the newly added
wb_limit_enable) to struct zram, after which neither of them was
reset anymore.  wb_batch_size and compressed_wb, which were added
later, are not reset either.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 593fa4ae47c4..0e1aa0da11aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
+	zram->nr_pages = 0;
 }
 
 static ssize_t backing_dev_show(struct device *dev,
@@ -2881,6 +2882,12 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+#ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_limit_enable = false;
+	zram->bd_wb_limit = 0;
+	zram->wb_batch_size = 32;
+	zram->compressed_wb = false;
+#endif
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0.176.g3575e65682-goog


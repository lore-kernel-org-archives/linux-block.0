Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B64825AA
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863551; cv=none; b=AivWO5yatu7bbtIVlTh1RsyZ/D6PbDJtBnQMI4SN9/HK8tMPj7WbA+LJsLtEW5f00OGRnGJgKGZaalkfm8+9iCHVKxmoZ4gWPDT7+xUnloZ8IG8QvxTqbOdD9aCM/xgQd5BK47oGRAobd34swDG53aT9+30LT3abhXn0y//F0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863551; c=relaxed/simple;
	bh=p9QuUmpHexkf1l0MhRpHw9/HXrmj0+xvXegnqoruuWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XII/kSs8WueFTyyUpELfCQcwXVLWcUbr8L9I/b/Cyzi+lFlbTrdkzvn3Awi8vJYOA76E+SQ7oLXHu7uiESI0uZ89u4VXHU8PHG7+n0S6+oJLbkvopiBVbYvX0DgLU43U14KO7zOcZftObuXHkJ7Izs30BF4uQOpf4Fk4I1P9dWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W3BjvIk4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3BjvIk4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso1080137b3a.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863550; x=1792468350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xtPVlUiId2ccKpm7W1Fnn6SIyzFCa51LSmz5bGyULA=;
        b=W3BjvIk4nB+s4LU+0lb25hpBdXb8oZP7NDTkcs3xyS1hFy33hnolvzYBSCPATkmtjI
         F/eaAz68PR31cmS6fhx8jE76RHsLexQQCDRM36oVf5AbuggjyCZXNmna+GdksqEvSOLO
         lv8bAZmR2TNVj2ETL2lYPhQMI/oBGNjTgmVDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863550; x=1792468350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xtPVlUiId2ccKpm7W1Fnn6SIyzFCa51LSmz5bGyULA=;
        b=zg2mS0ReQwI09wbDhJmSitDHCPBrAVGiqiLOkX5RmosvwAR5BSqi/THU59ObDeHKqu
         rW84b21FxFZJRdh7uKhdIcqq9msj2WuMB0RjHXMl7zwCe7BLXJMJKE0pyeebMYSuCw4m
         HwW+MUMHGQBKqXCJUxze33PJ6dAa6GNXfvc5XLYAlzw9hw11Nc5SUJCGbe2ddlBLLzXj
         0ePvt7jFQ6K36/4Gmx9CpONmpPVwh/CevVF+62BSSsnsFIXYe+5dHL6dRUKxXoCOI0K/
         +IJ04aLwwrLJtUfcqSeBOKjRy74sKlBdGdEkfsxkIZf+HuJbW9Ub2zOk+pVt5bDfd5MV
         f52w==
X-Forwarded-Encrypted: i=1; AKwUvBxlHhADUkWEAFqhsSCiYAremlH2WV0YUH6m79CMritE9rhIr16XJYUDFfxBuqd5TunDd0oj8SXEl5hEIg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+mViJBngCSUj+O21z+8mm726LiNZv6K7VVPGWHa/Sv3QN6j2m
	SGNuzzphf5ryhhevlbY2XHk0PDlzwyAJP56kDOrV75fzztWM3634Mo+NT8D/9wkUOw==
X-Gm-Gg: AYBFou2Cu54o0FRXANq29TJUb+fTdvKLw125Vw5p4AEqcQdbyKXnXjqhd5x3fQEwl7h
	Tqv2vCAsKRwU6m6wDwJuiZgtIUFIObgfwfOfcHl1SXYHBop9W1xRYzXLrTG/bWoRsET0hBxFsyK
	DAQgJWzHX3wVPOYAcUPyOcwqCHGbwjPhaYojfd7Ldn8faCd5Kl3VOuJh8B7xJn7iN3CcWW4pH8Q
	j8rLtBJf188tasyEsUzcLJPclZ7pF7Fj1q4vwgmOE8AQyhGhZiXdJQXRyp6GfLI8bRLGrY17UfX
	63qkcj3uSdW/EVFOpYSpFaHbs52RjUfTLt/XNuhGqC5ciVUCLYheKSUjo8D0MBb1nX5jSKaOgZw
	kj1htcVSE1jPidBUyF1sNETLx852M3NkUKgVwci1qbdRYlUDEmTmcfgxriAem6bOEPegMMvCH+6
	kr+bIuRzjL1Qmc2Y+7Z4QHnoNQTV5xmOPh5cRfrcaIhV68cNRRYDTW+0qsJAMQF4j4Ga/GM39cZ
	M+m0uDSUUSA2AcIwSBrRmZX8lVuZvbLTl5LJ3RLsXPrEEO6z1xNAhqpw4cZlA==
X-Received: by 2002:a05:6a00:3d11:b0:88f:9fd9:3779 with SMTP id d2e1a72fcca58-897c65410bemr9764142b3a.19.1791863549938;
        Mon, 12 Oct 2026 20:52:29 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:29 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 08/11] zram: reset writeback state in zram_reset_device()
Date: Tue, 13 Oct 2026 12:50:55 +0900
Message-ID: <20261013035201.2809924-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
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
2.56.0.385.gd3acb90ef8-goog


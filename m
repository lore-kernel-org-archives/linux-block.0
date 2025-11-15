Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE2221DB6
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174118; cv=none; b=CYsN5296yIWevQB9opUQZFZ3ev3B8Hf4Un4nQ9IFmtpzFl5DzsAymCv5qjwgWIzkMFYlRvXtEP93vC8hpHqIgEU8C9ECKsKrXLK7LLW/Qf7qRsPIUNZYaeQOYR6rRHnP+qI3FuMOgDkAgubiDL7jj0SzAkD498CfAASdJm34US8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174118; c=relaxed/simple;
	bh=Jd9ofiz/haPvieqadCmQgSYbnZI0iy0DmoD5pC7vvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q62wAlfLN+5v7LOEIe7fUyek/Usbj7NuazQxs1ij62MNxTKJOjfpQFzwhs8f0/+oYr/+H+RZf/2XXvLJD8uKMf1G028bv1UvWF7NoaoPXKWH77n4eRMQ+5s+XXeasy6DwieEAm0QhrdHnOlpc0VG+WPosLadXvANXGCT6d47bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cQxHxPtL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cQxHxPtL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29845b06dd2so28231675ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763174116; x=1763778916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BmRdC0cwQA4pj06ZuctEpCj+oY9x0ty4nsQhq6sVrM=;
        b=cQxHxPtLncrdb28UwkY/FO7GGnmpLe9VRVlP3jsdYKRb7rH1hWHuwWace0XGPmdbEu
         jYOUn/om/RksAFuqbxnO2Tgtx7D2gH6XxwZtDhDG5Un/hFhZRen+HgHUwfU+5965N9DO
         PzsoGdvtzJpxYgXzPWJEHzgOOrqMf+/nKe1U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174116; x=1763778916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BmRdC0cwQA4pj06ZuctEpCj+oY9x0ty4nsQhq6sVrM=;
        b=q75Ws93CkhKXpRg3TXM/Lq6S3APuq77gLAolvO5TJiwN5kx4ixJ6mOi3I9CVQadYYJ
         cdixuHKnG9sZXy58VgobXRxaaZb8EXgLGWsMABpE9zJ6ZkVwaUVTj1m2lauAyZTfE4N6
         HTEUW+xZGGLqQIU4eXYtGisitv2mkhwASUfqBfNWfj/+spuCQoXvWv4p0N82Mw4Ttm5u
         wlY+tU8JQUifLn5wlH315JePzryKm7/hE0ZnEgcaZ4uTJjKoFLG8AX5mZMLApcNiBPBW
         Kovl6VZjt/DVx2CuWFPZTp1XkmejBXtjjlez7GSwrZnAY0dDuv+bWDIdCd2qNL0qFpmk
         cZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC0moBygQeuPJm4aLquvMMIunZNxQbTV6sTaXeu4RUUon6nA3uPfNIVBPebHK8ByrE8gDiCyu6O+EbWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqE7COIUonufs5r3kN6cddiyy09rUupJ1eD9oZYW4EmjSJsowe
	3US/iMAjWV8XcoHSS6y12xD0KOfgKNmUvPrWTMt54IJE7ZZIqI4HDnnG8X1ZnpHs+Q==
X-Gm-Gg: ASbGncs/pWabG26EK05FwEpq8v/CUu5oNx5S3oT1P8F7GT7UxpNY2yUD98odZ0VM6y7
	HLB/AScCjJ3xaSNUrYyhT354iAhZYIPRgVIi9rpO5B3K0k8ZDVyK3Dx5qf1IPWqPDlveu1KectX
	CBsND0acE3t3AWRHGRbRQCfANdOP5qgU3t8wdoE6n5Y9XStAX0N3dZGoCjQkFK7SEKGIXyFaDhH
	MuKb521qQYdpRROhepm8P92eSyRl6XnQn+qnmMuScz2uOZLX6fLHXysPaezi871dajvh+014fQD
	apx2msTZThsBsWwH9UTrJPw20/VSMLLcu/eevO4yvolpYKGMXdzoHR94npDMwVBcEILzlhz4F4u
	MjvldDSZjdVM6zZ5hAGMeoZKYsM65BARsCpJHR+ElTu7+DMY+nRvfWjMoKWueA3IDtWo6oOA860
	DdUVrNxIzcPEolLSfzFGzJ88KyXZnnPrBLIWmldA==
X-Google-Smtp-Source: AGHT+IFf4M2Jlr3ydfB8URUmeRZ7uLXRnoh0xgPbDTGtZRUhasECUQqD8sDuwxAjOhCBrWOAohHVfA==
X-Received: by 2002:a17:903:3bcb:b0:295:1277:7920 with SMTP id d9443c01a7336-2986a72c34emr63213455ad.28.1763174116118;
        Fri, 14 Nov 2025 18:35:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1088sm68641555ad.57.2025.11.14.18.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:35:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 3/4] zram: take write lock in wb limit store handlers
Date: Sat, 15 Nov 2025 11:34:46 +0900
Message-ID: <20251115023447.495417-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115023447.495417-1-senozhatsky@chromium.org>
References: <20251115023447.495417-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write device attrs handlers should take write zram init_lock.
While at it, fixup coding styles.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e6fecea2e3bf..76daf1e53859 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -519,7 +519,8 @@ struct zram_wb_req {
 };
 
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -528,18 +529,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
 }
 
 static ssize_t writeback_limit_enable_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
@@ -554,7 +556,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -563,11 +566,11 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
-- 
2.52.0.rc1.455.g30608eb744-goog


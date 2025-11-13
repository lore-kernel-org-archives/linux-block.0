Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A033DEF4
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024072; cv=none; b=Pz6rutarSrHWUacjcByqAYS8pihaV+vdg4QDHQa6vaV9Yw1BOrIYIX0msUwY9MUslNGoFNDfsnofXPLBRMXVIixGxdqIlN84+19GA2cgcIrPovlEgw8mRtDDCl9GuSkHGZH7ZFsjpYhXuRPz3y8GePPWeSJ5e79vinpoi/KQYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024072; c=relaxed/simple;
	bh=G15zDhQSGXlkHBbvJ2D+mkyD9RCtv0j0QopfMySJkbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKAER6LDeuldd8NXEnnSOrbQWvJ219isXyR/MJNiNhYPVGQI6eBmr7tFM8FPui1ihTvrcxoYe7EP1WbZNc5RdpiR+IO+i4qSVHb1kpBfWACCMfctA8JXIXYUJX1RhzrreRmsgsnQRZ9Xkaf+qsXZYknVX0iwbPud2MO32DFx1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BqSw3m1E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BqSw3m1E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295548467c7so6017455ad.2
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024070; x=1763628870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66o8xvNrn3Zh6yfKx4kveyWbQRFbxbGWIXOV/eFIVRM=;
        b=BqSw3m1EKNyFz1IuhOERx7JwslfTdwBEVb/7wYg1qGuPO1fJ6pC/SGWuvbwrobFaGe
         6uyDr0IaJ53bUv0KnSXcHT9+A3s/lkvIj/Vo3IsVQEM7D/KRWLlbAWydImper7Y3E4gH
         6vObSv3Iqc22iBjnDNCaZZq1jzL+SkTTqZfO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024070; x=1763628870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66o8xvNrn3Zh6yfKx4kveyWbQRFbxbGWIXOV/eFIVRM=;
        b=chT7nrVmaQNKCs5iuAqEd5TujMbE24AP94TopH4ES699C5RuYQ7m0DfxDk0xllqB55
         KDh9Y0zaU+R95wJPpueLlVoA0o4JI7hYsz9ECJVAgIe9m2KzuXCe9RCiSXFFhhdWr4x1
         6FkHbw+L2MKPm/rRfJZvQk7m5h6AuUpYDAp4m6jHpbtpq2UiNu8A90z80VsOSXZK9j0K
         BV+qxoA+bn5AW+tKXeSDVuoGvORoE5pnP1Meby1Js71B7jkjfnUtW5vtaFTwl8oWWxzw
         ucbVkZT422CgYzHavffYpEPKyfAFBR6jr4GS1qXCuDj53QQ9JxqcF81ZgnwySmE8UZi7
         rXow==
X-Forwarded-Encrypted: i=1; AJvYcCV04WEN2DnPtKe6po22fcoBHXgJrmFhLbkd+10i3CkqpoNDjFSqMvD6StZ8tbG0SSUt3oWPrwYcRe/9Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiy9iTu441opeE/HvlBjbMzipGR7QWFasMhM+ksQ6CaKbs1TB9
	hBtSW7OKgsHH2SfKLHqAOiUF4n/6B2Jh9gLoeFIIbtkaaSeMiweIhvUEUMvhmAjrSQ==
X-Gm-Gg: ASbGncv05uLNBxUyaXKWBZQP72bVJh3rTd4tvAfOfKudPCUAhWIb3D3Rjt7mZKwBt5l
	WrOggWYifg0umbkZee3b00Tze7qwI1a3oKLPjRUEY1x8qsG20hMWr0X5w9dZX0cVgbqeP+Pe7+h
	5UIMn1V1DsJHRTZpwA+4ERZLRBJFVu0EGt3JTgFq8hevvz29h9s/5AnE7CAFiwxkY81J3uWhKPY
	R56Z7Ya/IDP4EPhNLqfGcN19UGeSe6Q0qBME/iJqlTVTcV29WKdP3db6hcelo9fJ7PDn2JF9kPt
	4U4S60rzATDs4b9vVzoVyY1G1PBElqOXP3GXWbGsYyffGb1+EEr3z+x37psFCNEsxzLg3ZHrGK5
	FZdEK3Tl/C/gHix6sytQ3ubbr6uNc2gPjsoIZzOpApOPh5rSeSiBjLjh3UwbEdh7GOpq5qPR2qy
	1oaUBiL5qFnUXNKthKy3MdUwKwjawj7Ckllv5Kpg==
X-Google-Smtp-Source: AGHT+IFCr46cECMeVud8wNJtWIGj5BffLnOQD6s1PPHNzh+xi7UWKBaPjYSgkMNd/Mok9dJQQjAbaw==
X-Received: by 2002:a17:903:1ce:b0:295:73ce:b939 with SMTP id d9443c01a7336-2984eda94dfmr81834785ad.39.1763024069976;
        Thu, 13 Nov 2025 00:54:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:29 -0800 (PST)
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
Subject: [PATCHv2 3/4] zram: take write lock in wb limit store handlers
Date: Thu, 13 Nov 2025 17:54:01 +0900
Message-ID: <20251113085402.1811522-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251113085402.1811522-1-senozhatsky@chromium.org>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
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
index 238b997f6891..6312b0437618 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -501,7 +501,8 @@ static ssize_t idle_store(struct device *dev,
 
 #ifdef CONFIG_ZRAM_WRITEBACK
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -510,18 +511,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
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
@@ -536,7 +538,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -545,11 +548,11 @@ static ssize_t writeback_limit_store(struct device *dev,
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
2.51.2.1041.gc1ab5b90ca-goog


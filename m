Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56428301715
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451024; cv=none; b=oIBQS7UauxgvRmYUG+GqeJ1v5ZQ3hD8Wlhh1Dr3eP9Wwvkj0s9KJUpnGff2yVIs4pZqLWWjNSpLPiUJ9yCwMfXfF4EKWqmwmGCdTTh8GL/Bv04qzHV8TjL11XhQfE6dEixnruZuzSYwpseV7B28UK3XBqDhsD5biemGlFfptgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451024; c=relaxed/simple;
	bh=nwoSFbvg2ufteXXIxITw7M1VYLp8Ig+96/yh4XFs01c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saRQhTu+UrqkoZSXXeGVp8UkG1v4qBSBEffQB8U5/Pl1sgm8CI50SaVYEicbS+X5bFRCgnGoBJLPLUT+3KZybk+hDymM9d2PzDu3F7sspsi+kFo/BQrYGeBqEez1xWqp/KbZO57MWDt4KQtn0zi1hO/hiY8h099f0EzQWbfeQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nemYsUte; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nemYsUte"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298456bb53aso58243855ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451021; x=1764055821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLeikw5PJ/qN7DZHExYRK+yLqtuCtzgt/wbA4Xek4OA=;
        b=nemYsUteqpz0D21I+F9lJ/fGGDu4C2K6QdJi89Ao4tfILBNwg7kcKHCr4EZi6TKggD
         jjqJY8If/0fMJsy5gNay7RL53HIK5Ejn7bDxko5EzKZ+i7mSw+EMR+GpKxBu9xT8A+cr
         IVHb/s2JhdFfbYNS2M3kl2GP4OOTiZpJu/5Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451021; x=1764055821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLeikw5PJ/qN7DZHExYRK+yLqtuCtzgt/wbA4Xek4OA=;
        b=aWnKBBHcjPjfGNqp20takoE0D1hwUbxIxaVw4WwvSR2vPJIhSftne4cxNA3H7ffTPY
         M3z1Za+e9flPobvqzE9GbdP6OueJ+U3UFhaUWA9Sc2mBpf01IeXTfb2ese9A19dYGJha
         Yz5BZGMG5S8pvm6bOU9gXjsw4hTIhczHRExwxc4XvFkCrFkqMzSt4JchQLkpb8XgI6gR
         gBu9vlLcUEbSqzuTQs+kt4Qg66vws7+yC8gmivJwXBB/A1kkpZYNI1y374RQ6w+Bmutg
         5uCScL8+OqJnL89ZrMRmLMQjGhvqNYzQl6QD0MLMohFgTjL0e5hUU6wEpzVobivYOv0n
         u8nA==
X-Forwarded-Encrypted: i=1; AJvYcCWfZoXn5e/sBRtKyFIIy4zNqFOh+2rMa3vxaCJkYSYmWY+rGO0VXZaFJIVWgzAwWzxjCIM69YjJZwHH4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0F2+voyxLytaR7rnGTpICZG14FwqUUEt0CR1mwWwQm3S6M0F
	X/7ozXv2ulrLi83/T6XOIN9lJ4Ii9KpMA4WP/Mpxyp3gJOjVfBTf44RSQD9ixM1KXw==
X-Gm-Gg: ASbGncsGbcdobe91xzRT/yQd1pXI8z02K/D4kN9UioypPwClMWm5FrAmMQjzbljDITN
	qPCF0K+RbGSmkg52edlVU08969DcEBYOu5xLMdaJMD5vyXuzRBp2oMlpZi9hPWGZD/v6HzDg5i5
	NJF17zGHmH6YsD1mNWn1jiGN3Bx4fvfYyKDi1HDH/aj+iIzUjNNYjJRVHfw1FCC0IDyH/dUs8zC
	Shi4RwHdek0Yv5qDaCbom1c2UeQioQJU1cniXWllgihNNg61LB2EZSBk+xFBhqZKMM6UxwZbTD1
	4n6MLeAlAx6mZV+tS7KZFYdEFmvy85Mtg7TrTg40QEIHmS4aZWwm6DBA1ao235J7YqoEEkc75aE
	x6ApwLLEm3FftW669r+z64K5S1BEjwa+BWXcOS9mA6+fownq7WJoJufXDJLS5rA+CNPYYR9bXUj
	wvz9vn/GXiX2o1jkV8VyF24ibj3oR/6pP8cq3CWA==
X-Google-Smtp-Source: AGHT+IFPr244P47pEFismSmInv5GHAI8P7iTWZDuNYFcomfeTvjtA6iKN1AEqAASeGrUa+CcERTWXw==
X-Received: by 2002:a17:903:41d1:b0:295:7f1d:b02d with SMTP id d9443c01a7336-2986a6da8a4mr198877365ad.22.1763451021561;
        Mon, 17 Nov 2025 23:30:21 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:21 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/6] zram: take write lock in wb limit store handlers
Date: Tue, 18 Nov 2025 16:29:57 +0900
Message-ID: <20251118073000.1928107-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251118073000.1928107-1-senozhatsky@chromium.org>
References: <20251118073000.1928107-1-senozhatsky@chromium.org>
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
index be39fe04b9b1..073a12132cb3 100644
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


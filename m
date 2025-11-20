Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3136CDF1
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652136; cv=none; b=GlhtSTwvixeYwBX8YEzAFhVExJuhN6ePlC2jYM2Z3OyNKUomHAT3Kb2Y1btEncdWNfVR1oX4BP56aN5IWo898v/OM7Z1BePB2JWZ/F19XDReqWG+BdP9J8L67WZeIHRqLebKjCU3Lwgn1poe10bqNo3JvAEdwENBBsA6Jt+EQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652136; c=relaxed/simple;
	bh=6i9wyNhqOFWWngjT8KYDQjhuLYLHg4Vp188ljYoAL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX47XmObLtvm0OFdX5qp7fsrhnrO7npRYJOp2etW8CvYQbTZjXlrG73jzRfFqhmO2hTruAWYj0iJycpRjsTRilwyTJ2Ma5MxVo8krIhUuF5CeNiBXjej1vSmqVJTDna57YzltvcufaFKyQYFRaxJuBC+PzmnzoIAW6sLYBkWvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKcwbqMt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKcwbqMt"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1279845b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652134; x=1764256934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8KDeSPboQyenPsR88PS7oH+E8JUyOLPtZOOBoNoQpo=;
        b=fKcwbqMt5yajV115c7lIH/xC73BJoY9KcDmK6vnpSYuiKp0rScnmzIQF2c6Gyg+X+r
         BLEPll733fLPWDQVXldKpP/84XN9ebdEcnbIAc3F0vhZKWdye0gm1ITZaxhifqelT1O4
         wwYEVh5t2/iJ+nx7ld4XIFCEICzDSwja1UmGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652134; x=1764256934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8KDeSPboQyenPsR88PS7oH+E8JUyOLPtZOOBoNoQpo=;
        b=iKoI0LApnjjh73Uc0zH9fBnCSDb7Y6+fy6lZnl8A99lTxbhjwJs5QV1BonIppTQu3U
         DuGjISXDngXwLSWyqdHgVHnkqGeybwMO90yFpfG/PHTlA4stCuj21YiFPVz9+h3KqJh1
         0VkZ2TjXrTdLIhx/7dOaWA5xAfkQch38ex9t3Ne7jOwMPcNwLgwr2nbg4x1LKIBsl00A
         dgGQcGVFesS3tx1sGxMZM14hCWa1DseMpqmygP4AFGIeuglk8PGzDSBtOCdYyZLQkJwz
         G2Lm9w5yhOAT/6sVDA94bMtb5AFFuCbaCFuV1nlSuGGH2/x94yMyVZAZ/PDUyJ+TcAzp
         YhNw==
X-Forwarded-Encrypted: i=1; AJvYcCX6PoPV6XMJiCeJFxDkzNXSbmwE9jBlyvfX2RMcWcjAm+BxxWyrfbNa0HDoyCIsoKiHvwqPuugV31Kuhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqDbZceWd9NZWnVgUEXPVfWuva0b8urjKGpsnTNDGqRQ6wLD/
	89SyHonI0dvOL/0+Xjzf6vu4zqpBE+7dEvfcjfYCynfNc5iqnZXyKJuu2Me+kO4BRQ==
X-Gm-Gg: ASbGncus4LZlQFZXPQM7fHi/AHw+5GFMaXc00LzeKlAswS8/78wT1oisS9WPmOkYRmi
	AZjfFKs3Cnsh+GALAz5hG1lnRgNRWsv2N/dwP8ZPdatfp57UmPkbhWc7vvOHKbprDhfv+Q/umow
	OQ9yJ0ASWK36N9bXCxFh9ywvviY/gOi6jBGoyNKOx8qLW6URyrlNatLj/Hh1t0lkKhFfgNDlQZ8
	03uKIbYUcSudOfVIwyhnaCVj4DM8neDtSblRqNVs/xV5wIfGLAPyHGMVtBMPEXwhXcjsgfVmpFz
	nscXqmBNO56ONQy6iubezV9+nPis9LBOVIWEqsME/TkTgP0rfcBFfSQhZ8DlO8AU76tNkox9Hr7
	7a3V+JOGrpfJ/ibSLfCwSDYl3fk89v7HQ5b23f1k1p8RM5uoBZYsG7DBabvEsgFqmTWBUm9ybHz
	43+gj+VlxLj6NZO7Vf7Dn6x61IjHN2ex1IWtUbrg==
X-Google-Smtp-Source: AGHT+IG2i3ZVAyerpko0bG5HQErQy5GRVNKpfeYhSDmo+oadwIZX5NPw7Ys6zkScWliwVzH5YQeGVg==
X-Received: by 2002:a05:6a00:3a0d:b0:7ab:6fdb:1d1f with SMTP id d2e1a72fcca58-7c3f7695779mr4532606b3a.29.1763652133881;
        Thu, 20 Nov 2025 07:22:13 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:13 -0800 (PST)
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
Subject: [RFC PATCHv5 3/6] zram: take write lock in wb limit store handlers
Date: Fri, 21 Nov 2025 00:21:23 +0900
Message-ID: <20251120152126.3126298-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120152126.3126298-1-senozhatsky@chromium.org>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
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
index 7904159e9226..71f37b960812 100644
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


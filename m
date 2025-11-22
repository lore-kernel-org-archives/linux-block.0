Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F82DECCC
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797258; cv=none; b=OkgYppa3LqdmrtieCta5uMgVcBJack0N93ZDur9PAbBAqVzspPXD3sTgv9HBnSJNsucB6hV3d1uFyFa7G5uf+w5LlWqeCzPRQU+pzDcF3hJBL6bF81LJS6nuc00wvyRKU0mX5BmW/yJ0IqiWA9XxdB9Zebr2wM6ThUZ72MfwLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797258; c=relaxed/simple;
	bh=0lvT62u7g2hF4e73HEKdSTUKddQUZd7pbA6qKmK7XgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI6OmVgWJPI8M1IO6uKrOZdCi8lNjJ05MJZ4CFPt4fV8in1u3iKLrSZtM5G0bMX8TeoFR7uTwuVjAQJpQ6BVqPGlg8+Hxyf+eS4hPQd2gtCoU+bICRNOOoQkUPYf4pJaX5vzBqTPnQptSMxBnPkUdVvzPnRM+kM3UjjPUNn9qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X12BBd45; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X12BBd45"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295548467c7so32620055ad.2
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797256; x=1764402056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP8ZymlO8cuxujreNygTi0dHk6OzbncHB3g2TEGb8AY=;
        b=X12BBd45p7hMcsDJsvrZh2BPdcYPYdrFQoaOHeBGCq9zJwuuVSpQIPeqapeUqYbNJp
         ExTl4QxTr7fKaKtO/da0EfpDeH39qiyUf7ckOFOseer6mTbsB9lgP1G2Nj2BHBfs2BUu
         vqDcUdZe+R03Bw4t9Mp1T4cYNfLxhOU9rs2uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797256; x=1764402056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SP8ZymlO8cuxujreNygTi0dHk6OzbncHB3g2TEGb8AY=;
        b=PeH1KeQEu+RCZXTJEfUIjQM3O9s0mqZCPZvylb+ptY5535Nq/gRG8YRvXiRvXveWed
         LSTm8t/rExdgI0CrOrYHyn2rLvX2qEyy2MLvZ8hmzi1q+hx58vYmzp25LnWxfe+uqjcv
         /P7bR17m6H9QDJxbMHdL8T4rBIqeIey/VsZRSVjjkFFI2sc35gCpurJgUqBE3O36+b+K
         qepnG9HBnbpkCG7GWSVal5tkRQLTzQW6SQrg/DGxnGD2xxO5b+7bNxbNqxBhOtUOMD3s
         SIdiRQm5bLO1fnpRV4NYovPmIPcysvaZf7pxqF9MhoLfmydoc46Zehb5TGYPSJA4IcjO
         CMUw==
X-Forwarded-Encrypted: i=1; AJvYcCX1dCh4EItOn0AKek/bEmz8kYsC7SvfayMOcUOZn93EhDmiiPgg630pxMAZLrILxjQ9jJLAu88v2/HUyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7D19XaCMA7cXGqqdA7WcU5lBhwf59nyhof8uwK/vNOVv001O7
	qH/NhUI+8qA4HEl49IDqv1NZxIG4mJXKMcthMjI81N2MrjXr5AMyfMneVVxAAUDr5A==
X-Gm-Gg: ASbGncu+CSYxURoKdVn9qi/JTi6Of3SAKCJ1rN/BJvgKGDRD6Xi8/+zdzpqqOrCF7p9
	aauwYvWinMJ36lXUwQqICCtlsAfzvyoPoqwWWIVFA8PFMvNEBQVisWHXoYSxiceTcqPznSkuAZm
	2Ncj/zU1LT+SPVlxMuLOpb9NyQpHJy8U6qdeLYOKuycc4tiBZ0eE/P+MoauhcotzfRqYu5ldjCM
	F7x3paaPkG78MFh11y+K6erlqxm1/2LAp2A+bgzB4b8mOa/A4MWb0h7BQm14areo6e7YBd6vBjM
	3GaJ5YWvFUK+jzDUXvnmwN8RI6U6IbssjXDzfn1bwSbByXF7jyki0KMgvw0jRmf6Asd4SmJ5R3/
	gRZB6OE/49j2bKXiK/XmVDyJ5xg8XIcRo7FMM94F7zdSeeYIUpxg9bRMu+X87ObaMClNjXGazzj
	ri9JzV/lKvCk/xvGUgiiuaW8+jfx6ROkeG1FKAfO//nv09Be/QjbWS5IrwYsJ+J5Bmws+0IBIn5
	A==
X-Google-Smtp-Source: AGHT+IEM8/Y4dIBBOwac1lJfHeplWi/wxjKlMN7X/1wlrBnzk52Ba8uHOaEg9loOMYDOH+d1fhjFKw==
X-Received: by 2002:a17:902:f608:b0:295:9cb5:ae12 with SMTP id d9443c01a7336-29b6becc884mr62810705ad.25.1763797255895;
        Fri, 21 Nov 2025 23:40:55 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:40:55 -0800 (PST)
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
Subject: [PATCHv6 3/6] zram: take write lock in wb limit store handlers
Date: Sat, 22 Nov 2025 16:40:26 +0900
Message-ID: <20251122074029.3948921-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
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
Reviewed-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5906ba061165..8dd733707a40 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -521,7 +521,8 @@ struct zram_wb_req {
 };
 
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -530,18 +531,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
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
@@ -556,7 +558,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -565,11 +568,11 @@ static ssize_t writeback_limit_store(struct device *dev,
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
2.52.0.460.gd25c4c69ec-goog


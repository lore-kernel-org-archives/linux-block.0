Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854101;
	b=0BKq7r/moko4w0YYF5DAsFAchxzTBIVttl1b5WyE54QpglFtQFBfXj/WQ/R2lfqw4tdk
	 5P9Vmrjks8/0eXnxY+kv8poxIJREbQCzcyQ0c+4usBU/0S/njzfMwlDVXy5hCn8RSltoj
	 sBUM2zIgEGcXcBXGK34Q8gaVRHLw/YhZlwRQXwX7AXMPqexHZ3+L/t2D6aAda2+5LbR+J
	 RzdHitgxRjvjuh8sC8JbXaEmcRU/2n730stsXeXlfSToOoeRprFTF9lDjixa/pZ7vNiea
	 QTRK8GNI0Z7wZVUtig0kRG3Bt/Cj7Lj2m2hQ6HQcz+6fvio8sb4JdewEEF1O7OxjlGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z4CptPZ1xxIkHaBqUwJgyo6uh3NXVfD6E10G6VWgJe8=;
	b=cFX95sDdKg32PXRDGnNu1WSyHYyJHdqqvhXJsNXY7tAapgIFihUcsqAXf3ot+FB7XmE6
	 wM4yr3ThZsLM7ZdW5UtHhc8MfoUYouEgTlNRzK54O+MMSUsgVd4ra+MnR1AyRa1ODXfhj
	 351eehWLQHYCDRjw8gxCr7F/N30tit+zM9v2/X2N46L87/+NtVV29wCgBuKd3E5aMx8Rz
	 xxOnL8qTsLmBe/oT4xgCZVf6F4YWEv8lndk/ZLwL2/0rlA3sAQ31FMjoZH854PP8ObJ0d
	 JSyp8eb8MXghAmpFpLI0KjbJdPMN/kc3YnRsROdYeuzuLbxKxzDGBk+Lpy9AOVxMh5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U+aQgEZx;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8D606A335
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D8D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U+aQgEZx
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so2523280c88.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854100; x=1794458900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4CptPZ1xxIkHaBqUwJgyo6uh3NXVfD6E10G6VWgJe8=;
        b=U+aQgEZxeS5Pre7SDZg848BQdqMpLL7Cd5tR4LeM0Qd358dg8QaB+rw3k/7OcykJnh
         VIidf2eRyWud4n6W1l7WdXDRcxxw8rJeoMdABWWD0TFNc4DeYOlOndfx5+ZowprbJsjM
         9PqRK0VDzKr2FVQh9FMNwF2M8h8rIVf5VAQUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854100; x=1794458900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4CptPZ1xxIkHaBqUwJgyo6uh3NXVfD6E10G6VWgJe8=;
        b=nlqVYeSzbjTCiXbpfJqLazbfvBIfRYok24NqFeyH6JvUT62xzGYDlf074LBVv8bmkI
         dmNt/GjYKlvrdh7sp3TzhSpkp457L2jrhmYOobjCyMKhC/9lsRlBT7za48N5mDDTzhnv
         9uVuszF7W6ilcODMRbJSUBEgbsb/5i/BKBvd3hks6IC+WCHeoXsKOvrXs8tPLQAwn2Al
         kA9VbMwgK5pRRWsWGekdegOGyO3D5L0i8dNZKJPO4y7zTAsgnolS+J8232Mq0QzZ2o5L
         6vM3SyX7v4vGRdpP0/5GlOIgvdYgyDlg42ib2ft79HlT8270aYj1Usw0Cueh0ReJaBmo
         RT3A==
X-Forwarded-Encrypted: i=1; AKwUvBxWHEREPGcslawbpOGMGRXKuFvbGOhReqjpU6Wwp9D6g6sb02fnZeMB8X03Rgno9CVuOzFfR38XMRYbog==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sr2W9LllJ2EdKwiokce5wvEyQqZVF9vpHVVqUpQgwSNbdIFQg
	e5lI+JHzX8xk7Vy5XVo5mm+boVTLUjUbXAbxHNu6bSGyj+31zjwjsAS8sw2X2m+JkQ==
X-Gm-Gg: AYBFou3pgE2t5huRWffq0C7gChxl+wr/casymwbonOfB2yQ9ufXrTrkv72j8mP3K0Ai
	TJiFB6yLuJ5xFmAt5/LPE711ps+5MpcYA31QTeM+YJhIJlFc+qrhGsUNBXv/qI9XuAOwCs7YpfG
	zM34YyWDRCrd+dubQE1j3BiuVcOR8zXfPz0bxCMSgi9ZU/LEnGnJMkslFPZCIYc6cXIsWmDvsf2
	Hu4//SwganiY/clZPG/bFFynGrtqrq1/7pimL0WKVkFqkixW98suxjs+icBOzxyqD9jQ4npZZdn
	sXCoQ6HJ5nfbSytt6FyM5VpiJrA2fNiN7FZBpm2nkO09TeTb3jGZEOt3q44nVAJ8N1t/TEVJCL2
	SEtushlbDH0IB5+XBOMCirhyZa8kAfPTJ4A/+r3xI+WMRNfCpw7az/NgzB5s/BrorUAIicGGQO9
	QIzuAG2bcN5lQRkYQWjqozeV41i5MENfTpbB6YAT9eBkqWtxC6vWcM3fQ8+xzCWTZUR4FfvHp9B
	U6Vj7Gekl8WudxTJHjhA2wpCGHXxt+XG80rR9lFirNXFWQcdBka/FLCVhl0ZrBTwzVX7dwYxNeo
	l7BKsZaAeWbb6jM/DMZWmwmpjVaAVsbY4RmKFvmH05qyEOU1JCr4uvOCVbeIuolKxauIPQ6FK/o
	pgp6KkCNkpQxoqJUvnzdCR2DHd3Y7lh4Cm6jzE6Y=
X-Received: by 2002:a05:7022:7e0c:b0:14c:d8d9:9502 with SMTP id a92af1059eb24-1ac5a0b8a9amr26997590c88.14.1793854100117;
        Wed, 04 Nov 2026 20:48:20 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:19 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 7/7] zsmalloc: constify struct zs_handle pointer in read-only functions
Date: Thu,  5 Nov 2026 13:47:37 +0900
Message-ID: <20261105044752.1997895-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105044752.1997895-1-senozhatsky@chromium.org>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify struct zs_handle * in functions that don't modify the handle.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h |  4 ++--
 mm/zsmalloc.c            | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 674358f39191..793fc887015c 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -65,9 +65,9 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 
-void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
+void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len);
-void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
+void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle);
 
 extern const struct movable_operations zsmalloc_mops;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ff1cde4c5dc2..e0f89a3b77f1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -805,7 +805,7 @@ static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx
 	return obj;
 }
 
-static unsigned long handle_to_obj(struct zs_handle *handle)
+static unsigned long handle_to_obj(const struct zs_handle *handle)
 {
 	return READ_ONCE(ACCESS_PRIVATE(handle, obj));
 }
@@ -1110,7 +1110,7 @@ unsigned long zs_get_total_pages(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_get_total_pages);
 
-void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
+void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len)
 {
 	struct zspage *zspage;
@@ -1157,7 +1157,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_begin);
 
-void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle)
+void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
@@ -1395,7 +1395,7 @@ static unsigned int obj_to_class_idx(unsigned long obj)
  */
 #if ZS_OBJ_CLASS_BITS > 0
 static inline void obj_class_get_and_lock(struct zs_pool *pool,
-					  struct zs_handle *handle,
+					  const struct zs_handle *handle,
 					  unsigned long *objp,
 					  struct zspage **zspagep,
 					  struct size_class **classp)
@@ -1415,7 +1415,7 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool,
 }
 #else
 static inline void obj_class_get_and_lock(struct zs_pool *pool,
-					  struct zs_handle *handle,
+					  const struct zs_handle *handle,
 					  unsigned long *objp,
 					  struct zspage **zspagep,
 					  struct size_class **classp)
-- 
2.56.0.398.g882cbad275-goog


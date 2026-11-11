Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379657;
	b=kHWipIVnrVyt4b/NAOt5hmFiksrPJQKjH+Y6HLUMmFPfG6kJgtEiEs4IHbSKpMy03ngf
	 WCfooLMw3Xi7C0wIKDYzeTaaoX3D4Roj8GPifAx1mB5GKkve1shpMGyWgAZ+6/V+xvnGH
	 3y47Hh4bKb99LtHpbslLph2R21budeyIzKv4+QXfGBx8wRqVFFbg3t46Jm3apuPk5bJZz
	 evM/fu2zWW2wmsGUhF+6x5fXOyDk2qKAb15Nr6JMzPpDZh5yIdIsdzdEKHpl0ys8lH1ou
	 KZBmlRjKxDgQQVLn82RVbrQxyTYhy7tB6TVTwvwKq4QVc1FIznT6dg3TvM5LpfpsfYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s901sm95u73URLyqX1tOE80ZT+B5IbZa2FXF/1v/wOc=;
	b=aQraUrevQOkX9KqabQsYi+SCRXay8ldtoUa9Mpu0V9h6YFhq99baCUwHEE8MEXOQr7mI
	 Ko+PDR2Bqo2lO+FoWLmBf6oWAwfVsWVRmvnFZaK+DBUJZc9NXV4lBKZTY6NmpKdoq/854
	 G09LA+0hCMOP0kcOMImCf9/u6JvLbI3OySm/w2Fbg9mrlwJe2wXvDBJpLjiyX+UpsN8SU
	 7XprQ9cG0V8TOoaX4MqnnFTztIWpJtbTl0o/lORMn5BYNjPyfpHbzaxH7QXuY9f4PYjds
	 LvKVPV3uHknv7d0BeWCPG5JCC4/+2JWzfHyMzQhCRCEPP9jYatb6/ygiLPTkFePZYWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Sj/rEClb";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A38606A99A
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A38606A99A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sj/rEClb
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1608534a91.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379656; x=1794984456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s901sm95u73URLyqX1tOE80ZT+B5IbZa2FXF/1v/wOc=;
        b=Sj/rEClb4j5wrxPtoGSuOWVTNzC0y3CqGXdUBRG0y+N+N+GN1lWcvteMhXFsohm7Ze
         ZsfqhOQ2pzSknMFqr4XY2DMGHmhQCmEw+WgKmdNQzJO25IkzVoUsUKTAzxBsZtHcA41H
         CThcaarxV8U+X8xzY8EYvMvC77Tvk+/5IPYak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379656; x=1794984456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s901sm95u73URLyqX1tOE80ZT+B5IbZa2FXF/1v/wOc=;
        b=GBg191oMneQHhLpGG8BDRO4cGFqCiyCQ4vioQbPUM5acCKU1JhlVFlkLUpKgkBdsr0
         0FuVTWQQkxGay441KzsQFwPiTjthrpZvMW7YTaSRLZ97Sa6HPIx+RN5svgZhy2aWWuCM
         objgGMZCdk2TXr4W7//KfGAmovpTaSvvnHJaXb8I7KNM2kDg8Q6ZO7FxH+MYKqTeLtK8
         AwPUV6EfxGB/2Ti2hgwMlgOpsQYE4CgXHEmwoUZNep1crVKB3+I1whGAfBYL+sItwiAt
         UUUyaKckOzN0RSNa2kV2iI1q/JKDQJsso/HFGu1oTvCKhwhCqMvQHpYJZ8Pa1eQjXNZG
         6C1Q==
X-Forwarded-Encrypted: i=1; AL+hErHdyxErduGNlkSomF+tdU5HOhZYzvU+M/aJCO7yC8Mn5AEq88e/QuG/JLu2WER06QKNh2+hNtJ0cenazg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IMH1T7qlyLBBZGpGd+uWROPNgp/qyRvboCbUEu1Es54PPrMBy
	wJxKdWBscEyX51RjID8R7Ga3ZIixV7qqao7bhbDczbg3uyRy3vVpL2EOZdZlJZ7pgg==
X-Gm-Gg: AYBFou38w7h8tWS3NLxCXRXYWdwntGqR68khwRcEeqEgqt65TPUWcMMsUruHQyZMaGA
	tznEt6X5BONeqk22KeuVAV6T2GFFxhKEKFmwm8sh2OySYyewFPZNUnxB01b9WCa5bHPGnOfgWx4
	55Zmddce8eIWPQHy8QVoyobxpv6pX7q5FPRJQBhZQX876IJ3O4AasdFPXWYXFoSE+oqhpUrqXPz
	ra2o9aocN+JZrJuQk43DfS0THplNxZY4Vlpvsyy1f4nmc0cbKF57TaGVvzg6xkjPzdlMA3SQPn7
	3RBQnG2M8aYbVNnh4yzw7Ls+STMwHLE3kNa9xHOJ4aev4wI35YA5bXdlkWIXZ362H+1Wy/tpJ0X
	1Bi+obuk/vBGj92mptutqTkBxupioYq3/GMCxtwgpR8Lhcedt8mXpOKsUVNsukslaA1y/48Far2
	yz+bh0ChVwZjdjYdrPgCwUfoQZXqvYadDMbzWOCeV5Z5XXxD80mMqDgWYRaPpN3qJhgszsCmABw
	kHbKqBYNhKJqpPf1RqlxI/XXVvo9+qUKWATXToF9CH5cFV+vq0XQiyEjnsjlOyAqw9AkRuE7UQg
	rEvBKL9Oo1TVJz6LL6PyHk3DY0H7gra+go7yuYr1Msr4eX/aXwcEooKZakFEwBQcUOOblmfO+Jo
	zsR7odtoF8MYYnw/I3Q==
X-Received: by 2002:a17:90b:4a90:b0:3b0:aaed:48d0 with SMTP id 98e67ed59e1d1-3b182f5a300mr1674067a91.37.1794379654696;
        Tue, 10 Nov 2026 22:47:34 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:34 -0800 (PST)
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
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 07/11] zswap: do not free the entry if its pool is NULL
Date: Wed, 11 Nov 2026 15:46:30 +0900
Message-ID: <20261111064707.2568433-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
In-Reply-To: <20261111064707.2568433-1-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
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

zswap_entry_free() warns if the entry has no pool (which should never
happen), skips zs_free() and then frees the entry.  A subsequent patch
embeds zsmalloc handle into zswap_entry, so zsmalloc object will point
to the entry, and we cannot free the entry while the object is still
there.

Bail out early and leak the entry, its cgroup charge and stats instead.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zswap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1160bd34e289..dc0400d7e1a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -787,10 +787,11 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	struct zswap_pool *pool = zswap_entry_pool(entry);
 
 	zswap_lru_del(entry);
-	if (!WARN_ON_ONCE(!pool)) {
-		zs_free(pool->zs_pool, entry->handle);
-		zswap_pool_put(pool);
-	}
+	if (WARN_ON_ONCE(!pool))
+		return;
+
+	zs_free(pool->zs_pool, entry->handle);
+	zswap_pool_put(pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
-- 
2.56.0.542.g3ef89b7020-goog


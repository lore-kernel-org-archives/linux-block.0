Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A43BE63B
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773805; cv=none; b=UqP9MTkkWCJWCUrbzx3WdLQt9gOwXLRFN4muHr8rFmsWORBnuh32Gznb/l+uz6kMtym3lgcoHE+/8E7lsCjvIKzacIKh8XyZF+DwSM3IHf3yvMb26/CZBdfqkxFJsMPAkMJiOxf6MD1G++23a5oNQnkfjziSawBUhAasSuOKsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773805; c=relaxed/simple;
	bh=kLgOVy+bATsUzIamzLMfOptz5iAJtTXdDloAK01IeDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXgYmRxZ1lOVfq9e2lLLzfwJEfDMkK/2agdsyP4LGmS0XHZACO6tJr+GE+/wUf+w78NuwOJxnVoT3GC8c3+aCRzxhBUnDJwXXU3S8W7WSJN6rAGdLa/rPslrK0vJVQ2LvUvHlgHHoewsBZnu2KT8qcKvtHpsI4gPVFaWJaTAHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7U4/zMr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7U4/zMr"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296dabef74so3674806b3a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773797; x=1777378597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm1uZfhnuhLjYk2Ukt+cLbqh8Cqoh4c1TPve8K7i0ls=;
        b=N7U4/zMr7DoPqj/U9MJ7LNFajgi/eNAG5nQH0lS2HEmXZqz+P1ng/TJhULW5tXxJsg
         WFYqsHe4B34+HDRZCeFpUHmxV0l/aySpgPnCldH3wkWD1YURcDXC1Kt5HE7KawAOwGTv
         BUHOjJBStSyVoP4DznSEflE+WmSu8NbhJ9kJW5FlnPlGk+xu8FnsjC+sHlk4Lty35hPm
         gbc6u4XDtwaNrzov8n6yamlsrMVUefECyFP9lxwPQz18qCi1EYufaGEzeHzGoCKIZNHK
         172wGktkoVO8sOhVy7GF+cqqXUgQUuYJ78X9jm30yTR7U46huxLYpyCvOTSH9L+KZu1V
         yHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773797; x=1777378597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm1uZfhnuhLjYk2Ukt+cLbqh8Cqoh4c1TPve8K7i0ls=;
        b=Dy3mhA3d9TLtv6GDc9umJ2b3KYjefAZ4W8hD5r5x7LU+9+HAMbdBl/QY6TUKLuqZ2N
         NPrOVC68OkaZoX13AKhykT00mHnzjz6+yZOUvpdo8qecHEf0bjJG8L7k2KO4BbbzUV2Z
         /P1+OCgquydGH3eDSIW1halgwFKaFT+3JaXUxbVMyTAeEgj417kjApx55HOhCsPEPPz+
         GL2EV4edkua5g0E6G7iPuKM5icsoC73BJBbZJDQS1KC0Wy2jUtYo+ZQlX3uxEgTVyb0M
         HBxR0LDfJfmMi2zy4BB6dK6zMJl4ACK4dGTyQ/l6ixmzevQ/yenOPLY7FmoL2/7FqESf
         SvCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FBksppEh7R4lEzs5VrEr7tEyTRmExcYlDrTA0snDu8V5/Jn2Nc+y8ihe39uZtVL0iz815575Fp9xmFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0LeN/YoS13K796dsaYFxDJuH7k0WSPJa7b1Cr98R9GhgOt0A
	XbhO7H/FRV75QvalrD44dZddRHsvAmETva5yybzOX14OPF7aPXnSlj/H
X-Gm-Gg: AeBDiesp4XycWoDuFDQ9N7+sw8rjXK3tbnCf1z5W57mHjBCRMamMFsdGHOn9wFj2dij
	3BJcd9/vujfWWLldiCzKhQoF+zhzn/rt2KWpvOtZ3NFuZ+QodB9DAbMtnjj7Xz8fJr89lpCdH6L
	/D8jpjQru4FCJiSPD/wKaro6mOM+YJbYIf5cdmkxwpq3EJP3AP4kqC+Lz+uWK1/gQGRz5I7b8uz
	nUxWHaoqV/riTWgUDHea3OG3GrkjjGfq/dIW4+bhxaK7+KUe0e/C3FhUsBFN5/t/yX+sIanVcml
	GWbZtOrgcdWJu1quov8KU0NGqZkGJxf3GtQcfNCCLScq5GQr0MJGFJGOQP/V68jz/gEl4xeJZn/
	VwQTHu5OsDL7hO6OFbanFa1lkOy0cbnGAnAxIlRfbh8AGe8AIdthSHpP7UgnDlcbDNNH0lyJTiJ
	aeKNCMLEtEZiWZaj4MSfz3lxMHdLXekx6/1GxIpAbcKzI6RK0=
X-Received: by 2002:a05:6a00:2e91:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-82f8c97e604mr19692584b3a.49.1776773796869;
        Tue, 21 Apr 2026 05:16:36 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm16371071b3a.54.2026.04.21.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:36 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Barry Song <baohua@kernel.org>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v2 1/4] mm:zsmalloc: drop class lock before freeing zspage
Date: Tue, 21 Apr 2026 20:16:13 +0800
Message-Id: <20260421121616.3298845-2-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421121616.3298845-1-haowenchao@xiaomi.com>
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueyuan Chen <xueyuan.chen21@gmail.com>

Currently in zs_free(), the class->lock is held until the zspage is
completely freed and the counters are updated. However, freeing pages back
to the buddy allocator requires acquiring the zone lock.

Under heavy memory pressure, zone lock contention can be severe. When this
happens, the CPU holding the class->lock will stall waiting for the zone
lock, thereby blocking all other CPUs attempting to acquire the same
class->lock.

This patch shrinks the critical section of the class->lock to reduce lock
contention. By moving the actual page freeing process outside the
class->lock, we can improve the concurrency performance of zs_free().

Testing on the RADXA O6 platform shows that with 12 CPUs concurrently
performing zs_free() operations, the execution time is reduced by 20%.

Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 mm/zsmalloc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63128ddb7959..40687c8a7469 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -801,13 +801,10 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }
 
-static void __free_zspage(struct zs_pool *pool, struct size_class *class,
-				struct zspage *zspage)
+static inline void __free_zspage_lockless(struct zs_pool *pool, struct zspage *zspage)
 {
 	struct zpdesc *zpdesc, *next;
 
-	assert_spin_locked(&class->lock);
-
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
@@ -823,7 +820,13 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	} while (zpdesc != NULL);
 
 	cache_free_zspage(zspage);
+}
 
+static void __free_zspage(struct zs_pool *pool, struct size_class *class,
+				struct zspage *zspage)
+{
+	assert_spin_locked(&class->lock);
+	__free_zspage_lockless(pool, zspage);
 	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
 }
@@ -1388,6 +1391,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
+	struct zspage *zspage_to_free = NULL;
 
 	if (IS_ERR_OR_NULL((void *)handle))
 		return;
@@ -1408,10 +1412,22 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	obj_free(class->size, obj);
 
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness == ZS_INUSE_RATIO_0)
-		free_zspage(pool, class, zspage);
+	if (fullness == ZS_INUSE_RATIO_0) {
+		if (trylock_zspage(zspage)) {
+			remove_zspage(class, zspage);
+			class_stat_sub(class, ZS_OBJS_ALLOCATED,
+				class->objs_per_zspage);
+			zspage_to_free = zspage;
+		} else
+			kick_deferred_free(pool);
+	}
 
 	spin_unlock(&class->lock);
+
+	if (likely(zspage_to_free)) {
+		__free_zspage_lockless(pool, zspage_to_free);
+		atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
+	}
 	cache_free_handle(handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
-- 
2.34.1


Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC23BE631
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773816; cv=none; b=q4P1F8MYcS6QEzPVCYZUjMOOeOyj/x3OrFlhJgHMKpmH2NFlG4o4sjQ6yevVn+twy9hTkzSdXJQjemtY+4YB2bMG/BF/IrLYb/WfK7C/BOREp5c6b6RjCoRd5xOi6DLGQilXWIKnqJzwLkSrgQOFYcJmEmvHRnhpRhq7/+BiRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773816; c=relaxed/simple;
	bh=6rKmLIe4zCY6D4i9zpxvV+Dzmm4hxKvdTnkjV+5cCJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ey+hZCzU8KkQLZBOPBSvUCR5NIQzZEn1nwvafsnmcXYqSZn+L2fTosb8pU/WQlEIOD0CRfX6r5NXXJzyHW1Fv/2rgz82gbG6aOCl1qp9yduoe6Cru3E/Ub+qoFkZANwTT652D9pioWDYl/8fkQrx2du4NKiPbqHUFZl1cN6bajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d23g07LQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d23g07LQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso1130775b3a.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773809; x=1777378609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuBH0tSA4QMEqer5rgkERxzfsnQAmO+99E5ku8qz2ok=;
        b=d23g07LQm3+TGeN2gKLl4InjSUO0r8W6mtsZA0/7YNWWPW6qGFbwhOGq48J6lhbY/S
         /mX6bqM5TpmAEicsI7FaYzUIz0xSntEkLhI0AK0BivUbfbcw0HNYAZ+usqO/rI1C/rse
         zZ6cvOfB3yWkqZPgJeDK4/JmsCbpcZpm+OE65bFPYmp0T9/45tGMAIgwcdiyMYUwnSYM
         y/ll1Aaen86lj0umRy0wV7a/hANP/6jyJJVVvfb5q/VHOswJ+M04Rk8ZpORMFfKg2TiA
         AgPpPLUUfmgEGX76mvxf+ZPsd9Q4cwpj0Nr8hqWJyloaIBXPGwgS5wh8q+lNR7H5onjU
         CLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773809; x=1777378609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuBH0tSA4QMEqer5rgkERxzfsnQAmO+99E5ku8qz2ok=;
        b=YtlSufbDaPX7B2XWyjMW4+sbQrJj7VH3beIQ+uJJQN3xxCn+rb6sEAdzm0OpN0sciS
         qYpPWeVfAPbtvVUgAYtXYEuEYYuRixsMZPDKpEJ++PZjGrn75rb4oG0VltqoPTFbE/YN
         CKd/MvhrYp4G1GSFm6uRCI7qjkAM87es25hEaLLJWIc5zpPqCHnpLylFk+DLE6vmkd64
         327yScXwNDuyLBlXVFfv8c9vr9K/0+uQV9wtG5m+Hg2JdFxTySgNgvQy3+PFEZwcP5eO
         9N6GUBd8twjFKdcr8YxjbwoZsIGY8qOqUeKa1iTqxIPNpG9F4BvzQDagYYpmiNKxGxeZ
         R7EA==
X-Forwarded-Encrypted: i=1; AFNElJ9WmIIucVLB+Zn81uxJqRfN7bX7BmfqzxrkYhyC2ESDGXUUhtL/B3dAo+8SYe+qre/+mDvlh6AyxV7DCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTi7IqNtwKGdevWjSTfnRzb+ISzr34WPdh+8SCitMiWByRmFuA
	RUAVIcbDOQ1qY/Ka0v9W50mCMpRurkOC3b8po5HdDwq3/XSGqNJtpZip
X-Gm-Gg: AeBDievlgQnJJ+VG61H+3QXeMP807bQO0jsiDQjxW991/YS+DEfrHwTIbztvNo15l4g
	j8Lf973Mz3EPPFaWAPAbYHdMorUvtVjDdIBJrw5QJPZJcaFtWA+/v7PZ8Yah1tCh3ma4KiYye41
	LpcBJtcQT34dy5RNGftrHAaiqsaY3RnwRtKtbXvbeGBlIb4G0GIxFL3NnfV9w4/7jO5gUK5x97G
	bnZkBkdlkD2bM0PujQhJYStnr/ef/bVn2SGNJn5aqvq2l1/HJqEcaBLIix/xJ1jkBuVXBnckafs
	TgOfW5rf3dDOhjyS3/tOz6O1SpvxaFP+AXtV8jAOu6lIUeoSJEBLVemxY1NNUMnil7ZJgpl6v6e
	G9Iw5EsMVqhx62eJhenab24i8WNGZQgcB7n1fY8GuVkPA04h8k12t3hL+hGvNMb0sCFdNTg3pYi
	siLfys0m1VoSZOMwiDwXb5Q2ZZZ3/Mrx86Z9rdMJK928m5IXw=
X-Received: by 2002:aa7:88ca:0:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-82f8c976ff1mr18659748b3a.46.1776773809369;
        Tue, 21 Apr 2026 05:16:49 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm16371071b3a.54.2026.04.21.05.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/4] mm/zswap: defer zs_free() in zswap_invalidate() path
Date: Tue, 21 Apr 2026 20:16:16 +0800
Message-Id: <20260421121616.3298845-5-haowenchao@xiaomi.com>
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

zswap_invalidate() is called on the same process exit path as
zram_slot_free_notify(). The zswap_entry_free() it calls internally
performs zs_free() which is expensive due to zsmalloc internal locking.
Unlike zram which has a trylock fallback, zswap_invalidate() executes
unconditionally, making the latency impact potentially worse.

Like zram, the expensive zs_free() here blocks the process exit path,
delaying overall memory release. Additionally, zswap_entry_free()
performs extra work beyond zs_free(): list_lru_del() (takes its own
spinlock), obj_cgroup accounting, and kmem_cache_free for the entry
itself.

Use zs_free_deferred() in zswap_invalidate() path to defer the
expensive zsmalloc handle freeing to a workqueue, allowing the exit
path to release memory faster. All other callers (zswap_load,
zswap_writeback_entry, zswap_store error paths) run in process context
and continue to use synchronous zs_free().

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 mm/zswap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0823cadd02b6..7291f6deb5b6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -713,11 +713,16 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 /*
  * Carries out the common pattern of freeing an entry's zsmalloc allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
+ * When @deferred is true, the zsmalloc handle is queued for async freeing
+ * instead of being freed immediately.
  */
-static void zswap_entry_free(struct zswap_entry *entry)
+static void __zswap_entry_free(struct zswap_entry *entry, bool deferred)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	if (deferred)
+		zs_free_deferred(entry->pool->zs_pool, entry->handle);
+	else
+		zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -729,6 +734,11 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	atomic_long_dec(&zswap_stored_pages);
 }
 
+static void zswap_entry_free(struct zswap_entry *entry)
+{
+	__zswap_entry_free(entry, false);
+}
+
 /*********************************
 * compressed storage functions
 **********************************/
@@ -1655,7 +1665,7 @@ void zswap_invalidate(swp_entry_t swp)
 
 	entry = xa_erase(tree, offset);
 	if (entry)
-		zswap_entry_free(entry);
+		__zswap_entry_free(entry, true);
 }
 
 int zswap_swapon(int type, unsigned long nr_pages)
-- 
2.34.1


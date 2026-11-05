Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854096;
	b=xIh/uFoUcu/O5qAvC8B6bgeIK9/+3tBDGWZ/BuEuf7QwYltXdkixG8lIFTtMCfTCPFVi
	 OaHVTacregEYD5A4p83YRpEFou5p+p0kMtkA4XvzXTviZ2lhN9ygI5GnGva+kPig9Gl7X
	 B8At4V5DM6TacvlXRgDBp7Sj/om619f0e3qIEddoFQDVzofzCQR/3jVLEiUaIoH6cxZRK
	 BYihxoz+Z/eicxDamhxxolCYmasXNWVv0FDmnGJ0mu7wA6YHC9oed8aJNQaBZaObzUuvK
	 1MDp+qAluiyylqPuYDnh3fv2foJxmG4vx3hjlvD5iGtvUVbLS/4EX6WdGO2pmMjLNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MPPjTKlf1KE39a7c47Z0O+dylLY3ZRlAYaAs3S22poM=;
	b=zRXYvXixn5t+4OBBzUcF4m3XgEFvxFwck9D6K7joeHcL0KEtxKP7WldNiFeGEytkRnu4
	 2ixf8sVqVcgC5PT2tPMpoG8wd9NQggMIGX1gizwTz0X9JrjYwdk16O3yHJ4YLhxy2pBzG
	 S6i2Sa1w8N3TiegrthOzkCbdLXPPhERBDDErfeUuY1asNseMxgSCVsg4G2mCw2dzTRodd
	 bOMKlAi+EUGI+4w8uX6liTKUe0s3l1B05c2Ecs5MegfZ1r/4/jXVIxz/cqFjjxFzuNBHo
	 RfeE/bhmypStfWGd7ihBjZh62vvStKV6cs7plJEys4J4L3kkRwyYWtEvZYHv6AgJqTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dMiKIhwl;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5F606A32E
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B5F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dMiKIhwl
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3820170eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854094; x=1794458894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPPjTKlf1KE39a7c47Z0O+dylLY3ZRlAYaAs3S22poM=;
        b=dMiKIhwlj6iroYWN3S4bOcvnoecgCmrJjBVm0nCxOVM8sG2yrmxA7p/7YmH2WKy93z
         RayJNzCZfCyM+QBE/POH4a8346vP4bftAuyHrw2B0rW9ZJHTPDcBQDV03G5cCCZLjtL9
         HwsKIBTicibpws0kIBqGMHe5qHtKWNJg3jy34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854094; x=1794458894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MPPjTKlf1KE39a7c47Z0O+dylLY3ZRlAYaAs3S22poM=;
        b=MzoVQ/LsIP8h1ArmKao/awp/i0HkTFemQjw7M8uCZVSwY1I4qTtRMyqxEAiUZqj7NQ
         XtOh+YOI/0vKwvsfZC6RF7t60HQoXVh0D3yBnDCA6mTQw72uGcJE/MAJjSlhhg9nsifI
         g2BMOtAGRFfyvOR4bHoUmW6nRlcDnCwiHVrkL9/PLGjrHFCLlTbCVXN6O837PJtH4yWs
         C1v2PQ88t2WLZQQqbU+z+eEdY3EEIsW7GIoa2CGsRONvNh9dqenZPK9uxX1Dmw3FYwqc
         cXngh/x285KQ0JxzTpXwd1lhwZoRySS7qfbmblIG6XEFkMt77fSoh96HPLv9dm/Kf8zb
         XWwA==
X-Forwarded-Encrypted: i=1; AKwUvBxjvGGhlP1QqjNgyuM4PvcpQ6dkreRrNhWhC7eJPql95hmCzRHJV0uqyzOsovjS8mWVbtynTVLrsTw5Og==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6dGD4jPW6Wq8CQZBDLC2aYpOoytw0uSDhIwigmGp5ZnWiYhM8
	vSryoq74UFyZOuq+8wdNtf8y3mANaikYw8KqxniY5dbPUO0uG5Z/rBeI1qM61bIOzA==
X-Gm-Gg: AYBFou13v7M5ei1uffGTe8iEE8X477RPPRkFSYovMNzayvSZL+l3QEpZ+cmd4EuF4ow
	f3oKgCB9D1g8XDAMZMa9xN+oEMD4BUQnPeE67M84K7JYq4HUHLtfoYg63VF49usLH1XXxBYIrc/
	aednDzlYLWusYVl6JHZ4xcwgU5mngb+PlQuf8EUfJOovbYDrw10KZ5jSBBoWBrJHh4oEfbmWZmk
	1N+Jhkqwtqv7TbIg1czTjFou/bIRFaMRMCJ5zu1HTcCpWVVvPmiUu+U4ebILED2qIwgalMgVRvi
	oLWKqALwxMHclPc1GqZmkmD7U7OzZsOePtMsrbxN3OXJujQv5b3b/o/8OxF09b3q8pN4zFgGFCK
	7fpi7pa9Dr43k6cqGO//DFXuLIxl/xtyCg7XPqI6FwnVhVzCW8YFUmh28ggEAyZbUEfzLnrM/lt
	6u6VbbTU1MasQAGXYs0Zo3HwWeJcGcQGULYGynDb7z/tbreVyw04hxXELQRvdV2lRhDXEhQN5uG
	gTtt47kuoDceFzJLm/RkN7spQGeKsj3eBZeSFeVpm1gaqQhd2B3mmlI2xn2xtMMyU2s/CEfA/mh
	MQZ8jm7h42UY5fE3uRr8rSl18QpXX+8kp+xBgh5MdZ0U3/PZ8MuHbzjEpxAH1l+O6A8ht1BV9Lz
	tPuYTQpi7ODDPsWD1sA==
X-Received: by 2002:a05:7022:ea46:20b0:143:5266:48ee with SMTP id a92af1059eb24-1ac5ecb4ad3mr29694277c88.42.1793854094168;
        Wed, 04 Nov 2026 20:48:14 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:13 -0800 (PST)
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
Subject: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and zswap entries
Date: Thu,  5 Nov 2026 13:47:35 +0900
Message-ID: <20261105044752.1997895-6-senozhatsky@chromium.org>
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

zsmalloc allocates an object from handle_cachep for every stored
object, just to have a stable address which compaction and page
migration can update when the object moves.  Both zram and zswap
already have per-entry structures that hold the handle, so we basically
keep a pointer to a pointer, which costs 8 bytes per stored object,
slab alloc/free on every store and free, and one more memory load on
every access.

Make struct zs_handle public and embed it into zram_table_entry and
zswap_entry (their sizes don't change), so that zsmalloc writes object
location directly there, and remove handle_cachep.  zs_malloc() now
takes a handle pointer and returns an error code, zs_free() resets the
handle.

Since compaction and migration update the handle in place, it must not
be on the stack (zs_malloc() warns about that) and must not be copied.
zram recompression allocates a new object before it frees the old one,
so it uses zram->recomp_handle, protected by ->dev_lock, and
zs_rebind_handle() moves the new object to the slot handle. zram
recompression is the only user of zs_rebind_handle().

This saves 8 bytes per stored page, e.g. 2MB per 1GB of swapped out
4K pages.  Since handle is per-entry the memory savings scale.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/mm/slab.rst |   2 +-
 Documentation/mm/zsmalloc.rst         |   4 +-
 drivers/block/zram/Kconfig            |   1 +
 drivers/block/zram/zram_drv.c         |  74 ++++++++---------
 drivers/block/zram/zram_drv.h         |   6 +-
 include/linux/zsmalloc.h              |  30 ++++++-
 mm/Kconfig                            |   3 +
 mm/zsmalloc.c                         | 110 ++++++++++++++++----------
 mm/zswap.c                            |  22 +++---
 9 files changed, 154 insertions(+), 98 deletions(-)

diff --git a/Documentation/admin-guide/mm/slab.rst b/Documentation/admin-guide/mm/slab.rst
index 14429ab90611..57e4a118a391 100644
--- a/Documentation/admin-guide/mm/slab.rst
+++ b/Documentation/admin-guide/mm/slab.rst
@@ -96,7 +96,7 @@ except some that are deemed too performance critical and don't need to be
 debugged by specifying global debug options followed by a list of slab names
 with "-" as options::
 
-	slab_debug=FZ;-,zs_handle,zspage
+	slab_debug=FZ;-,zspage
 
 The state of each debug option for a slab can be found in the respective files
 under::
diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index d2bbecd78e14..dbb5c1a8dcc3 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -23,8 +23,8 @@ uncompressed form). For allocation requests larger than this size, failure
 is returned (see zs_malloc).
 
 Additionally, zs_malloc() does not return a dereferenceable pointer.
-Instead, it returns an opaque handle (unsigned long) which encodes actual
-location of the allocated object. The reason for this indirection is that
+Instead, it stores the encoded location of the allocated object in the
+provided ``struct zs_handle``. The reason for this indirection is that
 zsmalloc does not keep zspages permanently mapped since that would cause
 issues on 32-bit systems where the VA region for kernel space mappings
 is very small. So, using the allocated memory should be done through the
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 402b7b175863..18da3a0333f4 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -140,6 +140,7 @@ config ZRAM_MEMORY_TRACKING
 config ZRAM_MULTI_COMP
 	bool "Enable multiple compression streams"
 	depends on ZRAM
+	select ZSMALLOC_REBIND_HANDLE
 	help
 	  This will enable multi-compression streams, so that ZRAM can
 	  re-compress pages using a potentially slower but more effective
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e2710ce35b1f..7c80db51b29a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -951,7 +951,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	if (test_slot_flag(zram, index, ZRAM_HUGE))
 		atomic64_dec(&zram->stats.huge_pages);
 	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
-	zs_free(zram->mem_pool, zram->table[index].handle);
+	zs_free(zram->mem_pool, &zram->table[index].handle);
 	zram->table[index].blk_idx = req->blk_idx;
 	set_slot_flag(zram, index, ZRAM_WB);
 
@@ -2067,8 +2067,8 @@ static void slot_free(struct zram *zram, unsigned long index)
 		goto out;
 	}
 
-	handle = zram->table[index].handle;
-	if (!handle)
+	handle = &zram->table[index].handle;
+	if (!zs_handle_is_allocated(handle))
 		return;
 
 	zs_free(zram->mem_pool, handle);
@@ -2099,7 +2099,7 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 	struct zs_handle *handle;
 	void *src, *dst;
 
-	handle = zram->table[index].handle;
+	handle = &zram->table[index].handle;
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, PAGE_SIZE);
 	/* an incompressible object never spans two pages */
 	src = kmap_local_page(sg_page(sg));
@@ -2123,7 +2123,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	void *dst;
 	int ret, prio;
 
-	handle = zram->table[index].handle;
+	handle = &zram->table[index].handle;
 	size = get_slot_size(zram, index);
 	prio = get_slot_comp_priority(zram, index);
 
@@ -2150,7 +2150,7 @@ static int read_from_zspool_raw(struct zram *zram, struct page *page,
 	unsigned int size;
 	void *dst;
 
-	handle = zram->table[index].handle;
+	handle = &zram->table[index].handle;
 	size = get_slot_size(zram, index);
 
 	/*
@@ -2177,7 +2177,7 @@ static int read_from_zspool(struct zram *zram, struct page *page,
 			    unsigned long index)
 {
 	if (test_slot_flag(zram, index, ZRAM_SAME) ||
-	    !zram->table[index].handle)
+	    !zs_handle_is_allocated(&zram->table[index].handle))
 		return read_same_filled_page(zram, page, index);
 
 	if (!test_slot_flag(zram, index, ZRAM_HUGE))
@@ -2257,31 +2257,31 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 static int write_incompressible_page(struct zram *zram, struct page *page,
 				     unsigned long index)
 {
-	struct zs_handle *handle;
 	void *src;
+	int ret;
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
-	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
-			   GFP_NOIO | __GFP_NOWARN |
-			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR(handle)) {
+	ret = zs_malloc(zram->mem_pool, &zram->table[index].handle, PAGE_SIZE,
+			GFP_NOIO | __GFP_NOWARN |
+			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	if (ret) {
 		slot_unlock(zram, index);
-		return PTR_ERR(handle);
+		return ret;
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zs_free(zram->mem_pool, handle);
+		zs_free(zram->mem_pool, &zram->table[index].handle);
 		slot_unlock(zram, index);
 		return -ENOMEM;
 	}
 
 	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
+	zs_obj_write(zram->mem_pool, &zram->table[index].handle, src,
+		     PAGE_SIZE);
 	kunmap_local(src);
 
 	set_slot_flag(zram, index, ZRAM_HUGE);
-	zram->table[index].handle = handle;
 	set_slot_size(zram, index, PAGE_SIZE);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2298,7 +2298,6 @@ static int zram_write_page(struct zram *zram, struct page *page,
 			   unsigned long index)
 {
 	int ret = 0;
-	struct zs_handle *handle;
 	unsigned int comp_len;
 	void *mem;
 	struct zcomp_cstrm *zstrm;
@@ -2330,26 +2329,26 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
-	handle = zs_malloc(zram->mem_pool, comp_len,
-			   GFP_NOIO | __GFP_NOWARN |
-			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR(handle)) {
+	ret = zs_malloc(zram->mem_pool, &zram->table[index].handle, comp_len,
+			GFP_NOIO | __GFP_NOWARN |
+			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	if (ret) {
 		zcomp_cstrm_put(zstrm);
 		slot_unlock(zram, index);
-		return PTR_ERR(handle);
+		return ret;
 	}
 
 	if (!zram_can_store_page(zram)) {
 		zcomp_cstrm_put(zstrm);
-		zs_free(zram->mem_pool, handle);
+		zs_free(zram->mem_pool, &zram->table[index].handle);
 		slot_unlock(zram, index);
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
+	zs_obj_write(zram->mem_pool, &zram->table[index].handle, zstrm->buffer,
+		     comp_len);
 	zcomp_cstrm_put(zstrm);
 
-	zram->table[index].handle = handle;
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2456,8 +2455,6 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			   u32 threshold, u32 prio)
 {
 	struct zcomp_cstrm *zstrm = NULL;
-	struct zs_handle *handle_old;
-	struct zs_handle *handle_new;
 	unsigned int comp_len_old;
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
@@ -2465,8 +2462,9 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	void *src;
 	int ret = 0;
 
-	handle_old = zram->table[index].handle;
-	if (!handle_old)
+	lockdep_assert_held_write(&zram->dev_lock);
+
+	if (!zs_handle_is_allocated(&zram->table[index].handle))
 		return -EINVAL;
 
 	comp_len_old = get_slot_size(zram, index);
@@ -2535,20 +2533,22 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	 * modify zsmalloc API to return this information. For now, we will
 	 * make do with the node of the page allocated for recompression.
 	 */
-	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
-			       GFP_NOIO | __GFP_NOWARN |
-			       __GFP_HIGHMEM | __GFP_MOVABLE,
-			       page_to_nid(page));
-	if (IS_ERR(handle_new)) {
+	ret = zs_malloc(zram->mem_pool, &zram->recomp_handle, comp_len_new,
+			GFP_NOIO | __GFP_NOWARN |
+			__GFP_HIGHMEM | __GFP_MOVABLE,
+			page_to_nid(page));
+	if (ret) {
 		zcomp_cstrm_put(zstrm);
-		return PTR_ERR(handle_new);
+		return ret;
 	}
 
-	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
+	zs_obj_write(zram->mem_pool, &zram->recomp_handle, zstrm->buffer,
+		     comp_len_new);
 	zcomp_cstrm_put(zstrm);
 
 	slot_free(zram, index);
-	zram->table[index].handle = handle_new;
+	zs_rebind_handle(zram->mem_pool, &zram->table[index].handle,
+			 &zram->recomp_handle);
 	set_slot_size(zram, index, comp_len_new);
 	set_slot_comp_priority(zram, index, prio);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 5b211a9f314c..d64c99b74214 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -79,7 +79,7 @@ enum zram_pageflags {
  */
 struct zram_table_entry {
 	union {
-		struct zs_handle *handle;
+		struct zs_handle handle;
 		unsigned long element;
 		unsigned long blk_idx;
 	};
@@ -159,6 +159,10 @@ struct zram {
 	unsigned long bitmap_cursor;
 	unsigned long nr_pages;
 #endif
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	/* Pseudo slot for recompression, protected by ->dev_lock */
+	struct zs_handle recomp_handle;
+#endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
 #endif
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 693c9484b638..6c76fd10344e 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -14,6 +14,7 @@
 #ifndef _ZS_MALLOC_H_
 #define _ZS_MALLOC_H_
 
+#include <linux/compiler.h>
 #include <linux/types.h>
 
 struct zs_pool_stats {
@@ -21,16 +22,39 @@ struct zs_pool_stats {
 	atomic_long_t pages_compacted;
 };
 
+/*
+ * zsmalloc writes object location into the handle and updates it when
+ * the object moves (compaction, page migration), so the handle must not
+ * be on the stack and must not be copied.  Use zs_rebind_handle() to
+ * move an object to another handle.
+ */
+struct zs_handle {
+	unsigned long __private obj;
+} __aligned(sizeof(unsigned long));
+
+static inline void zs_handle_init(struct zs_handle *handle)
+{
+	ACCESS_PRIVATE(handle, obj) = 0;
+}
+
+static inline bool zs_handle_is_allocated(const struct zs_handle *handle)
+{
+	return READ_ONCE(ACCESS_PRIVATE(handle, obj)) != 0;
+}
+
 struct zs_pool;
-struct zs_handle;
 struct scatterlist;
 
 struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
-struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
-			    const int nid);
+int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
+	      gfp_t flags, const int nid);
 void zs_free(struct zs_pool *pool, struct zs_handle *handle);
+#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
+void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
+		      struct zs_handle *src);
+#endif
 
 size_t zs_huge_class_size(struct zs_pool *pool);
 
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..2525fc40f2de 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -125,6 +125,9 @@ config ZSWAP_COMPRESSOR_DEFAULT
 config ZSMALLOC
 	tristate
 
+config ZSMALLOC_REBIND_HANDLE
+	bool
+
 menu "Zsmalloc allocator options"
 	depends on ZSMALLOC
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d8aab56f5cd..71e6dcb1fb3f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/errno.h>
 #include <linux/highmem.h>
 #include <linux/string.h>
@@ -264,11 +265,6 @@ struct link_free {
 	};
 };
 
-struct zs_handle {
-	unsigned long __private obj;
-};
-
-static struct kmem_cache *handle_cachep;
 static struct kmem_cache *zspage_cachep;
 
 struct zs_pool {
@@ -442,18 +438,6 @@ static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 #endif
 
-static struct zs_handle *cache_alloc_handle(gfp_t gfp)
-{
-	gfp = gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE);
-
-	return kmem_cache_alloc(handle_cachep, gfp);
-}
-
-static void cache_free_handle(struct zs_handle *handle)
-{
-	kmem_cache_free(handle_cachep, handle);
-}
-
 static struct zspage *cache_alloc_zspage(gfp_t gfp)
 {
 	gfp = gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE);
@@ -1302,31 +1286,31 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 /**
  * zs_malloc - Allocate block of given size from pool.
  * @pool: pool to allocate from
+ * @handle: handle to store allocated object in (must not be on the stack)
  * @size: size of block to allocate
  * @gfp: gfp flags when allocating object
  * @nid: The preferred node id to allocate new zspage (if needed)
  *
- * On success, handle to the allocated object is returned,
- * otherwise an ERR_PTR().
  * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
-struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
-			    const int nid)
+int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
+	      gfp_t gfp, const int nid)
 {
-	struct zs_handle *handle;
 	struct size_class *class;
 	int newfg;
 	struct zspage *zspage;
 
+	if (WARN_ON_ONCE(object_is_on_stack(handle) ||
+			 zs_handle_is_allocated(handle)))
+		return -EINVAL;
+
 	if (unlikely(!size))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
-		return ERR_PTR(-ENOSPC);
-
-	handle = cache_alloc_handle(gfp);
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
+		return -ENOSPC;
 
 	class = lookup_size_class(pool, size);
 
@@ -1345,10 +1329,8 @@ struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 	spin_unlock(&class->lock);
 
 	zspage = alloc_zspage(pool, class, gfp, nid);
-	if (!zspage) {
-		cache_free_handle(handle);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!zspage)
+		return -ENOMEM;
 
 	spin_lock(&class->lock);
 	obj_malloc(pool, zspage, handle);
@@ -1363,7 +1345,7 @@ struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 out:
 	spin_unlock(&class->lock);
 
-	return handle;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
 
@@ -1464,13 +1446,14 @@ void zs_free(struct zs_pool *pool, struct zs_handle *handle)
 	int fullness;
 	struct zspage *zspage_to_free = NULL;
 
-	if (IS_ERR_OR_NULL(handle))
+	if (!zs_handle_is_allocated(handle))
 		return;
 
 	obj_class_get_and_lock(pool, handle, &obj, &zspage, &class);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
+	record_obj(handle, 0);
 
 	fullness = fix_fullness_group(class, zspage);
 	if (fullness == ZS_INUSE_RATIO_0) {
@@ -1490,10 +1473,59 @@ void zs_free(struct zs_pool *pool, struct zs_handle *handle)
 		__free_zspage_lockless(zspage_to_free);
 		atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
 	}
-	cache_free_handle(handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
 
+#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
+/**
+ * zs_rebind_handle() - Rebind an allocated object to a new handle.
+ * @pool: pool the object belongs to
+ * @dst: unallocated destination handle (must not be on the stack)
+ * @src: source handle that currently owns the object
+ *
+ * Rebinds the object from @src to @dst, updating the object header so
+ * compaction and page migration update @dst instead of @src, and resets
+ * @src.
+ */
+void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
+		      struct zs_handle *src)
+{
+	struct size_class *class;
+	struct zspage *zspage;
+	unsigned long obj;
+
+	if (WARN_ON_ONCE(object_is_on_stack(dst) ||
+			 zs_handle_is_allocated(dst) ||
+			 !zs_handle_is_allocated(src)))
+		return;
+
+	obj_class_get_and_lock(pool, src, &obj, &zspage, &class);
+
+	if (likely(!ZsHugePage(zspage))) {
+		struct zpdesc *zpdesc;
+		struct link_free *link;
+		unsigned int obj_idx;
+		unsigned long off;
+		void *vaddr;
+
+		obj_to_location(obj, &zpdesc, &obj_idx);
+		off = offset_in_page(class->size * obj_idx);
+		vaddr = kmap_local_zpdesc(zpdesc);
+		link = (struct link_free *)(vaddr + off);
+		link->handle = (unsigned long)dst | OBJ_ALLOCATED_TAG;
+		kunmap_local(vaddr);
+	} else {
+		zspage->first_zpdesc->handle =
+			(unsigned long)dst | OBJ_ALLOCATED_TAG;
+	}
+
+	record_obj(dst, obj);
+	record_obj(src, 0);
+	spin_unlock(&class->lock);
+}
+EXPORT_SYMBOL_GPL(zs_rebind_handle);
+#endif
+
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
@@ -2292,23 +2324,17 @@ EXPORT_SYMBOL_GPL(zs_destroy_pool);
 
 static void zs_destroy_caches(void)
 {
-	kmem_cache_destroy(handle_cachep);
-	handle_cachep = NULL;
 	kmem_cache_destroy(zspage_cachep);
 	zspage_cachep = NULL;
 }
 
 static int __init zs_init_caches(void)
 {
-	handle_cachep = kmem_cache_create("zs_handle", sizeof(struct zs_handle),
-					  0, 0, NULL);
 	zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
 					  0, 0, NULL);
 
-	if (!handle_cachep || !zspage_cachep) {
-		zs_destroy_caches();
+	if (!zspage_cachep)
 		return -ENOMEM;
-	}
 	return 0;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 397b06c9f33b..f28a46cae1e1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -215,7 +215,7 @@ struct zswap_entry {
 	unsigned int length;
 	bool referenced;
 	u8 pool_idx;
-	struct zs_handle *handle;
+	struct zs_handle handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -769,6 +769,7 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
+	zs_handle_init(&entry->handle);
 	return entry;
 }
 
@@ -787,7 +788,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
 
 	zswap_lru_del(entry);
 	if (!WARN_ON_ONCE(!pool)) {
-		zs_free(pool->zs_pool, entry->handle);
+		zs_free(pool->zs_pool, &entry->handle);
 		zswap_pool_put(pool);
 	}
 	if (entry->objcg) {
@@ -888,7 +889,6 @@ static bool zswap_compress(struct folio *folio, long index,
 	struct scatterlist input, output;
 	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
-	struct zs_handle *handle;
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
@@ -948,14 +948,12 @@ static bool zswap_compress(struct folio *folio, long index,
 	}
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	handle = zs_malloc(pool->zs_pool, dlen, gfp, folio_nid(folio));
-	if (IS_ERR(handle)) {
-		alloc_ret = PTR_ERR(handle);
+	alloc_ret = zs_malloc(pool->zs_pool, &entry->handle, dlen, gfp,
+			      folio_nid(folio));
+	if (alloc_ret)
 		goto unlock;
-	}
 
-	zs_obj_write(pool->zs_pool, handle, dst, dlen);
-	entry->handle = handle;
+	zs_obj_write(pool->zs_pool, &entry->handle, dst, dlen);
 	entry->length = dlen;
 
 unlock:
@@ -980,7 +978,7 @@ static bool __zswap_decompress(struct zswap_entry *entry,
 	struct scatterlist output;
 	int ret = 0, dlen;
 
-	zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->length);
+	zs_obj_read_sg_begin(pool->zs_pool, &entry->handle, input, entry->length);
 
 	/* zswap entries of length PAGE_SIZE are not compressed. */
 	if (entry->length == PAGE_SIZE) {
@@ -1002,7 +1000,7 @@ static bool __zswap_decompress(struct zswap_entry *entry,
 		dlen = req->dlen;
 	}
 
-	zs_obj_read_sg_end(pool->zs_pool, entry->handle);
+	zs_obj_read_sg_end(pool->zs_pool, &entry->handle);
 
 	if (!ret && dlen == PAGE_SIZE)
 		return true;
@@ -1575,7 +1573,7 @@ static bool zswap_store_page(struct folio *folio, long index,
 	return true;
 
 store_failed:
-	zs_free(pool->zs_pool, entry->handle);
+	zs_free(pool->zs_pool, &entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.56.0.398.g882cbad275-goog


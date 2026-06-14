Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481403C3789
	for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781451346; cv=none; b=XyEtBAcvKy2N9v8iMNpuxQgB+3tjpi6Q1XGIP83Jj4bZJrPYzh3AbWdh3SSrXobCTAN0+nwW1V6p7JFRjaUroJgjTa10tvJjbC97TSNM/tIGQjyd3ArjSAdrEf1vkdmjUwwbVbQclNJAxK4e8EOSQ2r6/CeueLShdM99QIG4qdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781451346; c=relaxed/simple;
	bh=SEmcnaThJirfirtCrJB7w7V1XHZ+ozbyyyxT7/QXp/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQb0ETiR45X4V2+l7EF7m8z/tOeSr71sIWxfzlGOLuWNlISwuy/ta24A2YAHDgDqro25MzTsovfohD/q3aX+SKoOvpe0+JGHPC6r1eyGtsZC5gr3ik5JHP74JhqG1QcVOfl1K/Go/uMuKlStAYacHPXh+nRsc86/v1rjL7xBliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxmvZiva; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxmvZiva"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13721dfd471so2712625c88.1
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781451344; x=1782056144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dL4jh6CljPK2pUBwM3XMHGdtCtJ8jAZGJrHlUx58ijU=;
        b=QxmvZivaQXvNJfi04bdGFdkOS4IJqGPNxZTLN6rbonj+oQmJGBUewvHxfM8hTuz6uf
         i+ETvr0r/fCyV1m2MficqqqUytbl4mGtxqAIcDeevltnUY2JaJFXfrjkc/f7oeIp0gxa
         cgynZlH0JZGGV/DMu2DXzbQ3buZyAa9Wi81kwA7YmTzUglMhCNDWEeXQqNN0fEFajgDW
         UMmmQMkULTAm2GRtLj//UOCVzjzNy3CVVFXf3M+T6+a9oFTqzRoLF9T6stYtGxq/MDoZ
         ihn2hNOva0q/XauRbPypHZgDCLCHGHf9nHWbv3emStEGMUoAHQEQ3+hsmpCbs9Qf7xZM
         h5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781451344; x=1782056144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dL4jh6CljPK2pUBwM3XMHGdtCtJ8jAZGJrHlUx58ijU=;
        b=W91rOhVDw/JQFOxPqho4KoGGOVvBys9fHO/aI5tFc7tIBftGXUObmZ4izPivRvb/MX
         CLSrs9Jplm9dApGHYsm/yazgWmdihAzTPcXP5/Di0099UucLXD94aQch+TY7T7WSf1Dz
         zXgTZbGACVClX4ajkeTKGvO+Uhu9GJL3X+YkwBNLXhMKwp22ASyeGMNQuaipHkErTUGw
         H4kavqaBClnvM23jk5U+WwidTnB1u/AVFb+ZJely0JkBoVGgh57hfaRcW7JK28pRMViL
         27zP/u/Nt3rRJxfXk4c7nekMnZvas7PqkSlTH0IyAHLHLjfWavifycxGxU6luddC1ASy
         qd7A==
X-Forwarded-Encrypted: i=1; AFNElJ+culr1QoWoaecR5SkXtYxCPG/uILqoqv3Hjh9CHC1f3zjcLAnJnUOrhdxG3xUH0lSSFHYzdrTwCYeezA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4JVSFBNBmxpGiPCz6va/+Hail6tLOX8Kg2uDXKItMrCAc/eZ
	9twBZHWyQPbufk51/gTcmh9ueViUhTtzP2+MWp9SX4JAKlIsX1+yRk7a
X-Gm-Gg: Acq92OHJqbqakqV4GLyqZfB7UbeWPoveKcKjTd2Acl4vQLhklHQtTo4D6jAXb717bSV
	utkM7tWPuEmuFNyd1AR1prXv8dRio3V5nLPUGIN+tlQyuBsIYLt1caMQXleEHV+vMoFnuFPzRZK
	kbtKXQchoR5OIBWl3uVcLDUaZdk3SSddnHN+hFxyC8Caf5LU1FafL34jJaX9fOWRucRs9lNCjxv
	6SPcJKo5godB0YRU61SiMgCo6TEv1ZK9a0VrE9yG/CXOrFyWcAK/Jf0JMs7OddPNCWHkokl6d1q
	mRbsafOz8wuFpGiWssNpyJ9Zw2gL2XVlT8HdB/60Y0pB6RzcHcEWySEraTkd1pUySB9h71WGz4Q
	58Jley1ZKDHTq/oy/QhRWx1wi/DW1pSeAEdPnX0MroeHR2GOPN4o3q/JkLLPtIlX15agmxdLnJL
	QtXYQ82Gm3Uph911Nslre3LH2Wo56DITfrQZQjgF1MXYzyQ4ect454RtdayJ59vAjrZUCn0mK1D
	Q==
X-Received: by 2002:a05:7022:20c:b0:137:ea00:3f3a with SMTP id a92af1059eb24-1386f3500e0mr3183171c88.9.1781451343974;
        Sun, 14 Jun 2026 08:35:43 -0700 (PDT)
Received: from NV-J4GCB44.localdomain ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm12580632eec.7.2026.06.14.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:35:43 -0700 (PDT)
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Sun, 14 Jun 2026 23:35:29 +0800
Subject: [PATCH 1/3] mm/page_io: let block drivers register custom swap I/O
 ops
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-zram-swap-ops-block-register-v1-1-6c1a6639c222@gmail.com>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
In-Reply-To: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jianyue Wu <wujianyue000@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1781451334; l=9506;
 i=wujianyue000@gmail.com; s=id_ed25519; h=from:subject:message-id;
 bh=SEmcnaThJirfirtCrJB7w7V1XHZ+ozbyyyxT7/QXp/0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgW51Zh3v9nG0Wlld2Ti8ylp1TnO7yB
 H+z9CbXty/WEAQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBq6IcYS32kGX7vwT5waqxnXTy5OSvQnIuQ76gdPnMhD+5AVEVR6uGOd9LKRdUK0aJApP4rAfNS
 kiFgFHpwNLQ0=
X-Developer-Key: i=wujianyue000@gmail.com; a=openssh;
 fpr=SHA256:gVWBPJbHGWlCIw+V8F63Ff0k21S7AB5+rZt8+huemvg

Add swap_register_block_ops() so a block driver can install custom
swap read/write handlers instead of always building bios.

When swapon targets a block device (S_ISBLK), setup_swap_extents()
checks whether that driver's block_device_operations were registered.
If yes, sis->ops points at the driver table. Otherwise sis->ops
stays on swap_bdev_ops.

Swap files are unchanged. They still use the filesystem path and
extent tree, because their page index is not a raw disk sector.

Register swap_ops in a single global slot keyed by the driver's
block_device_operations. lookup_swap_block_ops() matches sis->bdev
fops at swapon. -EBUSY if the slot is already taken. That is enough
while only zram needs custom swap I/O. Several block drivers would
need a per-fops lookup table instead.

swap_unregister_block_ops() must pass the same fops that
registered. Swap areas created before unregister keep the old ops
until swapoff. The driver module must remain loaded while they are
in use.

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
 include/linux/swap.h |  35 +++++++++++++++++
 mm/page_io.c         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap.h            |  18 +--------
 mm/swapfile.c        |   4 ++
 4 files changed, 147 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 636d94108166..1d51df4179c1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -19,6 +19,41 @@
 struct notifier_block;
 
 struct bio;
+struct block_device_operations;
+struct folio;
+struct swap_iocb;
+struct swap_info_struct;
+
+struct swap_io_ctx {
+	struct swap_iocb	*sio;
+	struct swap_info_struct	*sis;
+};
+
+/* Set when the swap backend requires GFP_NOFS allocations. */
+#define SWAP_OPS_F_NOFS		(1U << 0)
+
+/**
+ * struct swap_ops - per-swap-area I/O batching callbacks
+ * @can_merge: optional. Return true iff @folio can be appended to a ctx
+ *             that already holds @prev_folio of @prev_folio_size bytes.
+ *             When NULL, folios on the same swap area are batched until
+ *             the iocb is full or the plug is flushed.
+ * @submit_write: flush the accumulated write ctx to the backend.
+ * @submit_read: flush the accumulated read ctx to the backend.
+ */
+struct swap_ops {
+	unsigned int		flags;
+
+	bool			(*can_merge)(struct folio *folio,
+					     struct folio *prev_folio,
+					     size_t prev_folio_size, int rw);
+	void			(*submit_write)(struct swap_io_ctx *ctx);
+	void			(*submit_read)(struct swap_io_ctx *ctx);
+};
+
+int swap_register_block_ops(const struct block_device_operations *fops,
+			    const struct swap_ops *ops);
+void swap_unregister_block_ops(const struct block_device_operations *fops);
 
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
diff --git a/mm/page_io.c b/mm/page_io.c
index c020e8ebf966..3ab620860379 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -24,6 +24,8 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 #include <linux/delayacct.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
 #include <linux/zswap.h>
 #include "swap.h"
 #include "swap_table.h"
@@ -325,6 +327,8 @@ static bool swap_can_merge(struct swap_io_ctx *ctx, struct folio *folio,
 
 	if (ctx->sis != sis)
 		return false;
+	if (!sis->ops->can_merge)
+		return true;
 	return sis->ops->can_merge(folio, prev_folio, prev_folio_size, rw);
 }
 
@@ -577,6 +581,18 @@ static void swap_bio_read_end_io(struct bio *bio)
 	swap_read_end(sio, failed);
 }
 
+/**
+ * swap_bdev_submit_write - default block-device write path for swap
+ * @ctx: in-progress submit_write context.
+ *
+ * Builds a bio for the accumulated ctx and submits it through the normal
+ * block layer. This is the submit_write implementation used by swap_bdev_ops
+ * for ordinary block swap areas. swap_ops providers that override submit_write
+ * (e.g. zram) but still fall back to the block layer for some I/Os should use
+ * their own bio construction, this function is not exported.
+ *
+ * Context: process context (may sleep if SWP_SYNCHRONOUS_IO is set).
+ */
 static void swap_bdev_submit_write(struct swap_io_ctx *ctx)
 {
 	struct swap_iocb *sio = ctx->sio;
@@ -640,6 +656,96 @@ const struct swap_ops swap_bdev_ops = {
 	.can_merge		= swap_bdev_can_merge,
 };
 
+static DEFINE_MUTEX(swap_block_ops_lock);
+static const struct block_device_operations *swap_block_fops;
+static const struct swap_ops *swap_block_ops;
+
+/**
+ * swap_register_block_ops - install swap callbacks for a block driver
+ * @fops: block_device_operations identifying the driver. Used as a
+ *        match key in setup_swap_extents(): a S_ISBLK swap area is
+ *        routed to @ops when its bdev's gendisk fops equals @fops.
+ * @ops:  swap_ops vtable selected for matching swap areas. Must populate
+ *        ->submit_read and ->submit_write. ->can_merge is optional.
+ *
+ * Lets a block driver (zram and similar) replace the default
+ * swap_bdev_ops with its own submit_read / submit_write implementation.
+ *
+ * Returns 0 on success, -EINVAL when @fops or @ops are bad (a required
+ * callback is missing), or -EBUSY when the single registration slot is
+ * already taken. That slot is enough while only zram needs custom swap I/O.
+ * Several block drivers would need a per-fops lookup table instead.
+ *
+ * Context: process context, may sleep.
+ */
+int swap_register_block_ops(const struct block_device_operations *fops,
+			    const struct swap_ops *ops)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(!fops || !ops || !ops->submit_read ||
+			 !ops->submit_write))
+		return -EINVAL;
+
+	mutex_lock(&swap_block_ops_lock);
+	if (swap_block_fops || swap_block_ops) {
+		ret = -EBUSY;
+		goto out;
+	}
+	swap_block_fops = fops;
+	swap_block_ops = ops;
+	ret = 0;
+out:
+	mutex_unlock(&swap_block_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(swap_register_block_ops);
+
+/**
+ * swap_unregister_block_ops - undo swap_register_block_ops()
+ * @fops: same block_device_operations passed to swap_register_block_ops().
+ *
+ * Clears the registered fops/ops slot so future swapon calls fall back
+ * to swap_bdev_ops. The @fops match acts as a soft owner check so a
+ * driver cannot accidentally tear down another driver's registration.
+ * A mismatch is treated as a bug and triggers WARN_ON_ONCE. Swap areas
+ * that already captured the registered ops keep their sis->ops pointer.
+ * The caller must ensure the module owning the ops outlives any such
+ * swap area. For block drivers this is guaranteed by the bdev open
+ * reference held across swapon.
+ * Calling unregister before a successful register is a no-op.
+ *
+ * Context: process context, may sleep.
+ */
+void swap_unregister_block_ops(const struct block_device_operations *fops)
+{
+	mutex_lock(&swap_block_ops_lock);
+	/* never registered or already unregistered. */
+	if (!swap_block_fops)
+		goto out;
+	if (WARN_ON_ONCE(swap_block_fops != fops))
+		goto out;
+	swap_block_fops = NULL;
+	swap_block_ops = NULL;
+out:
+	mutex_unlock(&swap_block_ops_lock);
+}
+EXPORT_SYMBOL_GPL(swap_unregister_block_ops);
+
+const struct swap_ops *lookup_swap_block_ops(struct swap_info_struct *sis)
+{
+	const struct swap_ops *ops = NULL;
+
+	if (!sis->bdev)
+		return NULL;
+
+	mutex_lock(&swap_block_ops_lock);
+	if (swap_block_fops && sis->bdev->bd_disk->fops == swap_block_fops)
+		ops = swap_block_ops;
+	mutex_unlock(&swap_block_ops_lock);
+	return ops;
+}
+
 static void swap_fs_submit(struct swap_io_ctx *ctx, int rw)
 {
 	struct swap_iocb *sio = ctx->sio;
diff --git a/mm/swap.h b/mm/swap.h
index edb512e619ee..4bdd38f7a5e8 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h> /* for atomic_long_t */
 #include <linux/mm.h> /* for PAGE_SHIFT */
+#include <linux/swap.h>
 
 struct mempolicy;
 struct swap_iocb;
@@ -79,22 +80,6 @@ enum swap_cluster_flags {
 	CLUSTER_FLAG_MAX,
 };
 
-struct swap_io_ctx {
-	struct swap_iocb	*sio;
-	struct swap_info_struct	*sis;
-};
-
-#define SWAP_OPS_F_NOFS		(1U << 0)
-
-struct swap_ops {
-	unsigned int		flags;
-
-	bool (*can_merge)(struct folio *folio, struct folio *prev_folio,
-			size_t prev_folio_size, int rw);
-	void (*submit_write)(struct swap_io_ctx *ctx);
-	void (*submit_read)(struct swap_io_ctx *ctx);
-};
-
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
@@ -472,6 +457,7 @@ static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 #endif /* CONFIG_SWAP */
 
 extern const struct swap_ops swap_bdev_ops;
+const struct swap_ops *lookup_swap_block_ops(struct swap_info_struct *sis);
 
 int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		struct list_head *folio_list);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 284eebc40a70..ebdc96092961 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2849,6 +2849,10 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 	sis->ops = &swap_bdev_ops;
 
 	if (S_ISBLK(inode->i_mode)) {
+		const struct swap_ops *block_ops = lookup_swap_block_ops(sis);
+
+		if (block_ops)
+			sis->ops = block_ops;
 		ret = add_swap_extent(sis, 0, sis->max, 0);
 		*span = sis->pages;
 		return ret;

-- 
2.43.0


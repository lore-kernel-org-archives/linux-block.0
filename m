Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D63074AD
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112152; cv=none; b=nsUvWV7dM/iHKO8+ykB+hmDtVOCCSYxoPs6w9OlBniAP1GkeMTeR506AahEEMT7PmyRyXTlqeWhYa62kQrnH7liUtLukRQ4ZSOwNuO3ycWnR2LOVqRdnPxDKpf3dSYGmzmdEwWkb03SSXvi3n0bF0Jo9MyRI20vRuxxcBqg6jFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112152; c=relaxed/simple;
	bh=UIab7wtwL7MJOqUh9OsFCLgRkvtJ87T6L6S86OEG8/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IR77KP5gq81fsiFCY8+XS0wRTpINniQmy6/TTa8rNE31X0AakcJtEkqvYnze8Ehhm6s9SfdXXqt92XEVF/ir5zQKhCmi7QvYuH75xHWKKGd6CHxoDsCK2/2BQNkj1EyWk1AORxcMl02gzkydgsFEd8UjaEyK1fV8/qNyAqHdkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h6fojIGy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h6fojIGy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2958db8ae4fso17395715ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112150; x=1763716950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=h6fojIGym1MMNKbJRIEDjGtNAPDQ2j1OghWgSnZEzYaWtO4DGTWcizz33YWHJQoDA6
         mH2mNbY1SEWYykiLBC/8l1JW9NVbY6uca56/EnWLhVjSvXjNXZ/EK54PjSIG78+v7uN6
         rA/IQPg6xou2bxRZzeHsxdd6UePdam1uPREkOGjPQ1MVT8DOMBD2b7WHYgGzUESpghQB
         4ASIxx6kPC3ovxKFie51S/IMGRjismQY/aJAx7QWSQfKkR6CuCK15wbnD9mUijpBnlLs
         kw5vdS3MFxBWGw3wyL3kajwzX9zYWUYwZKaxRYT2tRcX/OLlelxp1Au8hjAbrUGmT2i4
         1nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112150; x=1763716950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=pLRnWtYoFeVyp6nzqgqRlV8nuLI/ONVyIBraRwYQjSSvv8//8pSjzHrUf/qs4MfuMO
         ix1KrEIIVO8bV4A7Jxm8FIj7lImoPr+qNCUDEpPWGh0wuU8hpIpzDoG72dmM2CQWj7Q5
         sujPYyu2coX4QAw+XcnFcyzaGupYi5YEQBLMf9/t6y3eEwG8FPWqu+SLqioVvw6+6Gxf
         YuUs4bDcdoBmehbzcsPNmKu63T5X1dMJjHux8dNIbySz1r+boPrB9EoP+31Zv1MNNa6a
         Bh1rlHyGxStAu7+hALxzhfYmkZ+/a1LLm0Y7KDkbS2XDAk6gDpdk8FkU36nTE6SyrL/h
         i5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRgHqXVGxXuUxHEAHgrZAfK6DxiZFvPD5baAN3osZhPL88sjqDnqnQzEx6ToZcdklIxbyBj/eMGVzw4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lhkTk8BYmN+eQ0sKQjBXoJ5O7Ga3mjPM4y87PljQJeTDK2Ty
	r6mw2HXIicym5Ul0MYaa+ycEK7ogcYMpJnibBusbM9SbCPChFwC83//9yOw5V0DPZPg=
X-Gm-Gg: ASbGncvRcc+Yaxqh/eyTI/0Gw83sxBuyWK7OiQ5QwBTVDLxuaPnV9daJHcSI0ARNY8g
	stgdW6zqZbzpxvbb2YIeK2bpTXDmhwVemLuw/DOhznoCuLD5l5+pKo7WZPG111+gn+00EjwpX5r
	9I8E3tgidABXaqHmWLThliq4BwS5wIS5TY+TkLmoB4lNRhSmKjFhvZNYb/Y9MPvdTc0/NxndVPV
	XGDnL+lairnY4/sKbC0C+Mpesis46mdH7SaHsvj5UTCgpRV557BN0afUqLAliuTQuE6U+lySYlE
	RANbbQUBdkSh7HR24d9secv9Svivh9QM+ELTVDLl9rz5uO8f3d9lttGFdPAO8pkGTM3VpAXELtF
	6tHwf3g1rrtWIbadST/ioggjpTeONKQz+sGhxtBOpIlcNIPnp1/OGpUP1ffjsPXv/HAygL076MO
	W4exhhXja0duIrSJWB1bcD/p0F7A5mISx/uw==
X-Google-Smtp-Source: AGHT+IE5EpOKhzEVc2rBcafP7dwFxgYiV1vDTAUPbL2qqYMIRb4HDnxBwlI0YiLG3+RKWslwz123UA==
X-Received: by 2002:a17:903:380b:b0:297:dd7f:f1e0 with SMTP id d9443c01a7336-2986a751eb6mr23592765ad.43.1763112149863;
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 2/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:49 +0800
Message-Id: <20251114092149.40116-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for
IRQ rw"), bio_put is safe for task and irq context, bio_alloc_bioset is
safe for task context and no one calls in irq context, so we can enable
per cpu bio cache by default.

Benchmarked with t/io_uring and ext4+nvme:
taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
-X1 -n1 -P1  /mnt/testfile
base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_bioset
decrease from 1.42% to 1.22%.

The worst case is allocate bio in CPU A but free in CPU B, still use
t/io_uring and ext4+nvme:
base IOPS is 648K, patch IOPS is 647K.

Also use fio test ext4/xfs with libaio/sync/io_uring on null_blk and
nvme, no obvious performance regression.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/bio.c        | 26 ++++++++++++--------------
 block/fops.c       |  4 ----
 include/linux/fs.h |  3 ---
 io_uring/rw.c      |  1 -
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..64a1599a5930 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -516,20 +516,18 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
-	if (opf & REQ_ALLOC_CACHE) {
-		if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
-			bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
-						     gfp_mask, bs);
-			if (bio)
-				return bio;
-			/*
-			 * No cached bio available, bio returned below marked with
-			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
-			 */
-		} else {
-			opf &= ~REQ_ALLOC_CACHE;
-		}
-	}
+	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
+		opf |= REQ_ALLOC_CACHE;
+		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
+					     gfp_mask, bs);
+		if (bio)
+			return bio;
+		/*
+		 * No cached bio available, bio returned below marked with
+		 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
+		 */
+	} else
+		opf &= ~REQ_ALLOC_CACHE;
 
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77..7ef2848244b1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -184,8 +184,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
@@ -333,8 +331,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..1be899ac8b5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -365,8 +365,6 @@ struct readahead_control;
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
-/* can use bio alloc cache */
-#define IOCB_ALLOC_CACHE	(1 << 21)
 /*
  * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that the
  * iocb completion can be passed back to the owner for execution from a safe
@@ -399,7 +397,6 @@ struct readahead_control;
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
 	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 5b2241a5813c..c0c59eb358a8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -862,7 +862,6 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
 	if (unlikely(ret))
 		return ret;
-	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
 
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
-- 
2.39.5 (Apple Git-154)


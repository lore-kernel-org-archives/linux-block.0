Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B44EB5C
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kx7D6Lbb"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee9f626caso26766239f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704988952; x=1705593752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW8hJRUCyJnXXFKg+bUvndErLDbE+w7TyMXWFjFowkQ=;
        b=kx7D6LbbedZHx3TzS/bMHBBCyRkNFYlzcYcm8ta89x6E2cEMuaf4EXN4YYKWEt+9yV
         gr2UoswxNFsgWyj2hILf7+ethNqEfSqBWY4KWRRgnyezJUpBw1DC+p3YOILDrdrmDjeb
         hC+s2GFyf7FGklaUikm/G6xMSer7fYAoNbON+h2Y6NNORMayju4+V1ZJvwRvdrBGFdc+
         UQwfKRGqODdul4R4Mu0mYLbOlbdoxmtCiH0Pelp3d6/spILHv6tiXn4Jq48ALOAyyzqB
         9sREBofCtzDUjivnD8ANnXXMrdt7p/pFA/++tCeWnAacXS6rLgKyb+3ejcGnBbcrCUL7
         MvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988952; x=1705593752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW8hJRUCyJnXXFKg+bUvndErLDbE+w7TyMXWFjFowkQ=;
        b=tY6k7sf2AAoO7BKF82foOOu/oyZVNSK+e+SXupoytfSnS8OaFoTf6dE+p1KjgOdh5D
         sPFcV3RDNhJ268lj9nBwCGlqcHsIPdvaWNYmCsCrQL9XUbCuULM4fANT2wXcDSQNAd/k
         EQHlwhIL8jKD8bOAFv3LNL3+5BNkOx9F8cpUnH3YpVENuX6RBDq140/xe1osfX2ezckp
         zF/bn+a1CaxNFKH98oWcXSH88w0kH+qheT/wgOCpfZImIvNqBTO/A3j4oTYY/cwW5t7E
         wNddDViXz5mqDFmocsUhw64VEzWTaGvNE/zhR8TpVioKgo+XQH4QJ3bBKsc8TKFmULdI
         4cmA==
X-Gm-Message-State: AOJu0Yw9tS595Veu9CiK3dlQ86EJ2fA42KVE5diRz+H8xkgiVi3yC01x
	SfiJXao78Wkf3GwCOT2g34lLcT1+3HiG+IVeU+nDDvTbRhQp+w==
X-Google-Smtp-Source: AGHT+IF2eEbAxbphOSVC7Vjec4w3jveKEFYOuuDnETkuc3j1nbwELGk2/ugBlpLXWJKdboPMxMAkRA==
X-Received: by 2002:a6b:f215:0:b0:7bf:f20:2c78 with SMTP id q21-20020a6bf215000000b007bf0f202c78mr1930989ioh.1.1704988952049;
        Thu, 11 Jan 2024 08:02:32 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cl15-20020a0566383d0f00b0046e564817c1sm285450jab.33.2024.01.11.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:02:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block/integrity: flag the queue if it has an integrity profile
Date: Thu, 11 Jan 2024 09:00:20 -0700
Message-ID: <20240111160226.1936351-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111160226.1936351-1-axboe@kernel.dk>
References: <20240111160226.1936351-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't set a dummy profile, if someone registers and actual
profile, flag the queue as such.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-integrity.c  | 14 +++++++++-----
 include/linux/blkdev.h |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index a1ea1794c7c8..974af93de2da 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -339,22 +339,25 @@ const struct attribute_group blk_integrity_attr_group = {
  */
 void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
 {
-	struct blk_integrity *bi = &disk->queue->integrity;
+	struct request_queue *q = disk->queue;
+	struct blk_integrity *bi = &q->integrity;
 
 	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
 		template->flags;
 	bi->interval_exp = template->interval_exp ? :
-		ilog2(queue_logical_block_size(disk->queue));
+		ilog2(queue_logical_block_size(q));
 	bi->profile = template->profile;
+	if (bi->profile)
+		blk_queue_flag_set(QUEUE_FLAG_INTG_PROFILE, q);
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
-	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
-	if (disk->queue->crypto_profile) {
+	if (q->crypto_profile) {
 		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
-		disk->queue->crypto_profile = NULL;
+		q->crypto_profile = NULL;
 	}
 #endif
 }
@@ -377,6 +380,7 @@ void blk_integrity_unregister(struct gendisk *disk)
 	/* ensure all bios are off the integrity workqueue */
 	blk_flush_integrity();
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_INTG_PROFILE, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e1e705aef51e..de81642831bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -510,6 +510,7 @@ struct request_queue {
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_INTG_PROFILE	2	/* has integrity profile */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
-- 
2.43.0


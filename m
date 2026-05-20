Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD937266C
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309419; cv=none; b=F6wwQCzSXxFgnFdWGHj5Z1b5BbkXezDnAlt3KfrJI9FmlEkaTIBQJ6B/s8mpsACKhvsQ0iACyLEu/UprfR7fIC/3wuIdkN1nxBsvgUyotwh8RJIXGkOPLByqiUsgGTCLyNen8V+9tQ4zmu2/lM0ATqO4wmua2kZTMOQF/DPWdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309419; c=relaxed/simple;
	bh=cPsNcn0TlZf32NU1M5aejBTBxy7dprvtlGYrN6i4R2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ85h6QeWmTwcOmBd+Rb9+q/eHmIRNKq6TmyQeFThrJgwbA6tJedk5eJj7c2+12TwykgbkPWuMv74/yph/bsbeAcjw0ZVo4Y82xkD3jycaf4Hyd92ZNH0ZABmUEH8Y4qIXMcP+VEhj9/TZBsZ8pBXmjMNNocdwmVxO415+1pVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RNuJYRYf; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RNuJYRYf"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2bcdc085c52so7352855ad.1
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779309417; x=1779914217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt7RhXa7eT0nefDTSbQhlC00V1Qqmnntp3uU/PunKOg=;
        b=RNuJYRYfNu2D6ohcedwOGvOzo+z5n98qma48xiKshEoEpPHOKrkl8ubeEqZ2ElDEbf
         6ztKs1uuLHXfCH3QAyoLq4kv9fIU+wUH4jV2xaQ/BF4pNucZ52i1OuuCFkHaNffPPCZf
         GJ5afoPGagl/1aSVqPZchEtAbal/UFlZHguuZT7akC6TZzJmG2GBuIcLCIqZtyEooZGC
         FJgtfOh2/swcJqCX4jFS6b8ZzU1LZLEumCthwEUoPUbZmpDWYx7a183ygx5syJg+6b9m
         GcYlnoe+DnHiomkjkt9CqA6aOIskU5WCLZVkxJ4kyiywOBQXuJPq4MMOuuiaFntOJRyv
         brDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309417; x=1779914217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mt7RhXa7eT0nefDTSbQhlC00V1Qqmnntp3uU/PunKOg=;
        b=KHYOs+K9abce4XvqCPB2PMZJdmgG7yJ4hoHOH590qwzmqaQZG7QDIPIK+wgSN6cEpA
         s9Lj6G8n/x1rCRgsGRglaVMpowoE7gkXYu6Apveey+WQgTG8wK+HVkc/9LCWbOvk8ozd
         g8uadk3GQIwHcRyBktHplcoH87dl1zgGsf8Zc34kyb5Y3wPETW4HMMwReTPw9ty2PUju
         bHS161zRr+MCAXdkdzxUG0ZLXVn4GIjI5GLb4ACG+NOARRIz0XGznGbIfetaFyC9PXRu
         oeUxc3hzkwgL1XMiHmbfHRj4j+9WI9caYKOH7wB61l/6rotAsKnt3rX8f7tpYaSlMSCj
         EckA==
X-Gm-Message-State: AOJu0YwhJtsHa3k0u7LrVViLkc/2Q3byeZBwL3BfWR0J3Yoeu5z8FAG2
	IuRIbGvzJmYNVC3Gd9zz+OdJXjH/PRabRiKaL8YkIt+pxKovkSC3VQMrEb1HW2czOORrY34jWgW
	ao7R30ljkWIy9M0OL2ETcuniYxn+pCqK1fiNfpk7WvSBhu0x5Weo+
X-Gm-Gg: Acq92OFqORKIZG20gVJig5BKs8mif2bMcXMv1ZRBVr3V1kkRkJPpJv1P9UNBdW22St5
	pJsiMhu98yzTh8pjF7najZJlNbX+5i1ldU7JcakXRtdeQRX5XyeT9K2CSo2LXpwpAL7JtG/GDiU
	cqLe0nj2jes+SrtQklcihyMgW0kWi090dzFaKwcDez0tyMWiCzJOU8Sykiell9qAqzYDyMKgnZy
	RZmPcG6R1SJVE1/P/QZx8V9KfJYGlVJdiPopg6gOv2lqLSda3eGteyaeVeuvQ10bj+RV8qNydl3
	EICPaPpCY+shbV4cI35/LX9ARfS/K68S7o+rLNl7Tm2q3ajYYdr76B8+Jbei6d+yaWWP2vrdpbk
	JVMBh0s1SV/f+oSNLZTd1gts2rf6KX4/u0DykFFg=
X-Received: by 2002:a05:6a21:4688:b0:3a0:b812:3a84 with SMTP id adf61e73a8af0-3b22e652c5dmr14983266637.1.1779309416598;
        Wed, 20 May 2026 13:36:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-83f1983b319sm1531149b3a.6.2026.05.20.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:36:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n22m09-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:449])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E382634050F;
	Wed, 20 May 2026 14:36:55 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D84D8E413BB; Wed, 20 May 2026 14:36:55 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 1/2] ublk: move ublk_req_build_flags() earlier
Date: Wed, 20 May 2026 14:36:53 -0600
Message-ID: <20260520203654.1413640-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520203654.1413640-1-csander@purestorage.com>
References: <20260520203654.1413640-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ublk_req_build_flags() above its callers so it doesn't need to be
forward-declared.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 63 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4d7efc12247c..0cb29be561b5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -357,11 +357,10 @@ static bool ublk_try_buf_match(struct ublk_device *ub, struct request *rq,
 				  u32 *buf_idx, u32 *buf_off);
 static void ublk_buf_cleanup(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io);
-static inline unsigned int ublk_req_build_flags(struct request *req);
 static void ublk_batch_dispatch(struct ublk_queue *ubq,
 				const struct ublk_batch_io_data *data,
 				struct ublk_batch_fetch_cmd *fcmd);
 
 static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
@@ -469,10 +468,41 @@ static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 static inline bool ublk_dev_support_integrity(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_INTEGRITY;
 }
 
+static inline unsigned int ublk_req_build_flags(struct request *req)
+{
+	unsigned flags = 0;
+
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
+		flags |= UBLK_IO_F_FAILFAST_DEV;
+
+	if (req->cmd_flags & REQ_FAILFAST_TRANSPORT)
+		flags |= UBLK_IO_F_FAILFAST_TRANSPORT;
+
+	if (req->cmd_flags & REQ_FAILFAST_DRIVER)
+		flags |= UBLK_IO_F_FAILFAST_DRIVER;
+
+	if (req->cmd_flags & REQ_META)
+		flags |= UBLK_IO_F_META;
+
+	if (req->cmd_flags & REQ_FUA)
+		flags |= UBLK_IO_F_FUA;
+
+	if (req->cmd_flags & REQ_NOUNMAP)
+		flags |= UBLK_IO_F_NOUNMAP;
+
+	if (req->cmd_flags & REQ_SWAP)
+		flags |= UBLK_IO_F_SWAP;
+
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
+	return flags;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct ublk_zoned_report_desc {
 	__u64 sector;
 	__u32 operation;
@@ -1436,41 +1466,10 @@ static unsigned int ublk_unmap_io(bool need_map,
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-static inline unsigned int ublk_req_build_flags(struct request *req)
-{
-	unsigned flags = 0;
-
-	if (req->cmd_flags & REQ_FAILFAST_DEV)
-		flags |= UBLK_IO_F_FAILFAST_DEV;
-
-	if (req->cmd_flags & REQ_FAILFAST_TRANSPORT)
-		flags |= UBLK_IO_F_FAILFAST_TRANSPORT;
-
-	if (req->cmd_flags & REQ_FAILFAST_DRIVER)
-		flags |= UBLK_IO_F_FAILFAST_DRIVER;
-
-	if (req->cmd_flags & REQ_META)
-		flags |= UBLK_IO_F_META;
-
-	if (req->cmd_flags & REQ_FUA)
-		flags |= UBLK_IO_F_FUA;
-
-	if (req->cmd_flags & REQ_NOUNMAP)
-		flags |= UBLK_IO_F_NOUNMAP;
-
-	if (req->cmd_flags & REQ_SWAP)
-		flags |= UBLK_IO_F_SWAP;
-
-	if (blk_integrity_rq(req))
-		flags |= UBLK_IO_F_INTEGRITY;
-
-	return flags;
-}
-
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
 	u32 ublk_op;
-- 
2.54.0


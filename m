Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECF362144
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654884; cv=none; b=LaaZSBybRgLO1d6tOvhLSwPiAu6J3dOfO/ciX2WZ00zm0gAxAxcNXVr2JGXJ625k/dcd3ncre9lD8bONn2eKlD0uHYY0C4jj0kQgJv5EoZCRe9mPpN0YYubylxty7XOIZcEPImbaSD/UyrPD0+1dZ1es73DGTui4X8rT5nMYBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654884; c=relaxed/simple;
	bh=3inYvCp3hVwBKZSUhzinXLc9t8+CBnPJjpe2Nsvyaps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV9AimDlie2hKGGw2Mm1WU+6ouddJhGRfO3HO82ssnB+qnBJHVGk+Lq0v6ut61FTiAcpLu9eIGUeYl6lRsNbdujS1lnjXKE+W9H0x14gdRnvK0vCnOoYe4sAtT/2hD3IVRlkPunI+wi8dkJrqrU2UfadQRgArlIjl19xIRgAMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAXwCUY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAXwCUY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763654872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEUtSeV3+Zt9nlbWw/T6ulXGnABCUZsrbtAUeXuITb0=;
	b=bAXwCUY0oCDybelupg/gfPHlYlGs1k5j6GBemxkY02daXEPxUXcFW2exhRwmjIcUSouprD
	9eY9uRgZ354TkQcWZOSuuor/08FCRnhRDqh/z6CTXqFfnhvzJLKi6AxtN7YDGkJ19fFSIj
	q/fCv6+8SyLl0lmZTiA6iXeM300i+Gc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-udumkBL8P6y-tk3NP80NSA-1; Thu,
 20 Nov 2025 11:07:49 -0500
X-MC-Unique: udumkBL8P6y-tk3NP80NSA-1
X-Mimecast-MFC-AGG-ID: udumkBL8P6y-tk3NP80NSA_1763654868
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3E2E1801306;
	Thu, 20 Nov 2025 16:07:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18DEE30044DC;
	Thu, 20 Nov 2025 16:07:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/4] loop: fix NOWAIT io hang by introducing BD_LOWLEVEL_BIO_FIRST
Date: Fri, 21 Nov 2025 00:07:19 +0800
Message-ID: <20251120160722.3623884-4-ming.lei@redhat.com>
In-Reply-To: <20251120160722.3623884-1-ming.lei@redhat.com>
References: <20251120160722.3623884-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When loop device is configured with DIRECT_IO, NOWAIT IOs can hang
because of a deadlock scenario:

- loop IO can be throttled by rqos
- backing file IOs are always added to tail of per-task ->bio_list

When loop IO is throttled, the dependent backing file IO cannot be
handled, resulting in deadlock.

Introduce BD_LOWLEVEL_BIO_FIRST flag and apply it for loop DIRECT_IO
mode, so block layer goes through __submit_bio_noacct() in which
the low level IOs are handled first.

This ensures proper bio submission order and prevents NOWAIT IO hangs
in loop direct I/O mode.

Fixes: 0ba93a906dda ("loop: try to handle loop aio command via NOWAIT IO first")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          |  3 ++-
 drivers/block/loop.c      | 12 ++++++++++++
 include/linux/blk_types.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..3ae9eebc9fab 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -751,7 +751,8 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 			bio_list_add_head(&current->bio_list[0], bio);
 		else
 			bio_list_add(&current->bio_list[0], bio);
-	} else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
+	} else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO |
+				BD_LOWLEVEL_BIO_FIRST)) {
 		__submit_bio_noacct_mq(bio);
 	} else {
 		__submit_bio_noacct(bio);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 705373b9668d..d305622568ed 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -208,6 +208,18 @@ static inline void loop_update_dio(struct loop_device *lo)
 
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
+
+	/*
+	 * NOWAIT is applied for direct IO mode, so backing file IOs are
+	 * submitted in loop IO context. BD_LOWLEVEL_BIO_FIRST has to be
+	 * set for avoiding IO deadlock which is triggered when loop IO
+	 * and backing file IO are reordered, meanwhile loop IO is throttled
+	 * by block layer RQOS.
+	 */
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		bdev_set_flag(lo->lo_disk->part0, BD_LOWLEVEL_BIO_FIRST);
+	else
+		bdev_clear_flag(lo->lo_disk->part0, BD_LOWLEVEL_BIO_FIRST);
 }
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cbbcb9051ec3..71b96f17ca27 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -54,6 +54,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 #define BD_MAKE_IT_FAIL		(1u<<12)
 #endif
+#define BD_LOWLEVEL_BIO_FIRST	(1u<<13)
 	dev_t			bd_dev;
 	struct address_space	*bd_mapping;	/* page cache */
 
-- 
2.47.0


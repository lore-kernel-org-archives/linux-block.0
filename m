Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A791C433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD120578
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR0mpVGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfHMGQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:16:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34277 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfHMGQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 02:16:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so48881435plt.1;
        Mon, 12 Aug 2019 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB2W34FFRFhSU+6xsPtiaBhXXvBNBgq1m83tH9jQCgk=;
        b=lR0mpVGl7S5m6GiFXrWKwRq9XC7qJOtZEOUALc7cmgel+BKbdeD2iiqbSm6eSQvJMy
         nOuO40CVTkMbqWBy/vbyR1IBBGNQFVd/w+pb6qlW5FYWdsIqviQBhejEhP/0xveynMmI
         vYEX5DvPhD6WtMhiBVmS6NoNE8EpTDP2nprVIoqp1dD4M8iwW/ZIbzIrdvUnnxOlfiwW
         3X2olAWRnWo5GuLkRTzNn2959BE6SlZ5JD72dOEX0yCVy9I8Ty+6ERxWw4yJSBnqZNq2
         WH47O9SfGx1ufW3OOF+gpMj4koZoFQX2Ejw6wNAJrtnGzpt+Z5JDDBMandk4lOtnQLVE
         SzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB2W34FFRFhSU+6xsPtiaBhXXvBNBgq1m83tH9jQCgk=;
        b=BcNU7JozQCrJnYAzxRcCbP9BwJTRJm7uevM3n4f0/Jv5SZKl79TncumAPB3EY4b1H3
         8nuiA3ssuGsdqxcD/RmezF/t1lSKTBjhSrcLoqg6KDVSF64E5QYcxvJ0UOofyoMu21vQ
         PN+BUJjh9fjsEbZl7a9YLp9NEvGX1DtDkzrSYdcoFlR8H8Ymm+a9XiDZy4qppN5IQDx1
         PwIo66n4oF1f+5aR5h/s5zeDpWnyXdwH6GZtx4eW2TShRonZn5oJ5Zlr4qAXywOuIPb+
         7FfrYYxBb8XJpZueUMvUgK6OdY4N003jxXwgBhXl7ldDu7HEtFP38f5VrkLsYHObvtel
         Fzjw==
X-Gm-Message-State: APjAAAXGIiqVDD5JkPkbDCQtysKWuErrGbXdbEkLi+yZ0wh5JOWvG5Is
        LATyJzF9ZbH07hbHbo+h/Ig=
X-Google-Smtp-Source: APXvYqy02phZk28jrMxAd/3ZbPtBeJasaqaq1E4b04hPXcUojIzejAySe0BILM0w/izcaXiRSARIRg==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr37151447plb.266.1565677015327;
        Mon, 12 Aug 2019 23:16:55 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id j15sm140141434pfn.150.2019.08.12.23.16.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 23:16:54 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 3/3] xen/blkback: Use refcount_t for refcount
Date:   Tue, 13 Aug 2019 14:16:50 +0800
Message-Id: <20190813061650.5483-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Also convert pending_req::pendcnt to refcount_t.

 drivers/block/xen-blkback/blkback.c | 6 +++---
 drivers/block/xen-blkback/common.h  | 9 +++++----
 drivers/block/xen-blkback/xenbus.c  | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..b24bb0aea35f 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1098,7 +1098,7 @@ static void __end_block_io_op(struct pending_req *pending_req,
 	 * the grant references associated with 'request' and provide
 	 * the proper response on the ring.
 	 */
-	if (atomic_dec_and_test(&pending_req->pendcnt))
+	if (refcount_dec_and_test(&pending_req->pendcnt))
 		xen_blkbk_unmap_and_respond(pending_req);
 }
 
@@ -1395,7 +1395,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		bio_set_op_attrs(bio, operation, operation_flags);
 	}
 
-	atomic_set(&pending_req->pendcnt, nbio);
+	refcount_set(&pending_req->pendcnt, nbio);
 	blk_start_plug(&plug);
 
 	for (i = 0; i < nbio; i++)
@@ -1424,7 +1424,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
  fail_put_bio:
 	for (i = 0; i < nbio; i++)
 		bio_put(biolist[i]);
-	atomic_set(&pending_req->pendcnt, 1);
+	refcount_set(&pending_req->pendcnt, 1);
 	__end_block_io_op(pending_req, BLK_STS_RESOURCE);
 	msleep(1); /* back off a bit */
 	return -EIO;
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..824d64a8339b 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -35,6 +35,7 @@
 #include <linux/wait.h>
 #include <linux/io.h>
 #include <linux/rbtree.h>
+#include <linux/refcount.h>
 #include <asm/setup.h>
 #include <asm/pgalloc.h>
 #include <asm/hypervisor.h>
@@ -309,7 +310,7 @@ struct xen_blkif {
 	struct xen_vbd		vbd;
 	/* Back pointer to the backend_info. */
 	struct backend_info	*be;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	/* for barrier (drain) requests */
 	struct completion	drain_complete;
 	atomic_t		drain;
@@ -343,7 +344,7 @@ struct pending_req {
 	struct xen_blkif_ring   *ring;
 	u64			id;
 	int			nr_segs;
-	atomic_t		pendcnt;
+	refcount_t		pendcnt;
 	unsigned short		operation;
 	int			status;
 	struct list_head	free_list;
@@ -362,10 +363,10 @@ struct pending_req {
 			 (_v)->bdev->bd_part->nr_sects : \
 			  get_capacity((_v)->bdev->bd_disk))
 
-#define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
+#define xen_blkif_get(_b) (refcount_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
 	do {						\
-		if (atomic_dec_and_test(&(_b)->refcnt))	\
+		if (refcount_dec_and_test(&(_b)->refcnt))	\
 			schedule_work(&(_b)->free_work);\
 	} while (0)
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 3ac6a5d18071..ecc5f9c5bf3f 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -169,7 +169,7 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 		return ERR_PTR(-ENOMEM);
 
 	blkif->domid = domid;
-	atomic_set(&blkif->refcnt, 1);
+	refcount_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
-- 
2.20.1


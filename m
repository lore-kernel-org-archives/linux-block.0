Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2317C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B10222A1
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H4oMk2n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfBKTBC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36777 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbfBKTBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:01 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so935300itj.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZRgsZ4kd01/5hUxi2xP0/0l+SjG1tCpnsE1G+JLPfI=;
        b=H4oMk2n9Y3uwrP4JUnAI8ilC+iYkaG2D04CHxWxz5qtCzTUcHjYeufonFTjx/RKZXL
         Ww/xPSE/3bSzD0vqIYFl58ULiMQAIEvTW8mZh35LffczPc9vjaIJ+JUhxeAeiC0es19s
         kS7neX7MO+mWHwyc1URLLhH6zcyQPcRRfWcqKwqj2tW0Z3MIjnUoTBZjycauZyCwDeIF
         E3wF/FogVrprGArf/6TbbXH5KP2r1z9KZwUUxGQmArDnDH4Z7GaxmZhgPABFGCun+2Lv
         PS5q7eE41m6qCnr+y/707/g/uDnGS17aleu/izTQvO0/VERO9FWgGLc2eQ8Lk+1fIWd2
         vd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZRgsZ4kd01/5hUxi2xP0/0l+SjG1tCpnsE1G+JLPfI=;
        b=LPw6bvFidTiNgNrwOuaDeYXDx6wjaGMdMg9Hhu6Gzmg4QXpBebIpYySMDBePVpV3eU
         sW+YrU7lOj9dVd1GnZaCJ6aImnSWQRZAyE3Bhs3j+e2hP+ekN80EcG4CAQTSRka6WeB5
         rUuPzTXi/b7Yx5wzgMcHXEfl0AoPFCm74ZePLHYNKRZgdedlI44BjdZROM1Cu4NwxL6b
         SvYwCcbN4jvKHXOIv2A3cPbO5pTqeh/ocpU3dNgopDR3fsN624yXdFgEnIymKBKwHA7+
         OrF6AWb5A34X88swALnCOhy61nPKNsLfNAa92ECsXr5d7XYvljfiyk3IF1pm/XZVJA3M
         OY3Q==
X-Gm-Message-State: AHQUAubPJyzRnnFXGCpbfjDQq52x8JXtFF4239AQfKB0l9rbLbkLZplM
        aXqOYoTCUcHVXtAmmHkA6pArDQ==
X-Google-Smtp-Source: AHgI3Ib6FVnZ96ZPjhFAWG2engWWFkXxsH/pHQLUJpyk+xd9yFJFpJrB0crn/p4wv1HhQojuoFctXg==
X-Received: by 2002:a5e:c90d:: with SMTP id z13mr14041088iol.117.1549911660814;
        Mon, 11 Feb 2019 11:01:00 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/19] block: add bio_set_polled() helper
Date:   Mon, 11 Feb 2019 12:00:33 -0700
Message-Id: <20190211190049.7888-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c      |  4 ++--
 include/linux/bio.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f18d076a2596..392e2bfb636f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -247,7 +247,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		task_io_account_write(ret);
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+		bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -415,7 +415,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
 			if (iocb->ki_flags & IOCB_HIPRI)
-				bio->bi_opf |= REQ_HIPRI;
+				bio_set_polled(bio, iocb);
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..f6f0a2b3cbc8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+/*
+ * Mark a bio as polled. Note that for async polled IO, the caller must
+ * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
+ * We cannot block waiting for requests on polled IO, as those completions
+ * must be found by the caller. This is different than IRQ driven IO, where
+ * it's safe to wait for IO to complete.
+ */
+static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_HIPRI;
+	if (!is_sync_kiocb(kiocb))
+		bio->bi_opf |= REQ_NOWAIT;
+}
+
 #endif /* CONFIG_BLOCK */
 #endif /* __LINUX_BIO_H */
-- 
2.17.1


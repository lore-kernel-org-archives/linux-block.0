Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93AC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266A2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NCYS4jeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfAPRuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43178 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfAPRuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:17 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so5556935ios.10
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=NCYS4jeQEpuNkVMkTVOVaeVrUft0DzOSAiC6fPj+l7Elh+qbwuW4SG0d829ZrFl2T8
         tUGsystAt42gHhf6WMpSBh/N1Gq0QmmUWyEghWDh5H6iSw+BVFaAJltGjaCCwkjNslAl
         terDh5WemhixHnHHKFZxgRYDvGKXesLk/EK0XIKSm+1/636ACikDRNQUgf7trT7m3Rnl
         s0Ukp1dhfGdLA77UzN7p/qxHMYc3E1cwAmnBFO0O7k38E9/YBIPAczybK3RkiFsPcC5h
         5lU9+yQKCbUlUoWK5DivUPdUw6HYSrVHtMSbcLsAVMdQCdMeNOikjcGNhEHqFcuKD8Un
         pAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=PjgZOQbcM+TBTYFkDnEtLjZLdqMvW+uWcTeUrq16aLAqMSLwMiCxJu+zL33KQQ0Fcd
         Ox+obxVicD9MTOJkpaU/nJHuT2jcJtS3cAUaAcFg5qFUXB/fLNuAgLX8OzuvymF3ydUL
         9nOp8rWX6D05bzeHf2kZd6Zbf/mp+d38QvrhxX/pJ88lNELVcFXZT2RuW2XRD15KY30m
         JTwReUYDjo7MB6zVsP2rJtq6/+m6IjX1bowltltOLaCNL7D6AbTDCEfgL/Am6wALceVa
         sGyxY9ZIz6i1Mb8QqO/nmJ6aP5Xl/ami4ESwD3MqXCcMXRAUN7M69JfvxTdeO8irFX6a
         R/Ng==
X-Gm-Message-State: AJcUukdz/0asMa6rChf5yFtLMFmyDX39vyRX1I2TmBUlHvEK8pSNEDYi
        ND1hjf7XIYgSwJr76/DqAtX7qQ==
X-Google-Smtp-Source: ALg8bN5vowT5uuVRibpFdGHGtZ0ybEJbMXfPfCjYsoBDuffH9XZ3bguhHKkuOReyOU3rrQPrxEvtZQ==
X-Received: by 2002:a6b:cc07:: with SMTP id c7mr5153023iog.136.1547661017041;
        Wed, 16 Jan 2019 09:50:17 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/15] block: add bio_set_polled() helper
Date:   Wed, 16 Jan 2019 10:49:51 -0700
Message-Id: <20190116175003.17880-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c      |  4 ++--
 include/linux/bio.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5415579f3e14..2ebd2a0d7789 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -233,7 +233,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		task_io_account_write(ret);
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+		bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -401,7 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
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


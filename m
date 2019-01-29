Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F88C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B524B20989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SLPThqIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfA2T1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52085 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfA2T1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:12 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so6439499ite.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=SLPThqIKiqbj7HBmM5uswNYW6aEvsWxLSuxG184drJbuH24FPNHnSjq23bScQKVwJJ
         6REm+7yGIvUu4fVbvQR43gz2S1xK5GuY8jpqRlpWr03IQdi5lRFaqPN19x76aqk3gmXj
         jn/gl/zs0TlVXGrU5rWyVhKrgmbzt6wpnG6c7FDSJ8rtxQsEZjH9Dkq5E9CwLpx/6m0U
         2KtlNLewwyWZynYX4D9XpQNnK0wejyPu63AuWa1O+8zsvKWT1HrhslVgiYgi+hYR7fkz
         Nh5cYZ1LRoZct1JfpCEQeh6ja9iyHnEjgdR/veB7rkUtK2imSZY/oLUYQ7/HkeccNgTb
         TEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=ZO87HFcsvTA6LPX6tGcFxtQaJwOQz/UC2bNo/jTV8b0PuM1EUB9NW4KAo2Q8qyXzeX
         sWffzzZQLFUM51MpabmoqFGlRIEXaICM8jWKGWRm4vnpcG5ILUTen+1VFLqq/iO7paA5
         eFuCENElbwBsWdWUbqKCLmGAWlwkK5e/tsfgbFO/VT5zQKFJsklebP9dRXPWx2hRdT93
         7ZsPfRpq5w8XrD8JhQj41jRebC+PHtGky7Q8nhfRTvW+C/eXFrB54gwoXsQH0kQ9JsVn
         Q0Fgr0dQckYPITx4aBWw94FG2Ubl2kYqk4L4aUyvOB1RsiSbMhZsEsXo7h+MK0cEeNo9
         4unA==
X-Gm-Message-State: AJcUukcdPbxewnOlEahTMPidVe7BDlrZ5MRL30lPunZZVK3q7JjpSUxw
        5g/oQV9QrArVZg0kPGwmQc2IkQ==
X-Google-Smtp-Source: ALg8bN7an+spzZZ/GStEdkJ21j9I5XPaV9bQigkRIQs49kQ9tDLi6v3J9+c4PZ8dPm2atFMfwQ1eDQ==
X-Received: by 2002:a24:e44:: with SMTP id 65mr11878064ite.154.1548790031977;
        Tue, 29 Jan 2019 11:27:11 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Tue, 29 Jan 2019 12:26:47 -0700
Message-Id: <20190129192702.3605-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

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


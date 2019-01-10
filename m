Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34233C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046FD21738
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="otbjQTdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfAJCoW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfAJCoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4166027pgk.10
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=otbjQTdL6mIOkhEwpN8LZSDvw8zfM73Z0soH01PVqgSOKNI5ypPRJ1hvfKkcXzaUfd
         wr28SFjo9cgVpIM1FiwXA1r2TK4icFoKIsjGQMOYKVfTJqaLAIH758EJROE56xYfBZ9d
         OQr64TEsg+0ONRorP1zaMYR81qtMUktw2CZu1Rd8Q1M5h6wkSy/dQnnyA+uXdjYr85jn
         5SAOfDB6p8eUjsOsOxUAaIgmWAGzjKAzr7bDZgOe54AhryiEp6X3loKxYYMo+8ebh8Dr
         pheT24teUQWPUoL0hWGXhc+wfPDLFRKBymQPqmx8RhPDAtqaZIrYC3Jh/CnXrIK9i50G
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=C4sNUGvxawrJ3YEl36HyiK8rcbG2SiuTdUl3psWzNO0EIgzcL+302vfwRUAR22aAYE
         H7C7K1K33YE0VKOCARS4BtSeYIHYDq92CQWo1G39WjuAyA9C9h5uUWapFfVedzfz0pQ3
         Xw7GOz+zhyIIO0IaiBH0xkAj8oCQohQLKRNDIjV/K6w2hMZ7pGFt2Hq58aHP1NlWSKrE
         F0jELU3e7IOAkXhWhyuSjUs7s68WIQ7VkmHZaeybDzjsZEhF0CZKNkRoG9VY8e2R+L3A
         RXuJD6N3UN0gpYYNMhKX3QNQPxR8S65Eu/lAkiUdkFlFYdWRf7bINV8bdQmX4BKR55qJ
         Z5KA==
X-Gm-Message-State: AJcUukdAMr5xW8Hd8PBs6/sITvqFdBeHsinWKiTb5PbCuqQmtEFbFl9g
        ZnDj1d+u+EKvBlHbCaqRbbxNNQ==
X-Google-Smtp-Source: ALg8bN5IEuX/XI2VxWZtjjj8bx217jurJG7juAbtV9ibzKJqbBtdP59WTGNltBYOEaEXy5yhbcQlBQ==
X-Received: by 2002:a63:e247:: with SMTP id y7mr5296409pgj.84.1547088261422;
        Wed, 09 Jan 2019 18:44:21 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/15] block: add bio_set_polled() helper
Date:   Wed,  9 Jan 2019 19:43:52 -0700
Message-Id: <20190110024404.25372-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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


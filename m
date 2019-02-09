Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E0C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6876921939
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fLhRs4Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBIVN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:13:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBIVN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:13:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so3356465pld.6
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZRgsZ4kd01/5hUxi2xP0/0l+SjG1tCpnsE1G+JLPfI=;
        b=fLhRs4MasSdCI0cD30zSy6x6RUa5CZgDFc7VkmdQNEe7oLsbai7AcTAUC2lofWzpOe
         1cj1MHW87lHSivn4TGS0WSODGgIEPABv6gdKsX/o611C7viVkylv+oQ8gM80OnhAEBqM
         PRhMH0YqUhdPCemdrloqfy4P4Ghqi52XtUbYvTSESJ6rMYvQfOWY9HJKF2Wcit1/4SSY
         xcjJWrcV7s0VUmC1SrMbyEoOom4nHXzh1FaHYHszWh/q5uonow2XZvqJvrfqxfrF7hAD
         Gfxx2sBx7vQhPZQ8nBgL7NJeMEjcvEjkrhd4JgS+EOnyQLPTclS1uIMmj3Z0ZH3xDJF3
         telw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZRgsZ4kd01/5hUxi2xP0/0l+SjG1tCpnsE1G+JLPfI=;
        b=g95c5BIH/8JgMqNkLcZDvZSJmc8mXkE8sRMn+fZryl6rkMjPn0Hbr7b9vhR426ZZ3n
         zFGUNQAwVqyT6+VDbPOljr1so9N5D+WdC0ZO31fYldj7lwV32VmK7k6STIpuwGzl7Q9D
         ZTj2uyapQj7M5CrncpK782FOQnWx/7Sf46yq/akS6Bq4WUwWTOweY8t30lziBSLWbwWC
         vV/vxnb4ZmduxZ1g4meSDRHfojH28AG0EASuVYyjSl+zsbWZnQT2mx4bod+W4/SNRoFz
         hMU2ZSO0dA1LpNDpZNBU0HWr/CmcI3SQ5LtJu405sOO0zYbHuqdxylVX+1F8C0odmc1E
         zJLg==
X-Gm-Message-State: AHQUAub/lJrdt9+1jecA06oExSdLFZMiuW46xWiJRjufITMXfi+OsXM2
        D5nRyUykNbUdSs3wknwrD7NYAfmO76ptNw==
X-Google-Smtp-Source: AHgI3IYX4Ww+kCHI4+wcKD0mYmGD5FKOqGB/8hfF8Lhm/8Bz3gOne885zSTiUFKKJkWmdNDAIk8lBQ==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr30828375plp.9.1549746837327;
        Sat, 09 Feb 2019 13:13:57 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:13:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/19] block: add bio_set_polled() helper
Date:   Sat,  9 Feb 2019 14:13:30 -0700
Message-Id: <20190209211346.26060-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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


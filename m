Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD22BC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E5F2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PnnqyejQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLAEGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39266 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeLAEGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:54 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so10217209itl.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Qn86S9IysAhUjs5lPwgSM110FSlNFVglHplsagyxFA=;
        b=PnnqyejQfl3Y1Sx27UmSfYpY6XtRSsUkDvCBqF32TA7W8fVFAuIoTBWfJd6XPDavIR
         D7CEkQR8B35dmNB9vmJtSno1X0r/F9MkeHCazLVp9DGTES8W7VyqCSe5fGV+XcFGZqrH
         HZ4ieXxta9CZL/MgpkenNLTjzqJdAlxS2ologaO9S+/8shR+Gw6giCFN471CuoxhOIC/
         2Pkuf0a8cmF5Yy0sbrBvugVOKvBY0/anggkKLjU0C/Uehq+q15KWZMdc4QNpqDOwA82W
         PxLQhQ+hioHgoWbm3Si8URsnLMQnDyhVuME7SvIqv8a8oZD6LuPsjaQdOEKVhT6m4iMb
         1tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Qn86S9IysAhUjs5lPwgSM110FSlNFVglHplsagyxFA=;
        b=PWm7vN43CeuNJRPzX64vzS6eouP52YuV1pYrjA/8X/balBVEv9L0Y3Bo/w/i+DnfL+
         beG3sA6RY0WZ/zLYaaDxP8d9ygkKAEEZ/RSEoCeA+vtB4nQ8VyZQbX9I8iS1HuROyDfw
         CVIlnyrieB+/YRaleyGG2SNTiZOexMCkZdqVkKAbAPELJu4VfihQXspjNPqsOsY9rWpc
         gUKJo2K7rJe9BaG12Qj0r/cJXUXb+ZJhI4lOum8PYIPk9ou3abua5no1HnuNO2/hz3Tj
         ROrko1X1e3jQ0MMWrPsIQyNuxHhaAQ5QIEZeQLwK9DACyao4aTnRs4vG947DkEXKXdE0
         u2fA==
X-Gm-Message-State: AA+aEWYEQ73SqstcPSE418sKkM3AHLk7T/p4SPy1R+hN2hlH/B2KU/2W
        kdx/MEX4fv0nfLc/8ZWBydDFDJ606M4=
X-Google-Smtp-Source: AFSGD/VUg1tqk5zm1omAZOdspM+84VPskzax56AznGHgAnyPgdIrhavsyYAjV6LJaxwuP1fTkpaueg==
X-Received: by 2002:a02:9281:: with SMTP id b1mr5893855jah.86.1543597018129;
        Fri, 30 Nov 2018 08:56:58 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/27] block: ensure that async polled IO is marked REQ_NOWAIT
Date:   Fri, 30 Nov 2018 09:56:24 -0700
Message-Id: <20181130165646.27341-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can't wait for polled events to complete, as they may require active
polling from whoever submitted it. If that is the same task that is
submitting new IO, we could deadlock waiting for IO to complete that
this task is supposed to be completing itself.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6de8d35f6e41..ebc3d5a0f424 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -402,8 +402,16 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
-			if (iocb->ki_flags & IOCB_HIPRI)
+			if (iocb->ki_flags & IOCB_HIPRI) {
 				bio->bi_opf |= REQ_HIPRI;
+				/*
+				 * For async polled IO, we can't wait for
+				 * requests to complete, as they may also be
+				 * polled and require active reaping.
+				 */
+				if (!is_sync)
+					bio->bi_opf |= REQ_NOWAIT;
+			}
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
-- 
2.17.1


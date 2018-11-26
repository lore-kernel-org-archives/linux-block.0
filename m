Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6BC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1316820659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lP+rqi+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1316820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeK0Dkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54531 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeK0Dkh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:37 -0500
Received: by mail-it1-f194.google.com with SMTP id m123-v6so5068995ita.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/ImYfz/riZa32isBNBlGI10dC+68boqA2fqt5yslkE=;
        b=lP+rqi+JEJxGvbLvurZwrNc7lzsn7lfTmgbo22Ffx3Hm/lCKBuj28CPk18v+YZiCG7
         SNlPcunHTj6D6mbcUi+nkUe0Gvm8ulewvC2UEI/yMx9dAQVZG/7iE9WiI9yfRyNELVu1
         hR8kZbAvjSsSsEy9uSAIT4+NrnkACftnKKfcBedtWypDMkPFUVhR/Fmb4FF/jBJyShu5
         WxK31gXgu5x6Z2Dq6Rz+HQGVGtnjR3QeltZeQSsQJ34IdPXPaOb1IioBFdd9GuqGN0/p
         oYCyJ+Vx2cuc/9vzeKZD0j9LOxTazHmc0sAc/h/jM8JcY5q7Ip52EUtKCY7V6+uExgIl
         0ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/ImYfz/riZa32isBNBlGI10dC+68boqA2fqt5yslkE=;
        b=khVippFL4fTMm5DeACxyd2NXYjUcrLVLrKTf1eLxsKVJyovpJFTEm12iqtlqseO6qj
         kVqtXg0HXEHAEm8d6Miexo34QfMqE3B6V1zoOpAfXhi6hapt44rb3N9c82NvElgiRqp0
         aSNj8dUNZWc1lR2hJe3Ej34jf2+MqE57IfU0YWnEl/ukqXryjCl/B1+C0PbY9imb+3C4
         LFQeJd8buI0V6kUKdR5VNUEo7u0TInY2LUSnxanLmbkZd0FwheCsgLd9MTyxBRZhk21B
         cv4GGZmASKcV87WrTPluVNuTBtmoQaEDv/8ECFBkKjvFZ6cQ8zoFMLZ9wy48BboRtZ2S
         IJVA==
X-Gm-Message-State: AGRZ1gIYG3pwAr64Kc1r8WQkcCn/+plJNaueV4BoiZt0CbCCWlS9inso
        bEWV6JKl1U3iN72UrhRSjUXypuy9pTE=
X-Google-Smtp-Source: AFSGD/VMqOH8mkK44M6+hC82Uh2kkuHxB7MLTm3cr6UrpfPjnAIVkILTJ4iAsOkxVfDX0TS1Ww37VA==
X-Received: by 2002:a05:660c:fd2:: with SMTP id m18mr24372303itn.1.1543250757685;
        Mon, 26 Nov 2018 08:45:57 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/20] block: ensure that async polled IO is marked REQ_NOWAIT
Date:   Mon, 26 Nov 2018 09:45:29 -0700
Message-Id: <20181126164544.5699-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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
index 9acb26f7c9ec..9580ffe0cf24 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -400,8 +400,16 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
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


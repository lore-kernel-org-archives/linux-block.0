Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B22C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D0E2087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="acSniCU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D0E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeLMR5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51712 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeLMR5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:00 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so5003483itl.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=acSniCU1G/HYRD5NI6UAaYNqpGH9rY4W6ybYlE0RCelapdnzC2+LWzxdWAJWcp+rDC
         zLV+OZQvPkl+vR9OzL1Z3U3XJD9RMMHM+s48w91a565WFP3JM/iq2rgRjxdkwyiWPJ+4
         sCEe/N0VnCcEfE2yDVVR9KCi0/nulN0KKiMyNY5IjdlXnAeHuSaX69UoU12LVbtJ3USH
         UPW5ks+zq70ExVMPpMxfwkjiyveswAvceXMl3TXCfxhCVgXcRKZOY1R23iWq8ZLandd+
         2ZxZ1wmglryroWnkTYeohafn8jD8ju7wxGQ28f7pboedVWGaOvGEwWQPBXUpM3JwB9SW
         S/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=ar5C0UM43rJx18uaNMNtyEU3OVouJtC9OKUZgxienvkjgc3scZDBEqGhhxN86OF511
         v3NvlHdKJRe1CmQmboJggt9jNwsOw5hHc3MnFIrOzz5crG+r413hwlTBaWHwQNoLQijw
         vliiqM1ygoDTuB4F5KRjzqCYDUXSuO2j/3mwn9yxrHFIXDHTVo3nbJiKCoay9WXBkUg+
         a9XnyuyTtseu1VhN1xhbxOPu9hZj18L1VPxNbpqCeEf06F5D9EXoxIOhsM1Z2gYBAIYZ
         pPN1rPbZBqlORUYoUZmaRyLDutHPFJrl2YLkOtTdBIOl1XFmG8qd9J2nRExz1X+3ZexG
         TeZA==
X-Gm-Message-State: AA+aEWaIC4ZJ3iOhMZCQYAJLb1UnxsEcSwXnb+MhKius1jpl3Vs1vr/E
        roP/j0RYyfqVyLBO/VTcnU6EZ1Ua9f/W7g==
X-Google-Smtp-Source: AFSGD/UA3rY1AFcEN8lzB84y2GhM8A8iqBuUP/bkLrDSbW4G5cx2KhYmDzPsq05Ln792GH0iVgwDTg==
X-Received: by 2002:a24:68d1:: with SMTP id v200mr273000itb.163.1544723819053;
        Thu, 13 Dec 2018 09:56:59 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/26] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Date:   Thu, 13 Dec 2018 10:56:23 -0700
Message-Id: <20181213175645.22181-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tell the block layer if it's a sync or async polled request, so it can
do the right thing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6de8d35f6e41..b8f574615792 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -402,8 +402,12 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
-			if (iocb->ki_flags & IOCB_HIPRI)
-				bio->bi_opf |= REQ_HIPRI;
+			if (iocb->ki_flags & IOCB_HIPRI) {
+				if (!is_sync)
+					bio->bi_opf |= REQ_HIPRI_ASYNC;
+				else
+					bio->bi_opf |= REQ_HIPRI;
+			}
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
-- 
2.17.1


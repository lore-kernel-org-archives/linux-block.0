Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CFEC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A3021929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GegkU0H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbeLUTWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53287 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391642AbeLUTWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:47 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so8452562ita.3
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=GegkU0H+wROHphSz478S1xM7GYMvl2lNuA97LSeMlUoMhJjGVGXzLgQVvLZQ6vHK2r
         1pNDxvMIoDibgh3P4+v9MR2Gcozwy/TG80iHflNKAvs6ha1iZ+Mz7exogD+l/t8RcBKk
         jM/u5A0KCX66gP6DF4sj9KuCh4ZAhx6vL9gaI6E7WAtDy6LXyAhTdUBHWZSHaMqWyWsn
         GKxFb1oP/b/adCGBCKFQ5WyrlruqFBeJTzIEgX5M52g5lxKnQxJdUtab0gJ4NidiRS4M
         ODqc3orQSOre88/wDV0Y5rOKjvtdVjOSOLrreEBCGUenHLrxxW1xJx+1dxpeUGuzDGkK
         TRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=bdpAS+OdEcNemF9lFV8flcE99vE1QmADmaXbvIheacBfhYsoPPO1Vm8UbcABaWmA1n
         OCXgtyJu56TgT+m/Qu5ZZwbf47Umi5Vx6MEVNs3rfyNsma3gyR8RZuQx/thpKSnzxjGJ
         e+PIvfa9w5bFQkImlJsnT2quF5nt+3JW6yFuy9WQrgiABjsvnnql+ADBsmD1at9T6sH1
         gWc0h3C50Wf4BWTA6Rgi/+vcJX0HAI7EIA05fPuS5VBaw8rVAbN/+R/jcGm5OPNrZTn3
         dbFU5LGs3YeGorxDA/hXD8YEt/23qWpnD7PAcpUKeOfmhVlvwH2rmZHgWMILbGkKNXJC
         ZGMA==
X-Gm-Message-State: AA+aEWYF+mDatB/uWksvbonM72FrFQ/HKT3R/Exbsyu3oFedycD3qkwT
        eQI9ZLjEzLwpN9CSqYYv/rRZZA==
X-Google-Smtp-Source: AFSGD/XA4Ybd/zJZOcAfh3k/1DJHbqzyb1dAcNCVh7+Y4LbL0acNBKPqDyrnO7K4421qLVNmGpxkpw==
X-Received: by 2002:a24:1152:: with SMTP id 79mr2965435itf.167.1545420166329;
        Fri, 21 Dec 2018 11:22:46 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/22] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Date:   Fri, 21 Dec 2018 12:22:18 -0700
Message-Id: <20181221192236.12866-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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


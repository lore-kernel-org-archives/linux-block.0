Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB2C07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BBE206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ob2Al9z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BBE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLDXhq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39871 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLDXhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so9005589pfc.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=ob2Al9z+bpfazXrOpsm2EijMCcEkBP/Ljga69OwyllrOEb91xaOvlFCcaGoQEwKnuh
         0Q9L8pP8s28kig9yaGFQybCniKw+kQabPavh6j0dLL3rr+EUsHPHRnTA3kuDwPIh6Mig
         Mn3NbXKdYVoUT4ffdXKt25jPRpOHTuHEIpuWxbn4GWy5+tvzUi4fgZRIs9Q8sYkXGRhw
         +PLfuaXjteBI4i1XjNEqTzO6t1IDxQ9gWmm93nLH/PlP0dzvQoJy2Rt4xzl0FBggZBgO
         ejpihfIdG2viqjJCxXmsoTrs8KArcEDFi2BXtzwAks9AMgCOR5uxiXFoWKnY1Qgebq1x
         +sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=PJ7YmjmffKyO+Zu0e4umyhd0pGkLCJgwot7EDVhkE2UYKK0fZwQ54gve9QYTqn03j9
         9vKxq5MV8qU8skXziIpPFvpN+HIogxy8L98I9XBYcN3M92xPWwbauHZ5JqQoqTk1Y1qq
         cJqCY6JQGEdQvEuyU1EVy0NGX+bT8fplsa78WdEdRcTENDF/G6qNaoy8Y7y1aESyftLK
         Lw6l8CDoZ3PG7noRLsJYY2hvNjKv+83He4vnZBw9DhnHGehVvni4KcjDU4RcBoL3TFmx
         jFwf5TYzbluqQXZ4KQrckrVvtmZ9zQ5JOaPha6JPMFbp39R+oyt2PmqUbOqrj2dcq3Jb
         KsUA==
X-Gm-Message-State: AA+aEWb6JsI2BSXSu+e2gRGqtjr5remTwEpDgr5sP6Wo9x2cZN+sd5Zi
        3VeZ9L8jhWBJo/BDfATeCCHCBLikMSU=
X-Google-Smtp-Source: AFSGD/UMALFfr/m4YuRIp4o2wdkiDimaOlGrMwcbJEQBqApDn7m6HiBybCGeeursdN+bD2K1y/S6EQ==
X-Received: by 2002:a62:c185:: with SMTP id i127mr17728535pfg.43.1543966664980;
        Tue, 04 Dec 2018 15:37:44 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/26] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Date:   Tue,  4 Dec 2018 16:37:07 -0700
Message-Id: <20181204233729.26776-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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


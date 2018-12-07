Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956CC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297D92083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W8HFBiyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297D92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLGWUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45024 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLGWUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so2420101pls.11
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=W8HFBiyB2XMVBHaxGd7NtGW5LYdA6hlG7sdQehqbUYp98smU7U/Ym1XWMnxMvGO9oX
         7BAacez6JE/Wy6Mj6eXUdwJHtqikXK1eUEFr6iETjIT5CM3TXrOAbZ0dUDDkEZi9Dx8U
         YIIP+N6YMUCu1v9J3Lnp4DCqdbC+sqeFfln9FEqcleEaq0jl5jerRJnmupnqLQ97N+0A
         cii+hnqvQWBzHrjbB/lvPBJrmmaKqWqpN/xdSV9syZFmyJVItS+FJfufruDG7nSt2Hjb
         rA/smpdquhTRSxHIP8vWImwp5oZ/jh2t+fK/SDQrtc5LGSCMNwfJgrWjw+4kf7pn5o7O
         XUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=FDatnF4hKxFaQROOYY8+HZwus1q4u4w4YOsaM6R+s1TsV4sRx6I0f7OPJCqMH2/McC
         P+eFTlQqosRK+QuVV/rVOvfcermegqbK6aYRrHccE1aAK11iec3x/Uoz0mlGxEd7e0TN
         K+W2WDiPAiDs8t9nqhUjMZZlxlWnqnAELkHCeHeLaWHAUgawxb75yGFsERkHHHJd3yE2
         zWk0vXjdgr/tWWhaaCSzpOlcmSw2mMJnxVCA7u6bCdQ04bE1roeobSIIHC9de26r40GG
         c5k0YSApmavNjNVmdrzKn2vMpEM8Qj13j7XNzAG2oLmvP05EW01CPUe1428vh0ufff0a
         GsCg==
X-Gm-Message-State: AA+aEWbn3yce25W2ynvvhixeWfOVG6H0hNTsRiXrqd7qKHxLXMDd8tBh
        ZZMVirR8hRJYkX5DH4BK7o0hkt8tVSI=
X-Google-Smtp-Source: AFSGD/VaLTBN08GZha/K58BiRnbxCx8e8ICKA277hrvYXvc5aZjqHbkMCUMhBFI5eQtEciTOaL470g==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr3761521plm.234.1544221230789;
        Fri, 07 Dec 2018 14:20:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/26] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Date:   Fri,  7 Dec 2018 15:19:54 -0700
Message-Id: <20181207222016.29387-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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


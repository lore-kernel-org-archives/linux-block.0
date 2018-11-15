Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9182C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700421780
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T5sxAa0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeKPGBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44728 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id b81-v6so9694680pfe.11
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYF2DQMSuLBvvC6oyWCzDINndqOwZo6FPKocRmVKp6k=;
        b=T5sxAa0ZLNhXZpxss4WoFTAqUFa3kyESjrlyZu9kD3Y8OU5u3OKuAjcIw6l0YNXVkk
         5P2pUgzHOp0w1oNae4/v9GQtSyo1vfxi9k6LZdfS34r6u3kG94lWUT3cBw1hPH14TPJw
         VgppQZJFdHpMOXTA9Lu3rQwicPcQu7gidv4M8TPUVZr/CNLjQYvx989aKqgXqu4EwkW/
         lv1jgByNxezdU1sH87DqduSW2/WdkEPVA/8pYm+lU1WQQUhc7tHTwTB6ONJUAeYodwxx
         r2qNwBsipxL25Df4bU9KZYm8dAqfHt3YFp37HZVQXPC3H6KtPasmle0t1DqKp8AK+IpQ
         PH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYF2DQMSuLBvvC6oyWCzDINndqOwZo6FPKocRmVKp6k=;
        b=YZxtPqq4eiZrr49L3gLo6vYTp/jO4m478j5q8/8PVQ2kqj90JLDeI/hcX/f6QnZ6IP
         1EgvtCep+oy7hTlHIjqwWEjgfqVJIHblE7FxvwVb+htqw997V1H5aUZhYXGleYPR8PGm
         Uwmfcnt5ogR80ciXV7/FEuXUywgvb8ZXeArEHO8Pl9hX5cN2ORAUQ4XGi1FAOrrY1nwA
         sSLqI/B6MRRiDr0aDqXNQv07esPLU1VzUELVloDsu5I75YRIkVgf4NBmOA58uXjSGOl9
         8/ott7Z1EHgErG+W3SwKR5GO9duqavuv4YaEvUogulJBoOMazKT8CC56kJwC9Z9NQfVg
         NJSg==
X-Gm-Message-State: AGRZ1gI+PHQX5BxZo3cChnWSqYFK6kRmtI6bg7EpYlU1ynZWg+VdSU0L
        9Hn8lEaxEX31LREOcwbvWdpzqdMHNDo=
X-Google-Smtp-Source: AJdET5ed0D/bh3cdJA0Xz8YbicN07WRf9ub7ivRjcjJjGR41EvQaranHOJU8Hi37wz1PICenjsaqKQ==
X-Received: by 2002:a63:170c:: with SMTP id x12mr6869920pgl.364.1542311519713;
        Thu, 15 Nov 2018 11:51:59 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] block: for async O_DIRECT, mark us as polling if asked to
Date:   Thu, 15 Nov 2018 12:51:34 -0700
Message-Id: <20181115195135.22812-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inherit the iocb IOCB_HIPRI flag, and pass on REQ_HIPRI for
those kinds of requests.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7810f5b588ea..c124982b810d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -386,6 +386,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
+			if (iocb->ki_flags & IOCB_HIPRI)
+				bio->bi_opf |= REQ_HIPRI;
+
 			qc = submit_bio(bio);
 			break;
 		}
-- 
2.17.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D8DC2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF11E22252
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7VFba6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKTRNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 12:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgKTRNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 12:13:44 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458D4C0613CF;
        Fri, 20 Nov 2020 09:13:44 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so10309255edl.0;
        Fri, 20 Nov 2020 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmphNGE2+JHL0SC/phnWuUhFTKIOTNqnzzG2s8csli4=;
        b=F7VFba6GnYE/yP6lBxju3PtoaV911ac/qf/adlNuuCCg7IN2cJ+Rbmaimn7ZPEFA0p
         OuGINxHTKEez6r+e1S2KjA27OOpclaGiTUcf7E4G+/74xOvn9IRMbYUN+Shdg8sGtxTE
         XC318fRgzyan0JvACoNhka3pyop4psIWl6Fjyt2xRRwJf2vXCs3XfEr7TkXx8XWxnUy8
         l3STR7+P1qP7pBJYyK2uxgbNgm7SSq+A7Q27HlO/Muv91zGXZYh5uR9Qk6N54bM0xGp0
         S64ut+SFuh31d+W6bsxuS15Ya4rGiThwl+sS1O9H2uZ9EhyLfpK3AUKjvJFGBPzdMPeD
         6h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmphNGE2+JHL0SC/phnWuUhFTKIOTNqnzzG2s8csli4=;
        b=fOAIXhPvmWN4alK1KGAHMokvLGMxTTe1Y92/pFV0y+4uMQs8Ij2aiKIv2rilT4St4Y
         EeeR9AJ2A6oP0m9d67kquGKdggxfhqyCBP+JJO2awT2ElcAW9qoq4gp275jFxTK5HKCO
         MwT7bAwXApkwZZHoBqa5oJ7cc4+k3MUhiurb+cyK6IskSQZGh4HWH06THZbOBP7qd6Ha
         P86DDdP78Qw2xIhGJavD8JTniXZLhkP1IHO51+QXUJTgVXrOBizs7v4nRTsKvdOZNanc
         eNBDL82hpnuo0SdXzKGOJjc733qZtg4B6Pht9FpS6SH4Rabs4rRZsiThvbP71VmQfNr7
         T9PQ==
X-Gm-Message-State: AOAM530zneetycICQSJL35Cyq0V/ifevLrzjrlkfoYVgU/S3vN31ibxD
        seBmwTEaedupg0BGaE3leSAZIvIi1I8=
X-Google-Smtp-Source: ABdhPJxj6LxTjVlWXXxwOOpKyv2e0TrGIlWgY9K2zppixZcs4by6NuLSbjwaOW+RD2mz9qG3ZDDt3A==
X-Received: by 2002:a05:6402:2059:: with SMTP id bc25mr37469853edb.13.1605892422940;
        Fri, 20 Nov 2020 09:13:42 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id n14sm1340023edw.38.2020.11.20.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:13:42 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: don't ignore REQ_NOWAIT for direct IO
Date:   Fri, 20 Nov 2020 17:10:28 +0000
Message-Id: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_uring's direct nowait requests end up waiting on io_schedule() in
sbitmap, that's seems to be so because blkdev_direct_IO() fails to
propagate IOCB_NOWAIT to a bio and hence to blk-mq.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/block_dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..e7e860c78d93 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -263,6 +263,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(ret);
 	}
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio.bi_opf |= REQ_NOWAIT;
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
@@ -416,6 +418,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			bio->bi_opf = dio_bio_write_op(iocb);
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
 
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
-- 
2.24.0


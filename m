Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB407C2D0D4
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A312467B
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1w7hkIWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfLQOj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:39:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44334 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQOj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:57 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so11207874iof.11
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSvlHPa+iglQscNJSf7xQ/5HwRTlC6yUkzeNdFCcqV8=;
        b=1w7hkIWzvLtMu/dLZZMcZIijlZyfYWT25XG5COOJJfc8oH+ykaNVmhW+kyy47uEmxT
         44BfhsIy0PIQPcGGVhchbkR3/gV/mUaau6NjOzs4QWM9ffCFMNcxvMItscKe+DnZ8qPF
         Po3NAj4x4dgXGv6qHecBmhualhrDq1w6EvAdBXsygv8MWFEzZ7R9YWkEgVggpMNvni6n
         n37RGtE7bIULBdKOjo8NKGU+SO0IhHzTxOZvEEt83L9ftLfxh3r/Lej6KO9UMyH6X+iN
         W11mqMTLUelQXj54y55ExU0ini0NqxR9dbme6TbUTRm5QE3/urjzZE6sDy95hbxBcJ6x
         ntdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSvlHPa+iglQscNJSf7xQ/5HwRTlC6yUkzeNdFCcqV8=;
        b=DAm5u0PEHCgCPT8NtrDP1SSCBmaJUdOVVd8WE0/tk8lCOh2NXL5ot/zQOh7yw9rZ3/
         Q3t7MCOzXEQCqoCd5vQ0G0kSGr2PaMdBXxXU19sJkglkBogkQHJTYmJ1C3ZqxtZfuSoQ
         cF2/8H9XjwqP9awE4SOHSNDyTRfeBjJqWGiQxEVCWwZIJQRyzlFEbTsVEqk95RJSX2HU
         8u+uyATEJcP4+x1wwspvNmhVkZxdIwg3vqKgCdkxkMqMi2zCxVEjPopxGP4JYClBttoS
         SQZXyIlRkCieVv/7ps/n0K+w7buVi7BfYrF4qeMpgEawPhy9Ef9bj5V8D4s5uvfWfYxy
         T+Hg==
X-Gm-Message-State: APjAAAU4OusUOa5HR6KB5nlQfJF8phk6yUY88F3AKouIYR1TU40ekZfU
        QoRt1y9F1sH1cU7Y8xTpL8+zQw==
X-Google-Smtp-Source: APXvYqyLgOsF8+OSoa6LuQKDnmSyMVA3kpVF98IU1cYOBzMtc4vb4+N38upf1F2528sIApqSicZCyw==
X-Received: by 2002:a6b:680d:: with SMTP id d13mr3796828ioc.188.1576593596972;
        Tue, 17 Dec 2019 06:39:56 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] xfs: don't do delayed allocations for uncached buffered writes
Date:   Tue, 17 Dec 2019 07:39:48 -0700
Message-Id: <20191217143948.26380-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This data is going to be written immediately, so don't bother trying
to do delayed allocation for it.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_iomap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 28e2d1f37267..d0cd4a05d59f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 
-	/* we can't use delayed allocations when using extent size hints */
-	if (xfs_get_extsz_hint(ip))
+	/*
+	 * Don't do delayed allocations when using extent size hints, or
+	 * if we were asked to do uncached buffered writes.
+	 */
+	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
 		return xfs_direct_write_iomap_begin(inode, offset, count,
 				flags, iomap, srcmap);
 
-- 
2.24.1


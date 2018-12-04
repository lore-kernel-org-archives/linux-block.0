Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B4C07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F2E20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bBXaskkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F2E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLDXif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41293 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLDXif (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so9065896plm.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbgdkuX/L3fLyZ228OAfSCXQBLVO7eMAEh2tepSbBGU=;
        b=bBXaskkDSqkQosN6wAk5w9WEYOsU3jrcxjyNCFdyCv8VLVsw1ua0z7El8d/AxvMACx
         TJOn/uN82PHV+BPLmdhmj8e5c43c5cYCKX9ALTmHqKe0ROvL+e+K9KjgCL4JISUx5Qi5
         Y4zOz47efWiMCDQ2qfwPmvtQoLbPNn5pD74t3t/K+B+tVdEUKSay5H4Y8VbU9vIf2YwB
         8bl3w4d/xkSG4gC/F+gysHcf7MoZig950C+DBUe1bm9jG2f80Fw1Y7sIeFgtzx1hI831
         a03Qx55MDKWSHb/8ivcvx15gVrcDaZxtYUqUTrfNqd8qC9Gz5fHxOcvO87sYxzrsM4Sy
         OJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbgdkuX/L3fLyZ228OAfSCXQBLVO7eMAEh2tepSbBGU=;
        b=MZjn2TUzvvzGAhDI9bksUFKLpLCfvBHlTSA4oDLybekTz92iU0l8QmcTsQDFQaDvYm
         uQdt9exhqyzYdrYR9KsqTqwNu62jLnsWme40D3m7p9SaDjp+bdj5icb+M/yHKPZp+tos
         jKTUFsW6bd1qOzLdOPKevcPQYA7fw5CPzxXeIDv0q8yiMvRPCHXnmV24apc+QA2krWoP
         7bw2pP+JG3m+U1YRLo64wKP5IotmdMn23F8hYZT8jxocIUtdQk+/6xF2hdjWF5VmjW/k
         Up90L1ha3UigbKpY0zxHSSD9Mi+3zonm+vO7zubWDG9iWN+OiSdIySrZC1TMQuc5Ks1B
         nBDg==
X-Gm-Message-State: AA+aEWbcMjQ/mXJpMusMQM2/bKdtEnm5nnNV+j4jIvI9tScR6idZgnMc
        4z09Z97R+5ifsKp26YOsiGcWj7lUUoM=
X-Google-Smtp-Source: AFSGD/UOifFDnvRfNi0SxdjVBi403RuKY1dM3CB2s5Z6LuBFqwwTeNQ6AkiKKoUINkT/fAEXojQ8dw==
X-Received: by 2002:a17:902:541:: with SMTP id 59mr22450519plf.88.1543966714050;
        Tue, 04 Dec 2018 15:38:34 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/26] aio: split old ring complete out from aio_complete()
Date:   Tue,  4 Dec 2018 16:37:28 -0700
Message-Id: <20181204233729.26776-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 1c8a8bb631a9..39aaffd6d436 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1218,12 +1218,9 @@ static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 	ev->res2 = res2;
 }
 
-/* aio_complete
- *	Called when the io request on the given iocb is complete.
- */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_ring_complete(struct kioctx *ctx, struct aio_kiocb *iocb,
+			      long res, long res2)
 {
-	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
@@ -1273,6 +1270,16 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	pr_debug("added to ring %p at [%u]\n", iocb, tail);
+}
+
+/* aio_complete
+ *	Called when the io request on the given iocb is complete.
+ */
+static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+{
+	struct kioctx *ctx = iocb->ki_ctx;
+
+	aio_ring_complete(ctx, iocb, res, res2);
 
 	/*
 	 * Check if the user asked us to deliver the result through an
-- 
2.17.1


Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28EC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116D2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MfZh3KaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeLKAQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35853 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbeLKAQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so6206322pfc.3
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LdAh26WYFrL2379/w5QmgBLZw0GToHLyZ6z+1pYptw=;
        b=MfZh3KaDoXTTy95rcPtY1/eGCUtQvCqz/lb15myEOl0xD7bOFLF3yLV9hXbf5Gbo2t
         esHzCTLgL/L3JCUl00+Q4TbKUQw0Oz9vZ06cVuRI/wzIL7vRJQ5MZNyT/dIHvqrxNKmn
         Os1UtuY9SSu9HZnmZIATs7Pb0nKHLmO/smT8qE/utSc2FWzwJ+0Gi9z63M+Q7lVvWuTi
         ELCZyeFJDZLzMltkoOQ3uOTWI60p5ZPQiugcTSam2ykf5Jue+V8lxEib0KkM3SxXVih8
         jjKaHPp+9e/tQ7HfXU1lUm+jWfEFfAFhh12DtkfLsOR/3X2KoGnau/o0L/e2hchLHCnl
         NVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LdAh26WYFrL2379/w5QmgBLZw0GToHLyZ6z+1pYptw=;
        b=XBS8eKkmt8x4TCvoMhEsdwnVYAhqebbqD/YJSDrSeK5GUSbrG/1Pp1dMYRcZ7U4zp0
         rNsOTl+CuNxy9qpqGM3nHYwCyrKsCZGi0NAPL8x8Fv08J7U4EN3j05Q6HZGsIQdEEIXP
         B07dZrMK72ZT4h5rnktXBexe7l9UI96s2+vrwq6Bx9brywStZiofHjd/KPg5X65PljZ7
         q5d3+V2GrKRjqbr0LVR0hDSkDJPgTpo3kfiK28ihy/uoxZlxIlh5Qi67UTVfAaC/I2rv
         3NnQlx/0naKVF7umpyGPPuJ218BP7l9fjrQOua6XZJnY81tGh+Hri4AoZNin9WW9ZLUi
         hgnQ==
X-Gm-Message-State: AA+aEWb7r8iFlCakyQVBJ6xPfraIcO4qDW31FzdZQaM00oggjkKHU+/P
        Gywq38gJgD8oxSvwKTsWzgQ2nK0sQsrDsA==
X-Google-Smtp-Source: AFSGD/Vhsu1VRiaEwia88U95LQtj2tEpBbIQjs5y+zbSbuoN8m8NPQ4MB+ZY1+h67I0lkl9zERGg6w==
X-Received: by 2002:a63:1321:: with SMTP id i33mr12969007pgl.380.1544487405413;
        Mon, 10 Dec 2018 16:16:45 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/27] aio: split old ring complete out from aio_complete()
Date:   Mon, 10 Dec 2018 17:15:47 -0700
Message-Id: <20181211001549.30085-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7bd5975a83e6..a69e6228fe62 100644
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


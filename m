Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C03C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CD02083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pizans7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLGWVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLGWVL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so2286968pgr.11
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5L87GVqD2gO1OQfLYMKmRtAK+NVQxFtlE73GHDkfrqc=;
        b=Pizans7bLfj2W7PuQhQQ9a5P0s7tuNnJRng2Q0UeG++g6z3jv1wAnW8qTX3+ekDiCV
         sCp/NW1N6da1Zt+gciOV2lV/gti5TdMkUFiaD0xSftpSyaZVmY4Ce0W9CF3Vi52SSkn+
         qzXZ2lHrM241PXfPyhTJt3l98k6RrwXeFLoEdlyrchMfVU+3xUo4vptKEotXIabxFRre
         /8YFZ5wIA1uWMwzd0IyC45tcSVoRYJuAypboWMP5OiK1hyfMMi5ZAPtVP1T00IF58m48
         tBPTw5B2hl/88UBitt1qln4OE260m/Kh0itxdQGb21Nrp+tnDM+pkSR7tw5m7HaAN1+P
         eTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5L87GVqD2gO1OQfLYMKmRtAK+NVQxFtlE73GHDkfrqc=;
        b=AEengjYCI5Axr3jpVI8hvGGCqeGCwcPGXxsKFKPvqCmwjOg7zuK36AjZgOD4fsla04
         QxK+zriiG5fGd8CNpWGELdfEqooxXrrwUTLEKssSxfr1hSZ7UaMQujgEWfD/MTd4AnTO
         QyjuD3r41exxg766XQvo2C+84YLfCsmSqDc+fqmomDZqy4hiU2z3Uoqc1oOkUi0ril/e
         oYiz3aFDpcT5qh3CYsy8HUvZj/biRlMUkpthoZyxDVQ4GtfqpmMKkXa8ov9f5EditTsT
         /X6iHlwSRnPuNPKoII1R1HWtI+soWqrWTni7xbwPULZzhSZDd59sW4M2SKgJLzwdT6+4
         torA==
X-Gm-Message-State: AA+aEWYxcZAiHlNzu5CNob4G4aMmzFrJIADg52BwGaUr682JuLFEtY8f
        1xttd+cCx5/shZ/Hy6D/aePYi+LvtD0=
X-Google-Smtp-Source: AFSGD/XfJimPn/XcMBR25QRr/5CtqdTitfJNUEMUtxcW6GCKeiH/OW66Cj0+ZkmjHtoVsEC1OUdNBw==
X-Received: by 2002:a62:3811:: with SMTP id f17mr4061789pfa.206.1544221270229;
        Fri, 07 Dec 2018 14:21:10 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:21:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/26] aio: split old ring complete out from aio_complete()
Date:   Fri,  7 Dec 2018 15:20:15 -0700
Message-Id: <20181207222016.29387-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index fd323b3ba499..de48faeab0fd 100644
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


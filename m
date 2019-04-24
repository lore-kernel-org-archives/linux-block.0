Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D4C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91A20685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="c51i0KHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfDXVyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:33 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41016 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbfDXVyZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 90F29C030C4;
        Wed, 24 Apr 2019 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142863;
        bh=wskKyw1F3Fl5/kWgxI2sj45Pvjch1LbpcsO3j0mmxM8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c51i0KHT4IdI217DcBha1hcwx3QU08S5o4dYT220ypq9hPW3ytUHU+MqjyWlunF5c
         t9aH+Qrxem1Uh9TA4MEW5J7BxNYzxlnvCHz7TEz1ZJCrJZ6bPH5nU/CEsG65o6V3Lv
         u1Vq4PFSAkUYQIA3RVKBaFZmE0zs/lHuxNXnXqSI=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 4/7] io_uring: remove unnecessary barrier after updating SQ head
Date:   Wed, 24 Apr 2019 23:54:19 +0200
Message-Id: <20190424215422.7404-4-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424215422.7404-1-source@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
 <20190424215422.7404-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no operation afterwards to order with.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c101230df71..31357cc0e8e6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1795,12 +1795,6 @@ static void io_commit_sqring(struct io_ring_ctx *ctx)
 		 * write new data to them.
 		 */
 		smp_store_release(&ring->r.head, ctx->cached_sq_head);
-
-		/*
-		 * write side barrier of head update, app has read side. See
-		 * comment at the top of this file
-		 */
-		smp_wmb();
 	}
 }
 
-- 
2.20.1


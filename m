Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45470C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEBA20685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="r3/rEDTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDXVyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:33 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41030 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbfDXVy1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:27 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 7326BC030C7;
        Wed, 24 Apr 2019 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142864;
        bh=N03kNgSxQvwPesqZAQBECnNE0NAOvlkik1vWzNpvW9M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r3/rEDTr3hECbwd0JPZ8bV76XhFC4XD1AR86EzMkvv+1dOOhelErwbUvUceVGzBXg
         1mByDZqsu38CjS7cEC7rbzM4L51kXap76dbv+4G4xwKEged9ncl7YVT0J39ZPmE9ks
         iLuo4hSLoIgBlEtndqyyrn2vF+Hd4+n4CgSR+zQY=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 7/7] io_uring: remove unnecessary barrier after unsetting IORING_SQ_NEED_WAKEUP
Date:   Wed, 24 Apr 2019 23:54:22 +0200
Message-Id: <20190424215422.7404-7-source@stbuehler.de>
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

There is no operation to order with afterwards, and removing the flag is
not critical in any way.

There will always be a "race condition" where the application will
trigger IORING_ENTER_SQ_WAKEUP when it isn't actually needed.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0287f6694e3b..da084bcbd408 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1966,13 +1966,11 @@ static int io_sq_thread(void *data)
 				finish_wait(&ctx->sqo_wait, &wait);
 
 				ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
-				smp_wmb();
 				continue;
 			}
 			finish_wait(&ctx->sqo_wait, &wait);
 
 			ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
-			smp_wmb();
 		}
 
 		i = 0;
-- 
2.20.1


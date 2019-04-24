Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A9C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDBC20685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="qS9snzxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfDXVy3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:29 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41028 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731858AbfDXVy1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:27 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 25D3AC030C6;
        Wed, 24 Apr 2019 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142864;
        bh=l9WN3oodFm2l6ZgdbAKryqOBl7w8r+hOq9d0s2jkX8I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qS9snzxloRrBXnQv9qv/9yvuBAvUAOyRL4SYfdts3Z65zEH4AFCRwOsDM1a/+40qu
         6D5+EDcZ63nS1+Q+4HQLjGruZmd1fzXCsOWfC5cZ4p2/7VLknMq2LouYvPKjFCiOJv
         YxxIIXtyqXuIQYQo+jUBA61u1fNxFTTk92PBt7ss=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 6/7] io_uring: remove unnecessary barrier after incrementing dropped counter
Date:   Wed, 24 Apr 2019 23:54:21 +0200
Message-Id: <20190424215422.7404-6-source@stbuehler.de>
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

smp_store_release in io_commit_sqring already orders the store to
dropped before the update to SQ head.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f93a9fca8311..0287f6694e3b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1843,8 +1843,6 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	/* drop invalid entries */
 	ctx->cached_sq_head++;
 	ring->dropped++;
-	/* See comment at the top of this file */
-	smp_wmb();
 	return false;
 }
 
-- 
2.20.1


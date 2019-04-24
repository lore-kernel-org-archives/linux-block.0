Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D49C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7D420811
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="X/OcvXly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfDXVyZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41014 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbfDXVyZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 46327C030BD;
        Wed, 24 Apr 2019 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142863;
        bh=j00YEKIBIYx8iSi1Y8E2AsbiGHpsyQBbnqztzAtf1uE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X/OcvXlyLV6MDawzUJ6YwlKQ9k84bUI0JnIL3yFch0mWe/Gt2DnZCJgbW5Vgk8/zE
         K6rNDpIXYp0txCL9Cw1eATrjana3yCnzKjac4Zrnjh6mP4JhwiKuK3d8Y7a5Fgr5Ij
         ij+SHikoHgGn61q1+fT9RszJTJNxgM/WzqOySGcc=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 3/7] io_uring: remove unnecessary barrier before reading cq head
Date:   Wed, 24 Apr 2019 23:54:18 +0200
Message-Id: <20190424215422.7404-3-source@stbuehler.de>
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

The memory operations before reading cq head are unrelated and we
don't care about their order.

Document that the control dependency in combination with READ_ONCE and
WRITE_ONCE forms a barrier we need.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1f4419f38ef1..2c101230df71 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -431,8 +431,11 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	unsigned tail;
 
 	tail = ctx->cached_cq_tail;
-	/* See comment at the top of the file */
-	smp_rmb();
+	/*
+	 * writes to the cq entry need to come after reading head; the
+	 * control dependency is enough as we're using WRITE_ONCE to
+	 * fill the cq entry
+	 */
 	if (tail - READ_ONCE(ring->r.head) == ring->ring_entries)
 		return NULL;
 
-- 
2.20.1


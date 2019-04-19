Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482B0C282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B6A20645
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="V1dBgANQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDSStU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:20 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:51616 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfDSStU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:20 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 90FC1C03099;
        Fri, 19 Apr 2019 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1555667867;
        bh=Ny3nPJ9Jd45yAaHUdAjuhmCfTy/7e8qTCdVb/ocHtok=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V1dBgANQtdwhME2WNGM6MvB0u/KB1TcqIRkduhtHFpSzS/HMAdnHGkLooWMICtmi8
         l7Bk6uzzfykWOMuVW2WDZ6nXloQYhfcpBStnA4I8o5M843Cxxjdw0NSF0zGk44Qqsy
         XQ6cymlnR0f6YtJDtgvMVekGmHGAEPU1mTTCntaE=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/3] io_uring: fix race condition when sq threads goes sleeping
Date:   Fri, 19 Apr 2019 11:57:45 +0200
Message-Id: <20190419095746.22894-2-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419095746.22894-1-source@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
 <20190419095746.22894-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reading the SQ tail needs to come after setting IORING_SQ_NEED_WAKEUP in
flags; there is no cheap barrier for ordering a store before a load, a
full memory barrier is required.

Userspace needs a full memory barrier between updating SQ tail and
checking for the IORING_SQ_NEED_WAKEUP too.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 96863e4780b7..912b0b304d90 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1865,7 +1865,8 @@ static int io_sq_thread(void *data)
 
 			/* Tell userspace we may need a wakeup call */
 			ctx->sq_ring->flags |= IORING_SQ_NEED_WAKEUP;
-			smp_wmb();
+			/* make sure to read SQ tail after writing flags */
+			smp_mb();
 
 			if (!io_get_sqring(ctx, &sqes[0])) {
 				if (kthread_should_stop()) {
-- 
2.20.1


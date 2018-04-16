Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43661 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeDPKZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id y7so24424788wrh.10
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:45 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 05/11] lightnvm: pblk: warn in case of corrupted write buffer
Date: Mon, 16 Apr 2018 12:25:26 +0200
Message-Id: <1523874332-6272-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When cleaning up buffer entries as we wrap up, their state should be
"completed". If any of the entries is in "submitted" state, it means
that something bad has happened. Trigger a warning immediately instead of
waiting for the state flag to eventually be updated, thus hiding the
issue.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 7a632913475f..024a366a995c 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -142,10 +142,9 @@ static void clean_wctx(struct pblk_w_ctx *w_ctx)
 {
 	int flags;
 
-try:
 	flags = READ_ONCE(w_ctx->flags);
-	if (!(flags & PBLK_SUBMITTED_ENTRY))
-		goto try;
+	WARN_ONCE(!(flags & PBLK_SUBMITTED_ENTRY),
+			"pblk: overwriting unsubmitted data\n");
 
 	/* Release flags on context. Protect from writes and reads */
 	smp_store_release(&w_ctx->flags, PBLK_WRITABLE_ENTRY);
-- 
2.7.4

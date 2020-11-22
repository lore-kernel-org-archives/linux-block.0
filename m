Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FEC64E75
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C4920781
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPLfAxEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKVPjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgKVPjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 10:39:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897EC0613D3;
        Sun, 22 Nov 2020 07:39:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lv15so13952045ejb.12;
        Sun, 22 Nov 2020 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fl28dO735aCAhko0B6RL7SyZGlL+dtaEdr7rVCrHNgQ=;
        b=rPLfAxEfQrMaZWxlGBBQ5d77LNndT6OVQI8MQ2T6907z53C9QoVTKOPOFsmL4yC2JW
         36wJA7mxNcfbneKzsAqdpifGDGflHREGS2wnjXY4y+noVa17TU09bkb1/5bjIUHCpeDo
         BztYKy35vV3e+DDGG38CSWfnkDaogGcnAttQ20IRJKGOkG2qFlVSCw3SYBLqd/Esz3uy
         HOokYMbQI94IaNxVk/4L7hQhSbepslrv1vpfo9BGZfsoappahdARgR6uA7ccqgNZkWkj
         l5Joo5IHrLaOWvzNLkCvGpA0xM8IJiq2T8OsTs4fJXzxuRrt7Iq33AKxdF1J+cxwtOnW
         8aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fl28dO735aCAhko0B6RL7SyZGlL+dtaEdr7rVCrHNgQ=;
        b=XAxFAr8V2/6aHZlPfqer70Fd7490sYPQch986SCZC39jkCoHUwT+rap82CJ5jN0AZS
         nKUty2HzWNe/cFBFPnUvLpWm5C2EgQeZOqziOmY4kbCNAAh5nxhlCXRrIKr8JqvE8wkA
         f43Dp9R+wPPSYwZiRIyM5gbdnzlcldF8hshPEcAjP3KvFZTaK1oo8VG1Ai00IaC/hYSP
         XnepPxU6AS7z6/Hh6CZqUWFe6Ey/o/jYl0yidLxSsFR1q0m1zgO7fvmxKwMqAirZXNZN
         zcqhDQDXc0o7G/KcXujbviCQOyd+nUYRaV9cQ0MvwdQE67y4BYMH9YlnlwrV5NwDUnAv
         D+Dw==
X-Gm-Message-State: AOAM533W9hzmvNauTpQa+Bey95SEq1gkMcl3f3t9zyeCyIrQo/sTrRyp
        n9q/fQvx/W5nnQT1YXfM4oL4CR9mPLbPcg==
X-Google-Smtp-Source: ABdhPJzReAQ2abZZjO+qZieauY3jPn1AV5BGddQdRsAaDLI8owcy622mYph2MO6f7bQjG6vikUT4oQ==
X-Received: by 2002:a17:906:1c87:: with SMTP id g7mr35785480ejh.37.1606059549013;
        Sun, 22 Nov 2020 07:39:09 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q19sm3693742ejz.90.2020.11.22.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] sbitmap: simplify wrap check
Date:   Sun, 22 Nov 2020 15:35:48 +0000
Message-Id: <120b9b0870719675c91764822016597bdfa3ee15.1606058975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
References: <cover.1606058975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__sbitmap_get_word() doesn't warp if it's starting from the beginning
(i.e. initial hint is 0). Instead of stashing the original hint just set
@wrap accordingly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/sbitmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index c18b518a16ba..d693d9213ceb 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -97,9 +97,11 @@ EXPORT_SYMBOL_GPL(sbitmap_resize);
 static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			      unsigned int hint, bool wrap)
 {
-	unsigned int orig_hint = hint;
 	int nr;
 
+	/* don't wrap if starting from 0 */
+	wrap = wrap && hint;
+
 	while (1) {
 		nr = find_next_zero_bit(word, depth, hint);
 		if (unlikely(nr >= depth)) {
@@ -108,8 +110,8 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			 * offset to 0 in a failure case, so start from 0 to
 			 * exhaust the map.
 			 */
-			if (orig_hint && hint && wrap) {
-				hint = orig_hint = 0;
+			if (hint && wrap) {
+				hint = 0;
 				continue;
 			}
 			return -1;
-- 
2.24.0


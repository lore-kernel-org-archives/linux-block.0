Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F99C282C4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 10:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0D520879
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 10:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="cSjubKo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfAVKQX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:16:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51574 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfAVKQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 05:16:22 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so20589020ite.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JWGs5toXsRmnRsCYgGfqI4n4jxxRyhhfZqoj6TXmfCQ=;
        b=cSjubKo6bs+/vW3zncTOpWUqWMZY7O83uXhuiWdLHhXek1Wk3PoGrPIVnZvM9fiDNK
         TYhGMm/EV4I7mBMk0Xbp46CP0Re+gnjxfzWwsOs6nyTTEjQ6xDwScXmqfIWUX1WjxxrY
         dS0BRDlHUCfU4oC+1R/Qvpo8DjxlSQKmI79YcoK6tPsOApoonb4Jzn9HVgYKJDVggqMk
         X7FnnlNZZocyQAa0hXOpkkQWFN7f16uJdCjAe8BEImV/lHR0tC8yxynvZt0BBvgRWdY4
         jxvwrZ7lEewuBrRaMJy/FNo0DLOhrGHpqdpfe+nCkqkXXGgauqo1iYG6YjgnV9koSil+
         Gg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JWGs5toXsRmnRsCYgGfqI4n4jxxRyhhfZqoj6TXmfCQ=;
        b=WfXGYMw6AJKt3tGwsWabAwKcWZeSwxqGOFlgwfwu+HJft1EJ0n/1Xa2PpVlhgY4tsA
         gydgzyWE/zhv0zoedms9DFWzDbbgQCwjiadwPTzsG3V3sodJXeFDccA2rJcNY4o7sOw2
         lk3uk9YYbYVG+kUnHiiX8MdfZP+W5TB89oNg+Ro9xdiaBhDw3e3oIJyRJOdSqVhXtIY9
         OJgHL0s29KMoL+dPDQ3X6Opk9TI0cQ4/4n4YIY/sxCGAj5EUaIus9KkXmDdswhXREnrm
         dIYaS6J0659SO2TmldM7hkSaAZPP0BPycUm9ke6pLI2qp9wgjBR/Rskvi3vVYQWNKGbH
         lIFg==
X-Gm-Message-State: AJcUukfXtOPEWLSSDNcmKrEyPcEUxN/OsNScvKJZ2TxBzdtvWPCSfeKt
        z4t5zwP7yWx+XeCt/G8u1HBNBA==
X-Google-Smtp-Source: ALg8bN6Qr0A5bbgsepz6SubLpk4F1z9nC3kHx0+6wuFDoGHZfSZ91yLuPHLtcI04o6RKTlj1eSdrbQ==
X-Received: by 2002:a02:5184:: with SMTP id s126mr18921007jaa.12.1548152181802;
        Tue, 22 Jan 2019 02:16:21 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id q15sm5572816ioj.64.2019.01.22.02.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 02:16:21 -0800 (PST)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: stop taking the free lock in in pblk_lines_free
Date:   Tue, 22 Jan 2019 11:15:31 +0100
Message-Id: <20190122101531.30893-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk_line_meta_free might sleep (it can end up calling vfree, depending
on how we allocate lba lists), and this can lead to a BUG()
if we wake up on a different cpu and release the lock.

As there is no point of grabbing the free lock when pblk has shut down,
remove the lock.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f9a3e47b6a93..eb0135c77805 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
 	struct pblk_line *line;
 	int i;
 
-	spin_lock(&l_mg->free_lock);
 	for (i = 0; i < l_mg->nr_lines; i++) {
 		line = &pblk->lines[i];
 
 		pblk_line_free(line);
 		pblk_line_meta_free(l_mg, line);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	pblk_line_mg_free(pblk);
 
-- 
2.17.1


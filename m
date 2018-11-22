Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83238C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F1020672
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 13:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="W271uKsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F1020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437049AbeKWA0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:26:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36934 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391365AbeKWA0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 19:26:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so7776533edb.4
        for <linux-block@vger.kernel.org>; Thu, 22 Nov 2018 05:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWHtLTMGvL6s4MAnpD1kuO8lAzOkIuYD/LB+c3dyEeU=;
        b=W271uKsAdCGxoKSawAdcUCr4T6amic75JAKC6+EbnIyBAfUeq1Y0yAtJvb3g8Nlx8X
         vKOF8o6VTay+T8gSgC3KK0CNhHrVQJ5fBolZ1XjDtw1GwN06Ve6GqBOmR1vNEu5eUkjA
         4YntVcwySShSm5C7RQhLj/QGbrtRC+/22wFNeHfAdpNLSWVna3HXrdJLvVg2i3YheCsO
         X6cYVyYcne6fywmEoB2JBlqKR6s3rhAkvxW1vswFG7zVC/TuPYKpgXIXlAWpdrgy/jwQ
         Oh9GxkZlh2DJC7mlffzznRZ0oUOx5Xo0WSDFnbCx+dNreFVHqsQoUCI3HOP+N70qAXzB
         nW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWHtLTMGvL6s4MAnpD1kuO8lAzOkIuYD/LB+c3dyEeU=;
        b=nqsKbWKoJubrPw51oGet26BAqs9xKDODZNTDnZBgrEbkX1qtYKukBwUOl9U38BuS7Y
         57boJYpqmtkY0XvNyqEUdWjUZS6dGtTntlqpSH78jcx000HLf2Qi+jwx4OGOM3MmQVN/
         i+fGYDJv8uMioqM+Beh8I0XSxvXsjgm7VqdI/Fn7h04BrnPxly4T9KxpMAylKWOnYhl3
         TwLPtEWZWcw6UOf75AQ0JbmPe1Zi7MSdJYAUL7u66Gij6VDJEhcIUWgeS2PpSppQFi+N
         oPfACIe3y/Djt57Zy2w5+sPHbGOObwUo36JGVPjjeUKDFrZiCPf7FpDNA6XDzblkK2Mc
         NM5A==
X-Gm-Message-State: AA+aEWYOSRUiwIe6/5KUkM1wa2G8E04UFKekmMghBmxROs9GdqL748EF
        Kfl55i/liHOollS0MFgr7to08Q==
X-Google-Smtp-Source: AFSGD/W1MsrKTwBJ/DtpAzHbRHE88osLRK+CDTYvQHiVz2ENwt1fm3+Y+0EeTCTGwUJfkwK71cf3jA==
X-Received: by 2002:a50:b4b3:: with SMTP id w48mr9483874edd.233.1542894431731;
        Thu, 22 Nov 2018 05:47:11 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id s6-v6sm14246263edh.89.2018.11.22.05.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 05:47:10 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: avoid ref warning on cache creation
Date:   Thu, 22 Nov 2018 14:46:50 +0100
Message-Id: <1542894410-14047-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current kref implementation around pblk global caches triggers a
false positive on refcount_inc_checked() (when called) as the kref is
initialized to 0. Instead of usint kref_inc() on a 0 reference, which is
in principle correct, use kref_init() to avoid the check. This is also
more explicit about what actually happens on cache creation.

In the process, do a small refactoring to use kref helpers.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 13822594647c..e225bd60cbb4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -350,23 +350,19 @@ static int pblk_create_global_caches(void)
 
 static int pblk_get_global_caches(void)
 {
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&pblk_caches.mutex);
 
-	if (kref_read(&pblk_caches.kref) > 0) {
-		kref_get(&pblk_caches.kref);
-		mutex_unlock(&pblk_caches.mutex);
-		return 0;
-	}
+	if (kref_get_unless_zero(&pblk_caches.kref))
+		goto out;
 
 	ret = pblk_create_global_caches();
-
 	if (!ret)
-		kref_get(&pblk_caches.kref);
+		kref_init(&pblk_caches.kref);
 
+out:
 	mutex_unlock(&pblk_caches.mutex);
-
 	return ret;
 }
 
-- 
2.7.4


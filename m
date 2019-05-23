Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CAC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD342133D
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QziK08t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfEWPja (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 11:39:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfEWPja (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 11:39:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so5940411ljb.2;
        Thu, 23 May 2019 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg9QJMVoIXaKWf9d4CiiruugNRRgEMRA5guNFQCIeLc=;
        b=QziK08t3EUrliO+xfZUbyOcUD9cQyhbf8kO0GsHcyjftkFBnNC/BfRrHzr9W1s/6QP
         jtoQcNA2YjVKpTef+5mwavvlXvI5fPlaO5Gk2Y2o95csW7Boe8DEWdkmqOmK8vAYm0KQ
         +gpkyNlaniZ7bqlJt7kZ+Of6EAWbtse3eVvY0kM42vvvQdq+MaH6BxDiGpFWXuJpfSzL
         6UoFdzz8B9Uog5MamvqMYLJLuBp9yKMZ3YGzs1dQJBcsP0YRy7tR1X55SkzQ8hIKn+U6
         E+APeHivXDJtOR3Ht9fTdxrSuZWjF8V7Fxm2lX51+fgN8j9BIXD2h2GUSBQGMzugbuNO
         Lycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg9QJMVoIXaKWf9d4CiiruugNRRgEMRA5guNFQCIeLc=;
        b=GYkVYf//Y4ao83A1IrzyAsstYeuVHr4z359mod6oJWYna+gcewb+zg+zUSqKsa4nM2
         mIxhp4leV7M+AmuVYVA9XufCS/tV9i/gcr5UIeE1dxiGiRFwnLmGCphaDAG1tPJQE9C7
         TwC+YC/YVkV5gTLVCyxQpAMKnah3uA/37ScAK5xV10Y0Dc0mAS3Gi0p0Rb+V0Zsq+5mD
         TLsEGwe/5oLbRAy1X3LvuFOqfV8W502IakBlqgIULPh5HGjRwyzXydmhta343H+Rk9ZV
         h/Bdflq0No7gZH+ON36HuEeS5EJXM8CCA1uYxwB2xduEzrJ66F4ASArZpr5Bc43XFXP7
         H1yw==
X-Gm-Message-State: APjAAAWrWOFum//1+ZW3+H545spXbyu8bMwq7Tc5SwmPgyazB+kz116b
        sdbXj0tSCvpdekVlbaerOrU=
X-Google-Smtp-Source: APXvYqzXr1ofVFFaXNsYTFoUTH5r8CWb/cVF/6pYDgPWsAfpi6SgwvuOnII43JLm5tLUDHaKf0QgsQ==
X-Received: by 2002:a2e:8644:: with SMTP id i4mr7460180ljj.0.1558625968417;
        Thu, 23 May 2019 08:39:28 -0700 (PDT)
Received: from localhost.localdomain (mm-89-92-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.92.89])
        by smtp.gmail.com with ESMTPSA id z9sm294677lfa.25.2019.05.23.08.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:39:27 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
Date:   Thu, 23 May 2019 18:39:16 +0300
Message-Id: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

cmpxchg() with an immediate value could be replaced with less expensive
xchg(). The same true if new value don't _depend_ on the old one.

In the second block, atomic_cmpxchg() return value isn't checked, so
after atomic_cmpxchg() ->  atomic_xchg() conversion it could be replaced
with atomic_set(). Comparison with atomic_read() in the second chunk was
left as an optimisation (if that was the initial intention).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/sbitmap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 155fe38756ec..7d7e0e278523 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -37,9 +37,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
 	 */
-	do {
-		mask = sb->map[index].cleared;
-	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
+	mask = xchg(&sb->map[index].cleared, 0);
 
 	/*
 	 * Now clear the masked bits in our free word
@@ -527,10 +525,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
 		if (waitqueue_active(&ws->wait)) {
-			int o = atomic_read(&sbq->wake_index);
-
-			if (wake_index != o)
-				atomic_cmpxchg(&sbq->wake_index, o, wake_index);
+			if (wake_index != atomic_read(&sbq->wake_index))
+				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
 		}
 
-- 
2.21.0


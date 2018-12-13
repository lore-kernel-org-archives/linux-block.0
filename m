Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C994C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FD920851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E5vcL+W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FD920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeLMR5a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34960 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeLMR53 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:29 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so5220834itp.0
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gebr0BfrZPSt7sqZNiw2xj8KlSXIt8V6Wrau0EAezWQ=;
        b=E5vcL+W0Oc6XMYDNB9g4PC/UlQrmBRxAddKO/7j9Qx+O4nX1eyI3F+j1UuTE8llvEk
         S+QqGJYRpm4zwz8njAI8dVkil6aq4VCV4/268mVp0A1qcG7I6symQxB+Sc+8meyrcuXp
         XkEV7Jv7SGbndVPZWYSRqydqGhyvDg69gumShSoUDjA4d1pt9Lu+M5S51uhWwCuYydPR
         F3hL03mRSCV0PB7pyk8roVCLoxchNLQ5PAfONChZNQkOQ8Sjbb2q112xpiqHJESlWK+s
         oqWscN9pZGSSSeE9UKTZz387EXEj9TSCYXwGOWVllyZFjiULZpq7wn7qfVW4lhb893dI
         d/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gebr0BfrZPSt7sqZNiw2xj8KlSXIt8V6Wrau0EAezWQ=;
        b=RGwzeeXtxGf2uCppnXW2Urm0BQ4v7nmN/JBUZxmvnc5PvFaR2+UJVOFGIBnx/aiAMB
         3A/RYfOAXyiTsbbEtrAuJUuyK5seQTULU+mQtFSdnteQnUX3O8RKTvQ0utnHm2ToU/B2
         KI09vMv/qvcVgMmjOBZjTLNBQDEZ/F62vf6o5w6MiiKDpa+OPEev4T2wafzKRwQhCbsK
         IY2C5In2lcBhqCwx6AOq2Y90liQlLUE2EOtb5H6wIkUYZO4cTearJ4a7v3VaeAQEcb50
         Wmzpafsppb/DCey+l0pb/Jw387onMPxIJW4seXqCqCY4Py2/1iMmgGAVzRr07FC2f0yP
         muRA==
X-Gm-Message-State: AA+aEWZ80mLAFfJHBmzcPLGq4M13u07Jh6ZKOte8k2SoO7BebrcnEjjv
        yCUuyYdzrsegTcmw+6jvuiK5Y1qWTk7TPA==
X-Google-Smtp-Source: AFSGD/UX7Trp3xDIy54f9x1LvAzA5vO0O6/uqiDg42kAkvz4+YK2Qry4lVRUS9Zn3qygxDcb9f6BCw==
X-Received: by 2002:a24:ba0b:: with SMTP id p11mr272681itf.113.1544723848156;
        Thu, 13 Dec 2018 09:57:28 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/26] aio: split old ring complete out from aio_complete()
Date:   Thu, 13 Dec 2018 10:56:39 -0700
Message-Id: <20181213175645.22181-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7a3986c6cc1b..fda9b1c53f3d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1205,12 +1205,9 @@ static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 	ev->res2 = res2;
 }
 
-/* aio_complete
- *	Called when the io request on the given iocb is complete.
- */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_ring_complete(struct kioctx *ctx, struct aio_kiocb *iocb,
+			      long res, long res2)
 {
-	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
@@ -1260,6 +1257,16 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	pr_debug("added to ring %p at [%u]\n", iocb, tail);
+}
+
+/* aio_complete
+ *	Called when the io request on the given iocb is complete.
+ */
+static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+{
+	struct kioctx *ctx = iocb->ki_ctx;
+
+	aio_ring_complete(ctx, iocb, res, res2);
 
 	/*
 	 * Check if the user asked us to deliver the result through an
-- 
2.17.1


Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4BC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E39121929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U8r41AvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391710AbeLUTXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38687 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391681AbeLUTXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:16 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so8020103ith.3
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dCoL8psYwDA9lIycdd8lGQAwac9fL5Iq3Ghm5zotmoM=;
        b=U8r41AvDj2BDuOCSoWB2jOMYoJcs2jbDTVUobyGu/O0REarMOq7cMXzQLvn67+9anX
         ZOskJ2V12A1xe2cTB2DZFDTof/HvWIO0i1vcohGK6IrWOgrgo9f1SU9bxSK7MNrJ+D0Y
         T53IQot72LIw/cvMQbWm2U5hgfzqbnwq6BzsmjA/1o9unybvudBpCYe7ugFTnJgoxOYb
         asqiaqCZCb21a9BVj4iWtEOH4jZ9zWWk8CEbTJdcBM1H6DJDPIx0WQkxdQ6pX8OW2UJi
         uiYSGa2JZRXoYouxpwegNeiDrUCnDierWnay1DEr9lBzuBrOYa6yB7R9Wocw8SyybXDD
         gUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dCoL8psYwDA9lIycdd8lGQAwac9fL5Iq3Ghm5zotmoM=;
        b=HTE4Y6sK54uyLde42MTPCvUa8QldLp1SAr/IQjMiN7a4s8tx64pDO09BcKQmO/PXEX
         C7jbGEu7CWnO62jjt7Ns9sd/Nkh2Qb1ZLGqCTV+QUVIBL8WO5M4rTX9L3HH4STaAA7yw
         ZO0uVlIbEv8yR40UiU5B/8jaSp9GYfhxhsTchE3YW7FcQzXQCumx61g0+tFkMc+Ft7i3
         pBy69Y7iOytz72hvUAlqLEOUVXbSiogOmwoge55wsOYm/o7SX7zBctoloeEoRuRQKdIz
         O1LdIxadz3yqrL9y3w6gvIoAiepqKvKXVTtB168WGddtb8z4duJkdRfV6GJPYmDeKBWd
         qZHg==
X-Gm-Message-State: AA+aEWad9lHbyTRSwGXRr4v5RM8v3d9X7zvsGktpKw9gxSUm3kDjEA/x
        PkScgaFcDgFpJVDf2ZAQ51R03g==
X-Google-Smtp-Source: AFSGD/Wb5a/yEofZdbcyFM3P8k2MRLsytQg6muqJLjCky9zo5vwy1AISLleRjm4xF7dnZJ00FJUOlw==
X-Received: by 2002:a24:1152:: with SMTP id 79mr2966509itf.167.1545420195301;
        Fri, 21 Dec 2018 11:23:15 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/22] aio: add my copyright
Date:   Fri, 21 Dec 2018 12:22:36 -0700
Message-Id: <20181221192236.12866-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index a433503a2dc3..000bfa0de1ed 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -6,6 +6,7 @@
  *
  *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
  *	Copyright 2018 Christoph Hellwig.
+ *	Copyright 2018 Jens Axboe
  *
  *	See ../COPYING for licensing terms.
  */
-- 
2.17.1


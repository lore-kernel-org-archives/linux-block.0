Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B0C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 22:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BE42075D
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 22:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkCJFz4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfCZWFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:05:52 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41686 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCZWFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 18:05:52 -0400
Received: by mail-qt1-f202.google.com with SMTP id d49so14962083qtk.8
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5OS7MeeQZkVjDOMphKCQJrQLOTO9o+8UDZ4EUYnvOds=;
        b=PkCJFz4gIUUzxfFMy4dd9OumgOl5iHmWHQdrsah8NR6wKkHmArUqJsjoTnRlHoLjU9
         kZ1NHsaUAbUyuxT7QzvshppCC33sPT2qlAOinWw0eWFQzvgLDRodVsQ6vh4vPgimjjqL
         losIMDyUQN94ZsYUe3up5iCmUwZDBY6iMxBWuVI+DxaF3vpaG7X7GhpvyBDedC6clBPw
         AxY3tLUpMOJLrya+t3CW3BnWb+OTFHuItBmWBOnNER8Trsn0ednmN2Bvuu+3jJSSUhlQ
         2KAIaldNpXQ3iGxt3QxLCExUwR/slCPnslZNjXk/v27CrgcaRQJr5X3CvYxERlRIT8LF
         qN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5OS7MeeQZkVjDOMphKCQJrQLOTO9o+8UDZ4EUYnvOds=;
        b=gfb+W4a7jC94Jvwx3cEyaK+5dtm0WL7mSWCavNNF/g4EbmguUfqdHoi4e8BQzoXb4u
         iVvjRHDWE1E2/Yz197cw9C33hrkmYx4oPdPRN81Er4ctKw8s3LPnY0OtETgbgdkwPW9D
         CnkX2+PaXQFP+A4s/hMSE75wzYsrO1P2CksaVv2gFCpou9PV/TKiGs53aYu7CKkO7P3A
         7lcK205mEbY/TrPl0PIM4YheB/zgo2mw5g9pO0GvCoADdotyr1Hxq7OTfzOGyMkJpdal
         3V83mE+PcXAzSfQfoZ0f2LW2jyxYOIO8FAN5pf+Cj5yBl16cyHs4JAYaPfVBQl5JSRc0
         7Vjg==
X-Gm-Message-State: APjAAAUbgRZQmvFUjR0ApX4Hv0shTAszLNKOlzyJE5NfvXySTGg0aqKa
        9xu0xCJYR0wY636fcOQ7hdo8zQmq3Q==
X-Google-Smtp-Source: APXvYqx/cNkdwyZirz00IGu2ZgmtakS46fNpTZOT32zHCJpwPLUg87c4TuhXkaDGUy3yld7NLDF76nc2cw==
X-Received: by 2002:ac8:27a6:: with SMTP id w35mr27473970qtw.157.1553637951208;
 Tue, 26 Mar 2019 15:05:51 -0700 (PDT)
Date:   Tue, 26 Mar 2019 23:03:48 +0100
Message-Id: <20190326220348.61172-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] floppy: fix usercopy direction
From:   Jann Horn <jannh@google.com>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        jannh@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As sparse points out, these two copy_from_user() should actually be
copy_to_user().

Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only

 drivers/block/floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 95f608d1a098..8c641245ff12 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3749,7 +3749,7 @@ static int compat_getdrvprm(int drive,
 	v.native_format = UDP->native_format;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
 	return 0;
 }
@@ -3785,7 +3785,7 @@ static int compat_getdrvstat(int drive, bool poll,
 	v.bufblocks = UDRS->bufblocks;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
 		return -EFAULT;
 	return 0;
 Eintr:
-- 
2.21.0.392.gf8f6787159e-goog


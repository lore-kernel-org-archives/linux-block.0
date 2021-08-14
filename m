Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F287C4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 02:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D79360E93
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 02:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhHNCrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhHNCrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 22:47:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F6C061756;
        Fri, 13 Aug 2021 19:47:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so18757806pjb.0;
        Fri, 13 Aug 2021 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocF7LIpSwj3vsZpHqVHvaq9IL3YwB/xApDMByqK67ds=;
        b=OyLhTHyhLSnLWm8b6eBfuWOu8kblpYEzDoWcYm1Jpsp8Ty5aAk9ZxPtJONjDx6deXg
         5dDcPb73J1ZhbAHbhHZhZr/CELiSGpaYJTtQbLkmOSLstYo7/HgxrAJ/9ZrvB/lNdv+J
         iZJR0WW+f1vAuNfJVmGp4okMpSm9rWnBy9WANoAqyiKXe0evXOa6nNc+UX9TC0b4L2f2
         ctjx3hlQgYvqc7P/Y+oC+e/9Fd+C7ZbiCPVycaw5B4J6Nu8c6Y8a+B4/FpuTTz+y01lY
         dkvw9Rv45D1F3JXwadZCeQcgke2yocuSyMroYpjhc19vmnrgPRGonYafuTeVYpCr02zr
         uQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocF7LIpSwj3vsZpHqVHvaq9IL3YwB/xApDMByqK67ds=;
        b=hrZgYolCqxffcOVBdj7g3eAzBJmmrnwHMekJN7xDuEHVy4GLEJLjTWyLZMfx7rRKma
         yuhgz7OO9yfIdXb5guY0lBH6zWpIUAvJtmbG4Kwfi/cU3bf8mQxBYRTZFVrLx8uZyyie
         sCPmKu9D4BLCChT09d6pZgpG58iRZshOMnTD2/YMJYv24SC/WpElW8dcXu25sIWKBtOp
         9AQdvCzpLPKl4TM9lzXzjwZ/ZHe+3zCUd0puz1CYHAhct0UM3OqK1BFL+zqK5inWLdgc
         phi0cY0HPBv8kpxL6zuplEMvJwE5CZyM+9Q8Yvv1TV+za/wny3RHxTN6h/IT9zdPf/3O
         CE1A==
X-Gm-Message-State: AOAM533mjJlsAcfaXpKYPM0xaj1DgOuU5lDei4F8MnLwmSS38cq9gc1V
        M65rExvFNizxXLTtUtZXQw0=
X-Google-Smtp-Source: ABdhPJxb71dylV6u6SGMAKjdVOS5i4Ex3mgGwZG/+orObYO9bwMN0dj9fTlf2giLBadoPnXQlJmQpg==
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr5561376pjb.192.1628909244769;
        Fri, 13 Aug 2021 19:47:24 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:6ce2:9fb0:9db:90a4:39e2])
        by smtp.googlemail.com with ESMTPSA id fa21sm3067379pjb.20.2021.08.13.19.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 19:47:24 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: [RESEND PATCH v2] loop: fix setting arbitrarily large block size
Date:   Sat, 14 Aug 2021 08:17:17 +0530
Message-Id: <20210814024717.1839753-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_validate_block_size took an unsigned short argument. Passing an
argument with size greater than the size of unsigned short would cause
an overflow and could potentially render the upper bound check on the
block size useless, allowing to set an arbitrarily large block size.

Reported-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---

Changes from v1: Fixed the spelling of reported-by tag. Fixed the
commit message.

 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a758cf66507..635baff0dd66 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -236,7 +236,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  * @bsize: size to validate
  */
 static int
-loop_validate_block_size(unsigned short bsize)
+loop_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.31.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEFC63798
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AC12220B
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 01:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT7EbjWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbgK0BaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 20:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbgK0BaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 20:30:16 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3BC0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 17:30:15 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b144so3078007qkc.13
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 17:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UQGvsqVXaE6k8F7lV5xV/+35dPRQ1m/VGDOCJYYYeG0=;
        b=kT7EbjWsLRc6meC7TZcwTZj2TH3JeMkTbDI+vGYTQG8wApRc3qbI4f6NG5LcDgomg0
         s3FRZpodpzGONyyGAau1z8fTctAea+B7T02YdchkbgIpETJ0zYzFGVEOw7BdL1tKl+pK
         yQ7SoA6EqADPyTDgDybnglAJ0adzir2Sf0DGvjoUQF23puGbJSp9MqEZU2dDYE9QWQbt
         3y9APTD4+isp1aWTTNk5H+btbeSLLtKHCnCWhJlQ1NYD+ZHDkNlmtwTQpfvbGLfXw1u4
         715lxZsQy0aK6nPsLRiVENkWQtH0x2JiQcz1uUiFf6nhVbck1n89oSOGmSbtio+6phqo
         0c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UQGvsqVXaE6k8F7lV5xV/+35dPRQ1m/VGDOCJYYYeG0=;
        b=j90aPDpSpsWsTZzNUXpNpL2OYniEgkK3SIEHVU7UohSkVTQk7ITj/g4t4thC4n2iSq
         wZKtyMEMMD0/RMzR0SpYqDPptmoOAZ8XedFSdHVZ8IuMEdYplEHgHdTZZleGfXqQuabo
         dO6fLEH6O8vBJoVzuCIdahl1iaE3v/wId7CLRk/ODtEqx5SHVyiioRxJrxKwfBQUcnig
         rKrLIrQ0p7gXphCEEycWOEsrUp4VhJWx0GhFf227jl3eCTQ28C6YnnCdQqxPIt3dRTZ0
         EZ4rkBwJlGkkq76+7zU8fMPaGEk1lqU/SQx+CXlui6jV0Dg4j6hG2MlOUQOlN5HpR01E
         AUYw==
X-Gm-Message-State: AOAM533hWAw3yOiIhI/AUeSD92xYYUuXsZIwWzYz9gPwK1wltlT35F7g
        2CTfwg+YT94AstzR/o+LZrA=
X-Google-Smtp-Source: ABdhPJzwOqpOdhNSmtyDKaN7mwxX9fLQU/49/ikFd8nZUYdglswFjZpvyOGW/9YGQvjzu7Kb9vWhNg==
X-Received: by 2002:a37:8ec5:: with SMTP id q188mr6075134qkd.85.1606440614295;
        Thu, 26 Nov 2020 17:30:14 -0800 (PST)
Received: from DESKTOP-2I1VNC3.fios-router.home (pool-173-48-78-29.bstnma.fios.verizon.net. [173.48.78.29])
        by smtp.gmail.com with ESMTPSA id h13sm5110723qtc.4.2020.11.26.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 17:30:13 -0800 (PST)
From:   Changming <charley.ashbringer@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, yaohway@gmail.com,
        liu.changm@northeastern.edu,
        Changming Liu <charley.ashbringer@gmail.com>
Subject: [PATCH] block: fix a unsigned integer overflow which could bypass check
Date:   Thu, 26 Nov 2020 20:29:45 -0500
Message-Id: <20201127012945.410-1-charley.ashbringer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Changming Liu <charley.ashbringer@gmail.com>

start, and len are 64 unsigned integers and
purely from user-space, thus star + len can
wrap-around and bypass the check at

start + len > i_size_read(bdev->bd_inode)

This overflowed value can cause trouble
after passed in truncate_bdev_range.

To fix this, a wrap-around check is added just
like in blk_ioctl_zeroout, so that such the
overflowed value can be rejected.

Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
---
 block/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3fbc382eb926..3fddb1fe5b35 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -133,6 +133,8 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
+	if (start + len < start)
+		return -EINVAL;
 
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
-- 
2.17.1


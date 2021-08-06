Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82DC4320A
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2146A61184
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbhHFLGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:06:19 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47986
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245299AbhHFLGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 07:06:18 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9FA603F109;
        Fri,  6 Aug 2021 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628247961;
        bh=l6Crxr7OCP95ZsjBftxKKMqfoQ4lcuoG+yhpbemOXu0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=oN0z2sFHSpBGlOta2FnY8Ao9EE9iL/YOWKCyNDeGYYEUhJ6mboXufR37rKoXie46e
         bGlptR5u6SFgWmFqQ0OjHPdFD+RE6sH8BxMaeA76g+DaTsgnqkk5cEZkctoGneNWAw
         jdLWxU2utggd6w3m2hIzw5Tsk5YAj5Z1QoVXDv2M0MfJfC+I5rr8NdiV0KUo0ZQzBS
         exD5JhZQgi/Wsfp9beW6PUXQFR4n/fUFMpMa77pjV51FJpK2w6I26QZsIlbVHlDydk
         /p7vDntJKfJ7qe4TOg9Q6MsLodm6QE1FXFvD46CzhElz3hfgEJCB6KrqkKs0IkCZDd
         XxULMTABC5Cnw==
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen-blkfront: Remove redundant assignment to variable err
Date:   Fri,  6 Aug 2021 12:06:01 +0100
Message-Id: <20210806110601.11386-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being assigned a value that is never read, the
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/xen-blkfront.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index d83fee21f6c5..715bfa8aca7f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1092,7 +1092,6 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	err = xlbd_reserve_minors(minor, nr_minors);
 	if (err)
 		return err;
-	err = -ENODEV;
 
 	memset(&info->tag_set, 0, sizeof(info->tag_set));
 	info->tag_set.ops = &blkfront_mq_ops;
-- 
2.31.1


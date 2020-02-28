Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D4C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B273124699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QM3+t/It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgB1PGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37874 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so1668037pgl.4
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=syM+mD+FEQQ9t/H4a+6C6wVoDM4rV6ydwN4nhDRJ5r8=;
        b=QM3+t/ItT8OM1ccTogoMuGduUXCDcb5dWMhFBqioGwQo9IQQG/Vk6ZzE11/t/1Cny/
         Tj4I0tpgyYquMKgb5FisK3LPZjYTz07jzyTHJDkNp9uBcKCEHezZ8HeLgmoDRxqR0vTi
         8lbGQ0Q+3rvhRadW+fDghIuy2NGJaCGU5U2Ls0D8CD5WgDIlxEXq3Eqb3CO4XRpzrUKB
         j6Gpb+spQ/IOuN58sS57hhVuRIAH4iua4Xu9nkWwMezK9Sugw544+lPbkJnO+JnSa+g9
         GB7SkCRxveb4Js77TQhJmvzYNLrkHXRuGNni0KnEZ+5BmbufEyPjTSBl3dpDZNJOmIC9
         Nifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=syM+mD+FEQQ9t/H4a+6C6wVoDM4rV6ydwN4nhDRJ5r8=;
        b=nV3IZuJBtHugIqGUgJCTEOO2R3cc8gntGXoVSJ9ppk5O3EPlKL4BDMp7ZwwUUfDMQO
         3gS0B33Fd8CDOxeIGlRNCKZG8MGjk0aLuFG7Zno/QzuoZ1TEm8E7MoCzBK4wd9xmCAH9
         NasXp3o7TqusEiitv5ovZFQxz4+gwq6bB0ADTiVwj4wEzaVQ4StiwE2/65CfARFCpg/S
         /AkZuluhMy+zQpQGt+AUJMnK+SBCOq0CRr+73PVxLzs7vwsN7++GzRja/nyGSwc4DpxI
         PtS3m3+I8Iz6cdSTGV2zXSHtZ3vGJn0QLl6nUkKqSFBmaSyParzYqo6fCNa/23H/+jH6
         kMkA==
X-Gm-Message-State: APjAAAVXU55AYNKRdfb8Mj9b9s8jPiGzRB6TvHj9avqTGSuBoodpj4DE
        o1lzgvpXIAML11l2fZKK3rBdsw==
X-Google-Smtp-Source: APXvYqxWI/DBEwPuCP/Kk1TM+CIIF4ErZ8ITndynh6kFMO69cOTMEAOzHw9u33oZUyT7IoMLbdGh+w==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr5094787pgi.289.1582902380700;
        Fri, 28 Feb 2020 07:06:20 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:19 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/6] block: remove redundant setting of QUEUE_FLAG_DYING
Date:   Fri, 28 Feb 2020 16:05:15 +0100
Message-Id: <20200228150518.10496-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, blk_cleanup_queue has called blk_set_queue_dying to set the
flag, no need to do it again.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d36c2ad40ba..883ffda216e4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -346,7 +346,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-- 
2.17.1


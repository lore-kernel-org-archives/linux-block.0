Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 07:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B83D60F23
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 07:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhJLHos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhJLHor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 03:44:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86052C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 00:42:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c16so29125322lfb.3
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=O8ukzt+WDtLTA6OQKMFjKA1OeKZH22NepCDeKfyYr9Y=;
        b=LjKnynFG68WUuiFGX82t/9VgwQI07zwPjSl3r+096aTEM05lNWLzVEancLdcE7rpWl
         9DrI6KDTMPYY86HvEJTY6W+xjU+3dDYgGiIxww6aPKgE51qPTsYbk0ZXR8KIo1Zt/d2i
         K8ZUsRGdlZpx6ZPcgHgeT/eneTnR8m5KlTfrKBl++DfxWNrGWzaYoWKcmFm8ApV9ULDv
         U+Q0jlpmTwFVkWMMPcFhurjapKDHL7C3NzKtrBhPIifOsreKBIa/GlysbfcyYKlHSsC0
         Wau3BHhDt2YdEcCzQ5SKrySvbsoo5hGYduLn9hlmORiUr4tD5I195b7jVJ2kQbrrixS5
         b4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=O8ukzt+WDtLTA6OQKMFjKA1OeKZH22NepCDeKfyYr9Y=;
        b=Gc8YuGfEBBFRmPtmdHL27CciqPiMFG9mifJ8JJVoEiIxRZCyG6yJB+qjtiwQ/UPk2D
         rBsFRfejfh3dK5JZWC718MN8LZocIztOuoLXL0MNfih/AMoLsD5SmhvwduljU2osDG3I
         kwcio+BAKxisuSdHgwDQ72WDlI/KWBmvC3h3ebpd9WFfAi8ptwHKYGhJOpwKgHHKvRDK
         mE5r1WwOL5B1YdckrT9cm++mJPrJmKl1yK6pMzME46HM5LPbW78SbbVBoAMSrAFnAT9U
         RyH0J3Pl0tXOEVhjyD8hJmT2Fh91SfZHBiQdsedUpJIEh3C014inj20AKUbAMDyr343F
         H8qA==
X-Gm-Message-State: AOAM5333Ze8aSBNUh6VF7Aaq2tTud2JB4ernQrYA2XATMv78q1L6SYOd
        eu3NoQzTc1NdwTctFv+A+n6by7IO/4I=
X-Google-Smtp-Source: ABdhPJwoY5SEh4yJiEcbJb0/wp1KNhGu2Xr3t8MdKQA1PJJBfM4ZHle16yULYvaALxu89cT8Ufb0lQ==
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr6304699lfu.489.1634024564790;
        Tue, 12 Oct 2021 00:42:44 -0700 (PDT)
Received: from localhost (80-62-117-201-mobile.dk.customer.tdc.net. [80.62.117.201])
        by smtp.gmail.com with ESMTPSA id w2sm900747lfq.0.2021.10.12.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 00:42:44 -0700 (PDT)
From:   Pankaj Raghav <pankydev8@gmail.com>
X-Google-Original-From: Pankaj Raghav <p.raghav@samsung.com>
Date:   Tue, 12 Oct 2021 09:42:43 +0200
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, p.raghav@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com
Subject: [PATCH] block: Remove the redundant empty list check in
 blk_flush_plug_list
Message-ID: <20211012074243.jygb7sqlheoi6ytv@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The callee: blk_mq_flush_plug_list already has an empty list check for
plug->mq_list. Hence, removed the check for empty list from the caller.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b8c70670190..db28e2261825 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1724,8 +1724,8 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	flush_plug_callbacks(plug, from_schedule);
 
-	if (!list_empty(&plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
+
 	if (unlikely(!from_schedule && plug->cached_rq))
 		blk_mq_free_plug_rqs(plug);
 }
-- 
2.25.1


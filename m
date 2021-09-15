Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E26103C
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhIOGvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhIOGvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:51:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330EC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eb1cMZHo+CU7OQx66iykkaGOuWhkW1Li7UWCzyYEOFs=; b=JER8baoG5awXFTLpZxmMuRG4it
        iRgMdVIwsq2eWMIM92pjw7E/V9zRWvwjkFFLUOxvTBYYuU2PRSf2iudFZoN5efbxOUbFSs7BUGsdi
        l7SEixDVxY7oeyuWTCZJ7DwyN/W046hL6zXRY2rAzRq6TK3P70qdwkUWhNdYlKrwcrMfx0o4b6d2F
        0K0TaOUfyKAy8HjOiTuGimtXcTz3IcSTOGgg9p0yh9yEVkCkBprJB9wgIxClvdfVkHK69MDaPVjwe
        4Km5joSvQHIhjEzuCUWYI55tRO0VusJSuY++AWv02PnaloJ9gLgIut+0i9JvkoGb/XCzPC+bVYvyP
        IkVmPcmQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOjP-00FQzp-4m; Wed, 15 Sep 2021 06:49:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/17] block: remove the cmd_size field from struct request_queue
Date:   Wed, 15 Sep 2021 08:40:37 +0200
Message-Id: <20210915064044.950534-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9e367509bea10..6737e484280d3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -544,8 +544,6 @@ struct request_queue {
 
 	bool			mq_sysfs_init_done;
 
-	size_t			cmd_size;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.30.2


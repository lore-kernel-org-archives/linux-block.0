Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C22C43217
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhLIGfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhLIGfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38068C061353
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k1jQcHDEY+hv1JxFnkBmOyMscmpU5/Fn6uTtWF0Lbt8=; b=tzFcKAdOn7iEf3FdBxWEv81yk/
        3tPiT+sqco4gk0KSDVKCCEP9XIBdVp76Yy0kPEt+lXX75iGo3rdRYnQnU7zHPv8HRCRD4UE65NYFK
        SMVRbuGbno2+NHOf5vC3jOuGwystOFrpeu6bKv/F2R95BmY4XujSvycuyAXaPpbtMALqNNz/3S/nx
        dwcWAYFEClWDQFVCozxdmoFJhiW9bsKg1wf82xoauz4+fMO7yylzkhQGVDZUPUBniPHt/kz4neDOV
        ZUTHnn6oKEPRNrdk5dAt2ono8R9sy4CrCZJpac6KPwOlx0evc1bV5BVbMyT1UFeckosAqaeoDaLAQ
        NcZ6wi0A==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxt-0096TU-AD; Thu, 09 Dec 2021 06:31:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 04/11] block: remove the NULL ioc check in put_io_context
Date:   Thu,  9 Dec 2021 07:31:24 +0100
Message-Id: <20211209063131.18537-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No caller passes in a NULL pointer, so remove the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 0380e33930e31..04f3d2b0ca7db 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -155,9 +155,6 @@ void put_io_context(struct io_context *ioc)
 	unsigned long flags;
 	bool free_ioc = false;
 
-	if (ioc == NULL)
-		return;
-
 	BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
 
 	/*
-- 
2.30.2


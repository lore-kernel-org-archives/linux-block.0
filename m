Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213DAC43217
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhK3Mum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhK3MuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EBC061756
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4dOr9mVd/x4gQxXkD4EqAd0AYwdkpTESj/mQN52XBZs=; b=GUD04Fg2/+p9JC9MwbWEBsmPRD
        gKG2ihM+rVVfxK9fBJPTZVowcJPIDsFktg+7s2YHV88q59ISFskrIQRCjZksDnK7ZxM3RiQ8o8ej+
        iqnGSxLHw/cVdNOWwQjUkucrG+sO4uxxtrmeUsAPdDKS1BJvKgn+WFbnQb/uozlZg4QNJytlq5LW8
        +3kBC/fREshKfyrUczZNpMD08jLnwfkcAjvvgBab/dd5zC4n4dePRKo5ace+S41wjT98N0z4bDTKQ
        q9FaYU7AP+jrXboL8ygMXboP0mpdl1SGwc+VfzBwv9A5JAGnDpSV339HeHb6WTQUePwEfRK27nAyZ
        7dPe+cUw==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2X1-00CFc5-V0; Tue, 30 Nov 2021 12:46:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: remove the NULL ioc check in put_io_context
Date:   Tue, 30 Nov 2021 13:46:33 +0100
Message-Id: <20211130124636.2505904-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No caller passes in a NULL pointer, so remove the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


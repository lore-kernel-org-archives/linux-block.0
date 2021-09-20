Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BABC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8AD610A3
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhITMlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbhITMlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:41:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60430C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hOWn0oOcbtNVNaQYWHu1z+Xns4EP79rgG66Uf+o3nAw=; b=fH4wQ8HKjaq0zzDMEhjUajuc+I
        2gqKjl7PMWNgnVW1CKJ0SHGdwP5taJwIWNXfW2/CPJk1KiBmmpAWuhMD0QRbb7Mkyz6X8yccQKuy9
        LwJmDPM5t2FCpZpQ1HDlU/LWbpVXG6gywDpyPm2FZmyNp2MlOf/OI34qdin0ZFZQsln9rpIwt69Q3
        LY86abOa6nvuVESDL4i1wFutAgbmLXwaAe4InfUkDbE+iMP6XUCuF/KsgI3egW9OL6dcz1EFR0g8c
        cjfRO2ufg1f+oE/voQlqvGnstyooiWZvJwxjuEd0rshVpeCZ3bmYdcOjrFDXLLL+jkVbMReXlkfrF
        FT75pFUw==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIYn-002fAV-9F; Mon, 20 Sep 2021 12:38:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/17] block: remove the unused rq_end_sector macro
Date:   Mon, 20 Sep 2021 14:33:19 +0200
Message-Id: <20210920123328.1399408-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-rq.c       | 1 -
 include/linux/elevator.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 5b95eea517d1b..79974bb0d250f 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -7,7 +7,6 @@
 #include "dm-core.h"
 #include "dm-rq.h"
 
-#include <linux/elevator.h> /* for rq_end_sector() */
 #include <linux/blk-mq.h>
 
 #define DM_MSG_PREFIX "core-rq"
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index ef9ceead3db13..80633f3b600c2 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -162,7 +162,6 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define ELEVATOR_INSERT_FLUSH	5
 #define ELEVATOR_INSERT_SORT_MERGE	6
 
-#define rq_end_sector(rq)	(blk_rq_pos(rq) + blk_rq_sectors(rq))
 #define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
 
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
-- 
2.30.2


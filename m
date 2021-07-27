Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18583C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE3A61108
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhG0GdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0GdA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:33:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45015C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FXdF4EZSXmVp/dLgSh7XkFHoxuX06wGclM8vJvZxtes=; b=UF4ZgyT3Ishk05ITHot+AlXACZ
        SRWaqflj0RI7zkWLtVxYPpGi88Ol7VEEhdU17nqy4sgYTlu0tA29pw9c3oddqVzqjyzzVX+iZc6/X
        io1oOkOQAulE6dLvesZ9SVXnB0LhAZXTbDDz8uXps7SM+cH9bh/sv46SV7mjtrErYx63gvfXAaTCV
        1TqUMdQadTgsM6wOT/j6EGu7NuLJs1hAOWDWcjeyDglD35VtqHHgPOtPNnr7G4fg2dvffXUNwSYJC
        vb8F8IfEr72O9We5t/6ZepOYrYUYtzlaaiYvx6Vk8ZGGEhuxTZHcFBqWyhYw8XnfLV5wBmY6+NNv1
        EYC07jKg==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GcU-00EkZP-MU; Tue, 27 Jul 2021 06:31:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: simplify disk name formatting in check_partition
Date:   Tue, 27 Jul 2021 08:25:17 +0200
Message-Id: <20210727062518.122108-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_name for partition 0 just copies out the disk_name field.  Replace
the call to disk_name with a %s format specifier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4230d4f71879..48e001aa1930 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -136,7 +136,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	state->pp_buf[0] = '\0';
 
 	state->bdev = hd->part0;
-	disk_name(hd, 0, state->name);
+	snprintf(state->name, BDEVNAME_SIZE, "%s", hd->disk_name);
 	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
 	if (isdigit(state->name[strlen(state->name)-1]))
 		sprintf(state->name, "p");
-- 
2.30.2


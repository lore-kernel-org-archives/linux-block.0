Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2BB6103C
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhIOGwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhIOGwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:52:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFFC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=opY5yNG9aaBSMMSQn/Gu6NHBK9MuMIt+xgH/pqHpWWY=; b=LpjDuFzaVCmz2VVxiPakt1VI4d
        IhmIkofy0NsB6zUJzObNLC65vdpvxdGnJU/yaCX54LDfiRpYBCWiagPyCqy8jJIr6AwjIALY8Gk3j
        MQOTKwlg1Id2gQkV0Fl6kc03Lr1ruAp6+74IBcuAuY+LoM9XprWj4BNWXjqVH6BuHAo16sRz7B8lP
        NClcl34FhFZ+YrEy9UU6C6WEqSZn/eptzw1Ds1Cn4FfZDoXevpqYkTEOOoYrtqtMX7KG+GHw2JCmR
        ngMFDACkOOC8tDB6ngJVd56eLTSv5coCv5y6+wBS82vQmJ4gNbuZVfMjK419YKs7lzMTcr4fFd813
        tSSw9k3g==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOkG-00FR3H-No; Wed, 15 Sep 2021 06:50:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/17] block: remove the struct blk_queue_ctx forward declaration
Date:   Wed, 15 Sep 2021 08:40:38 +0200
Message-Id: <20210915064044.950534-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This type doesn't exist at all, so no need to forward declare it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6737e484280d3..4bcbb1ae2d66a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -253,8 +253,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 
 #include <linux/elevator.h>
 
-struct blk_queue_ctx;
-
 struct bio_vec;
 
 enum blk_eh_timer_return {
-- 
2.30.2


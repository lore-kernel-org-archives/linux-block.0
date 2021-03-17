Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE0C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 07:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFBD64F4D
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQHYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 03:24:10 -0400
Received: from casper.infradead.org ([90.155.50.34]:47240 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQHXq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 03:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wag0Bl1ZU57/qCMf2GGcuNfV4n2palPTyTsJjQBgB20=; b=U7tlJ5xjGVaxh5u0szcJiuZxDk
        efDVe27x51js9tKW6XHkPdAWSwxhj2h9KWgAKVmAS7OO8cp1+MU1cDAeiPsD5H/da95TyFGUiaa5v
        dYNtFVXcxrtKY1eP5/ZjBfqBc0DBW10O4SpViA34KZYTx79m/lBIMo9BS0LTgSllcNwQb6MhDoMf2
        omQ+RBW1je86RXAILzNNDA08P42sFqRmBOVkADQkZYRzVZlRQyFww3i1qt1Q3x5+x9J8dUypesJ+F
        AMhv/L9Qkf7eiKoF1wQ9NTQs1qvlj2zi7zmT/hxAkxS1LUeNzR6yw48LixyCJm+RuwIQUzft5zWa9
        SgiTH8xA==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMQWj-001Cmy-L4; Wed, 17 Mar 2021 07:23:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove RQF_ALLOCED
Date:   Wed, 17 Mar 2021 08:21:22 +0100
Message-Id: <20210317072122.155380-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This flag is not used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b434e..158aefae1030db 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -85,8 +85,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
 /* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* request came from our alloc pool */
-#define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
 /* runtime pm request */
 #define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
-- 
2.30.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBFBC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46CC23D4D
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgLJH4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgLJH42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 02:56:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716BC0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 23:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mNGOwSgaKJejoStArKZv6NFL3tjCO5r47qJ3FVQSWYM=; b=GpOvDLmeUrLOwYkBlRTcfjnKf0
        YwLHaZdLWc6gpjPCSibIvJmsru/IyWcaYRdkt9fbw7m7nUjEuXzLXYV7wAqA2XywpJxknX/64S1pl
        1P5U47IoQWQuGilQZ3qrxKwEtDJJ2Pe2YD3vhAWUUvQLWhaWy1K+LQsoG3z1MsK/IS8gY9aup8Slm
        wBYMN7PwXhwfhGbod0+XN9MSFiE+HQjMsaPWyX3ibbH0INzLSlj4nbTPJUnuvdOnijtC5co/AudGA
        2K3Vjz9dj1We8o1CfRxT0u8pLhzY+dJsqk61RfI+PCNkV9vi7eYhds6Jybiy8Jrb9lpSzw/+d87/P
        zOobKLLg==;
Received: from [2001:4bb8:199:f14c:a24a:d231:8d9c:a947] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knGni-0002ZK-Fb; Thu, 10 Dec 2020 07:55:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: add fs/block_dev.c to the block section
Date:   Thu, 10 Dec 2020 08:55:42 +0100
Message-Id: <20201210075544.2715861-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210075544.2715861-1-hch@lst.de>
References: <20201210075544.2715861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

fs/block_dev.c is a pretty integral part of the block layer, so make
sure it is mentioned in MAINTAINERS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f00..49ebab558139c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3192,6 +3192,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	block/
 F:	drivers/block/
+F:	fs/block_dev.c
 F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
-- 
2.29.2


Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E36C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8259E208DB
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3arlM32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbgE1RV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 13:21:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B6C08C5C6;
        Thu, 28 May 2020 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fhvwApKi7hFfnbClTcE5ZRTBxezOiN4RHKZN34MfLVY=; b=j3arlM32mybwAh1hGcKe02vBYr
        6bQE1Q6w1QypYIeBacisUEzc4QIP/OJeCOHbuqS1sKo73mjzB5mTcjcstiieRHiEIAlTPbhaC1kdx
        2ly+izFST1O2kvWwZ+WEskGMzuQpEsU8QwH17tHxxslCnDOf5n4Q3FbwZPm4VlvhQJdFmixYb6sPQ
        T6ytsx2uGv+1h6xkV1LH5vvfbbs/LN0ktxC6Qamrx5Wt6vypxuMO1g3FwxffcXNOVVtaZJ/zr3193
        uzwstPGX+9+KwNxewzN8yhBG5eHlfsnVVWLCcmzX6E+WV8SAaPisq0vpejJmunjXKGrpiLx1ZgL9f
        Vhel679w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeME9-0006YK-2o; Thu, 28 May 2020 17:21:57 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] block: add another struct gendisk to <linux/blkdev.h>
Message-ID: <9a8676b1-c79e-9963-3ffc-c113b11d988d@infradead.org>
Date:   Thu, 28 May 2020 10:21:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add a forward declaration for struct gendisk when CONFIG_BLOCK is
not set/enabled to prevent multiple (30 - 50) build warnings.

In file included from ../kernel/sched/sched.h:39:0,
                 from ../kernel/sched/core.c:9:
../include/linux/blkdev.h:1895:41: warning: 'struct gendisk' declared inside parameter list will not be visible outside of this definition or declaration
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
                                         ^~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 include/linux/blkdev.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200528.orig/include/linux/blkdev.h
+++ linux-next-20200528/include/linux/blkdev.h
@@ -1836,6 +1836,7 @@ static inline bool blk_req_can_dispatch_
 #else /* CONFIG_BLOCK */
 
 struct block_device;
+struct gendisk;
 
 /*
  * stubs for when the block layer is configured out


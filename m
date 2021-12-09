Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75736C433FE
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhLIGfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhLIGfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10289C0617A1
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iNhB2F+DQBk25j1m+zjBB+NXxsYM9P2plArpomO4DGg=; b=YxhaAOF2YhCgJTxnnLg0g/NGnn
        lke29kzrCOjw4NJ+78Ov1jdp4IhlK1g2dc9MLkkJ/SORlly7lQ2xadwNgTi/qOmCAW9X9IeyXVuB4
        LBRPb3tVi/9SYwgb64QopDewan7a8q8sfRX7zC+yF8YRfiSvgiQFxXKfh7c9U8LGQn8fEBZxc/tX4
        tlCNCefjAR9sjIcKBTPPly1U+tQUtdz7SbVGuu6JR1ElvJhZUE/3xEB71P95gbLZGAPL3g+258DSV
        nG4Ec6EYXnX0PxRw9ayE1XSK4OwFgh04Qzneh4FcxSgLADk3V3hI4o5KiSUMNa2BhskGykEmwd67c
        +B/s688Q==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxo-0096ST-9G; Thu, 09 Dec 2021 06:31:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: more I/O context cleanup v2
Date:   Thu,  9 Dec 2021 07:31:20 +0100
Message-Id: <20211209063131.18537-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series dusts off a few more bits in the I/O context handling, and
makes a chunk of code only needed by the BFQ I/O scheduler optional.

Changes since v1:
 - fix a comment typo
 - keep the RCU critical section in ioc_clear_queue
 - add a few more cleanups

Diffstat:
 block/Kconfig             |    3 
 block/Kconfig.iosched     |    1 
 block/blk-ioc.c           |  247 ++++++++++++++++++++--------------------------
 block/blk.h               |    6 +
 block/ioprio.c            |   32 -----
 include/linux/iocontext.h |    9 -
 6 files changed, 125 insertions(+), 173 deletions(-)

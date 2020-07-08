Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819EC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21882078D
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jh/luEok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgGHMpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:45:04 -0400
Received: from casper.infradead.org ([90.155.50.34]:34092 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGHMpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 08:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iIrUNIZ1TvkRMtCfNO8fsXHL6aBOpwrsvSgJNfYzcrQ=; b=jh/luEoktv4g70nSBL4er/hYuZ
        utfCfy2saLEAxFyxTIc9K8Wkvcdo/Eiq6JnBBJu0vHaZHL7WII0HsgDI+g9v8pAlT/nEhWmUm1Gt+
        LzFMXPl/9fETVNb3orDJ061cp+FBEZrjW1c0rQc/VIn1/iaYoOIpkgjREQaRruDz9MO1DSDClcBkE
        kIuEDsC02WSRaCnnzPiNpJBeRuwxsjSu0NGYtRxWZ56KiLCvcdx9Wd0qCE/7D8AXRMckkK44vJCD6
        q9ITdWBP6tumqiCor2JtqRE/C/vLD89XS6BNnTJuQ2tykWUeBrtpydu7YorxlJVkA9KxLelXNoqu2
        RUJbDicQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9B8-0001oQ-Ap; Wed, 08 Jul 2020 12:28:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove leftovers of the old ->media_changed method
Date:   Wed,  8 Jul 2020 14:25:40 +0200
Message-Id: <20200708122546.214579-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series converts md as the last user of the ->media_changed method
over to the modern replacement, and then cleans up a few lose ends in
the area.

Diffstat:
 Documentation/cdrom/cdrom-standard.rst |   18 +-----------------
 Documentation/filesystems/locking.rst  |    4 +---
 arch/xtensa/platforms/iss/simdisk.c    |    2 --
 block/genhd.c                          |    7 +------
 drivers/cdrom/cdrom.c                  |   28 +++++-----------------------
 drivers/md/md.c                        |   19 ++++++++-----------
 drivers/mmc/core/block.c               |    3 ---
 fs/block_dev.c                         |   30 +++++++-----------------------
 fs/isofs/inode.c                       |    3 ---
 include/linux/blkdev.h                 |    2 --
 include/linux/cdrom.h                  |    2 --
 11 files changed, 23 insertions(+), 95 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321EC43217
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiKNE0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiKNE0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545C6588
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hY7YBMJc1QQnz8XcekSn67uNhcHkIsSIbkXcDugLNmI=; b=RgMH7BN5b4qXt0rwCyaz+B49CO
        2X+MvtbIA5tYzce9793yoSdgIx7CMS5X0pFzj3WyMCsEmFCPCvBJ3V9H2WMsDis4KvqjtfJVWK2UU
        PyNB3hvunMr2gApBex3iTcBm+d63I6jeKw0MadaoSA1/mtjqSvyAR5VEXB4s4vaBKh3M8Dd+4OXod
        dfaCJ8G4qqj3ScOBoVFCy9wXDCwYuQq/5y+nZSeWGcTjKVFS2yRhCOjCiZWdgG/GsPsoL/25qH1Q/
        uiXRCx9FgXfhmtwtdXIrX2dfEUFjBfdQSdqqSOQvUtlera8jc/K3y/eyKkpwPWEk+jQVk0ghE9mwb
        9aEDgU+A==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3Q-00Fv58-7G; Mon, 14 Nov 2022 04:26:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: untangle the request_queue refcounting from the queue kobject v2
Date:   Mon, 14 Nov 2022 05:26:32 +0100
Message-Id: <20221114042637.1009333-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up the registration of the "queue/" kobject, and given
untangles it from the request_queue refcounting.

Changes since v1:
 - also change the blk_crypto_sysfs_unregister prototype
 - add two patches to fix the error handling in blk_register_queue

Diffstat:
 block/blk-core.c            |   44 +++++++++++----
 block/blk-crypto-internal.h |   10 ++-
 block/blk-crypto-sysfs.c    |   11 ++-
 block/blk-ia-ranges.c       |    3 -
 block/blk-sysfs.c           |  129 +++++++++++++++++---------------------------
 block/blk.h                 |    4 -
 block/bsg.c                 |   11 ++-
 block/elevator.c            |    2 
 include/linux/blkdev.h      |    6 --
 9 files changed, 108 insertions(+), 112 deletions(-)

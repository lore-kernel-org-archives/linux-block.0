Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF59C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGTOZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiGTOZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A11509E3
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=818n4hghSWcZdXj4DaV+zo1nD4qlSvKhLsny4MC7WzE=; b=L2JeP5YIjJ5RmGP1L0jp18wB5p
        HljUsfpSNlhMwARgFiuZCctEbIHUeOseEW3jPeNR0uq2BkZcuivNWe5/78hq+6tJEEloRo6RsZDJK
        rDm4ZwWe8qHxygnHCJi57ReEvZwXtx6q0tLZBfahiGF11ACS7gpX778QU8f4LuiqPINCH6uWaQ2UN
        1mDtTMdlcRLmMeQVI0mbfnREcc5t3xiFU/8098RwTeJ674IoSZtMigpt5HByIut8QG7gKCpSJ6RkU
        6n9A8gtq/wXJv44heOV1fRf/CtclNb4KI8aw0t4KDe6fgmXfSL0OJqEqAdH07cFNUGaKOgz2T1LiP
        Dha2n5nA==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdH-006nby-Ek; Wed, 20 Jul 2022 14:24:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio splitting cleanups
Date:   Wed, 20 Jul 2022 16:24:51 +0200
Message-Id: <20220720142456.1414262-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has two parts:  the first patch moves the ->bio_split
bio_set to the gendisk as it only is used for file system style I/O.

The other patches reshuffle the bio splitting code so that in the future
blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
under file system / remapping driver control.  I plan to use that in
btrfs in the next merge window.

Diffstat:
 block/bio-integrity.c  |    2 
 block/bio.c            |    2 
 block/blk-core.c       |    9 ---
 block/blk-merge.c      |  139 ++++++++++++++++++++++++-------------------------
 block/blk-mq.c         |    4 -
 block/blk-settings.c   |    2 
 block/blk-sysfs.c      |    2 
 block/blk.h            |   34 ++++-------
 block/genhd.c          |    9 ++-
 drivers/md/dm.c        |    2 
 include/linux/blkdev.h |    3 -
 11 files changed, 100 insertions(+), 108 deletions(-)

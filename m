Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D58C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 06:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGWG2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGWG2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 02:28:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481712610
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=knAv6nOULEyOrhTClimVOOiTjo03B7WeTgvQxj5gV+4=; b=ylyDWptgbvBQf0K3V/uR0bcVG2
        CZAQMh1M+ZzCmOkTZVxfabYj/t9AmljMGooT2dFJl5efLc26fI3b3GKAq3ouo2Eh2elf0dgWXTvES
        SJe1cjsWZR6KHJj8OdRE0G5dLHLZDe0xqsri69teR2qY76CH49jy7qYlp65Vtb5ipO9ecuhFOFiZR
        9jZWMScjQjTbxMKZAXws88d5TWioVuDaGPsCQdemWkhFHuUA6mtjKLYAIUxXj/8hdiJvfjdRh6Q2c
        X3ouHsRvOFKUiahAf74nF11wLpLE1OBUE2EhSqkmT7Y6Bap6blYivamYeEmkZ5bRuJwsxt3FD2fgC
        qJ6YcaEQ==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8cc-00GLdN-LU; Sat, 23 Jul 2022 06:28:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio splitting cleanups v2
Date:   Sat, 23 Jul 2022 08:28:10 +0200
Message-Id: <20220723062816.2210784-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has two parts:  the first part moves the ->bio_split
bio_set to the gendisk as it only is used for file system style I/O.

The other patches reshuffle the bio splitting code so that in the future
blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
under file system / remapping driver control.  I plan to use that in
btrfs in the next merge window.

Changes since v1:
 - drop a bogus patch
 - fix a comment typo
 - fix a commit log typo
 - clean up the blk_queue_split calling convention and name

Diffstat:
 block/bio-integrity.c         |    2 
 block/bio.c                   |    2 
 block/blk-core.c              |    9 --
 block/blk-merge.c             |  186 +++++++++++++++++++++---------------------
 block/blk-mq.c                |    6 -
 block/blk-sysfs.c             |    2 
 block/blk.h                   |   47 ++++------
 block/bounce.c                |   26 ++---
 block/genhd.c                 |    8 +
 drivers/block/drbd/drbd_req.c |    2 
 drivers/block/pktcdvd.c       |    2 
 drivers/block/ps3vram.c       |    2 
 drivers/md/dm.c               |    8 -
 drivers/md/md.c               |    2 
 drivers/nvme/host/multipath.c |    2 
 drivers/s390/block/dcssblk.c  |    2 
 include/linux/blkdev.h        |    5 -
 17 files changed, 154 insertions(+), 159 deletions(-)

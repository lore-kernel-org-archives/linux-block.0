Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiBBQBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbiBBQBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2239C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=h6DGnPAi6icKpLNtt8Hb/HkwHAnwlWy1Evj+0HJb+8c=; b=AWahWlSz0YktSw/gVWlIFiRi0O
        6McquSFvdCPlYwTVdvemGueZnId79bkBYFk197k+1sXdSPY337d69WaIzlR1NJYO/xs6Ua6NpTSrQ
        cDnrGvQ+6n19vTEABc+pGR5mS4aGPtib/UNCLGoilYqFf94UuWsBjox0qy2LX0jrSK1klQDHplGk6
        gSyI2dBA0mjs7E9rMl3WMsDLQKgkMaoYGk1Wg7InZncLq0C/Qn7GjimHEpmEWyTuR4fiy281IRLcK
        Jq5XTlw0HdqoiUTTradOV1xJNZm5ShFio2d9FAEFA4Uke0BZa+tYTK2TaIP/r5STx9nAzUq1sq9Ct
        Kib78m1A==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4F-00G7vu-Ff; Wed, 02 Feb 2022 16:01:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: improve the bio cloning interface v2
Date:   Wed,  2 Feb 2022 17:00:56 +0100
Message-Id: <20220202160109.108149-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series changes the bio cloning interface to match the rest changes
to the bio allocation interface and passes the block_device and operation
to the cloning helpers.  In addition it renames the cloning helpers to
be more descriptive.

To get there it requires a bit of refactoring in the device mapper code.

Changes since v1:
 - rebased to the lastest for-5.18/block tree
 - fix a fatal double initialization in device mapper

A git tree is also available here:

    git://git.infradead.org/users/hch/block.git bio_alloc-cleanup-part2

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio_alloc-cleanup-part2

Diffstat:
 Documentation/block/biodoc.rst   |    5 -
 block/bio-integrity.c            |    1 
 block/bio.c                      |  106 +++++++++++++-----------
 block/blk-crypto.c               |    1 
 block/blk-mq.c                   |    4 
 block/bounce.c                   |    3 
 drivers/block/drbd/drbd_req.c    |    5 -
 drivers/block/drbd/drbd_worker.c |    4 
 drivers/block/pktcdvd.c          |    4 
 drivers/md/bcache/request.c      |    6 -
 drivers/md/dm-cache-target.c     |   26 ++----
 drivers/md/dm-crypt.c            |   11 +-
 drivers/md/dm-zoned-target.c     |    3 
 drivers/md/dm.c                  |  166 +++++++++++++--------------------------
 drivers/md/md-faulty.c           |    4 
 drivers/md/md-multipath.c        |    4 
 drivers/md/md.c                  |    5 -
 drivers/md/raid1.c               |   34 +++----
 drivers/md/raid10.c              |   16 +--
 drivers/md/raid5.c               |    4 
 fs/btrfs/extent_io.c             |    4 
 include/linux/bio.h              |    6 -
 22 files changed, 183 insertions(+), 239 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97E46135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTOnk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJTOnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E1C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/d7SxdTOz8o3QCIg6YnBTDFytTv16oogtzt7IBzTkCQ=; b=DzoaZC7a9YkcwfW9zhxXttu+lh
        mfHH15h2BdyHdY8RbHGtR/0IwmxEc4KlVE4dA9aOwNqEJByquo6AKFiQA6KiOzLsM1fDi31pRIeFN
        1WsjqlRa4HlnLRjKZ6wDlOmREQyAcvK/22rAKBn67OLS6skn+0mJXcOnzSXP87SVm3uckO6OLBq01
        TSfe80Ycw9c3e/O+R04Gy1m6SNp58YULrR8M98oEJCwKn8RMXY4ICrfH5HGnzFbpJPFsq25fpmhSN
        Z+NXgXPb3b9vu+wmhZ8PDrefDqNRQcVYzqmKm+gn3uP5bsJVbVV57JBA0ymPeMAeCDfQ2FetPZ5wT
        N75KTKoQ==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCmR-004oEp-S0; Wed, 20 Oct 2021 14:41:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: cleanup and optimize block plug handling
Date:   Wed, 20 Oct 2021 16:41:15 +0200
Message-Id: <20211020144119.142582-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this is a spinoff from Pavel's misc optimizations.  It shuld take care
of his two painpoints and also cleans up the interface for flushing
plugs a bit.

Diffstat:
 block/blk-core.c       |   17 ++++++++---------
 block/blk-mq.c         |    2 +-
 block/blk-mq.h         |    1 +
 fs/fs-writeback.c      |    5 +++--
 include/linux/blk-mq.h |    2 --
 include/linux/blkdev.h |   29 ++++-------------------------
 kernel/sched/core.c    |    5 +++--
 7 files changed, 20 insertions(+), 41 deletions(-)

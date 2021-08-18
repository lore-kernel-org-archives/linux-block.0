Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E68C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF68F610E5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhHROsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhHROsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:48:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DFC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ueb0FU874/kNzcB75UFmzLaPePixjHf/+ZuKck7YC8M=; b=LzuBiC+mGMGAm0wFhxOgzLic7K
        OvxrmN+4C18mKvIydlYhfSgVmYJryRXoDEpz1+z04o2L/rtxod3UznhB+EpfSwjjW+Usg481thED3
        axr+pEUiT0Uov3usoTEGwOqEWbWCP2Qr9H5mFnxOkWegkY15IBsaJWnBbnj3qBnmD8aCR5fR5Q734
        p+3f/ew1xZU5aXu2MEyt124f55nxih8yrAmywqbOhqh7YNyYeeqxRAty2wLUu7s967x8Ww0eqeRQc
        upuc8qYHtb1WZSAEt/jy4PtWUaoBDbh0W8x8wE7ZrK6ZIhz5mP9Fu23Jkouf9U2O0dhwa9UVIXbjS
        RJ/EMzEw==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMp5-003wSL-FJ; Wed, 18 Aug 2021 14:46:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: add error handling to add_disk / device_add_disk
Date:   Wed, 18 Aug 2021 16:45:31 +0200
Message-Id: <20210818144542.19305-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series does some refactoring and then adds support to return errors
from add_disk (rebasing a patch from Luis).  I think that alone is a huge
improvement as it leaves a disk for which add_disk failed in a defined
status, but the real improvement will be actually handling the errors in
the drivers.  This series contains two trivial conversions.  Luis has
a tree with conversions for all drivers in the tree, which will be fed
incrementally once this goes in.  Hopefully we can convert all the
commonly used drivers in this merge window.

This series sits on top of:

   "ensure each gendisk always has a request_queue reference v2"

A git tree is available here:

    git://git.infradead.org/users/hch/block.git

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/add-disk-error-handling

Diffstat:
 block/blk-integrity.c         |   12 +-
 block/blk-sysfs.c             |    9 --
 block/blk.h                   |    7 -
 block/disk-events.c           |    7 -
 block/genhd.c                 |  186 ++++++++++++++++++++++--------------------
 drivers/block/null_blk/main.c |    3 
 drivers/block/virtio_blk.c    |    7 +
 include/linux/genhd.h         |    8 -
 8 files changed, 125 insertions(+), 114 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9124C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 07:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiC2Hdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiC2Hdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 03:33:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D924A75F
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ez2NI4Q1HqExaSrgvjuYMBA2xGi6O0vr2aWT3pRhjwY=; b=2GLDbezkG/k1ssY/ZerOhGwKi9
        TVE5VoJZ2VCbCryQVeGzMdEWwjpPS6l/HPsWGt8dkNJiGIZZ3d++YdjZy6+ft8hjIztp7IIJH/YnX
        At4U3WZ8my2jmm5jC8LA0ku9Czp836oN5cR7G8Zi8NsxTEKMTZa/Ma4SfvuMvlceZS5IWbbxayPJC
        9oCOrOZMBL7BTnBgz+AIob4dWyAg7kYfmPtEzNhTeaZ8nuqO+Tywj3mnxoCXJmrafMVePXhHEyUYE
        gI6CM8aVhrcMo7QPI79YYeLdNcnxwxkBJHPJeFuzUa6BYf9Na/Fi3HfxOm33ocy5xBVEZrE7hmzXM
        aVRD2TIw==;
Received: from [94.198.141.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ6KX-00BL8y-2w; Tue, 29 Mar 2022 07:31:53 +0000
Date:   Tue, 29 Mar 2022 09:31:45 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.18
Message-ID: <YkK14fRnn3GVpGxQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b2479de38d8fc7ef13d5c78ff5ded6e5a1a4eac0:

  n64cart: convert bi_disk to bi_bdev->bd_disk fix build (2022-03-21 06:34:45 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-29

for you to fetch changes up to a4a6f3c8f61c3cfbda4998ad94596059ad7e4332:

  nvme-multipath: fix hang when disk goes live over reconnect (2022-03-29 09:29:06 +0200)

----------------------------------------------------------------
 for Linux 5.18

  - fix multipath hang when disk goes live over reconnect (Anton Eidelman)
  - fix RCU hole that allowed for endless looping in multipath round robin
    (Chris Leech)
  - remove redundant assignment after left shift (Colin Ian King)
  - add quirks for Samsung X5 SSDs (Monish Kumar R)
  - fix the read-only state for zoned namespaces with unsupposed features
    (Pankaj Raghav)
  - use a private workqueue instead of the system workqueue in nvmet
    (Sagi Grimberg)
  - allow duplicate NSIDs for private namespaces (Sungup Moon)
  - expose use_threaded_interrupts read-only in sysfs (Xin Hao)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix hang when disk goes live over reconnect

Chris Leech (1):
      nvme: fix RCU hole that allowed for endless looping in multipath round robin

Colin Ian King (1):
      nvmet: remove redundant assignment after left shift

Monish Kumar R (1):
      nvme-pci: add quirks for Samsung X5 SSDs

Pankaj Raghav (1):
      nvme: fix the read-only state for zoned namespaces with unsupposed features

Sagi Grimberg (1):
      nvmet: use a private workqueue instead of the system workqueue

Sungup Moon (1):
      nvme: allow duplicate NSIDs for private namespaces

Xin Hao (1):
      nvme-pci: expose use_threaded_interrupts read-only in sysfs

 drivers/nvme/host/core.c          | 38 ++++++++++++++++++++++++++------------
 drivers/nvme/host/multipath.c     | 32 +++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h          | 23 +++++++++++++++++++++++
 drivers/nvme/host/pci.c           |  7 +++++--
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/configfs.c    |  2 +-
 drivers/nvme/target/core.c        | 26 +++++++++++++++++++-------
 drivers/nvme/target/fc.c          |  8 ++++----
 drivers/nvme/target/fcloop.c      | 16 ++++++++--------
 drivers/nvme/target/io-cmd-file.c |  6 +++---
 drivers/nvme/target/loop.c        |  4 ++--
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        | 12 ++++++------
 drivers/nvme/target/tcp.c         | 10 +++++-----
 include/linux/nvme.h              |  1 +
 16 files changed, 133 insertions(+), 57 deletions(-)

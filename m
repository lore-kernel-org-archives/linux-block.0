Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F4C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A506B64F59
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBBJei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhBBJeO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:34:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F9EC06174A
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iRa22Ar6Ooo4KG4nCBybV9MasxMnSD0i/XFg7+z6V9c=; b=XBX4R5nr7Y+Tq6eLOpYkJUk5du
        +cyQVydaTjHlbpwd00xL0eH5z5836s45CJfuEGrGBh3WJUmjCobKiUyxNCXPptPxGE7/Fnm9DFoWW
        AJIW4zEesEOlVjI/bqdBRHR2u3kjz5z6bLo4SoMKjbRBRPVHeobY7GUZqhv8vfr7wbhh4JZfGFwwV
        21/ApjLR42XWJZlHT8AgZfmj9k9J2AHYU8BSaJEZl717/l9gayBFXOQn2R2LWtblV/KAolkzgGDoI
        rv4Fe7qsIybU+Tk9/VzbdB8oZBCWViAvJa8VanvaUU7yBH0j6Mm9HdWl8owywkkYugVU4ZsK8zBp0
        yFbYQKTg==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6s3l-00EzXn-Jk; Tue, 02 Feb 2021 09:33:22 +0000
Date:   Tue, 2 Feb 2021 10:33:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for 5.12
Message-ID: <YBkcYFf7hJfpK+vl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e8628013e5ddc7cf78cc2f738ab760e8c0fa8559:

  drbd: Avoid comma separated statements (2021-01-31 08:05:36 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.21-2020-02-02

for you to fetch changes up to 563c81586d0ab2841487a61fb34d6e9cd5efded7:

  nvme-tcp: use cancel tagset helper for tear down (2021-02-02 10:26:13 +0100)

----------------------------------------------------------------
nvme updates for 5.12:

 - failed reconnect fixes (Chao Leng)
 - various tracing improvements (Michal Krakowiak, Johannes Thumshirn)
 - switch the nvmet-fc assoc_list to use RCU protection (Leonid Ravich)
 - resync the status codes with the latest spec (Max Gurtovoy)
 - minor nvme-tcp improvements (Sagi Grimberg)
 - various cleanups (Rikard Falkeborn, Minwoo Im, Chaitanya Kulkarni,
   Israel Rukshin)

----------------------------------------------------------------
Chaitanya Kulkarni (5):
      nvmet: remove extra variable in smart log nsid
      nvmet: remove extra variable in id-desclist
      nvmet: remove extra variable in identify ns
      nvmet: add lba to sect conversion helpers
      nvme-core: get rid of the extra space

Chao Leng (5):
      nvme-core: add cancel tagset helpers
      nvme-rdma: add clean action for failed reconnection
      nvme-tcp: add clean action for failed reconnection
      nvme-rdma: use cancel tagset helper for tear down
      nvme-tcp: use cancel tagset helper for tear down

Israel Rukshin (2):
      nvmet: Use nvmet_is_port_enabled helper for pi_enable
      nvmet: Fix nvmet_is_port_enabled indentation

Johannes Thumshirn (1):
      nvme: add tracing of zns commands

Leonid Ravich (1):
      nvmet-fc: use RCU proctection for assoc_list

Max Gurtovoy (1):
      nvme: update enumerations for status codes

Michal Krakowiak (1):
      nvme: parse format nvm command details when tracing

Minwoo Im (2):
      nvme: support command retry delay for admin command
      nvme: refactor ns->ctrl by request

Rikard Falkeborn (1):
      nvme: constify static attribute_group structs

Sagi Grimberg (3):
      nvme-tcp: fix wrong setting of request iov_iter
      nvme-tcp: get rid of unused helper function
      nvme-tcp: pass multipage bvec to request iov_iter

 drivers/nvme/host/core.c          | 37 +++++++++++++-----
 drivers/nvme/host/fc.c            |  2 +-
 drivers/nvme/host/nvme.h          |  2 +
 drivers/nvme/host/rdma.c          | 30 +++++++++------
 drivers/nvme/host/tcp.c           | 55 +++++++++++++-------------
 drivers/nvme/host/trace.c         | 53 +++++++++++++++++++++++++
 drivers/nvme/target/admin-cmd.c   | 71 ++++++++++++++++------------------
 drivers/nvme/target/configfs.c    |  6 +--
 drivers/nvme/target/fc.c          | 81 ++++++++++++++++++---------------------
 drivers/nvme/target/fcloop.c      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  8 ++--
 drivers/nvme/target/nvmet.h       | 10 +++++
 include/linux/nvme.h              | 30 ++++++++++++---
 13 files changed, 243 insertions(+), 144 deletions(-)

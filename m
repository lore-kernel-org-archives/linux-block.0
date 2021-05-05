Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D3C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E8E613BE
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhEEObh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhEEObg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 10:31:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142EC061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3GseHQCOIbUNnOllumCqVN6wzm81HRtZY3U8DLA8vK8=; b=0q3ayFBPZRmm5iiVN6hai3Y7eX
        H/tfUGyEXJ52CtHw7EEUYpLPlYZdMDbU+7v+lp8Z3Ia04SPr213t/Idc/G9c9HJgATeLoTOa6nBkm
        YmEoK01qUBJF4V0jvE7BsGVffqW8Lvi2aQKDjEGaierW4E9nStpjtmVH3Zqpf7/eo5z3SUkNfNeHe
        7PhMPRFTScxlFqWvXOXZrHGWI5R/K8wr4IgxWk9sKqvKjmb21O9pfBJQV22zW2bCcPFHvAvhuIvYY
        mDjpHLdqxGXVnhJ9r7bn/TEbO6HmTO0Ka6NTtMr/CGToFVnN0zIyR5d+v/GYvTTRgmsnHVWY8Jmew
        WIAIUVhQ==;
Received: from [2001:4bb8:180:9479:fe4f:f2b:7c56:307a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leIXr-004pM9-0Z; Wed, 05 May 2021 14:30:35 +0000
Date:   Wed, 5 May 2021 16:30:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YJKsCBgfk5vjsUiQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit cd2c7545ae1beac3b6aae033c7f31193b3255946:

  bio: limit bio max size (2021-05-03 11:00:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-05

for you to fetch changes up to 4a20342572f66c5b20a1ee680f5ac0a13703748f:

  nvmet: remove unsupported command noise (2021-05-04 09:39:26 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.13

 - reset the bdev to ns head when failover (Daniel Wagner)
 - remove unsupported command noise (Keith Busch)
 - misc passthrough improvements (Kanchan Joshi)
 - fix controller ioctl through ns_head (Minwoo Im)
 - fix controller timeouts during reset (Tao Chiu)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme-multipath: reset bdev to ns head when failover

Kanchan Joshi (2):
      nvme: add nvme_get_ns helper
      nvme: avoid memset for passthrough requests

Keith Busch (1):
      nvmet: remove unsupported command noise

Minwoo Im (1):
      nvme: fix controller ioctl through ns_head

Tao Chiu (2):
      nvme: move the fabrics queue ready check routines to core
      nvme-pci: fix controller reset hang when racing with nvme_timeout

 drivers/nvme/host/core.c        | 98 +++++++++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c     | 57 ------------------------
 drivers/nvme/host/fabrics.h     | 13 ------
 drivers/nvme/host/fc.c          |  4 +-
 drivers/nvme/host/ioctl.c       | 65 +++++++++++++++++----------
 drivers/nvme/host/multipath.c   |  3 ++
 drivers/nvme/host/nvme.h        | 16 ++++++-
 drivers/nvme/host/pci.c         |  3 ++
 drivers/nvme/host/rdma.c        |  4 +-
 drivers/nvme/host/tcp.c         |  4 +-
 drivers/nvme/target/admin-cmd.c |  6 +--
 drivers/nvme/target/loop.c      |  4 +-
 12 files changed, 143 insertions(+), 134 deletions(-)

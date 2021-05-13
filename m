Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D57C433B4
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190AF61354
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhEMRFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhEMRE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 13:04:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF79C061574
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fiCWapO073jEA0FUhOiRuc4EhkynRDlHMqEG2raIyC4=; b=zqGQUb/zw4xOK/n5ziSLL5ZDYS
        4ggTWxZEvp57J1Ajy6OQaXn24aXWeBSH/XRSvEhStFKaJGl8BfcLkjQmELcnmRWwcqhW8c6DK1fLW
        WEQi5bqUQw3vu5idBHVtNVC8+Ccf/jxjMQN2gwnwXdBbjNyPDopO4RoAYhExjv5h8mPKhXGl1hl0k
        t/Q1TJWUuJ0bNPY5AxQslF7wvheu3UmpR2P0o8nm5/iafE4o7qoT4fgYB06oGeNXkvXXxG501e8zf
        Soigj4ipNRK87pE87zzeISKB4VQYwjUixf7RrsJ4x0qqEa4oB+uDa8jqrbdzLGmaLUCzMt1XTd/Kg
        cMRO8oHg==;
Received: from [2001:4bb8:198:fbc8:26bf:3bb3:2a36:e078] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhEkR-00BPAu-EY; Thu, 13 May 2021 17:03:44 +0000
Date:   Thu, 13 May 2021 19:03:40 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YJ1b7OeZpoR3j13K@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit efed9a3337e341bd0989161b97453b52567bc59d:

  kyber: fix out of bounds access when preempted (2021-05-11 08:12:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-13

for you to fetch changes up to e181811bd04d874fe48bbfa1165a82068b58144d:

  nvmet: use new ana_log_size instead the old one (2021-05-13 16:33:32 +0200)

----------------------------------------------------------------
nvme fix for Linux 5.13

 - correct the check for using the inline bio in nvmet
   (Chaitanya Kulkarni)
 - demote unsupported command warnings (Chaitanya Kulkarni)
 - fix corruption due to double initializing ANA state (me, Hou Pu)
 - reset ns->file when open fails (Daniel Wagner)
 - fix a NULL deref when SEND is completed with error in nvmet-rdma
   (Michal Kalderon)

----------------------------------------------------------------
Chaitanya Kulkarni (5):
      nvmet: fix inline bio check for bdev-ns
      nvmet: fix inline bio check for passthru
      nvmet: demote discovery cmd parse err msg to debug
      nvmet: use helper to remove the duplicate code
      nvmet: demote fabrics cmd parse err msg to debug

Christoph Hellwig (1):
      nvme-multipath: fix double initialization of ANA state

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

Hou Pu (1):
      nvmet: use new ana_log_size instead the old one

Michal Kalderon (1):
      nvmet-rdma: Fix NULL deref when SEND is completed with error

 drivers/nvme/host/core.c          |  3 ++-
 drivers/nvme/host/multipath.c     | 55 +++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h          |  8 ++++--
 drivers/nvme/target/admin-cmd.c   |  7 ++---
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  6 ++---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/io-cmd-file.c |  8 +++---
 drivers/nvme/target/nvmet.h       |  6 +++++
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        |  4 +--
 11 files changed, 58 insertions(+), 45 deletions(-)

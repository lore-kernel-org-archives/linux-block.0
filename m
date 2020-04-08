Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B216DC2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 06:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8665A20747
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 06:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nu4p8acJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDHGVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:21:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHGVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 02:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WQ2/BelqGc2mBQ3+MhcoOWmoQ/rHBX7wXBZCtSTUPOE=; b=Nu4p8acJ9WScpz7CjgxRfju+UH
        EBaZuoNnRsiBkfco7RUklUpyYCRpyJueOLwBXwhi7eWrd5EAUZKbMlCQdYjurWjIP5kwi0QjlhpI0
        TjGhfeqpBIOzkcGyJ81TMsa8dyRQkOQX7/3xm/ZniLe8cgf5TEcyaqpkPnyQDZk9Cl4jFqanN8vJo
        PtOF+59e/b/PynXcB/HVfU54tjiVaC6lDggP1MphEKj2lCDwYhPYKr3gKa0lwQB1geQ5/tTlsmMrU
        8ZrOPveCGI2QzqSnKK5l0zlE/mIo1DifS5kg8E+9p0LGjue1Ntt5eIqWtUXr9AqJsp988FAwoo0sN
        8ixBAWnw==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM45d-0007zu-PY; Wed, 08 Apr 2020 06:21:34 +0000
Date:   Wed, 8 Apr 2020 08:21:31 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     kbusch@kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 5.7
Message-ID: <20200408062131.GA212017@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 458ef2a25e0cbdc216012aa2b9cf549d64133b08:

  Merge tag 'x86-timers-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-03-30 19:55:39 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to 21f9024355e58772ec5d7fc3534aa5e29d72a8b6:

  nvmet-rdma: fix double free of rdma queue (2020-04-07 18:33:45 +0200)

----------------------------------------------------------------
Israel Rukshin (2):
      nvme-rdma: Replace comma with a semicolon
      nvmet-rdma: fix double free of rdma queue

James Smart (3):
      nvme-fcloop: fix deallocation of working context
      nvmet-fc: fix typo in comment
      nvme-fc: Revert "add module to ops template to allow module references"

Nick Bowler (1):
      nvme: fix compat address handling in several ioctls

Sagi Grimberg (7):
      nvme-tcp: fix possible crash in write_zeroes processing
      nvme-tcp: don't poll a non-live queue
      nvme-tcp: fix possible crash in recv error flow
      nvme: inherit stable pages constraint in the mpath stack device
      nvmet: fix NULL dereference when removing a referral
      nvmet-rdma: fix bonding failover possible NULL deref
      nvme: fix deadlock caused by ANA update wrong locking

 drivers/nvme/host/core.c        |  34 +++++--
 drivers/nvme/host/fc.c          |  14 +--
 drivers/nvme/host/multipath.c   |   4 +-
 drivers/nvme/host/rdma.c        |   2 +-
 drivers/nvme/host/tcp.c         |  18 ++--
 drivers/nvme/target/configfs.c  |  10 +-
 drivers/nvme/target/fc.c        |   2 +-
 drivers/nvme/target/fcloop.c    |  77 ++++++++++-----
 drivers/nvme/target/rdma.c      | 205 +++++++++++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_nvme.c   |   2 -
 drivers/scsi/qla2xxx/qla_nvme.c |   1 -
 include/linux/nvme-fc-driver.h  |   4 -
 12 files changed, 242 insertions(+), 131 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD90C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ECA61404
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhDVOPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhDVOPx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 10:15:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78DC06174A
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=F8NMnIEX/BAYPz90VJgRLYD8ulo3eabExPoF+jKA5eE=; b=aafr7cBr2009wwNCr2QTcjdZDB
        Jxe0usenJjDaH/0eBYN4l4HqCM36YVJsVac7CvGPcRspXWqcNhR0fk1Ojeq81lL3+CAvIJaWbNWEq
        2/gwGTfXtx8NzldEYNlcLaMrkk2T14ltQGz0FV1h5lhlf+gElrRVz68IMgUTQu5cuO4YI5Ujd3pkH
        OvVByvTcxqTE3WUBBQsSh3IqgtoAryHPG/4vWvy3rpZIbSycs+3ynCYUxKl2ezG7RcJz3ffE0tari
        yHqOaTQjLph0C59viL9ypSyiXVqFCZGZtVV+zoh41BVnejHX3kxZ9W0bAKlBEcAlSigqIM0NkzlTJ
        0IoEWhFw==;
Received: from [2001:4bb8:19b:f845:4eeb:727b:c6de:39f1] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZa6t-00DkW0-1K; Thu, 22 Apr 2021 14:15:15 +0000
Date:   Thu, 22 Apr 2021 16:15:12 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] third round of nvme updates for Linux 5.13
Message-ID: <YIGE8ORkKryOdxtE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b777f4c47781df6b23e3f4df6fdb92d9aceac7bb:

  ataflop: fix off by one in ataflop_probe() (2021-04-21 09:15:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-22

for you to fetch changes up to 2637baed78010eeaae274feb5b99ce90933fadfb:

  nvme: introduce generic per-namespace chardev (2021-04-22 07:25:17 +0200)

----------------------------------------------------------------
 - add support for a per-namespace character device (Minwoo Im)
 - various KATO fixes and cleanups (Hou Pu, Hannes Reinecke)
 - APST fix and cleanup

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: do not try to reconfigure APST when the controller is not live
      nvme: cleanup nvme_configure_apst

Hannes Reinecke (2):
      nvme: sanitize KATO setting
      nvme: add 'kato' sysfs attribute

Hou Pu (1):
      nvmet: avoid queuing keep-alive timer if it is disabled

Minwoo Im (1):
      nvme: introduce generic per-namespace chardev

 drivers/nvme/host/core.c        | 258 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.c     |   4 +-
 drivers/nvme/host/ioctl.c       |  38 +++++-
 drivers/nvme/host/multipath.c   |  51 +++++++-
 drivers/nvme/host/nvme.h        |  14 ++-
 drivers/nvme/target/admin-cmd.c |  10 +-
 6 files changed, 276 insertions(+), 99 deletions(-)

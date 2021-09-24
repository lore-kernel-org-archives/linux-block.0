Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B4C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 06:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C275D60F48
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 06:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbhIXGjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbhIXGjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 02:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A79C061757
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E88Z00ZlAwLBAUITmbRn6M8Pl/W09ZjXCUecGA0cccs=; b=sULAqj+uLXdWuZvG6CmAxm76wZ
        qGj1GhWwQfOfIe4OtN9F8vHBAxiqfDhG5knui07tRIq+LCsofnkxQguHU7lVOwnPIhjRVxoIfUUZs
        uM8Kt/BpPk6o3uAnzCrDdaj1UGSO3qxtu4FWNPRT8OstJPoED6ioIJipL7LoUkNAPp8IfHGQ3n23h
        8BL3sUa/9QAk+D83h2kLHs9fE0XfSWjeGhqekEcWuWzcyfxaOekgEMrDx+E2tbL4IH1V7TDW8SFZ3
        i28IVSTRpx8tqIfj0My8hr3Ztnwuu+A+nVcCA+qbQlkqtmtLQp8cZ+KyZQcCFgEw0cqQR0jXBZBw4
        wgOOeP9g==;
Received: from [2001:4bb8:184:72db:7155:a6da:d23f:c65d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTepM-006vTg-4w; Fri, 24 Sep 2021 06:37:03 +0000
Date:   Fri, 24 Sep 2021 08:36:54 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YU1yBgH+CqJu9h5u@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 858560b27645e7e97aca37ee8f232cccd658fbd2:

  blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd (2021-09-15 12:03:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-24

for you to fetch changes up to 298ba0e3d4af539cc37f982d4c011a0f07fca48c:

  nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15:

 - keep ctrl->namespaces ordered (me)
 - fix incorrect h2cdata pdu offset accounting in nvme-tcp
   (Sagi Grimberg)
 - handled updated hw_queues in nvme-fc more carefully (Daniel Wagner,
   James Smart)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: keep ctrl->namespaces ordered

Daniel Wagner (1):
      nvme-fc: update hardware queues before using them

James Smart (2):
      nvme-fc: avoid race between time out and tear down
      nvme-fc: remove freeze/unfreeze around update_nr_hw_queues

Sagi Grimberg (1):
      nvme-tcp: fix incorrect h2cdata pdu offset accounting

 drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
 drivers/nvme/host/fc.c   | 18 +++++++++---------
 drivers/nvme/host/tcp.c  | 13 ++++++++++---
 3 files changed, 36 insertions(+), 28 deletions(-)

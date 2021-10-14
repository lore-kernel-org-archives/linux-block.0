Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDFD610CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhJNNH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhJNNHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 09:07:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529ACC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EgscirJH6Nx+kJdPjctUeiJAQYME4Qbw7QEV81O8Dww=; b=x1GXTPRL+yVxNZiEjS35geXjrV
        ZtUWL+HjIdRB6uyq+tZ52kDbtOch1eoCeVJnJPTPyFat51gI7r8KDnvcIkV3rqerbirNEYO8T3Iwx
        XdedfQqLh+gvir4wsu8LrpLIBWcsnGeKGvi+xw73VSRJ6BYbqObv8TYoBdj2fSjOA+xEVw2DErN6K
        8Fp5442lDptII4zRJhsO9caLOJKUFxb6znPAGdSKvHIcNt59QrFvQ1YmGxuvzstfZJWo+j0lepLC7
        scIiJs6r6KCweVloD4+ULc+SFQuiwUlY5mqsWZGmBQei5/hDmP+idbpsIl3R7Bzph7nHE204y07tz
        5QI/EjfA==;
Received: from [2001:4bb8:199:73c5:b1be:a02d:b459:cc1a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb0Qf-0039Ud-FH; Thu, 14 Oct 2021 13:05:49 +0000
Date:   Thu, 14 Oct 2021 15:05:47 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YWgrK/7ttndn93Fx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 298ba0e3d4af539cc37f982d4c011a0f07fca48c:

  nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-14

for you to fetch changes up to be5eb933542629ad6a7d4c92097b1b472b1612d0:

  nvme: fix per-namespace chardev deletion (2021-10-14 08:07:47 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15:

 - fix the abort command id (Keith Busch)
 - nvme: fix per-namespace chardev deletion (Adam Manzanares)

----------------------------------------------------------------
Adam Manzanares (1):
      nvme: fix per-namespace chardev deletion

Keith Busch (1):
      nvme-pci: Fix abort command id

 drivers/nvme/host/core.c      | 21 ++++++++++++---------
 drivers/nvme/host/multipath.c |  2 --
 drivers/nvme/host/pci.c       |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

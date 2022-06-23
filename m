Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91427C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 13:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiFWNYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFWNYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:24:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993D49CBD
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MYz9g7LLBWo3lswpU1/1a/rHCbBCo/ztXRmq3SmkIhA=; b=AlJ0/SDtwJLNK0Sna9EBajV4UV
        hfcLUbeS0nYww9pq5uETOmvqW5qbP+NUSlseF4HUwTQlzYNAnco8ZRsP9alsns5C+Du4ZFaohD7FU
        MIPmm/pRaiccPKEnSHlwQLHWhTFWxkPYUaCMhZgy4AQ6HpfU+aCQ015kU4E67k4uN25LZFA6TKxI1
        jwsBUrn9gSakbAXk2m4YSmMyQjljdvdrGVff2DTK1C++PpvoLgeHz2Fmb39Yp8tsa0XzCC5obbvJy
        IhTq65tBJD2pRmg+qLJm7eQZoQ+wrUQFoSZ25jUZWR75xieoKOnSO/dNyncrDI+zF6wqIXEblLC3a
        8oOIl9XA==;
Received: from [2001:4bb8:189:7251:9e7:d0ec:8481:b319] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4MoT-00FKom-8P; Thu, 23 Jun 2022 13:24:01 +0000
Date:   Thu, 23 Jun 2022 15:23:59 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRpb4LlxotvjCML@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:

  block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19

for you to fetch changes up to e6487833182a8a0187f0292aca542fc163ccd03e:

  nvme: move the Samsung X5 quirk entry to the core quirks (2022-06-23 15:22:22 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: move the Samsung X5 quirk entry to the core quirks

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  6 ++----
 include/linux/nvme.h     |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

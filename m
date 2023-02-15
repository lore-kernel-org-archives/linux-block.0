Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69321C636D7
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBOSRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOSRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 13:17:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F183B671
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PLAjOyCVDcX2GLrlUJT+B3gok+cwSdvPQqv9oJy56yY=; b=5ESGkpU+SHhaxxqrPH+n6I+G5z
        6gRovY32UVnaH3k9bespj+Yj/E29BCgfe3uYcvFhMC3U3BbtAay/AM7TulR/qfDX2Yxz8pL0EfJ0m
        83zbk7Ft6j0pKhXx9rKKiUKzr6g7JhlhPaDoKpVuXwSA87OJB3cQ9lQcG1VDS3EgDy9p9RN9U/xxw
        FrS18dzBVOWaB/BqMmmxfpgFwjIDxa3/dCvNTgCTTcHda+igMPepIuGbX1jLoDACAH/xF+NOPPYt7
        ECejL8raR3vS1/22FXbkkpJ5D35BoN8v4jDwsfR90ZFBNtvjjj1uho0JKqXnvMq8X0ISVEqKSjhz8
        TZwpHYGw==;
Received: from [2001:4bb8:181:6771:d204:2f73:7b8d:611c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSMLG-006p3W-FM; Wed, 15 Feb 2023 18:17:19 +0000
Date:   Wed, 15 Feb 2023 19:17:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <Y+0hqoUKkv1fMMzk@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 2f1e07dda1e1310873647abc40bbc49eaf3b10e3:

  block: ublk: check IO buffer based on flag need_get_data (2023-02-13 08:36:23 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-15

for you to fetch changes up to b6c0c237bea191fb99b6c2de093262402b0159a6:

  nvme-pci: remove iod use_sgls (2023-02-14 06:40:57 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - fix and cleanup freeing single sgl (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: fix freeing single sgl
      nvme-pci: remove iod use_sgls

 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

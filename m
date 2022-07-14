Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E4AC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 14:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiGNOiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiGNOiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 10:38:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8E49B6E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uD27qdxYN8lWOtvC15ApMDfnGoCi5Cne/k7LhGdN3N8=; b=yxoCqDSmZLi5DrFl7IbJKhJEI/
        CAR9E6sI3lCcFGdHpcsXQQ5NWGfbv9e14hKhgD18o7MvuS60QNe1CpNJSFV/iczyOz0Z/r+HRWB64
        0iSahnnxKoTfoJl4VaC1UI8syljfFfdi3JOV1X+yq0jXUvanxCwRarAxgcc7t5IYxW7WcKSh17foo
        76Sq/+BsW5Bu8UX115gZkyfnPSq0JzQwJwxW3CjvpoLGNH1PRPDE1iJsMho98UwQKaronPUl7BNrw
        lIm9pSq5j247rnvVdxptU/4UH6BL0o6cwErWFGaaq0Qri9iiqzvsawDRLUU85qHmdO3iRUX1SWwnW
        T+XTj7cg==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBzya-00FGrX-9f; Thu, 14 Jul 2022 14:38:00 +0000
Date:   Thu, 14 Jul 2022 16:37:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.19
Message-ID: <YtAqRsNAUZXA60+V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:

  Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-14

for you to fetch changes up to 6961b5e02876b3b47f030a1f1ee8fd3e631ac270:

  nvme: fix block device naming collision (2022-07-14 16:35:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - fix a block device naming collision (Israel Rukshin)
 - fix freeze accounting for PCI error handling (Keith Busch)

----------------------------------------------------------------
Israel Rukshin (1):
      nvme: fix block device naming collision

Keith Busch (1):
      nvme-pci: fix freeze accounting for error handling

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

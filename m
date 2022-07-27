Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15097C3F6B0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 15:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiG0Pyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiG0Pyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 11:54:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330422A702
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WQYkpy+Ys/D1auBSZUAVXib7a0WAy5gtMoYU+H97DjU=; b=Po388BffC1OOnkc7ZLBiMhYFhI
        8vvcpcrTYK5jXF8A+wt6HzIev3khiRSeDrZ8rXsQ5jy916df09KNgQSf1txMMocxhxHa5/rLI6mgj
        1NR1aGXKnkJu3bG0jgOzLA3HX05e/vH2MLEUTPZpwCNcwybCnkuMPuz+EFWXqMNE5IE4A/i8Rb5r/
        tBxH11NFrLYXsQfct/hb/WzfuyAVRpYt0NH5KOVpI+ZWAdDMKBSPB1aOrry5hNMS8RHrKQCPjcNqh
        06SlChfyD6/fFqK8+VxoEJcjM0nzNvnF3pOEq1CYsvqF+rsrnXt+/ER1T3SnzSC9+7Y7sW/vaKcqA
        fn3B/6yQ==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjMo-00FFfc-2q; Wed, 27 Jul 2022 15:54:34 +0000
Date:   Wed, 27 Jul 2022 11:54:31 -0400
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 5.19
Message-ID: <YuFftyWcAMRP/NC5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 82e094f7bd988c02df27f8c8d81af8f750660b2a:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-27

for you to fetch changes up to d6c52fa3e955b97f8eb3ac824d2a3e0af147b3ce:

  nvme-pci: Crucial P2 has bogus namespace ids (2022-07-25 07:34:07 +0200)

----------------------------------------------------------------
nvme fix for Linux 5.19

 - yet another duplicate ID quirk (Tobias Gruetzmacher)

----------------------------------------------------------------
Tobias Gruetzmacher (1):
      nvme-pci: Crucial P2 has bogus namespace ids

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

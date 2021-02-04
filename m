Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DFC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802F664DEC
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhBDQXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbhBDPIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 10:08:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89881C061788
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vc7vRliYes5zaCs8iBxhh34R72R5PPnrfftjwCg4twk=; b=YO8d0D4yNDZTcIzkA7+YUMpPaZ
        kBM17bWol6tL2O47zoifb2czaVrFcBQgoF+jVUY33uQDvLkkFRBWqxCKduYfcE5XutLH0Pym1Lvnn
        gWj8qhT/DeurR+anDvhIb+LDGCDxlt4YVjn8RJr5KpHLUFrgyhszM6uPdHiPJMp00IcmljwHT5GNm
        rlfoa8mYygSsIOIsLar9QOU8yVHZhEQksYo2fhA7tA3WQ3vSqhaPYVd22uvWHWruTdPZ2aOz9lVwN
        lYguah0E+IMVFgXADKAX5Qrhs2FTKxVMGr4xLEU8H9y6Ag/iOqrknbFj4QWFSpMdbapKxQazq10sa
        JQCL9jmg==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7gEN-0011WA-HK; Thu, 04 Feb 2021 15:07:39 +0000
Date:   Thu, 4 Feb 2021 16:07:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <YBwNukLwQfsXQL9U@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit cd92cdb9c8bcfc27a8f28bcbf7c414a0ea79e5ec:

  null_blk: cleanup zoned mode initialization (2021-01-29 07:49:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.11

for you to fetch changes up to cb8563f5c735a042ea2dd7df1ad55ae06d63ffeb:

  nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs (2021-02-03 16:57:36 +0100)

----------------------------------------------------------------
Claus Stovgaard (1):
      nvme-pci: ignore the subsysem NQN on Phison E16

Keith Busch (1):
      update the email address for Keith Bush

Sagi Grimberg (1):
      nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs

Thorsten Leemhuis (1):
      nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs

 .mailmap                  | 2 ++
 drivers/nvme/host/pci.c   | 4 ++++
 drivers/nvme/target/tcp.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

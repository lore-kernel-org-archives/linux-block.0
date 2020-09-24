Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DFC4727D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC48238E3
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUvetM9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgIXNrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgIXNq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 09:46:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C4C0613CE
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QPRY1PBjjGfg4Jna7TYhCqqdJngF0dkb335+a5ET34E=; b=dUvetM9OE0gs43FYE0YiBXqPWP
        99ISp6Jj1qNb3w8YBhf9Uda0YsDf9pEQJHOAKJ3LsvZkEiJaQdmCh9UoCrmDrR5mKiC5HuHQZgFKW
        qBAgRXxZLPasTMyUr1w31jSFhzSdYA+ZuUBnjUslk6T7MMeIMAv80/SqKHVd+yD2tYsbHvnPwKYKF
        3UxLI6g1W0TeYB0OLv/xE5qaIVheV23olB3yOTJCLxLwJ5h+JZdWvNGjdtLzBxVkZmSK32Gq1z+MN
        9IbNoSx2v08UOKxUtzVU5c3hOEma8R8Rx/O7RSqBEQhJNX1S7BsMJViTOElktriij25/UKcojL8mP
        wyISLjRQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRaJ-0003Da-U6; Thu, 24 Sep 2020 13:46:56 +0000
Date:   Thu, 24 Sep 2020 15:46:54 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200924134654.GA873840@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 4a2dd2c798522859811dd520a059f982278be9d9:

  Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-24

for you to fetch changes up to 46d2613eae51d527ecaf0e8248a9bfcc0b92aa7e:

  nvme-core: don't use NVME_NSID_ALL for command effects and supported log (2020-09-23 20:01:47 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - fix error during controller probe that cause double free irqs
   (Keith Busch)
 - FC connection establishment fix (James Smart)
 - properly handle completions for invalid tags (Xianting Tian)
 - pass the correct nsid to the command effects and supported log
   (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: don't use NVME_NSID_ALL for command effects and supported log

James Smart (1):
      nvme-fc: fail new connections to a deleted host or remote port

Keith Busch (1):
      nvme: return errors for hwmon init

Xianting Tian (1):
      nvme-pci: fix NULL req in completion handler

 drivers/nvme/host/core.c  |  9 ++++++---
 drivers/nvme/host/fc.c    |  6 ++++--
 drivers/nvme/host/hwmon.c | 14 ++++++--------
 drivers/nvme/host/nvme.h  |  7 +++++--
 drivers/nvme/host/pci.c   | 14 +++++++-------
 5 files changed, 28 insertions(+), 22 deletions(-)

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80195C64ED6
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCANsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCANsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 08:48:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68713513
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BO2ojvrftzKAb+rB9vgOUPkR8QgNJwvNUsPY8PtxTpc=; b=QMeT97TQK8Fu7VHwOAci0h/DRq
        4k6GldJ8NzmdBXLXLRwDs8xLJcTejnsfcqJBKL5zee+WcXKbhy0Yxiyp1ygG4goqR9Qe25/VDyX5V
        yff3cW3cd8cKJg63VPSBNl77AQTRMl48BmjF3HmvurMZAcBX5YlNUTSqShV6wZBwOLwygSVjLNLsK
        Ne7O6OfREES1e4Y+w3t1J2xBA55kkNBtmrmmV4TAApEpn9eM8Syg1i7McvGx6B+toHv+IdzP2jToF
        rl2Fy0yjQKiC00KJSMMSmAIY2GWECTLVw0Q7qA0LjmD8yu0o3jqKCrFOFCOtXr+wsomzPSw19CWKg
        dsLpeuUg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMoX-00GNaS-F7; Wed, 01 Mar 2023 13:48:13 +0000
Date:   Wed, 1 Mar 2023 06:48:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <Y/9Xn595ioya85dO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 310726c33ad76cebdee312dbfafc12c1b44bf977:

  block: be a bit more careful in checking for NULL bdev while polling (2023-02-24 13:19:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-01

for you to fetch changes up to 26a57cb35548ae67c14871cccbf50da3edb01ea4:

  nvme-fabrics: show well known discovery name (2023-02-28 06:14:44 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - don't access released socket during error recovery (Akinobu Mita)
 - bring back auto-removal of deleted namespaces during sequential scan
   (Christoph Hellwig)
 - fix an error code in nvme_auth_process_dhchap_challenge
   (Dan Carpenter)
 - show well known discovery name (Daniel Wagner)
 - add a missing endianess conversion in effects masking (Keith Busch)

----------------------------------------------------------------
Akinobu Mita (1):
      nvme-tcp: don't access released socket during error recovery

Christoph Hellwig (1):
      nvme: bring back auto-removal of deleted namespaces during sequential scan

Dan Carpenter (1):
      nvme-auth: fix an error code in nvme_auth_process_dhchap_challenge()

Daniel Wagner (1):
      nvme-fabrics: show well known discovery name

Keith Busch (1):
      nvme: fix sparse warning on effects masking

 drivers/nvme/host/auth.c    |  2 +-
 drivers/nvme/host/core.c    | 37 +++++++++++++++++++------------------
 drivers/nvme/host/fabrics.h |  3 ++-
 drivers/nvme/host/tcp.c     |  6 ++++++
 4 files changed, 28 insertions(+), 20 deletions(-)

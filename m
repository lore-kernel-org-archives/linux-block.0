Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8BC7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjC3WhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjC3WhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:37:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6618ECC36
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NJllDt/tGBBHR8YkJulvsU7yOqGtD9huZUiRyzH8+0k=; b=IjFEZOWRKZF9n6Ohm4mRbeHhpw
        rYDcQUZRK2aYit5WTlAp+C5SPj6hINEeUZiflr/05++xB3onMCX/MF8bGWs/3ln6cQVovW1uxLDmM
        6GWpWu8cZWnNzXHnmg4wGzmrUmQIW8Pyl1qHkBCpUUmmPrxfg5PkQtmjr8XH62ZwRx8h9tjRok0CQ
        8hwA60S8CcceNwZPyec6JLsjm7kSxtQv+5nUelrvem2k/5zsbJvV8bjgcNfYt93qOUDXMya/5KdqE
        I4D73avsRW/E+HmYY6Lw0KO6t8BYUAxaC0V3IcdD9x2yACITOftCQBFR5ZVhG55xPMTFFGjOgvg8K
        Tr1VXq2Q==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pi0tK-005EfC-35;
        Thu, 30 Mar 2023 22:37:11 +0000
Date:   Fri, 31 Mar 2023 07:37:06 +0900
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZCYPEl0cfKtOlkU8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit bb430b69422640891b0b8db762885730579a4145:

  loop: LOOP_CONFIGURE: send uevents for partitions (2023-03-27 13:27:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-31

for you to fetch changes up to 88eaba80328b31ef81813a1207b4056efd7006a6:

  nvme-tcp: fix a possible UAF when failing to allocate an io queue (2023-03-30 11:24:33 +0900)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - mark Lexar NM760 as IGNORE_DEV_SUBNQN (Juraj Pecigos)
 - fix a possible UAF when failing to allocate an TCP io queue
   (Sagi Grimberg)

----------------------------------------------------------------
Juraj Pecigos (1):
      nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN

Sagi Grimberg (1):
      nvme-tcp: fix a possible UAF when failing to allocate an io queue

 drivers/nvme/host/pci.c |  3 ++-
 drivers/nvme/host/tcp.c | 46 ++++++++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiFONhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbiFONhg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 09:37:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF2292
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Olw5KXnhihAXNLgi8gB31e2MWGWril1WP4iwNiYTYJs=; b=hdm3I9GWRmJ5fii+SLDgFmZPT1
        ImPKPXVTIQfXuTWI3FPGh2c9Z0N5m4venrIcNWJgN7c7WSCz89jLNZJM0ti96C1B8hCUPOHHNyAnN
        juzVOsAucpRB818fVIaqq00QR1bG/2Gdiv+/iNxtTTuL8HBF8rNPmuvjhpWkCPCpMTSzJ1YsdVgFv
        xPNZX0e1IeE6Jk6fjayRjhZUwooJdPmJwO9MTcuQGSxUGRRLOxHyq/j+WO9w4kEK/oZ0WM8iCGigI
        WbGjtl8+ZI1we1g5a8FYd33yRnhEbt97xQpDC+5wTZozzIrsYyjfvmCAJnQaTegp7LXwnHmiZ/PwC
        4v37vtpQ==;
Received: from 213-147-167-122.nat.highway.webapn.at ([213.147.167.122] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1TD3-00EkEX-G6; Wed, 15 Jun 2022 13:37:26 +0000
Date:   Wed, 15 Jun 2022 15:37:21 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YqngkWynuVHY+aDS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-15

for you to fetch changes up to 43047e082b90ead395c44b0e8497bc853bd13845:

  nvme-pci: disable write zeros support on UMIC and Samsung SSDs (2022-06-13 19:56:57 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - quirks, quirks, quirks to work around buggy consumer grade devices
   (Keith Bush, Ning Wang, Stefan Reiter, Rasheed Hsueh)
 - better kernel messages for devices that need quirking (Keith Bush)
 - make a kernel message more useful (Thomas Weiﬂschuh)

----------------------------------------------------------------
Keith Busch (5):
      nvme: add bug report info for global duplicate id
      nvme-pci: add trouble shooting steps for timeouts
      nvme-pci: phison e12 has bogus namespace ids
      nvme-pci: smi has bogus namespace ids
      nvme-pci: sk hynix p31 has bogus namespace ids

Ning Wang (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs

Stefan Reiter (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50

Thomas Weiﬂschuh (1):
      nvme: add device name to warning in uuid_show()

rasheed.hsueh (1):
      nvme-pci: disable write zeros support on UMIC and Samsung SSDs

 drivers/nvme/host/core.c |  5 +++--
 drivers/nvme/host/nvme.h | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 3 deletions(-)

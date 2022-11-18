Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EC0C43217
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 12:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiKRMb5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbiKRMb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 07:31:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7713D2A
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7HRUTm/HDd/79pZLj7ke4I0y92JSxt5kxA62qQmyk08=; b=s+wSsIHSef/g30huvesGT7FxTj
        FlYUPCiFLTPg8FyuYaxAllb32errcCNzuoNS3Q+h3yOmovot/kHdBn64oK0B53M+dEs7G/rOQPVyj
        K80uorj8yrQGg91WlIQ9bB4Il6aR397ZcZpCHpbhmN3XzozGZihUSvXjSx1ZgSTBhbXjZcAwJrLZs
        DRUWguSFUsdqm2YS061xdU4ciJ7Nz3nxVgdY75DPsqMaqWmlBBHlAtQbCFxKCoEDSvEgBT5GR73j4
        SNOz3K3uuNSpMqwsfHKB6w4bLAiglRFn5gRPgctmlMlCFopzZuM0a45est1IXHWOt/tjxxbx6hGqZ
        9mFG4fzw==;
Received: from [2001:4bb8:191:a0ee:6e05:c552:a35b:761c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ow0WZ-003tUb-A5; Fri, 18 Nov 2022 12:31:15 +0000
Date:   Fri, 18 Nov 2022 13:31:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 6.1
Message-ID: <Y3d7EA+VHiylXGu+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe:

  blk-cgroup: properly pin the parent in blkcg_css_online (2022-11-14 12:13:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-18

for you to fetch changes up to 0a52566279b4ee65ecd2503d7b7342851f84755c:

  nvmet: fix a memory leak in nvmet_auth_set_key (2022-11-16 07:20:56 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - two more bogus nid quirks (Bean Huo, Tiago Dias Ferreira)
 - memory leak fix in nvmet (Sagi Grimberg)

----------------------------------------------------------------
Bean Huo (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro

Sagi Grimberg (1):
      nvmet: fix a memory leak in nvmet_auth_set_key

Tiago Dias Ferreira (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000

 drivers/nvme/host/pci.c    | 4 ++++
 drivers/nvme/target/auth.c | 2 ++
 2 files changed, 6 insertions(+)

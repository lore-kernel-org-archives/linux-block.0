Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F0C77B6E
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 05:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDNFRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNFRG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 01:17:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831CEB4
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GjnYIyMBNHhHmz53AYPKDgCNgzIvG7TjdHr4iouOWIw=; b=eH5EomSEbTDZWkTjclmKp3y8kl
        7n7aWaELraSI604LvxyxeOVZSlSZkX7SjkCQijRrZxUCug0z2Ux8cKh92qU+A+ZGVur2S8dWeESFx
        ehuiODL3iM4S5qQK4Wrnnp+bZiqQhNeXZXkxNoKqdGZIRgKJxaYOUtDyUuboUAA0CFydshNOrN45x
        pcYwnpyrpEg/C03/Prfj+EiHEaFhvB7aN46/PVlBJ+8OLAkbxCFcL4WSXkvNcdV+JFt05NIPkM2LT
        2J6lw/ghN6Nn6+MPDnT3o1qlENAF1Qtfiu/bMdH8gx+YsMWJX07UqKg64t/Pg4eUOqWEtur1hbgIV
        ZEsHm2dA==;
Received: from [2001:4bb8:192:2d6c:7f18:1319:183f:920d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBnv-008LGl-1u;
        Fri, 14 Apr 2023 05:17:00 +0000
Date:   Fri, 14 Apr 2023 07:16:57 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <ZDjhyQfNnHzyvKAm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:

  block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-6.3

for you to fetch changes up to 74391b3e69855e7dd65a9cef36baf5fc1345affd:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD (2023-04-14 07:13:48 +0200)

----------------------------------------------------------------
Duy Truong (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

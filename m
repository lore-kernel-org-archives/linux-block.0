Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E71C52D11
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAZRiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAZRiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 12:38:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CE6A708
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sxJBaTN19A70jHkuOMUFcmvbgXlT2VUpb4rKJphDDN8=; b=uajMenBIr8eCQhs1dW/vNOBwPu
        Kxrg7S/wEvyr0WbUHeSTvcqMOv2R5QCTHBi4ncG88/G9cXBYvtNSi+AxQ2ofNbaFDTToJ2ch0cKJh
        NSh/AJukkXoouPLMaFtDHT2KiqQoZgmKGu9NqhPgX2oGjZY1g5AuCLePee7Os15CNcpSp+Q//qQ3T
        vKI49h6DaF4/Ix6DUFMdUewacU5NB6oawxkOFgnqAle2KSF9BJwH7J/IBVBaWaeb4Hmt7Y1Q5pyIG
        rreDnpI3S3BGVNTch7PdoICOn0ZARGCPtEJ8JjOQDq5af7aShw9DiiVg9hMVvBfbjHGc3Xpsw6KHb
        qZROfs5w==;
Received: from 213-225-9-99.nat.highway.a1.net ([213.225.9.99] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL6CQ-00C3zC-L7; Thu, 26 Jan 2023 17:38:11 +0000
Date:   Thu, 26 Jan 2023 18:38:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y9K6fTTrhXSWkVeZ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 955bc12299b17aa60325e1748336e1fd1e664ed0:

  Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-26

for you to fetch changes up to 85eee6341abb81ac6a35062ffd5c3029eb53be6b:

  nvme: fix passthrough csi check (2023-01-25 07:09:38 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - flush initial scan_work for async probe (Keith Busch)
 - fix passthrough csi check (Keith Busch)
 - fix nvme-fc initialization order (Ross Lagerwall)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: flush initial scan_work for async probe
      nvme: fix passthrough csi check

Ross Lagerwall (1):
      nvme-fc: fix initialization order

 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/fc.c   | 18 ++++++++----------
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 10 insertions(+), 11 deletions(-)

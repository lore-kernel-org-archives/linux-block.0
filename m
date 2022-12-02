Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7BC4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 09:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiLBJfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 04:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiLBJft (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 04:35:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F80C65
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 01:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rH8MM7ztjz32yvM18t1XgQUk0Ikrcd9m0/ls9NFDjpk=; b=ovvUSIoX2OSGPjQK0ieMY9h+xs
        g/FX3Be3y+FFp31tzqEQXLfC1y5RuH/DJlImpPf5CIK4Vj6nuf4DvDkeX55W4Y9QjByx4QlNAKYTo
        EQwlump5q2b69fAF0+kPOAesVER4IYJi0/jJwQrFx0Fn3D7gNkXXZqAEHK1DWMu97peXA0I8c/jCv
        cZP5Nlj3pqAJP44tBWdTVg8Qb4xh7xkFtcEQd8HrsRu9H0LeVhXN/NIfKb5VCa/hVHxTKjre1lSkE
        L1qOiEFOs7zRDa2Fbaqs3cQYSF3aRecsYAIfsR2atHl48FXlPefctihxPkVagXSrv5yCq/Hr9UJP0
        9A6XiwSA==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p12SJ-00F1P3-KY; Fri, 02 Dec 2022 09:35:40 +0000
Date:   Fri, 2 Dec 2022 10:35:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y4nG6f7QDhcmbldD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 7d4a93176e0142ce16d23c849a47d5b00b856296:

  ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-01-02

for you to fetch changes up to 899d2a05dc14733cfba6224083c6b0dd5a738590:

  nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix SRCU protection of nvme_ns_head list (Caleb Sander)
 - clear the prp2 field when not used (Lei Rao)

----------------------------------------------------------------
Caleb Sander (1):
      nvme: fix SRCU protection of nvme_ns_head list

Lei Rao (1):
      nvme-pci: clear the prp2 field when not used

 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 3 +++
 drivers/nvme/host/pci.c       | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A216C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiI2PCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiI2PCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:02:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DAC128895
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1TanhPj1pvcWXIurjMX1HYDdYlrIVvvf4bEhTgkHyPM=; b=RZzS61qBiS5FQDdv2VyMluo1tf
        Uiy6z8C1s7FpDcgB99m2iHyF6eOmUK/3mEOlQLnsXbrY6SzJknZBt5/qkTDUIj87O9ZcDVrDlqMkf
        uXvVNRox0GnsiiHhPuVK3vpnnAJcGmjRtf8F7JYWLHwXcCQVJK6pjcT2bEpI/QB1+E867H2I92Ld8
        DYUkTWnOL9AjvhnUm8g/HSJy9d0Knv0uwrjag+Ut1izfhPPFlwLe+UhE+kI2MXk/VNuockXxhE0wU
        sXPpwf57SLhqgQzPJElSDi+FlQ27dKE12aQg0Ri/cXJKbngvs7/3epWtosLjUzSFKgy7BRTRxsHrQ
        if7jPQCQ==;
Received: from [2001:4bb8:180:b903:9be8:d11a:21a0:96eb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odv3W-003jvq-GD; Thu, 29 Sep 2022 15:02:30 +0000
Date:   Thu, 29 Sep 2022 17:02:28 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YzWzhIAX+vtSmo39@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:

  Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-29

for you to fetch changes up to d14c273132aec81a1a8107c9ab4865b89e7910a7:

  nvme-pci: disable Write Zeroes on Phison E3C/E4C (2022-09-27 09:20:30 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices
   (Michael Kelley)
 - disable Write Zeroes on Phison E3C/E4C (Tina Hsu)

----------------------------------------------------------------
Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Tina Hsu (1):
      nvme-pci: disable Write Zeroes on Phison E3C/E4C

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

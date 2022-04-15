Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84ACC433FE
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiDOFJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352183AbiDOFGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB75DA77
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FwyfvshCqsOyUWe+mRot2kKKs7MrlOQVeRHh4KfZtGk=; b=bybxW/gB1JnSH36w8OK/bPbG2t
        llA2Hd3i3vSDh27kckiO49hau3Mx4puUr2JepHRjNknygb2CA9OhAQyys7XQoL3vAsqXqbWpIMoUi
        rgZyz43XmBqk3EeXjcio4fWoghfiGVeyiFRGrO8CN1QqqwYxF2GIxYI6Y/kxG3DV8Hw3xrOz2W7H1
        myxge20h+7Fc7qzMAwgpEGJYfR7kD9SemgmwYwcpbNBbv5zhi9U88mYEc0wTxu4C0sy4rfiL/M6hv
        dU2iWI9HbLgbe7PeG/e1mC9TXQnY217WCEYYGysTJW8J9OuqShGj+dITO+US78X0wyaalQ/nEJzVn
        GpozD//w==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfE52-008Ve3-8Y; Fri, 15 Apr 2022 05:01:12 +0000
Date:   Fri, 15 Apr 2022 07:01:09 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.18
Message-ID: <Ylj8FUYefzczGF92@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 3e3876d322aef82416ecc496a4d4a587e0fdf7a3:

  block: null_blk: end timed out poll request (2022-04-14 10:16:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-04-15

for you to fetch changes up to 66dd346b84d79fde20832ed691a54f4881eac20d:

  nvme-pci: disable namespace identifiers for Qemu controllers (2022-04-15 06:56:17 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.18

 - tone down the error logging added this merge window a bit
   (Chaitanya Kulkarni)
 - quirk devices with non-unique unique identifiers (me)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: don't print verbose errors for internal passthrough requests

Christoph Hellwig (3):
      nvme: add a quirk to disable namespace identifiers
      nvme-pci: disable namespace identifiers for the MAXIO MAP1002/1202
      nvme-pci: disable namespace identifiers for Qemu controllers

 drivers/nvme/host/core.c | 27 ++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  9 ++++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7600DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiLVPoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiLVPoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:44:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCB2937E
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/f2XEf/Fa2fRDROPNECEjqK+VdtLUPh4SVKjpPIIJdU=; b=GCWmkw+MCX/e3eh8zZDPvAGGhS
        wxjuYMQhASv+xCpDl3ldhd+rzk/haft0KTkOnFUrVpQP8CytqMY/+545QYVrng/FJJ0GgNzkG5ebm
        t9x8n7TEinzDCM1KhivfttfjGPoc9tIi5gY51WS+tYQwfD6oT6IZeHmTbSvCvHcLkq1YLOzRIDeBn
        gcbhbD/DvGo+2jm7dsdwO1TxYH7BImNLLo1tX+ngHCpC2pOUHA2L65TpjmlvSsAAqtOryqs1zf+OZ
        wj4PVrFW86axeBMBik+wVPGLfQ7g996M3n3WZWK8ymkvjXhDYng74+iI++6w+uTVPWFy8I2u6UpnW
        KHvjqgLQ==;
Received: from [2001:4bb8:199:7829:d328:c3ff:20ad:37] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8NjZ-00DejP-8D; Thu, 22 Dec 2022 15:43:49 +0000
Date:   Thu, 22 Dec 2022 16:43:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y6R7MBrn2xzmwT1J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 53eab8e76667b124615a943a033cdf97c80c242a:

  block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-22

for you to fetch changes up to 3659fb5ac29a5e6102bebe494ac789fd47fb78f4:

  nvme: fix multipath crash caused by flush request when blktrace is enabled (2022-12-22 09:40:27 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix doorbell buffer value endianness (Klaus Jensen)
 - fix Linux vs NVMe page size mismatch (Keith Busch)
 - fix a potential use memory access beyong the allocation limit
   (Keith Busch)
 - fix a multipath vs blktrace NULL pointer dereference
   (Yanjun Zhang)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: fix mempool alloc size
      nvme-pci: fix page size checks

Klaus Jensen (1):
      nvme-pci: fix doorbell buffer value endianness

Yanjun Zhang (1):
      nvme: fix multipath crash caused by flush request when blktrace is enabled

 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  | 37 +++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

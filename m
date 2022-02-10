Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A186DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 07:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiBJHmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:42:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBJHmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 02:42:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B6C58
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=a3gwvncnlSn4GBCTOYJCrV+pTVRA9a4zE1uhsJkRlGg=; b=0lSkCBcYZGnLlp75fp8QyW7Pv5
        DN32VsRxgyRrWbJeJ7hOADecZStoX3Cosl9CiVMRxyCEVEK4TYbzKOI0hEa36Nk4SIwiO4cG2/IFJ
        kXHNwhobYwjbLSbult2cCzba55QgVUbA8VstO7hSbTn2gAfU+jnCdrhOe1Zs6+D6kmElbOs81jgTE
        sxi07e1rBnDYZqwEAnAZAGQViShAaBC0u4pB4kjDLJylhI+HlVEFW7PjyIAnyS7F9htym/IugXxdL
        S68Jp4ODq+j8/YSEsmK+t7PGbU5kOkpxGvDbhjjfsc6puYcT4sRxz1RgWKsKFhE7tadFSkoC700MQ
        4KemabFQ==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI45j-002u5H-CB; Thu, 10 Feb 2022 07:42:11 +0000
Date:   Thu, 10 Feb 2022 08:42:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YgTB0csAbKyI5WvN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:

  block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10

for you to fetch changes up to 63573807b27e0faf8065a28b1bbe1cbfb23c0130:

  nvme-tcp: fix bogus request completion when failing to send AER (2022-02-09 14:50:42 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - nvme-tcp: fix bogus request completion when failing to send AER
   (Sagi Grimberg)
 - add the missing nvme_complete_req tracepoint for batched completion
   (Bean Huo)

----------------------------------------------------------------
Bean Huo (1):
      nvme: add nvme_complete_req tracepoint for batched completion

Sagi Grimberg (1):
      nvme-tcp: fix bogus request completion when failing to send AER

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/tcp.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

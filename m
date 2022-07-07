Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFAC433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 13:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiGGN0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiGGN0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 09:26:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F298326F8
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Aycc0fHEDsk5iliYgbS1RkZHcrdY9EoPv5d9uS5Mmz0=; b=GPbvLLwg2YI9zLq/Qf1KzP6Ws2
        EES2/ASly2xqLYfkROzcwytMgYuxLTfVrlOkeM8cu3MkA2yKEbSRsTqCcpKZdEjgTt1zF3uvT0nhx
        5anDoq39hypVQH4sAvi2ziPMNOLauFgCx9JTBOG+PPmouZVuyM/EHiujIJYBZiUJ++WdgxqraC5X0
        Fo53xvc6cLgOwNSAOGIR0N/IlLXe+vgEo02gMC0IpyF2qiVdk1R2fOi4H4YXZV52vEWnRT+JDWS+R
        BkR0zncXcu1BlUlPIYw4iqjZG/mo9PViyJYdPz9ISK/6IbYr3WVHgTNTXZXg26WG6nbo7bMvcge1y
        m+6MqZdQ==;
Received: from [2001:4bb8:189:3c4a:2f57:8289:689d:9cf6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9RVn-00GFAZ-MF; Thu, 07 Jul 2022 13:25:44 +0000
Date:   Thu, 7 Jul 2022 15:25:40 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Ysbe1DGn9vLRpEOh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit f3163d8567adbfebe574fb22c647ce5b829c5971:

  Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-07

for you to fetch changes up to 5c629dc9609dc43492a7bc8060cc6120875bf096:

  nvme: use struct group for generic command dwords (2022-07-06 19:12:56 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - another bogus identifier quirk (Keith Busch)
 - use struct group in the tracer to avoid a gcc warning (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: phison e16 has bogus namespace ids
      nvme: use struct group for generic command dwords

 drivers/nvme/host/pci.c   | 3 ++-
 drivers/nvme/host/trace.h | 2 +-
 include/linux/nvme.h      | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

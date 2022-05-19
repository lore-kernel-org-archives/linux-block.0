Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7057C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiESTrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiESTrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 15:47:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BAED8FA
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1ivFVvaH/Bc6oWSN5A3QdGzfic2gASfrHsi7yeEYLXk=; b=qPEBoXBHLc04gcHRBNEBC5o9DO
        HwVNEDzw5ASlNCWc9mjylZL3R35XlwTEgU6C1jIb2g4jliL9WCGlQLAxj8zHwwFl5/5HIwsec0Urx
        NBscVkXQ+T0re0Od/8izJD1F2wYsyFO3wpOspVImUZUDveeR5Z6Qn3XjUvgm0zxmPQqTRqd3CmY5m
        kmQS0GvL585BkQof0qA3sYpKTYHk3DFYWGDMmYWhuPZunPjYDRXva695ONP/BPg6M+u1/1MlJMCJx
        FaorBVScHjqAlwRRBY2Zw9L/e560In/vZRqKgwvxmcn/sygbkvmKZCAZNbYJ0ikSNpP3dF+gR48fH
        FhTp9Ygg==;
Received: from [2001:4bb8:19a:7bdf:3c5b:8fdd:1000:1647] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrm70-009Ab2-MS; Thu, 19 May 2022 19:47:07 +0000
Date:   Thu, 19 May 2022 21:47:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.19
Message-ID: <YoaeuNGHGE/t29gY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[note that my GPG key expired today and I had to extent it.  It
might take some time to propagate to all key servers]

The following changes since commit da14f237ceef059ff1a9ee14de283905c2dac11c:

  Merge tag 'nvme-5.19-2022-05-18' of git://git.infradead.org/nvme into for-5.19/drivers (2022-05-18 06:28:04 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-19

for you to fetch changes up to 78288665b5d0154978fed431985310cb4f166836:

  nvme: set non-mdts limits in nvme_scan_work (2022-05-19 21:30:22 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.19

 - set non-mdts limits in nvme_scan_work (Chaitanya Kulkarni)
 - add support for TP4084 - Time-to-Ready Enhancements (me)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: set non-mdts limits in nvme_scan_work

Christoph Hellwig (1):
      nvme: add support for TP4084 - Time-to-Ready Enhancements

 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      | 95 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h          | 31 ++++++++++++++
 3 files changed, 117 insertions(+), 10 deletions(-)

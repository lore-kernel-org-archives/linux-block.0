Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CCC47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277B20873
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cl/hwNkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD3PbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgD3PbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C76EC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qV6FYbXfm7HLoEX0VHHt9MvYYQwVc+cSDyidfoDsmf4=; b=Cl/hwNkpnaaSj8liBE/YOTy036
        rPxdCN7VtGMXJTw139SXux+R+qAeZSgj21vR+dB05agkSJtS9Gvf1Q4IhmVAMk2XBo/sjiDymbUvt
        UsaUqMaSCVvwxZEMGUhKZoApn7Ts7JjXt4hCT5xakqA+8gTcnus4eacsfGi4k42nMX4jZbillQUFz
        pFUcNuKe1H5FMRJukIGZcjvP4JzDJuiDXsF/KEZkIOAVzvkMsSv/fYLFkKahDu9o1+/Meltkv8qk+
        ygPJjXYjhHbGzrWQvpCf0SFHZkMs6Jnr/3SnxgEhBtbW9qqSddJ6zEM5JpBWcbxjd2sk/HE+CDgEQ
        eEDX2JSg==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUB9C-0000se-O1; Thu, 30 Apr 2020 15:30:47 +0000
Date:   Thu, 30 Apr 2020 17:28:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fix for 5.7
Message-ID: <20200430152832.GA2579034@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit d205bde78fa53e1ce256b1f7f65ede9696d73ee5:

  null_blk: Cleanup zoned device initialization (2020-04-23 09:35:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to 132be62387c7a72a38872676c18b0dfae264adb8:

  nvme: prevent double free in nvme_alloc_ns() error handling (2020-04-27 17:08:06 +0200)

----------------------------------------------------------------
Niklas Cassel (1):
      nvme: prevent double free in nvme_alloc_ns() error handling

 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

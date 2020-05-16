Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B384DC433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959D520657
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sa6Dpxcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEPNZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgEPNZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 09:25:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B5C061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cBvcrhcHFAjklTbDfnqUpat87EkDNZ+5qGzYA+vntis=; b=sa6Dpxcz15Gty74rOZd2NCOMv1
        u59rrv/b+pLCNsGCfsD9GhJKPhkDJvfXDUshwIF25R9mQ9UOB3BgMRpXQWnATvGSAghNKjax1l7ok
        GjzRdxPVkhkaX8h39eL3jKWU9Rqhq7J6P87xBKd2YajnhV2wDix8KuFiARY1LzZt2KPs6M/vUw2G2
        WJY8yeVSI1FeSKYqkaeKNKQL9nPKxEoHaMBLAJS+TU5G3fqiG08N+6cjMCvWhW6asFslBjCc0+Q9t
        MLTRPq+WMn9i2Ciw9wHnzjCzNMBX1a8O+nK9/eZ0SC08wluaxHDi+fR43R16t1T5eJzJtL6SrhNf/
        CNk3o9fg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZwop-0003CY-IM; Sat, 16 May 2020 13:25:35 +0000
Date:   Sat, 16 May 2020 15:25:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.7
Message-ID: <20200516132532.GA244143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 59c7c3caaaf8750df4ec3255082f15eb4e371514:

  nvme: fix possible hang when ns scanning fails during error recovery (2020-05-09 16:07:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:

  nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: dma read memory barrier for completions

 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

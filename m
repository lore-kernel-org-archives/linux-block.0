Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1082BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40642084C
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VML4oMja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbgE1NWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390248AbgE1NWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 09:22:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D88C05BD1E
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MWHKjb7+kiBo0BJokolr/fr90Vz0BdGIU+SZu8bg4tk=; b=VML4oMjaSyxC/lbvVcmOegaKpL
        4FkezgitluhQZiJckSwJdzo4hAxwNNAa0S76HxHjccuLaNLLeTyLtCvBFrRoBz1nZN7YfeXUpUMUy
        b9d/kM0g0nldf5FB/CXjsvBX1TsaI2i7O/OWxnAi2v0nAxLy+3MNNA9rg7Zkd+E7aekWqOLl38GRw
        aJ2zeMQCJXGpJvtDKeG1ty2PwP5sl8+z94EswMDJI+3XPcojdTHRaKWST7WurBpTA0Y9BPys58/X6
        WbObKCJ+Te0BbJeND5SMnTAJzXzTl3TVp0ZEgi1nG6H1PYRmuu/kN53GYNi1KobYyQc555HM72uYW
        a2ro0j4g==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeIUT-0004mt-Ts; Thu, 28 May 2020 13:22:34 +0000
Date:   Thu, 28 May 2020 15:22:31 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@fb.com
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.7
Message-ID: <20200528132231.GA837884@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:

  nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to 9210c075cef29c1f764b4252f93105103bdfb292:

  nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll() (2020-05-27 20:32:56 +0200)

----------------------------------------------------------------
Dongli Zhang (1):
      nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll()

 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

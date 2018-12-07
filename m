Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F695C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F620672
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plpUEbsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009F620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLGPiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:38:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGPiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 10:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J2otbpKts3RDCAkwnTipHBmN0joIA5ilo8ND7jori3Y=; b=plpUEbsGCJ/fZBLP7ItRJfXb7z
        s4pNQ+dXW+skzCafC0bbZc1pA/unwH1371jrHv54cYXUJLpglAuXHL4gKBH1RzWBr512drDpY9L5U
        xhJvWg67jnEttu7+kfIk5YkeTOPazlXegEOTCT5t33fNUCYCndlxOSYk80bHa2LuHqpvanStcHz6y
        7cFFZ3aUAcokq1ZBKicWRzeGKI3BrrjZToDnMzNBWMqTnrPWlHXUA9BjXz3Vzxt2XSMhNjLpUrxMU
        Xl2vcCFuBYkZefeNsiMMa/4GNcYOHmcJ2PKnckWX+7vNVpUI1mY7BNIR+vJqAwp+rOmpWBY99Pa5v
        dbWzpqlw==;
Received: from 50-242-72-51-static.hfc.comcastbusiness.net ([50.242.72.51] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVICs-0003Cp-Sz; Fri, 07 Dec 2018 15:38:22 +0000
Date:   Fri, 7 Dec 2018 07:38:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181207153821.GA14210@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit ba7aeae5539c7a7cccc4cf07a2bc61281a93c50e:

  block, bfq: fix decrement of num_active_groups (2018-12-07 07:40:07 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to d7dcdf9d4e15189ecfda24cc87339a3425448d5c:

  nvmet-rdma: fix response use after free (2018-12-07 07:11:11 -0800)

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet-rdma: fix response use after free

James Smart (1):
      nvme: validate controller state before rescheduling keep alive

 drivers/nvme/host/core.c   | 10 +++++++++-
 drivers/nvme/target/rdma.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

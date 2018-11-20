Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920BC41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E996620684
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4m1lG9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E996620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKUCoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:44:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 21:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dGRISEPatutdt4htlvDjN0TB3+Ix02ppCeJm3f9CJ+M=; b=a4m1lG9vXt+4pCnux/Iqx/tTev
        IghDXppJQoS7bkaNcmqyefI9bZKFhG3iEfVDRWfp5mVJIi6JdTUpLxPBQltgIE76NDMosRFII8/O/
        1eWzEEaaOBewxgxkI9iT/bonvea32OEnhOafs6tb9Ka+HYOx1k3TygZiWnPO8IBoMkYTX/gnCY7st
        8t3fnflWUljqpxFxy4psThzgSXvc3FAoBwfObHDCZtialD83bOXz8K68e05/dBjw9r9Agv72CCpHQ
        Hic6qD73Z0/BTZnGvVmrR5wKZcp/EP6UK1izEL6TBJkfBMY5qtxDnYlrWPW5Nk+zGuw50UW/pIY/X
        FLvSnqvg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP8fM-0004Ps-UC; Tue, 20 Nov 2018 16:14:21 +0000
Date:   Tue, 20 Nov 2018 17:14:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 4.20
Message-ID: <20181120161411.GA1367@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a:

  SCSI: fix queue cleanup race before queue initialization is done (2018-11-14 08:19:10 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to 4cff280a5fccf6513ed9e895bb3a4e7ad8b0cedc:

  nvme-fc: resolve io failures during connect (2018-11-15 11:37:55 +0100)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: resolve io failures during connect

 drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

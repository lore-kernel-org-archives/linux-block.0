Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233DC282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3157222C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BERQVC9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfBMHEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:04:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbfBMHEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 02:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OFBAB6HlFhr5QqNN+F3bwrZdCaqpYp+te5ziTarFU9o=; b=BERQVC9K9F3Q1yz5jMKjjhRGid
        jT+7isBUa/qegaTI3bfc8YsZStaneJXygWff8Mg2epfFFx1O0WkZ3U9Q3Y93I76t76HOlmMTphEz0
        gf15r1f/IdNnabA6Akhin1zQ1vjgJf1dcMKwTp4MdjF/zuknMkNRXO29XFjnjQktUbAZ/2eOMOHZn
        Eq5WECF0RVu2kOcpcPxuhq7BNKomJmaMXdZ7oR9Y202txObOjREOsYZuIycZKsIjYykl+7BA5FNJt
        +qpFqZKY+POnTZV01xNC0aBxS7cevVYO9d7TMSlAkEOCEa9xAVb1PFt/45VAezT+CqAt6BNI1DLS4
        muOlWDpw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtob1-00012v-CD; Wed, 13 Feb 2019 07:04:39 +0000
Date:   Wed, 13 Feb 2019 08:04:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.0
Message-ID: <20190213070438.GA11528@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit aef1897cd36dcf5e296f1d2bae7e0d268561b685:

  blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue (2019-02-11 19:51:52 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to 4726bcf30fad37cc555cd9dcd6c73f2b2668c879:

  nvme-pci: add missing unlock for reset error (2019-02-12 09:29:07 +0100)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: add missing unlock for reset error

 drivers/nvme/host/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605BC433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiBCTft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiBCTft (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Feb 2022 14:35:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB5C06173D
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GBFnOgde9oqUR1AZu6IyA7t4Yh0JHyulvtCcPkRH72M=; b=qEd4J265F2FKKnc2DCyHAp63Xb
        HOFS4F6ioFMSLfMAQ2wwMCq1lxa1UM6j9D9u5gT72HewYXBW2Kotx2+3gI3RDkLoCkvcbf6xGejVO
        /w40SFCdpLs4qb3wwAOLIOkP8+x+guSPxKOvq8zQrysCWjXQOjofBzU1NTT1SCam4XWJJzl1SKuxb
        3w+n0iAdlQDTKtZYdhyDItOfY2OkHOx8DvjauaClCROgonBLDHMlIZqNabZsAMKOIATzKWLn+680B
        1wqrz78J5Ea+0jjNjvNWPfPWAsv7iEpC5M0HWT1GSWD+FSzV+z+Vc7b6a9iJUnJYJcLOnzX0HIzA8
        qbA/Knag==;
Received: from [2001:4bb8:199:3f6d:6013:69ea:945:9283] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFhtT-002bIV-Dq; Thu, 03 Feb 2022 19:35:47 +0000
Date:   Thu, 3 Feb 2022 20:35:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YfwukSSzRWJE2Jy2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b879f915bc48a18d4f4462729192435bb0f17052:

  dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-03

for you to fetch changes up to 6a51abdeb259a56d95f13cc67e3a0838bcda0377:

  nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts() (2022-02-03 07:30:57 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - fix a use-after-free in rdm and tcp controller reset (Sagi Grimberg)
 - fix the state check in nvmf_ctlr_matches_baseopts (Uday Shankar)

----------------------------------------------------------------
Sagi Grimberg (3):
      nvme: fix a possible use-after-free in controller reset during load
      nvme-tcp: fix possible use-after-free in transport error_recovery work
      nvme-rdma: fix possible use-after-free in transport error_recovery work

Uday Shankar (1):
      nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

 drivers/nvme/host/core.c    | 9 ++++++++-
 drivers/nvme/host/fabrics.h | 1 +
 drivers/nvme/host/rdma.c    | 1 +
 drivers/nvme/host/tcp.c     | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

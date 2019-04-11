Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B113C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FFC2083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwFH+V1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKPb7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:31:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKPb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WNMrPTVm2MR5pNFDPHj2Q5G4aqrbODCTOa7tmZumx6k=; b=MwFH+V1OBoqFpuQAia7rf3mlsT
        3ewA6CB+ahCnPEFDLqsGjUkXd7x2KKlg5UpVcpb2emm5yibFoVqkQdkaUlwO81Jyp7pLqsnlm7EWE
        xJJ1YASfJNdhKT4CpLXNrGbfoRltPZF3a8bPEoSc7y2pSQ8T8IJpCqbaIitzTgYKhDYW1jfqlgN52
        La4z2vwPgkdv5WmPNol6tCeB2NXApLDxIVSWrJy1E3sHyovAYQcEK6cFpMV4vTDgltytLrvRVrCWi
        x2WeyrfXWj8L64mHnrHtXPRy1W8K1iUEmA3hD8Xlnr5dBVnxjMnWcE0wxiysOc3NIjVzXyO7GGWOE
        BCCNbQmw==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbgD-0004Cy-G0; Thu, 11 Apr 2019 15:31:57 +0000
Date:   Thu, 11 Apr 2019 17:31:34 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.1
Message-ID: <20190411153134.GA16359@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

two nvme fixes for 5.1 - fixing the initial CSN for nvme-fc, and handle
log page offsets properly in the target.

The following changes since commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925:

  block: do not leak memory in bio_copy_user_iov() (2019-04-10 16:14:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to d808b7f759b50acf0784ce6230ffa63e12ef465d:

  nvmet: fix discover log page when offsets are used (2019-04-11 17:28:30 +0200)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: correct csn initialization and increments on error

Keith Busch (1):
      nvmet: fix discover log page when offsets are used

 drivers/nvme/host/fc.c          | 20 +++++++++---
 drivers/nvme/target/admin-cmd.c |  5 +++
 drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  9 ++++--
 5 files changed, 73 insertions(+), 30 deletions(-)

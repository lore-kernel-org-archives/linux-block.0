Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E0C05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 05:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBIFKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 00:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBIFKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 00:10:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF282B2A6
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iBtAheEM6wnZRltncAb4YD4CDLILeplXzPceme4va8E=; b=Lrg/w3DKkynU3iy7W4KH9bNOow
        cIkYDdQDtku0f/6foOh3dFEzo3Yf6I7PY5qHrKZNRzeIb9BGUZ7HqLeKGlBEfpKpM4kcuRAfiixkI
        YV4u9xFV+KunYrHxJFKnBClbNp7a/cGTAK6qLIHtqx7dj/VqxrxEGZu6/UQbPeZw1DWp1Y1Sf1QVv
        /dI8WfBTBr+jSh90TD+31ylnwW8Pwi8iUgGADf5COpyepCUBpKe3eNA3mmBkDGC6w8GcLqEofhnEB
        7/V2zDrhbgDU5txfR6rWENqDbBQxQzs1XnfOfYDnopqkj3KmUzNbZywi4xzxXQRIhSCQGF9IxGsEa
        2sIaZpXQ==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzCM-000BYu-4R; Thu, 09 Feb 2023 05:10:18 +0000
Date:   Thu, 9 Feb 2023 06:10:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y+SAN97vxJtL/l4G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:

  Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-09

for you to fetch changes up to 70daa5c8f001e351af174c40ac21eb0a25600483:

  nvme-auth: mark nvme_auth_wq static (2023-02-08 07:28:16 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix a static checker warning for a variable introduces in the last
   pull request (Tom Rix)

----------------------------------------------------------------
Tom Rix (1):
      nvme-auth: mark nvme_auth_wq static

 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

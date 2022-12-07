Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A47C4708E
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLGOJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLGOJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 09:09:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D81096
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ega/ymHiohwYqmOVO0xNlbAF7Cc6uCydw63WlUlCezo=; b=0UC+BruLxoBLOsf3QgVl/nG9zw
        R46YttzGV+7FI5uxFh3f/30D73Y9sKUE01Stp2cjFXKCS2SLQjIM0zG80zhuvVKo3h9/Z5EOR52IV
        RLXO/uesJGdRwOQJIYC+ljgEbhuuWLr4/tvOMdQ06t4Cc3edmlMIvqhK2+bxUNL3dgE/qvUs7IPl2
        UjWQj6NQJ+AyCivGhZqYzrwax8zTcohdfu0Z+i1NI/ACzUvq7HiWjUlevQ8jaApwHzXbQc+T0eU+a
        28BZCDy3pNa4JtN7qozXBiTUrFx2488CJLTxy0rjX5pIKSwpU2+9/6GqHureoYad11X4zdFbUczak
        EACFfPxA==;
Received: from [2001:4bb8:19a:6deb:1e50:ef0a:649d:fd9d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2v7D-004XpL-Sv; Wed, 07 Dec 2022 14:09:40 +0000
Date:   Wed, 7 Dec 2022 15:09:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y5CeoZZcOCYaS/P9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 899d2a05dc14733cfba6224083c6b0dd5a738590:

  nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-12-07

for you to fetch changes up to 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224:

  nvme initialize core quirks before calling nvme_init_subsystem (2022-12-06 09:05:59 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - initialize core quirks before calling nvme_init_subsystem
   (Pankaj Raghav)

----------------------------------------------------------------
Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

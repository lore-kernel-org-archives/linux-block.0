Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE94C636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBQNZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQNZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 08:25:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C664B1A
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dh2mOVLVNuPHRCozUiQ72xMyWhCXI8s2QDhvo1SiyDM=; b=s0SA5F37zI1ckNkiCgMVEK+N9E
        6QGRqMfv1xi2Bk+3YtO1gXlL0B9Kja84lRFktJyrKThQIQ7LSEFGj57MQnMX/hwq0lL51lytBBcMU
        Ls/jv0+jNVzSoEZ7VzCCaY4fmINGYVMAYrUYKmkbBd46NYZ878wnUy2ecSZrLKFofYYd51jgPahar
        BoUOiIHffhi9pu3189UHBhDb0Qhgagv6OFTlqHqxCrdYtsMMoeJR59bhXEg0NW4WSLIEFub/iTx0p
        3P8ZvfCrQqUbDvDKhHQ2MgKlhIn+ztU9O0/CS9NYwM25xCPxZOF9ieOu4JdDTKG9yFg10cu4TXHiT
        DeEw65MQ==;
Received: from [2001:4bb8:181:6771:d986:bedf:4fff:d74c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT0jy-00EHF9-EJ; Fri, 17 Feb 2023 13:25:30 +0000
Date:   Fri, 17 Feb 2023 14:25:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.2
Message-ID: <Y++ARzuse5GE4UCL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 9a28b92cc21e8445c25b18e46f41634539938a91:

  Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-02-17

for you to fetch changes up to e917a849c3fc317c4a5f82bb18726000173d39e6:

  nvme-pci: refresh visible attrs for cmb attributes (2023-02-17 08:31:05 +0100)

----------------------------------------------------------------
nvme fix for Linux 6.2

 - fix visibility of the CMB sysfs attributes (Keith Busch)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: refresh visible attrs for cmb attributes

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

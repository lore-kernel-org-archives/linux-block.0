Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302CC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D39214DA
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uULZEGDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfHSV7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:59:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSV7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ujodQeB0+IjwFSh24PwJeDH5Ge2ugJ2865YxLf1QjNk=; b=uULZEGDKV4P2+TCH10H4br1ww
        WLxOZ/a4nGHxaVW1zmMbIJUW4OTfABwae5jSSan+Mrb2xAzll8NoePoojzxT8SqYv4sgwgKcvJXOZ
        St4hCxmUR2YcQSw0JlX2F2GCumD70nnQxrzq4hLFgsRzTRkEJQHf734YKNspNqg0Ywsc8FRjJN3nO
        PCNht4lkdZMx4SmqhyUTZl9ZkbMPRR6/8PAevOkSKaRUqmsv4Jw/WaaeLeAZEdtih6woD/hT8PxJa
        l92HVquHFCikca0Mwkm5h2+Ewlb48iukq4v4kK4R+p2dxWk9mAhBSKtvwsRblG7AG9Xt/oTa0ceNL
        05Eip/TdA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hzpgH-0001wz-MC; Mon, 19 Aug 2019 21:59:13 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] some more nvme fixes for the next round of 5.3-rc
Date:   Mon, 19 Aug 2019 14:59:11 -0700
Message-Id: <20190819215911.28552-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

Few important late fixes for nvme:
- multipath fix that prevent possible I/O hangs in path failover from Anton
- cntlid verification caused regression in pci controllers from Guilherme
- suspend/resume quirk that fixes a regression on the LiteON device from Mario

The following changes since commit 2fc7323f1c4b94f8301058805a5da7d202e27bfc:

  io_uring: fix potential hang with polled IO (2019-08-19 12:15:59 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3-rc 

for you to fetch changes up to 1b538f48fdb0522cc44c920f606fac45d5dd8b00:

  nvme: Add quirk for LiteON CL1 devices running FW 22301111 (2019-08-19 12:08:17 -0700)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix possible I/O hang when paths are updated

Guilherme G. Piccoli (1):
      nvme: Fix cntlid validation when not using NVMEoF

Mario Limonciello (1):
      nvme: Add quirk for LiteON CL1 devices running FW 22301111

 drivers/nvme/host/core.c      | 14 +++++++++++++-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/nvme.h      |  5 +++++
 drivers/nvme/host/pci.c       |  3 ++-
 4 files changed, 21 insertions(+), 2 deletions(-)

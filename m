Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7C5207F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHgcih2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2RaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2RaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:30:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F41C061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8+DbFmLONb9RPRXJafuIV7buNQfBxWlf9Ys9UE/QO2I=; b=jHgcih2eGtVJCHGOkdDLjN+5iz
        P2Lp3xTMDAIzFCcwiE4O1soVvp9KBnHjXngtbk1Zk35phm+grFVAt248Xhm8Aa8Oc86Gdejh72Fvh
        Nq9rUm7wZZynf3rH67iec9k7YhZ9V/J6Xc/W2xBjlAwuunRSJ3WFApW8LXhDyAaYMsHtE1N3xknWd
        XQgYWpusDkQIP6ZaN4Fn1kYUcQ5dwG6n7XsQ5LMQUhPFS9YOAgZZiTGmwuyLheAw3TBLvQEjicrDk
        z+frH63QSsWdnoRu7O4SapJE6bU09+OkaqrpzD4z94YNnqvxOdSTDK0bxqOmXJ7qNFAHSbU9jBw4p
        XcaJVGEg==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0pu7-0003Vv-Ae; Wed, 29 Jul 2020 17:30:11 +0000
Date:   Wed, 29 Jul 2020 19:30:10 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200729173010.GA25167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 1f273e255b285282707fa3246391f66e9dc4178f:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:

  nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: add a Identify Namespace Identification Descriptor list quirk

Kai-Heng Feng (1):
      nvme-pci: prevent SK hynix PC400 from using Write Zeroes command

Sagi Grimberg (1):
      nvme-tcp: fix possible hang waiting for icresp response

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 drivers/nvme/host/tcp.c  |  3 +++
 4 files changed, 17 insertions(+), 12 deletions(-)

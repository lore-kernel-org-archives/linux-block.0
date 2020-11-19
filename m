Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD943C63798
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC0F246DE
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 07:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OISqq6V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKSHvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgKSHvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 02:51:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB01C0613CF
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 23:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Pyu9heZIDLVyXwvBLRyPWIbTuCXkV5mAZehTNuiPea0=; b=OISqq6V4TeyD5DG2t3TMdXlEbG
        MusG4yOkvrmrRQZ7vEwkX2W5xC1BkKgKbqnfiwNM5PkLpHNdTporJaGJ5uolfavnOGKYvR0v/qeAm
        k3pV1KAH34Zq+bmPXC4Y+qDf60o7rN3SMphDudYOcZN1ugAaf5ya16tfXvJYQlDqwh/14rPjbe56u
        d7oPNkyrj+Dinl3mj8FbEbu3apaaEz0Bp+YANRHAK22Mo5Oz07NN0q8jp8j2QuxJn9McXHPULmdVO
        uyeSc5QTrtsdFaDZP+HXrIDGFfnYYikRI5yZD7zMPvSs5O/QWBDgO+YvHR0zohVDnc+U2tpMOXGPB
        8YZ5u9Hg==;
Received: from [2001:4bb8:18c:31ba:300a:fbec:1f54:a33a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfeiY-0000y8-U8; Thu, 19 Nov 2020 07:50:59 +0000
Date:   Thu, 19 Nov 2020 08:50:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201119075057.GA2465128@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 9f16a66733c90b5f33f624b0b0e36a345b0aaf93:

  block: mark flush request as IDLE when it is really finished (2020-11-13 14:24:16 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-19

for you to fetch changes up to 8168d23fbcee4f9f6c5a1ce8650417f09aef70eb:

  nvme: fix memory leak freeing command effects (2020-11-14 09:57:55 +0100)

----------------------------------------------------------------
nvme fixes for 5.10

 - Doorbell Buffer freeing fix (Minwoo Im)
 - CSE log leak fix (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme: directly cache command effects log
      nvme: fix memory leak freeing command effects

Minwoo Im (1):
      nvme: free sq/cq dbbuf pointers when dbbuf set fails

 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  6 ------
 drivers/nvme/host/pci.c  | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3ACC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA83D206B2
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 10:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEZMVw/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJKgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgKJKgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 05:36:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F9C0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 02:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qibVoX6IULdWdPkI08Qmvy4hrCZ2mnIgyB5imAKkBcw=; b=UEZMVw/892HnI3xkni8Ccd4diF
        qRgZGa9eN8Xm7GqFqftAdHOdcx8XCoNLr8aN5XxWkmNP/s2Bw1jLEHXEFwr0DeaBtR+9juPkAOgoM
        0OfhW6QB8gTmeL+tEYePxKjZLxHAoPyuMnqUyz1Ln62yN04/iICR6/CzJ579MAaEBiLdwVkslZTbF
        hWWbMuCCinVjxjyiJThzTD1qkao+Wqs39fYxIA2O7nHzXIkaQEkTCM1CrwInFjGa79hFP+BN9CpT3
        ijK7WtlU2Dqf9ab3aZJrSTKk9x2kejNRPTVapfzm+lhKlY8CTpVrO/C5oBGXQQ0E96MBmrq0L4zQg
        rpxuc6Bw==;
Received: from [2001:4bb8:180:6600:1e3a:5cde:56c5:2738] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcR0d-0006HB-W3; Tue, 10 Nov 2020 10:36:20 +0000
Date:   Tue, 10 Nov 2020 11:36:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.10
Message-ID: <20201110103620.GA3200092@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e1777d099728a76a8f8090f89649aac961e7e530:

  null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-10

for you to fetch changes up to 65c5a055b0d567b7e7639d942c0605da9cc54c5e:

  nvme: fix incorrect behavior when BLKROSET is called by the user (2020-11-09 17:39:15 +0100)

----------------------------------------------------------------
nvme fixes for 5.10:

 - don't clear the read-only bit on a revalidate (Sagi Grimberg)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvme: fix incorrect behavior when BLKROSET is called by the user

 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

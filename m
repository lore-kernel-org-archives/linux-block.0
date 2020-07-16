Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45539C433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209AE207BC
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JbisizTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgGPOmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgGPOmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:42:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D4C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DYDmyYTH9KAmzY7DEUnovhADbtU1IOpaCstIMpojNGA=; b=JbisizTMiCzaYQQDjCpJkubB3x
        0VtjrpgnNqIW3EdUpJbyjIjxv0o3MwAR9tqTxSvcu5s/2O7CGqnWoQEMFIsP6Q1/7Asyfvd9FRw6w
        zAfzZt8Z29K2gGqO0SBl8XyKQLBawP2IPF44nA1rxsoZaR4r1JywMivdttA1mRvlTm0f/S6cPoaka
        xBpq4wv/nJaIvhVTlvyJTOQAewMyIBi8D2x6eR5uvo6Slh4nF6VN7BG8BUbcgL+N/TBgON3VRooG/
        KrGesm/Esdt2iUhUN7HXOmTaoY/xkstg2b7QRkKo8xDcwNrtZN8HiGgi7aghcujbrX2co5rM7mUPs
        EltmcGFw==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw55K-0000pH-8l; Thu, 16 Jul 2020 14:42:07 +0000
Date:   Thu, 16 Jul 2020 16:42:05 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.8
Message-ID: <20200716144205.GA475287@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 579dd91ab3a5446b148e7f179b6596b270dace46:

  nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 05b29021fba5e725dd385151ef00b6340229b500:

  nvme: explicitly update mpath disk capacity on revalidation (2020-07-16 16:40:27 +0200)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvme: explicitly update mpath disk capacity on revalidation

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

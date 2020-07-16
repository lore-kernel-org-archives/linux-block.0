Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4065C433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF3020787
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TarVFLIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPOdP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPOdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB176C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=niz8BZ3+orX2F8Zgd7PShUBTkfMRHT9kOHEGtsE5E/A=; b=TarVFLIQBuGpO1Uyf0zbX7Wod5
        hqYaPMJs6cqBqLHgT3AaAuNFx2kXwgsN0Kwq8ai9g+daJHY+8uDfbRa+uDL6uJ9YEBput95IFDpC/
        r4lMopnR1lrSHDmrx5F02kGbzfzp2zkevXnYDKDEl3cc5vtEaYn9s1pMKwQiIAtGvpZPLbx+KpWds
        qImX2+2qTMmIcLD7+i/FMDllSnGudgCZMRasrrwQnev69ZVM7NmV9w/+EmxmZWs4EU4K/73Xdl17e
        n6yhyT1j00cdJnJypDtcovGInn5jBCVL446mw/u5IdI8Z10VNb6jSB3hZHDHThegB5yt+t1DZM5RN
        0EX3nPog==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw4wi-0000Bv-2G; Thu, 16 Jul 2020 14:33:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: simplify block device claiming (resend)
Date:   Thu, 16 Jul 2020 16:33:06 +0200
Message-Id: <20200716143310.473136-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series simplifies how we claim block devices for exclusive opens.

Diffstat:
 drivers/block/loop.c   |    7 -
 fs/block_dev.c         |  231 ++++++++++++++++---------------------------------
 include/linux/blkdev.h |    3 
 3 files changed, 81 insertions(+), 160 deletions(-)

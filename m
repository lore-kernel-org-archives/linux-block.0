Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAADC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FC92077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTnaIA1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfCMRz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMRz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQvM3AVLvmtwwsI5N6JIciEQVMEUbAAIvRWgNyZSjH8=; b=FTnaIA1h6DDcGogDRj/AmTd+s
        N2GlQCHqyvnym98IqCKvRAaNV2b99OXvVu/W6e80gxBhynjS49GOaAIbxGfNl/9sD/OX1mRbCafdy
        k++34cI+x6M2fEqTR+B8qYVmwJumtJsA44Tm3qa3O4iF9GIt76oE+RsMZzDJWTUQhjSiSuyDCCtiG
        zoRrNXPbqgW6JGpmANv4E8hlDLdKOFkkusaOoI/2P0UEpLF75rYdLqTVZX/FFjaHDupBwU/9ekV0Q
        nLcSC2Ik0cXuD0+kteF7Hn08sRrq66v+0vOz0Ksdx6WXEUgwstRaIbTCnEX/e4Ruu95IBiM9eDZlF
        FhdkdfagQ==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4867-0001BK-Ez; Wed, 13 Mar 2019 17:55:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCHBOMB] nvme fixes for 5.1
Date:   Wed, 13 Mar 2019 18:54:53 +0100
Message-Id: <20190313175510.20725-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

git.infradead.org seems to have some hickups at the moment, so
this bunch of nvme fixes will come in form of a patchbomb instead.

Most important is quirking Write Zeroes on qemu, as the implementation
there is buggy and could lead to ext4 data corruption.  Except for
that we have various other fixes all over the place.

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6590C7EE24
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 05:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjERFbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 01:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjERFbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284FF4
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=s9/boZrdClRccMuvsWkOM7TFtrXRUrc2tLQCZ3l6lO8=; b=gvCHuIv21/PPjkkrcgMlx10lNW
        8PhLBgGa3lcDZ8FCeIVgJPzhEEnSt1hTsWxjqCAd1d5mjHmpCGgkEG10z3OSRXM74JUsrfSt5oHJn
        6URN/Hp9RqLYtXxwa6U1Uy0S/t7XPS5nlq203OtM4Yqe811WEmmJjQSzZlixzvfP1hMOjiiE8EWPr
        kxcnGkvxVUmBbbYGS7358pVpofcD3zajIUXejc+0bmF0SETeT92TtC4IENiOG9SplYU/hIBthHbMD
        sC0CHHxdXYgHUYb8ziUOAbsTUh9kMD3Md5jrlncwlFijSiGSC9dQ8+w1JwV5ILrNx39i6+hEJ3XIc
        qqB/8VPQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWEC-00Bwco-12;
        Thu, 18 May 2023 05:31:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: keep passthrough request out of the I/O schedulers
Date:   Thu, 18 May 2023 07:30:58 +0200
Message-Id: <20230518053101.760632-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this is my respin of Ming's "blk-mq: handle passthrough request as really
passthrough" series.  The first patch is a slightly tweaked version of
Ming's first patch, while the 2 others are new based on the discussion.

This isn't meant to shut down the discussion on wether to use scheduler
tags for passthrough or not, but I'd like to see the bug fixed (and
a series I have that needs it unblocked).


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057BAC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CBE610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJMRPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbhJMRPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:15:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DC4C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uYNcAkyZUU/OVIpBT3iO/T1mC9A7bmQB000wdlCtxDA=; b=HlZA1/Zw3WPzK0VgADF861Drvq
        gc5m9F6Yr9sNzpL+d8BHVfjBeAXPWd70PwN8ISXwlyMNCBF3IAaO+kJdFcm7SeTyu/9gocTMlk4LT
        ahYb0U25oahR1NNftHBRA3FZuac0P66nBfAMsRMEzG5UIGh1SdFHaLiR2b9Hh4d1UoV627yTZSDJH
        E/j/nohbYUUK8AtT/ly0P1euybXUqwHyd+Y4bF9pkHV/KgXJnRG4Dpvok4EaA5pVYMEDyQtWYB3ir
        3VRV6pqHqDOAhGTcMW1862liNyCvtwQ1ZbXn787I3t4R+iNUqC5m+RFVbBXXpwMX9QmtAQYSa44VE
        650n0eAw==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahnd-007eL4-7O; Wed, 13 Oct 2021 17:12:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: simplify I/O size calculation helpers v2
Date:   Wed, 13 Oct 2021 19:12:09 +0200
Message-Id: <20211013171215.1177671-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series calculates various I/O size calculations.

Changes since v1:
 - rename chunk_size_left to blk_chunk_sectors_left
 - split a patch into two

Diffstat:
 block/blk-merge.c      |   28 ++++++++++++++++------------
 drivers/md/dm.c        |   18 ++++++------------
 include/linux/blkdev.h |   27 ++++++++-------------------
 3 files changed, 30 insertions(+), 43 deletions(-)

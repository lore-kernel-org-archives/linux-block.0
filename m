Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52942C433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3360061451
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhENNUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhENNUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 09:20:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE18C06174A
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wq07GzW5+dy29qEQNilChQ2Aoc10PSztzJzKzTeesyQ=; b=ow5sDqvJdkuaPrCCgr0K7n4fIb
        a7O/v+k1+61aRaWeJnZ8iA3n8q90ZrPS85HEOjJxdRI0J9ovNcR1ANMzc4xCdOiS9E0/q40hVFLkg
        DVDKDKDxodYprTwGoMWz/JDW0BCIgFoULTBAZhvK+DYxduIJNRQhAY/EF4zHGiX427LJFJV8WBAt3
        T+svhlIMaWjmANzIx0NJ9A37wMZrUZ5W4qZlINcze0A5HtM/l71CIXRLAaS2Jf7LthLNIOKRvs9E8
        xyGNvcH29nNtFseNunS/ZmR68USwmarhKCWEOP3vXxxCSU1oRZg2pDW64JihcxOGqbb6tHi1ZVGXb
        faxT4/PQ==;
Received: from [2001:4bb8:198:fbc8:cf38:8667:24ad:8b9e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhXiH-00BzyK-1d; Fri, 14 May 2021 13:18:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: fix a race between del_gendisk and BLKRRPART v2
Date:   Fri, 14 May 2021 15:18:40 +0200
Message-Id: <20210514131842.1600568-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this is based of a patch from Gulam and suggestions from Ming and fixes a
race between del_gendisk and BLKRRPART while also removing a global lock.

Changes since v1:
 - fix the GENHD_FL_UP check in __blkdev_get
 - don't change where remove_inode_hash is called for now
 - improve the commit message

Diffstat:
 block/genhd.c         |   11 +----------
 fs/block_dev.c        |   18 ++++++++----------
 include/linux/genhd.h |    2 --
 3 files changed, 9 insertions(+), 22 deletions(-)

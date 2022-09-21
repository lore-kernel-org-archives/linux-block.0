Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE4C6FA8B
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIUSFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIUSFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F843E75
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NwCVUcTaAl8jMvQrWUKup9Q8suDo94zeOUoMOzZFE3M=; b=dOoegQxw0kbRIv0oUVWA8PxWcE
        IBVCNh0kGDbz6upynToYwF5sLMeKnGAuovkC0A1Z4ciVDFJdverpKbwuObLatvyMxzRK4Tw09EG1X
        iuwTtCHmdDK+XesB5xY7ITqE997K0kn+VKuzq3UQc3TDAdS25vbZGOl1ExuizbVa41DfnIKHL+1Bi
        C+mb0dWewvluolEBFTWgL9LycBZXHmCdTPOCwQ9F4cY6obvtFxEX7lTXZ2nR4l9DVMbvLg6TD+0aF
        wtMAM468P3AJwSlxBIoW3HjI/haYvNnvdcNkQo1GfcOi+i1mc+QU3rBddIjE386VcuBqzI+b7Invq
        ko37Bslg==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45o-00CGVe-RM; Wed, 21 Sep 2022 18:05:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: blk-cgroup cleanups
Date:   Wed, 21 Sep 2022 20:04:44 +0200
Message-Id: <20220921180501.1539876-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun and Jens,

this series has a bunch of blk-cgroup cleanups and preparation
for preparing to make blk-cgroup gendisk based.  Another series
for the next merge window will follow for the real changes that
include refcounting updates.

Diffstat:
 block/blk-cgroup.c         |  186 +++++++++++++++++----------------------------
 block/blk-cgroup.h         |   68 ++++------------
 block/blk-iocost.c         |   37 ++++----
 block/blk-iolatency.c      |    5 -
 block/blk-ioprio.c         |    8 -
 block/blk-ioprio.h         |    8 -
 block/blk-sysfs.c          |    2 
 block/blk-throttle.c       |   13 ++-
 block/blk-throttle.h       |   16 +--
 block/blk.h                |    4 
 block/genhd.c              |    7 -
 include/linux/blk-cgroup.h |    5 -
 mm/swapfile.c              |    2 
 13 files changed, 148 insertions(+), 213 deletions(-)

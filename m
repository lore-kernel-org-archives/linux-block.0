Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B623C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDPTtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDPTtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 15:49:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2332230CA
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F9L9P58n57A0ufxvv7/0CHGHdWHcZ5biLhxf3fIs/58=; b=aMPqZZ/QJ3P0lBygd2Qvg5WGgY
        6JQTRvajB/KBX/IB6JHCiAlgA36+Gj5fUWZOZGpawMeSBb0+DI5InDZFHm9kl1rvMipJXicrxHklc
        TRcxDGMzK16/3qEYOlQcB/9L+q9BADhkP8y7QGfjXljVpOHkTbPzQCZjeCOsq0yX3pZFIkkt/BLVj
        fUPUvGqI8TSKp+eFKu/jNqX1fXbBzwqmk/B4U6goZC0bOSuHrF4Q6zVI9FSNn0DilsJcdD8++5fPG
        SZJtD0zCfMBUYQaLptH7omFc28HiPj1uq9wbsXHn8pDiiiNC1O7iE5I6gM9SO2TXIGfZNQP/5X/4f
        ycwPtHrg==;
Received: from [2001:4bb8:192:2d6c:5f21:d4dd:b05:2ef5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8Ms-00ENOh-1d;
        Sun, 16 Apr 2023 19:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: RFC: less special casing for flush requests
Date:   Sun, 16 Apr 2023 21:48:48 +0200
Message-Id: <20230416194855.29144-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

inspired by Barts quest for less reording during requeues, this series
aims to limit the scope of requeues.  This is mostly done by simply
sending down more than we currently do down the normal submission path
with the help of Bart's patch to allow requests that are in the flush
state machine to still be seen by the I/O schedulers.

Diffstat:
 block/blk-flush.c      |  115 +++++++++++++++++++++++++++----------------------
 block/blk-mq-debugfs.c |    1 
 block/blk-mq-sched.c   |   14 +++++
 block/blk-mq-sched.h   |    1 
 block/blk-mq.c         |   68 ++++++++++------------------
 block/blk-mq.h         |    5 --
 block/blk.h            |    2 
 include/linux/blk-mq.h |   31 +++++--------
 include/linux/blkdev.h |    1 
 9 files changed, 119 insertions(+), 119 deletions(-)

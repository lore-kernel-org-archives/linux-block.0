Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA3C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDPUJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPUJl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80321BC0
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F9L9P58n57A0ufxvv7/0CHGHdWHcZ5biLhxf3fIs/58=; b=k3FIcYJpgqF9fmMKvZHmInUV9H
        bb7O7PY/5NHqA2HdcLI+sKzN2yBh+5tbBBOnC1Ap2Co7tJh+89o3ZX62iZk9eQwVNM3MpNm7SNZIz
        d73X2+xlPLMwQR1db+maUL4ttsLloOZN24wOA1ziF514jNvDyDRxaqKzwZiHLKRLh3/RSl4wL/bj7
        PyoUlAYF0HWjnkX/0TXLryyoZxeqKsxrKhgP4go3tUa2FNNjoKJuDLDCxOsIzIb4I7MIzMXPbM6c1
        gioNAnTxCdaqu8kZHh95NXos+c9VEbNjqeVaDBvSJ+rDKwaLY+Rom2DwzATPRGn7IeUunf3S2S0rC
        PYGaD2UQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8gq-00EOHd-22;
        Sun, 16 Apr 2023 20:09:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: RFC: less special casing for flush requests
Date:   Sun, 16 Apr 2023 22:09:23 +0200
Message-Id: <20230416200930.29542-1-hch@lst.de>
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

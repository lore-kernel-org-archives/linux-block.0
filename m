Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC57C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDKNdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDKNdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3013448B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RfUdgJvzGQT5nsVFZkY4qwOAE2QlwC9gr1cW8+Mu1v8=; b=vCuLmPDXGgJo49X8MmEdTzY4OQ
        32W2tvj6t/fy4zeIRSz0fvMeA/vfqFfmUGZypcaA9BzzAoHq9LoqWordQj95r/Il6yOg/cIEbNvae
        FEgQ6YaHoLZDyuQKFdmh+PThaJU1rM+u1kRF805fuQ8ntxV0WRPaOgx0lTSVabGhhWvH2CfQoEMXB
        dc2cxviTw0mbBPrYd0jzTLM+DO6MhRfm+8UUSaPY2154DHq13Xod4kl8OD1Mq4l8iM8E2SlL+tFjL
        AtYZNGG7fPBMVJYLtrA8aS7ugW7Chpa5bPQ4BJ/is3GK5p/CbjZ0aRhEDkUrEQYECWezrThYm+NpE
        dFqSB0xg==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE7p-0007qI-1z;
        Tue, 11 Apr 2023 13:33:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: cleanup request insertation parameters
Date:   Tue, 11 Apr 2023 15:33:13 +0200
Message-Id: <20230411133329.554624-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

in context of his latest series Bart commented that it's too hard
to find all spots that do a head insertation into the blk-mq dispatch
queues.  This series collapses various far too deep callchains, drop
two of the three bools and then replaced the final once with a greppable
constant.

This will create some rebased work for Bart of top of the other comments
he got, but I think this will allow us to sort out some of the request
order issues much better while also making the code a lot more readable.


Diffstat:
 bfq-iosched.c   |   16 +--
 blk-flush.c     |   11 --
 blk-mq-sched.c  |  110 ---------------------
 blk-mq-sched.h  |    6 -
 blk-mq.c        |  283 ++++++++++++++++++++++++++++++++++----------------------
 blk-mq.h        |   11 --
 elevator.h      |    3 
 kyber-iosched.c |    5 
 mq-deadline.c   |   11 +-
 9 files changed, 200 insertions(+), 256 deletions(-)

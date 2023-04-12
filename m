Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA077C77B73
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDLFc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLFcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:32:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32246B1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=p/pmkJViUIBzzwuSFun8vsfxTSu0G+cwP2WxFm0SluE=; b=N9FDekcYiU7u0jzqjjc4gkeOrm
        whztnagct3GTM/7lJ7Kdkqi6y8UBKFTi5cwzhzkZGb3g0q7W1/oghKnOuI5jn5dH7y3unGXgWoY0B
        /P6v7T9vOewaHtQGo0sekgMg2qrbOCjWRq1B4t0NDkAUa/i5OszjppW47xMHdyMZKIKi1dwXYVOTk
        JQlgqF8qUHNVlXQDNYDHIlhBdgDjXL4KK8GKrpXLg2ZA8/QuFZXeNFIz1XrjsN/nicUjSxA+u60Qg
        Ie8XGF21ebXQWdvwi44vkh7by6YxQney21YLr09SBEvnUDfnQZ7qCE/sBJv3YSdY+BkQlzTB5bfoN
        cQEFD1Mw==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6B-001rE7-1m;
        Wed, 12 Apr 2023 05:32:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: cleanup request insertation parameters v2
Date:   Wed, 12 Apr 2023 07:32:30 +0200
Message-Id: <20230412053248.601961-1-hch@lst.de>
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

Changes since v1:
 - add back a blk_mq_run_hw_queue in blk_insert_flush that got lost
 - use a __bitwise type for the insert flags
 - sort out header hell a bit
 - various typo fixes

Diffstat:
 b/block/bfq-iosched.c    |   17 +-
 b/block/blk-flush.c      |   15 --
 b/block/blk-mq-cpumap.c  |    1 
 b/block/blk-mq-debugfs.c |    2 
 b/block/blk-mq-pci.c     |    1 
 b/block/blk-mq-sched.c   |  112 ------------------
 b/block/blk-mq-sched.h   |    7 -
 b/block/blk-mq-sysfs.c   |    2 
 b/block/blk-mq-tag.c     |    2 
 b/block/blk-mq-virtio.c  |    1 
 b/block/blk-mq.c         |  285 ++++++++++++++++++++++++++++-------------------
 b/block/blk-mq.h         |   74 ++++++++++--
 b/block/blk-pm.c         |    2 
 b/block/blk-stat.c       |    1 
 b/block/blk-sysfs.c      |    1 
 b/block/elevator.h       |    4 
 b/block/kyber-iosched.c  |    7 -
 b/block/mq-deadline.c    |   13 --
 block/blk-mq-tag.h       |   73 ------------
 19 files changed, 265 insertions(+), 355 deletions(-)

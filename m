Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D687C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMGlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGlI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385ED8690
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AC4IdtNSvLBN0TPaYDGIl20rIzADCLYeBfd4QQZFPpY=; b=sJFLxo0OzHV386u4L7nn9F1qrM
        85xSUi4ZcL4lY5Yr5G5ctURixdBJ3BQ3WlhnfxK2TD5r2zVYwySdAiNf04nQZZt0QACF5N+uLsALN
        RvJ5dmdlK+D5TW4wOCOOCcvtOW4i9FMGUNoSJsWtosh8QMLR2fuZ2GIuqX21DChXncNP9BR6MQ5y2
        Qnd+dxuJRoaiC0vKZCam3LIgLWjWiH0sFLEC0gPIv2JFGc9W4trGRtMOoSznB5n7n5SzszLS+JcoT
        BsmBgjcJn26LfQoc+wANMAQw3u3noCSxVY68AHxNdgU6G5576EnePJ5KYAuMGevvobBnaRBEsiYra
        5SgtHD9Q==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqdf-005BQj-0Y;
        Thu, 13 Apr 2023 06:40:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: cleanup request insertation parameters v3
Date:   Thu, 13 Apr 2023 08:40:37 +0200
Message-Id: <20230413064057.707578-1-hch@lst.de>
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

Changes since v2:
 - rework a comment
 - fix a spelling mistake in a commit message
 - two additional patches to clean up blk_mq_add_to_requeue_list calling
   conventions as well

Changes since v1:
 - add back a blk_mq_run_hw_queue in blk_insert_flush that got lost
 - use a __bitwise type for the insert flags
 - sort out header hell a bit
 - various typo fixes

Diffstat:
 b/block/bfq-iosched.c    |   17 +-
 b/block/blk-flush.c      |   17 +-
 b/block/blk-mq-cpumap.c  |    1 
 b/block/blk-mq-debugfs.c |    2 
 b/block/blk-mq-pci.c     |    1 
 b/block/blk-mq-sched.c   |  112 -----------------
 b/block/blk-mq-sched.h   |    7 -
 b/block/blk-mq-sysfs.c   |    2 
 b/block/blk-mq-tag.c     |    2 
 b/block/blk-mq-virtio.c  |    1 
 b/block/blk-mq.c         |  307 ++++++++++++++++++++++++++++-------------------
 b/block/blk-mq.h         |   77 ++++++++++-
 b/block/blk-pm.c         |    2 
 b/block/blk-stat.c       |    1 
 b/block/blk-sysfs.c      |    1 
 b/block/elevator.h       |    4 
 b/block/kyber-iosched.c  |    7 -
 b/block/mq-deadline.c    |   13 -
 block/blk-mq-tag.h       |   73 -----------
 19 files changed, 280 insertions(+), 367 deletions(-)

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABCCCA479
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGUFQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8B79685
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fc8QV1X1iKaXhzgry1xfjfhVtXpABQdYuFVoYOaVbx4=; b=pFhfdf7r81gX3kJhE0xrX4OrzY
        w9/c5s2ZhpBPwbRTdG9ps7olG14Dsopr/WpZqSeqhSj9uuFjHE8JDj+IEsl/HOneIfjrEinzbr+RT
        ZCBapzx576yynW3E75g9m7Bu9CwWABgJ8K3ErBrzz9BMt7MZTzTkFyzAZh8Eo7pz/XBq2X2ksjbqw
        Oacla+Mk3jRft+NOR6CxqJY6IrDA+6XqOOJxt3y0K3TNTGrYxq1sLQoZS2aAix0ToXo2Q8NCfzGRA
        DzeJE1jWJy3nabn4x6kb527UxBSdk/+MzjNsONzqRZMypU+RPKg3ra6NFJhXjVPGBN6HBZ2yKb9F3
        pWI66W2g==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOY7-00HDOo-Pg; Thu, 21 Jul 2022 05:16:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: ublk fixups
Date:   Thu, 21 Jul 2022 07:16:24 +0200
Message-Id: <20220721051632.1676890-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming, hi Jens,

this series has a bunch of fixes and cleanups of ublk.  The most important
one is the last one, which moves ublk over to a proper gendisk life cycle.

This series passes the ubdsrv tests.

Diffstat:
 MAINTAINERS                   |    7 
 drivers/block/ublk_drv.c      |  530 ++++++++++++++++++------------------------
 include/uapi/linux/ublk_cmd.h |    1 
 3 files changed, 241 insertions(+), 297 deletions(-)

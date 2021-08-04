Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E7C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DE560F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhHDJm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhHDJmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD0C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1qVaQySvDOJeK5ZL0MyITtotrwjkuDRpzKgiar8AD/I=; b=KYOpCffu8+dNy8o/q1HNbCsGzt
        3Zj63wq8HSPiW6vI158vgUPeOh/69KIJpqQR2YGoue3ByjXC9d1VQlAGPaA2f+fyaWu5HUxRn7OJE
        P7gM/mcHQz1faTEznnrIyaxOc2tV6UjT7bm1oawl9v97xU6A2tQ8OmM3q2LnaNCqXY+CfHSJpOQCs
        EiJavyNcbu5JCq1m5q7PI0CDGXBwAG8E2YX8SUUSCftKq4QKonLb8DdjQVNStV5NCHwRgaZbn79AH
        A81ZwWiIFubalasqL5BXRCE9v5CAx4cWLhZGR5VyKSkBTQgyx+uYo7+gZ9VLkHVRLFi1Ssgi/+zhx
        9x98cJJw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDPI-005dwa-Kn; Wed, 04 Aug 2021 09:41:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: use regular gendisk registration in device mapper v2
Date:   Wed,  4 Aug 2021 11:41:39 +0200
Message-Id: <20210804094147.459763-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

The device mapper code currently has a somewhat odd gendisk registration
scheme where it calls add_disk early, but uses a special flag to skip the
"queue registration", which is a major part of add_disk.  This series
improves the block layer holder tracking to work on an entirely
unregistered disk and thus allows device mapper to use the normal scheme
of calling add_disk when it is ready to accept I/O.

Note that this leads to a user visible change - the sysfs attributes on
the disk and the dm directory hanging off it are not only visible once
the initial table is loaded.  This did not make a different to my testing
using dmsetup and the lvm2 tools.

Changes since v1:
 - rebased on the lastes for-5.15/block tree
 - improve various commit messages, including commit references

Diffstat:
 block/Kconfig             |    4 +
 block/Makefile            |    1 
 block/elevator.c          |    1 
 block/genhd.c             |   42 +++++------
 block/holder.c            |  167 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/Kconfig        |    2 
 drivers/md/bcache/Kconfig |    1 
 drivers/md/dm-ioctl.c     |    4 -
 drivers/md/dm-rq.c        |    1 
 drivers/md/dm.c           |   32 +++-----
 fs/block_dev.c            |  145 ---------------------------------------
 include/linux/blk_types.h |    3 
 include/linux/genhd.h     |   19 ++---
 13 files changed, 219 insertions(+), 203 deletions(-)

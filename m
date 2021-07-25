Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F35C4338F
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B8B60F35
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhGYFOz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092BC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f9IQxdqjylE1ARpLgWiOlgVqO3Su0p30DC/bztOa4O8=; b=Sz+BSPkkftYhytROMPktnFnlzz
        CelGpW1v4NO/mao/CjuisnbpiEenZetGlvKlytJKsEnVErVXNVryIJKvOyyHuaiZpMtc9j46XOe23
        6DwKkAxUfPtbp+5qJ9g/ajhMM4jTHf6qpZhev92mNkAtGeN1T4oJNWF1VVx39Ah+PKnlF3ghNyqPs
        aI9lvPHchsOwhlm+zku6q4hbunbXm9OV3rmHeuNx9j+GU+CGBgk+2yzlkiloPLtkUTlMXmEudoF3v
        GWiZqSTRSCqDlaNLmhxlFXM9ZrCI4Ff6nKNl8M+4pLf2AWeXrDQZBSUVJMtlf7LG38PdxRcrwdiOR
        aZ8O3KEg==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X6K-00Cpf1-20; Sun, 25 Jul 2021 05:55:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: use regular gendisk registration in device mapper
Date:   Sun, 25 Jul 2021 07:54:50 +0200
Message-Id: <20210725055458.29008-1-hch@lst.de>
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

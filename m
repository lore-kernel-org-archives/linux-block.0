Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90ECCA485
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiFHGob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbiFHGeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 02:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C88FC809
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=u8DDQqdh5p2hv1CeGGmfIsI+O2JkdNq/ozBJEnlu1ac=; b=qcc0XU6iwU4WUmN92CyGqUMgNi
        qdb00yM/oQcCb4rtEU5KxhizeRgl7w/+O+W01AvSAANPgJnEUGl31IfetL++huv/XrMPTQNKW29sK
        Vq0IdA2+yrqumcffkRUGqCnROL+TaAy/cxkGN0UF3dlWjz9VcC0UBjxhBYbqQDPwYkb7oAIi6mKK9
        0RyHJ7t1/Jb6WzLSFqdFZt5+9Y4Jt9+kOiyrQ9EwTFp7zf1b+wF3oa0aBw0xZmxUdjVp6/UC3cWVy
        hU9hDI6cK1Mm+gq1wKtif0QCz1AZsSwJoZVMl/IQKRJ/pkY5YkrRwCeurVaBo/e5kQ/CncxR9S7G0
        dt0cPG1A==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nypGe-00BJSr-Bm; Wed, 08 Jun 2022 06:34:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: fix and cleanup device mapper bioset initialization
Date:   Wed,  8 Jun 2022 08:34:05 +0200
Message-Id: <20220608063409.1280968-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Mike,

the first patch fixes the device mapper bioset to restore the previous
behavior of preallocating biosets instead of allocating them at bind
time, and to actually allocate pools for the integrity data.  The
others are cleanups on top of that.

Diffstat:
 block/bio.c           |   20 -------
 drivers/md/dm-core.h  |   14 ++++-
 drivers/md/dm-rq.c    |    3 -
 drivers/md/dm-table.c |   66 ++++++++++++++----------
 drivers/md/dm.c       |  136 +++++++++-----------------------------------------
 drivers/md/dm.h       |    5 -
 include/linux/bio.h   |    1 
 7 files changed, 78 insertions(+), 167 deletions(-)

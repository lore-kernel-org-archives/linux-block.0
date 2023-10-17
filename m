Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C41CDB482
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJQSsf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQSsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 14:48:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE890;
        Tue, 17 Oct 2023 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QmBB7UCJvM+8yHBnQ7IH5164AJuOIh1lyxiriNf+nz8=; b=2qn8C3xxVDrnY0ucy44K3DH+jf
        48imZX/ufyAIbXT7dgrG0eQyCM7FTXmhDA+lDs20K2qQrvJhKsdO3qBcBJTwOp9h41MXnNBxm/i95
        tXHgJduOPy4pxm+n/WegsDH0R6fzsabcjMx1nZHC0iFHuZZjHn+r3sPX7AS869zQYA0Qk20tYfYoC
        ip0xT3Ocn3+kZMbM5he0ZMNsgrwMXJmUmIh/gWWHOdzq7kmB3HuNCcYzhvT8KznuK2VOi0ZJktwis
        nEaJ5VvdFVL7oiLTc33SE1q5Aj+k3dsC0f5KLNcJLT/2IEYvuvQ+Vru1zgPNV6F2k3BNnJDqxqbLE
        SYLOfOUg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsp7D-00D0K4-0x;
        Tue, 17 Oct 2023 18:48:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: don't take s_umount under open_mutex
Date:   Tue, 17 Oct 2023 20:48:18 +0200
Message-Id: <20231017184823.1383356-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

Christian has been pestering Jan and me a bit about finally fixing
all the pre-existing mostly theoretical cases of s_umount taken under
open_mutex.  This series, which is mostly from him with some help from
me should get us to that goal by replacing bdev_mark_dead calls that
can't ever reach a file system holder to call into with simple bdev
page invalidation.

Expect future version to come from Christian again, I'm just helping
out while he is trouble shooting his mail setup.

Diffstat:
 block/disk-events.c     |   18 +++++++-----------
 block/genhd.c           |    7 +++++++
 block/partitions/core.c |   43 +++++++++++++++++++++++++++++--------------
 drivers/block/ataflop.c |    4 +++-
 drivers/block/floppy.c  |    4 +++-
 fs/super.c              |    2 ++
 6 files changed, 51 insertions(+), 27 deletions(-)

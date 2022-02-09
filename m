Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19485C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiBIIVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiBIIVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:21:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617FC05CB86;
        Wed,  9 Feb 2022 00:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7lXlvtJia9QHDC+a5JJcKfyPxGmS91rbuQ/+DSnKG8Q=; b=Dcf2viGCk8tLKDlqdp0JE2ecAX
        kuVbF2Rz3tO4iy37+IOQQDOARovx86y0xS4OLur4dSTQy35tgzu/maQ3oerz34bAUICL7b8WySTTl
        TGZtOmo8i9T0oLB2pmsi8YCpzjcOoN8w0xTepnkJF78gggPilmzp0YcR2iuChSaaOEwDkD/pEic2L
        Nkquw7QCWmbxGLRR3XS2Tefv/hoQAiib7q1VFRwmWt7HDj0V7fBJ8qnvWoKeyzC1VAVLEMlpvZDLC
        wAhW9U/ZCWotCiaXLQWZmmbymm4WfkRsHhmXaUrQoiTpVoQYboruaO3OvrZuTa3KMMexy/8Bt3DB2
        P+8fFR6g==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiE8-00GbA2-0s; Wed, 09 Feb 2022 08:21:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: add a ->free_disk block_device_operation v2
Date:   Wed,  9 Feb 2022 09:21:15 +0100
Message-Id: <20220209082121.2628452-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series adds a ->free_disk method to struct block_device_operation so that
drivers can defer freeing their disk private data until the gendisk goes away
and don't need to play games with the validity of ->private_data.

This also converts three simple drivers over as example, but eventually I
imagine that all drivers with private data will use it.

Changes since v1:
 - fix a tag_set use after free in virtio_blk

Diffstat:
 block/genhd.c                       |    4 +
 drivers/block/virtio_blk.c          |   74 ++++++++++--------------------------
 drivers/memstick/core/ms_block.c    |   64 +++++++------------------------
 drivers/memstick/core/ms_block.h    |    1 
 drivers/memstick/core/mspro_block.c |   57 ++++-----------------------
 include/linux/blkdev.h              |    1 
 6 files changed, 51 insertions(+), 150 deletions(-)

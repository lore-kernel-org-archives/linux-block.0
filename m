Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiBBP5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiBBP5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 10:57:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C346C061714;
        Wed,  2 Feb 2022 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qaGJg5sliE0aHp6OdivVPKol5Er2DaJYLyP4md4riM8=; b=XTfuh88jFFMwVg5coKd1C5B9FO
        VIsVEb82M2wONasTApUEytc6qMynbnCDMugSVyxbWFWm/Bs+CD3VK2h06dsj1kkySWJWkG8AiMt2A
        6g358tKGvWUJ1S0Bh0oRXQCh5YvYg1SNdpZnNSnMDzytR3LTfukckfehb8og7NvCYNuaBzN2UdY09
        gz+U5DGF8ynrV/gG5buf67TLtJhmclJMQTTQM3Fqnib4EytDcnG+0KbFiiwi+FDdGb8Q6bFfIyiDS
        +8y84WpvyTuTw5kwFfXSFbpdWXUjRNnhkNYTxrrZ3TAJWjg7awoiJ+MoMCK4glSIBSuNuXPDF8uUI
        EKLpRbuw==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI0E-00G6W8-1U; Wed, 02 Feb 2022 15:57:02 +0000
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
Subject: add a ->free_disk block_device_operation
Date:   Wed,  2 Feb 2022 16:56:54 +0100
Message-Id: <20220202155659.107895-1-hch@lst.de>
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

Diffstat:
 block/genhd.c                       |    4 ++
 drivers/block/virtio_blk.c          |   64 ++++++------------------------------
 drivers/memstick/core/ms_block.c    |   64 ++++++++----------------------------
 drivers/memstick/core/ms_block.h    |    1 
 drivers/memstick/core/mspro_block.c |   57 +++++---------------------------
 include/linux/blkdev.h              |    1 
 6 files changed, 42 insertions(+), 149 deletions(-)

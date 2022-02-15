Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC43C433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiBOJpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:45:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiBOJph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:45:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD6E61F8;
        Tue, 15 Feb 2022 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=k2zUIoihKeX/PzTYAq+E6BX9omLlFxe2qXDX5akB7yw=; b=vDOP69iXQBS1etC9BNUgTKGNBG
        /khYC8I3DdAsyvTAJQDnYeX8sXRlOuPZJeOAg/ldjkhU4zwEDMdN62+p/QTA52FxDk2wuxx6tIgda
        CA2897HUhMe+Fy3qhaK9jPNazwCJfvlB4KDDsrn6/vmV3IkOSRW8BeEDzQxJnzBfvu9zPaEC+EIo9
        4K1EQz2VVPqr9rpyADPoup8dCtU3DiwZtLdfFU9fDcfvK2XJUDBpa3uwIT13Bv91g8aX+FEprUjgN
        EjidiXCviAuUxOEzRtRsF+02dAO8y/DKM2ys/hmDSXPyv89cjHn42WPRbN+QMMOUEKuwSSMjCsKHQ
        /4k/L6VA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuOb-0025zX-8L; Tue, 15 Feb 2022 09:45:17 +0000
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
Subject: add a ->free_disk block_device_operation v3
Date:   Tue, 15 Feb 2022 10:45:09 +0100
Message-Id: <20220215094514.3828912-1-hch@lst.de>
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

Changes since v2:
 - only call ->free_disk after add_disk has returned to simplify probe error
   handling
Changes since v1:
 - fix a tag_set use after free in virtio_blk

Diffstat:
 block/genhd.c                       |    5 ++
 drivers/block/virtio_blk.c          |   66 +++++++-----------------------------
 drivers/memstick/core/ms_block.c    |   64 ++++++++--------------------------
 drivers/memstick/core/ms_block.h    |    1 
 drivers/memstick/core/mspro_block.c |   57 +++++--------------------------
 include/linux/blkdev.h              |    2 +
 6 files changed, 46 insertions(+), 149 deletions(-)

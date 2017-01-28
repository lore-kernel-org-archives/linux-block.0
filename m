Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdA1JAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 04:00:45 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: make SCSI passthrough support optional
Date: Sat, 28 Jan 2017 09:32:48 +0100
Message-Id: <1485592373-29837-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this series builds on my previous changes in Jens' for-4.11/rq-refactor
branch that split out the BLOCK_PC fields from struct request into a new
struct scsi_request, and makes support for struct scsi_request and the
SCSI passthrough ioctls optional.  It is now only enabled by drivers that
need it.

In addition I've made SCSI passthrough support in the virtio_blk driver an
optional compile time feature, as it's not actually needed for most
common setups.

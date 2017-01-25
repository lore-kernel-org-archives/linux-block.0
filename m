Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdAYRZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 12:25:36 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: split scsi passthrough fields out of struct request V2
Date: Wed, 25 Jan 2017 18:25:08 +0100
Message-Id: <1485365126-23210-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this series splits the support for SCSI passthrough commands from the
main struct request used all over the block layer into a separate
scsi_request structure that drivers that want to support SCSI passthough
need to embedded as the first thing into their request-private data,
similar to how we handle NVMe passthrough commands.

To support this I've added support for that the private data after
request structure to the legacy request path instead, so that it can
be treated the same way as the blk-mq path.  Compare to the current
scsi_cmnd allocator that actually is a major simplification.

Changes since V1:
 - fix handling of a NULL sense pointer in __scsi_execute
 - clean up handling of the flush flags in the block layer and MD
 - additional small cleanup in dm-rq

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdAML3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 06:29:22 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Dexuan Cui <decui@microsoft.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: fix data transfer size caculation for special payload requests
Date: Fri, 13 Jan 2017 12:29:09 +0100
Message-Id: <1484306953-3194-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

the first two fixes fix a regression in 4.10-rc1 where the data transfer
size for discard commands wasn't set properly, leading to hangs with
Hyper-V VMs.  The use the new data transfer size helper added in patch 1
more widely.

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXNor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Sep 2018 09:44:47 -0400
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: clean up physical merging helpers V2
Date: Mon, 24 Sep 2018 09:43:45 +0200
Message-Id: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

this series moves various helpers related to merging based on physical
addresses from the public headers into block/, cleans up the code a bit
and removes not nessecary includes from the block headers.

Change since V1:
 - dropped the Xen related changed which are moved into a new series
   to be sent after this one

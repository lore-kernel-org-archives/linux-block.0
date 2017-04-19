Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757645AbdDSAcP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 20:32:15 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] mtip32xx: assign driver tag
Date: Wed, 19 Apr 2017 08:31:41 +0800
Message-Id: <20170419003142.9581-3-ming.lei@redhat.com>
In-Reply-To: <20170419003142.9581-1-ming.lei@redhat.com>
References: <20170419003142.9581-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Assign driver tag for internal command, so that we
can avoid kernel oops[1] trigered in blk_mq_tag_to_rq().

[1] https://bugzilla.kernel.org/show_bug.cgi?id=195429

Reported-by: Jozef Mikovic <jmikovic@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f96ab717534c..8cfe5a6edb05 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -180,6 +180,8 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 	if (IS_ERR(rq))
 		return NULL;
 
+	WARN_ON(!blk_mq_get_driver_tag(rq, NULL, true));
+
 	return blk_mq_rq_to_pdu(rq);
 }
 
-- 
2.9.3

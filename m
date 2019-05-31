Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3CC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6118225F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaC2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A6F583F44;
        Fri, 31 May 2019 02:28:50 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99B5A88B1E;
        Fri, 31 May 2019 02:28:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/9] scsi: introduce scsi_cmnd_hctx_index()
Date:   Fri, 31 May 2019 10:27:57 +0800
Message-Id: <20190531022801.10003-6-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 31 May 2019 02:28:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For drivers which enable .host_tagset, introduce scsi_cmnd_hctx_index
to retrieve current reply queue index. If valid scsi command is provided,
blk-mq's hw queue's index is returned, otherwise return the queue
mapped from current CPU.

Prepare for converting device's privete reply queue to blk-mq hw queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/scsi/scsi_cmnd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 76ed5e4acd38..23f611a6a9f2 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/scatterlist.h>
+#include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_request.h>
 
@@ -332,4 +333,18 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 	return xfer_len;
 }
 
+/* only for drivers which enable .host_tagset */
+static inline unsigned scsi_cmnd_hctx_index(struct Scsi_Host *sh,
+		struct scsi_cmnd *scmd)
+{
+	if (unlikely(!scmd || !scmd->request || !scmd->request->mq_hctx)) {
+		struct blk_mq_queue_map *qmap =
+			&sh->tag_set.map[HCTX_TYPE_DEFAULT];
+
+		return qmap->mq_map[raw_smp_processor_id()];
+	}
+
+	return scmd->request->mq_hctx->queue_num;
+}
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.20.1


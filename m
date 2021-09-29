Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CFEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3315B613D1
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhI2ESp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231866AbhI2ESd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 00:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632889011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6EPpWJMM1oEudtfCAFWs0O0JIxg1Z+CB9nptxSUO/I=;
        b=XAcKm1AilLQBToRMtsAm7bXFYDYEDdToQVlg+zCR/QOOS3ugTUrZ7/GgbBmjpPkILPCt0q
        znoiLfv8HbvvhiA6/a4o+RLy9xkOKCdOLSJjHhoRYC95dMTIEY8Xxc63Ze4fsiGCgOx3WN
        DAYB01WKpTazACPh9ocVxU07qASlV64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-lfUDn5s-NniTKp1cX7OPqw-1; Wed, 29 Sep 2021 00:16:46 -0400
X-MC-Unique: lfUDn5s-NniTKp1cX7OPqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFC9D802947;
        Wed, 29 Sep 2021 04:16:44 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD32619C79;
        Wed, 29 Sep 2021 04:16:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] nvme: add APIs for stopping/starting admin queue
Date:   Wed, 29 Sep 2021 12:15:55 +0800
Message-Id: <20210929041559.701102-2-ming.lei@redhat.com>
In-Reply-To: <20210929041559.701102-1-ming.lei@redhat.com>
References: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two APIs for stopping and starting admin queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fa75433c036..c675eef70a63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4563,6 +4563,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_quiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
+
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
+
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..47877a5f1515 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -659,6 +659,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
-- 
2.31.1


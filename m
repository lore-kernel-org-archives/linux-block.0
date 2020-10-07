Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5535C4727F
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 01:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A443F2078E
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 01:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+goCCUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJGBFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 21:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727203AbgJGBFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Oct 2020 21:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcTNro04spti2p/S2A1ZPa+JleaPimENQhhyc8a5ofk=;
        b=e+goCCUOn+YSZ5aTCeuyBgZ0TtS7+ri/k4UQUX8TFdP0XAebVQYJ0Mm0GyOkp9xtjqiD7E
        YlYegAOU+WOZxsvXWtK4x3/Xa5X0gw2vDT4svPag28EXoj9Kmbtn+TEMJhS9D7RozLiXxI
        qz4nE+/8VjOGf2/5T+St0zIoHwNERYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Vq-FRL6AMsmNxFyrm5C8SQ-1; Tue, 06 Oct 2020 21:05:07 -0400
X-MC-Unique: Vq-FRL6AMsmNxFyrm5C8SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383F410BBEC5;
        Wed,  7 Oct 2020 01:05:05 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75EC45C1BD;
        Wed,  7 Oct 2020 01:05:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 4/4] nvme: use blk_mq_[un]quiesce_tagset
Date:   Wed,  7 Oct 2020 09:04:43 +0800
Message-Id: <20201007010443.71456-5-ming.lei@redhat.com>
In-Reply-To: <20201007010443.71456-1-ming.lei@redhat.com>
References: <20201007010443.71456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

All controller namespaces share the same tagset, so we
can use this interface which does the optimal operation
for parallel quiesce based on the tagset type (e.g.
blocking tagsets and non-blocking tagsets).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>

Add code to unquiesce ctrl->connect_q in nvme_stop_queues(), meantime
avoid to call blk_mq_quiesce_tagset()/blk_mq_unquiesce_tagset() if
this tagset isn't initialized.
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c190c56bf702..2dd2d6ff8e7a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4623,23 +4623,22 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	if (list_empty_careful(&ctrl->namespaces))
+		return;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_quiesce_tagset(ctrl->tagset);
+
+	if (ctrl->connect_q)
+		blk_mq_unquiesce_queue(ctrl->connect_q);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	if (list_empty_careful(&ctrl->namespaces))
+		return;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
2.25.2


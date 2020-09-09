Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA15C10DAA
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A78521D79
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsfvoJB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIKmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:42:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44245 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbgIIKmA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 06:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599648114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbG1GA7EmxIM6OFuKoLm0uEGcjT5hmviO9SzGOkDFtQ=;
        b=EsfvoJB+ci5kMkWzhKf8e97T1aKHMPdb1Ch4X3G8KAZtHpr+z2q3hmzQsr4WXhg/sbCNu7
        RsmGSfXhBuNXQ1QztEnaXzEb9tsEwLTbCACv+fHgh2h4rgVTHfh+ynDujhwR58LenuvTJf
        PIcKH877slTxveFV64RrzvUdR1ZYBv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-DY68L9VHOBC1ZB7CQ9sVhw-1; Wed, 09 Sep 2020 06:41:50 -0400
X-MC-Unique: DY68L9VHOBC1ZB7CQ9sVhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648A15200;
        Wed,  9 Sep 2020 10:41:48 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1EB427BC8;
        Wed,  9 Sep 2020 10:41:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/4] nvme: use blk_mq_[un]quiesce_tagset
Date:   Wed,  9 Sep 2020 18:41:16 +0800
Message-Id: <20200909104116.1674592-5-ming.lei@redhat.com>
In-Reply-To: <20200909104116.1674592-1-ming.lei@redhat.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

All controller namespaces share the same tagset, so we
can use this interface which does the optimal operation
for parallel quiesce based on the tagset type (e.g.
blocking tagsets and non-blocking tagsets).

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
index ea1fa41fbba8..a6af8978a3ba 100644
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


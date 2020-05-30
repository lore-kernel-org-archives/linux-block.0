Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EBC433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B320715
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL7mgqaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgE3Nwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 09:52:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbgE3Nwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590846766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wxFB+oeJxY2LikvP01WxSw60v3LNNOG3VBVBlKjXSU=;
        b=FL7mgqaHkatdgGct90QWq9Ou0Oox8gG5LX/1WwE0MDPmdKSX0gsNn4mTsPrHhsZWNUwpdC
        1M33bRULxhmzx+63GWw+WUxhPXY4FbOrjgxRRx1IQUe1s53kJ7aF7B+IiJOffZXby1cH2t
        lYQNiXeTX05obNPb16wQNVkGXDHVuXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-HVVnf0XjPXiN6vtyHw4RfA-1; Sat, 30 May 2020 09:52:44 -0400
X-MC-Unique: HVVnf0XjPXiN6vtyHw4RfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2B38735C0;
        Sat, 30 May 2020 13:52:42 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 747252DE81;
        Sat, 30 May 2020 13:52:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH V2 2/3] nvme: add nvme_frozen
Date:   Sat, 30 May 2020 21:52:20 +0800
Message-Id: <20200530135221.1152749-3-ming.lei@redhat.com>
In-Reply-To: <20200530135221.1152749-1-ming.lei@redhat.com>
References: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one new API of nvme_frozen(), reset handler may use this helper to
query if all ns queues have been frozen completely. Meantime, the reset
handler can check if there is new hardware failure happened. If yes, reset
handler can break from current handling, and schedule a fresh new recovery,
so deadlock or deleting controller & fail all IOs can be avoided.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f5a9ba..469010607383 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4243,6 +4243,20 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
+bool nvme_frozen(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+	int ret = 0;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		ret += !blk_mq_queue_frozen(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+
+	return ret == 0;
+}
+EXPORT_SYMBOL_GPL(nvme_frozen);
+
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e04a36296d9..459e5952ff5f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -508,6 +508,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+bool nvme_frozen(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-- 
2.25.2


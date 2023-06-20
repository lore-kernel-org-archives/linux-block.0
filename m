Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16724EB64DB
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 01:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFTBfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFTBfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 21:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40F1B0
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687224873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikczhd6nnU0AFQRVGRfBcA4iWBBki9GNxTX/jhJO73E=;
        b=AWWTC9B7JfRYxNSAYVaAkK9ist8YBrqSXMu8UUAALaAFL+17zlXsWY05G9xsj4Ay//o3Tl
        w8tS6YgpNbIjTr6w0oTMao/SU81ZpUwlkuYmr66f0RYggu6m9bZjgjzO+H+Bm/awr66Ofv
        HS5f7E9dE7kOnuRAy2ONeE1APMzxYU0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-B72X3qVrOi-g8Skv5OvAiQ-1; Mon, 19 Jun 2023 21:34:30 -0400
X-MC-Unique: B72X3qVrOi-g8Skv5OvAiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E56CE1C08DA3;
        Tue, 20 Jun 2023 01:34:29 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 219DB492C1B;
        Tue, 20 Jun 2023 01:34:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] nvme: unfreeze queues before removing namespaces
Date:   Tue, 20 Jun 2023 09:33:48 +0800
Message-Id: <20230620013349.906601-4-ming.lei@redhat.com>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If removal is from breaking error recovery, queues may be frozen, and
there may be pending IOs in bio_queue_enter(), and the following
del_gendisk() may wait for these IOs, especially from writeback.

Similar IO hang exists in flushing scan work too if there are pending
IO in scan work context.

Fix the kind of issue by unfreezing queues before removing namespace,
so that all pending IOs can be handled.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b3f12368196..7d8ff58660ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4002,6 +4002,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/* unfreeze queues which may be frozen from error recovery */
+	nvme_unfreeze_force(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


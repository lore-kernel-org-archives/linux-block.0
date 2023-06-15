Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD729EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbjFOOeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFOOeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 10:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22605E52
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686839612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJGrZXTwtOsU4kZNzkQsFkVjDkz2Qxmf1lywo+B8LeY=;
        b=KY+GzHs5oeAIhb5LmPPGFFwuHCiX7xI4nKVeipzI4yJ4iaVWMRwsz3ncHSTNhNdMMduwOE
        4duGl0jQnGn5/Dv9xyiOwYdtwScYMOPOU9AhKglz2FrfSklBHYMHMT8VrMBqRhG2UPIwbr
        s5pe1Ckq9bNAe+VlmkH0rFYTEM708Qs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-_VlH3dn7Pjmdn2mPw3qQYQ-1; Thu, 15 Jun 2023 10:33:29 -0400
X-MC-Unique: _VlH3dn7Pjmdn2mPw3qQYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD039858287;
        Thu, 15 Jun 2023 14:32:54 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C431140E952;
        Thu, 15 Jun 2023 14:32:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] nvme: unfreeze queues before removing namespaces
Date:   Thu, 15 Jun 2023 22:32:35 +0800
Message-Id: <20230615143236.297456-4-ming.lei@redhat.com>
In-Reply-To: <20230615143236.297456-1-ming.lei@redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
index 96785913845b..ec7bd33b7e5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4645,6 +4645,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/* unfreeze queues which may be frozen from error recovery */
+	nvme_unfreeze_force(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22FEB64D9
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 01:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFTBfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFTBfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 21:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF61AC
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687224877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nn7UL2W4aoSkEptI3kxMwdGhVnchUthDYAf2sSLtDo=;
        b=LbzsmJZlP67SIk0Dd+xczb3Ds86PJ6xrCFOEhsnb1XggcktA5bZW3spWYpN+1/VdKRIG97
        An5PbGVrp9F+lVpncOX8lDx1ARJC+x/f5VyyIqXvm/0dbRj/o8WjQr3B/xONsx4MKnKlaT
        T0J/sbqlGJe8Dh/Ll579/paCjrrz3PM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-jWmzT-B2Ni23TCAMt4rAxg-1; Mon, 19 Jun 2023 21:34:33 -0400
X-MC-Unique: jWmzT-B2Ni23TCAMt4rAxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EF78811E78;
        Tue, 20 Jun 2023 01:34:33 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4201940C20F5;
        Tue, 20 Jun 2023 01:34:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/4] nvme: unquiesce io queues when removing namespaces
Date:   Tue, 20 Jun 2023 09:33:49 +0800
Message-Id: <20230620013349.906601-5-ming.lei@redhat.com>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Error recovery can be interrupted by controller removal, then the
controller is left as quiesced, and IO hang can be caused.

Fix the issue by unquiescing controller unconditionally when removing
namespaces.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7d8ff58660ee..de910badcdfc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4005,6 +4005,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* unfreeze queues which may be frozen from error recovery */
 	nvme_unfreeze_force(ctrl);
 
+	/*
+	 * Unquiesce io queues so any pending IO won't hang, especially
+	 * those submitted from scan work
+	 */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
@@ -4014,10 +4020,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_unquiesce_io_queues(ctrl);
-	}
 
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
-- 
2.40.1


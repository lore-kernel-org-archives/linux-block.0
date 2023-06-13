Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3026C7EE2E
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 01:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjFMBAC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMBAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 21:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D210E4
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686617951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gStSfx1ogbTdgzJdx2VuBuo97qQ8rhlYaSRSYb3L4aY=;
        b=dWfPephnppiKFteYUCBgVMhE/RPZ9+9FuFEVPCujvbi4KnPTqjNS9vNksjTXCbJ9CVEA30
        LsWfYV2mthhZLPCrh2lHHZ9P9+gI5JDRVIjs+Hn8LIFEw9ODtYtqBXSq+s2Tahj0Guw9js
        WsBmqykq27Zm0mkF6P4odOKvhifHixA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-JvDnC9Z6PrCkzsLufI4JuA-1; Mon, 12 Jun 2023 20:59:08 -0400
X-MC-Unique: JvDnC9Z6PrCkzsLufI4JuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2F7F8007D9;
        Tue, 13 Jun 2023 00:59:07 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB7340D1B60;
        Tue, 13 Jun 2023 00:59:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] nvme: core: unquiesce io queues when removing namespaces
Date:   Tue, 13 Jun 2023 08:58:46 +0800
Message-Id: <20230613005847.1762378-2-ming.lei@redhat.com>
In-Reply-To: <20230613005847.1762378-1-ming.lei@redhat.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When error recovery is interrupted by controller removal, the controller
is left as quiesced, then IO hang can be caused.

Fix the issue by unquiescing controller unconditionally when removing
namespaces.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..4ef5eaecaa75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4692,6 +4692,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/*
+	 * Unquiesce io queues so any pending IO won't hang, especially
+	 * those submitted from scan work
+	 */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD33C433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C2660EE2
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJIDu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 23:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232369AbhJIDu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 23:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633751311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2LFQq71dqWB0MJ8/20HA9VFLVcxA/IdZ6Nqm+rYqvg=;
        b=UsSkYDosMAK8OMn5vN8+W7JvPJeS7EnrjZn9vOad1HBmMgmyauaprtFWA9hm95jzsrGMjR
        wmxgaUS0/hw3vHl/LcT1LBTch7UXrP/ceD67FxJyeMzAvZldJlUS/wcwC3KcFftfjTGZWk
        NyM0HaPeA/YgiEOQf5IHyIL0GMzf9XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-7NVxqno7OwOLoUegGtotBA-1; Fri, 08 Oct 2021 23:48:21 -0400
X-MC-Unique: 7NVxqno7OwOLoUegGtotBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80183824FA6;
        Sat,  9 Oct 2021 03:48:19 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2DD5FC22;
        Sat,  9 Oct 2021 03:48:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is reallocated
Date:   Sat,  9 Oct 2021 11:47:12 +0800
Message-Id: <20211009034713.1489183-6-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nvme-loop's admin queue may be freed and reallocated, and we have to
reset the flag of NVME_CTRL_ADMIN_Q_STOPPED so that the flag can match
with the quiesce state of the admin queue.

nvme-loop is the only driver to reallocate request queue, and not see
such usage in other nvme drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 440e1544033b..eb1094254c82 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -384,6 +384,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		error = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_cleanup_fabrics_q;
 	}
+	/* reset stopped state for the fresh admin queue */
+	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-- 
2.31.1


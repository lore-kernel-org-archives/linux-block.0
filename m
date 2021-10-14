Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7490C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9026360E96
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJNIUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJNIUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 04:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634199495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2LFQq71dqWB0MJ8/20HA9VFLVcxA/IdZ6Nqm+rYqvg=;
        b=BFE2xS0Fb1OZa3ViHRE+rJcSvGUOzrmggFhNivcJ+qilJ1DH3W3DvSUOyDcmEwwP6eeWtu
        bb8XVgJbJLBPcgzrvlf8Kl3HvBv4/0r4JrsduF7mN/wyw2dZKAAUwrpT0c3Oivx9yAoCFl
        RB46jdA5+b+VdwPhma8Fn4tIGUCMMyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-fn7xKnZ2PDinhBM-1ZhhJA-1; Thu, 14 Oct 2021 04:18:11 -0400
X-MC-Unique: fn7xKnZ2PDinhBM-1ZhhJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E884101F002;
        Thu, 14 Oct 2021 08:18:10 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 114305DA60;
        Thu, 14 Oct 2021 08:18:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is reallocated
Date:   Thu, 14 Oct 2021 16:17:09 +0800
Message-Id: <20211014081710.1871747-6-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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


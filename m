Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C9EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjFTNSF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFTNR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229951BD6
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687266991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ogIibVOnLt0486zOB1sPzcKIarKm0lmpYQoT+khdF8=;
        b=jHe2ykuMs48G6ymcYYJdkyqjgSkQVCdTD4Aufz9IwKdmIYAYBRSJLzs7xvC3etBafcJocp
        saV/LMyCeCepA4byaW+VZgA+8ctkj9qQqpA9nT/hbJ1WKV3jxM9QP19t9tri4uZRwAdd8Z
        gbEy8E5zCU0ChHeZj4+XQQTD3OKC3WI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-GCAQWWmxOiKw8ZGkanUDUg-1; Tue, 20 Jun 2023 09:16:28 -0400
X-MC-Unique: GCAQWWmxOiKw8ZGkanUDUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F11EB88D0F7;
        Tue, 20 Jun 2023 13:15:37 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9142A1402C06;
        Tue, 20 Jun 2023 13:15:12 +0000 (UTC)
Date:   Tue, 20 Jun 2023 21:15:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
 <20230616054800.GA28499@lst.de>
 <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
 <20230620054141.GA12626@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620054141.GA12626@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 07:41:41AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 16, 2023 at 03:20:38PM +0800, Ming Lei wrote:
> > > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > > will be failed.
> > > 
> > > del_gendisk also sets GD_DEAD early on.
> > 
> > No.
> > 
> > The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> > bio_queue_enter().
> 
> IFF we know we can't do I/O by the time del_gendisk is called, we
> need to call mark_disk_dead first and not paper over the problem.

In theory, device removal can happen any time, when it isn't clear
if the controller is recovered well at that time, that is why this
API is added for avoiding to fail IO unnecessarily.

However maybe it is just fine to mark controller as dead in case that
removal breaks current error recovery given current nvme driver error
handling isn't very fine-grained control, so how about something like
the following:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3d72fc677f7..120d98f348de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -558,6 +558,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
        }

        if (changed) {
+               ctrl->old_state = ctrl->state;
                ctrl->state = new_state;
                wake_up_all(&ctrl->state_wq);
        }
@@ -4654,7 +4655,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         * removing the namespaces' disks; fail all the queues now to avoid
         * potentially having to clean up the failed sync later.
         */
-       if (ctrl->state == NVME_CTRL_DEAD) {
+       if (ctrl->state == NVME_CTRL_DEAD || ctrl->old_state != NVME_CTRL_LIVE) {
                nvme_mark_namespaces_dead(ctrl);
                nvme_unquiesce_io_queues(ctrl);
        }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 953e59f56139..7da53cc76f11 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,8 +246,9 @@ enum nvme_ctrl_flags {

 struct nvme_ctrl {
        bool comp_seen;
-       enum nvme_ctrl_state state;
        bool identified;
+       enum nvme_ctrl_state old_state;
+       enum nvme_ctrl_state state;
        spinlock_t lock;
        struct mutex scan_lock;
        const struct nvme_ctrl_ops *ops;

> 
> An API that force unfreezes is just broken and will leaves us with
> freezecount mismatches.

The freezecount mismatch problem is actually in nvme driver, please
see the previous patch[1] I posted.


[1] https://lore.kernel.org/linux-block/20230613005847.1762378-1-ming.lei@redhat.com/T/#m17ac1aa71056b6517f8aefbae58c301f296f0a73


Thanks,
Ming


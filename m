Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B239C433DF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 03:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBD521548
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 03:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7G4Wsfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgJNDe5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 23:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729640AbgJNDe5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 23:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602646495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKR932KG8ej2rUdaJrcd2mjKDWjkF7Vu+9H8bWeY56c=;
        b=X7G4Wsfk1bYkP5PrQ9yRf5IP/kzIKL1KtYYDgl5+RuPodQZIpLqrfO32pcY21+PmSnf1Ym
        mnrqfry+OTNG2bJK2achGuU7xs20WNARatnViegtrjXx27jepEActCXZxAxh7XWryzP+4T
        3z90mzus0hZfY5d/bHQsmAXyR9SJWiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-kuoBe2YrM_eWLP4W4qg2Iw-1; Tue, 13 Oct 2020 23:34:52 -0400
X-MC-Unique: kuoBe2YrM_eWLP4W4qg2Iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E5F1015CAC;
        Wed, 14 Oct 2020 03:34:50 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1EE35C1A3;
        Wed, 14 Oct 2020 03:34:39 +0000 (UTC)
Date:   Wed, 14 Oct 2020 11:34:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014033434.GC775684@T590>
References: <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014010813.GA775684@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 09:08:28AM +0800, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> > 
> > > > > This may just reduce the probability. The concurrency of timeout
> > > > > and teardown will cause the same request
> > > > > be treated repeatly, this is not we expected.
> > > > 
> > > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > > completion, so
> > > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > > 
> > > > .teardown_lock still may cover the race with Sagi's patch because
> > > > teardown
> > > > actually cancels requests in sync style.
> > > In extreme scenarios, the request may be already retry success(rq state
> > > change to inflight).
> > > Timeout processing may wrongly stop the queue and abort the request.
> > > teardown_lock serialize the process of timeout and teardown, but do not
> > > avoid the race.
> > > It might not be safe.
> > 
> > Not sure I understand the scenario you are describing.
> > 
> > what do you mean by "In extreme scenarios, the request may be already retry
> > success(rq state change to inflight)"?
> > 
> > What will retry the request? only when the host will reconnect
> > the request will be retried.
> > 
> > We can call nvme_sync_queues in the last part of the teardown, but
> > I still don't understand the race here.
> 
> Not like SCSI, NVME doesn't complete request atomically, so double
> completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> 
> Given request is completed remotely or asynchronously in the two code paths,
> the teardown_lock can't protect the case.

Thinking of the issue further, the race shouldn't be between timeout and
teardown.

Both nvme_cancel_request() and nvme_tcp_complete_timed_out() are called
with .teardown_lock, and both check if the request is completed before
calling blk_mq_complete_request() which marks the request as COMPLETE state.
So the request shouldn't be double-freed in the two code paths.

Another possible reason is that between timeout and normal completion(fail
fast pending requests after ctrl state is updated to CONNECTING).

Yi, can you try the following patch and see if the issue is fixed?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..fab9220196bd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	if (ctrl->queue_count <= 1)
-		goto out;
+		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
@@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-out:
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -2030,11 +2025,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+
+	mutex_lock(&tcp_ctrl->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	mutex_unlock(&tcp_ctrl->teardown_lock);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2043,6 +2038,9 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
+	/* drain pending timeout for avoiding race with normal completion */
+	nvme_sync_queues(ctrl);
+
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
@@ -2051,6 +2049,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2058,6 +2057,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	else
 		nvme_disable_ctrl(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2080,6 +2080,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
+	/* drain pending timeout for avoiding race with normal completion */
+	nvme_sync_queues(ctrl);
+
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto out_fail;
 

Thanks,
Ming


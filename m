Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27081C433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E021582
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC3Qu85z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgJNBIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 21:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730814AbgJNBIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 21:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602637714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/69ONf8FQ290l0+b/tZ1c1YE/U0q1L4yCfmk70YYnc=;
        b=MC3Qu85z3Yd83zZQ/GfAMIDsKIkSsTzQ7KL7mArfu9TP+GxqnAqDXCeAacAP2OtNBnbsab
        C+DMOc19kFXks5B/nuM+O9uUfnnIEToAvmLMT0pV6ditvtLxcVGfK/U7de8npd/k6FfzPN
        RyS/7AciOye+drN6ISMxuC+9OeSN9P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-Ir_DaHO7OsmFzFbumOpCXw-1; Tue, 13 Oct 2020 21:08:30 -0400
X-MC-Unique: Ir_DaHO7OsmFzFbumOpCXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A715456BE8;
        Wed, 14 Oct 2020 01:08:28 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 641D16EF7D;
        Wed, 14 Oct 2020 01:08:17 +0000 (UTC)
Date:   Wed, 14 Oct 2020 09:08:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014010813.GA775684@T590>
References: <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> 
> > > > This may just reduce the probability. The concurrency of timeout
> > > > and teardown will cause the same request
> > > > be treated repeatly, this is not we expected.
> > > 
> > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > completion, so
> > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > 
> > > .teardown_lock still may cover the race with Sagi's patch because
> > > teardown
> > > actually cancels requests in sync style.
> > In extreme scenarios, the request may be already retry success(rq state
> > change to inflight).
> > Timeout processing may wrongly stop the queue and abort the request.
> > teardown_lock serialize the process of timeout and teardown, but do not
> > avoid the race.
> > It might not be safe.
> 
> Not sure I understand the scenario you are describing.
> 
> what do you mean by "In extreme scenarios, the request may be already retry
> success(rq state change to inflight)"?
> 
> What will retry the request? only when the host will reconnect
> the request will be retried.
> 
> We can call nvme_sync_queues in the last part of the teardown, but
> I still don't understand the race here.

Not like SCSI, NVME doesn't complete request atomically, so double
completion/free can be done from both timeout & nvme_cancel_request()(via teardown).

Given request is completed remotely or asynchronously in the two code paths,
the teardown_lock can't protect the case.

One solution is to apply the introduced blk_mq_complete_request_sync()
in both two code paths.

Another candidate is to use nvme_sync_queues() before teardown, such as
the following change:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..dc3561ca0074 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
+	nvme_sync_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
 		blk_mq_tagset_busy_iter(ctrl->tagset,
@@ -2171,14 +2172,11 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	/* fence other contexts that may complete the command */
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static enum blk_eh_timer_return


Thanks,
Ming


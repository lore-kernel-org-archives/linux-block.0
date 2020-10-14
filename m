Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A338C433DF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB93207C3
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLl+78A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgJNJ5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbgJNJ5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 05:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602669422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+Nfo7CPvqON4B3Kn47TT+yFPZmeO35wHPJpTlz7u8g=;
        b=PLl+78A8Pd6S0t7MCPnY6sr/w2a/ojnkxvUERzJr6uu+3KbrizGt+T6pLd9eV6jDj80r96
        uJi0ViJHlAB/krVwA3/YtH2392Nj2m4DHftgsZ1NGNeUXcLE1r2eHvSZfBPxNZlY2UFDFa
        g1bwlOd14XRgxzXY8e9QEf/DcfEiSPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-J3VBtSrYNCmOJPeN5WNKvw-1; Wed, 14 Oct 2020 05:56:58 -0400
X-MC-Unique: J3VBtSrYNCmOJPeN5WNKvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8362210066FC;
        Wed, 14 Oct 2020 09:56:56 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CDDE60C07;
        Wed, 14 Oct 2020 09:56:46 +0000 (UTC)
Date:   Wed, 14 Oct 2020 17:56:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014095642.GE775684@T590>
References: <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
 <20201014033434.GC775684@T590>
 <f5870b91-28c5-ea99-59df-cdcc8c482011@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5870b91-28c5-ea99-59df-cdcc8c482011@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 05:39:12PM +0800, Chao Leng wrote:
> 
> 
> On 2020/10/14 11:34, Ming Lei wrote:
> > On Wed, Oct 14, 2020 at 09:08:28AM +0800, Ming Lei wrote:
> > > On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> > > > 
> > > > > > > This may just reduce the probability. The concurrency of timeout
> > > > > > > and teardown will cause the same request
> > > > > > > be treated repeatly, this is not we expected.
> > > > > > 
> > > > > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > > > > completion, so
> > > > > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > > > > 
> > > > > > .teardown_lock still may cover the race with Sagi's patch because
> > > > > > teardown
> > > > > > actually cancels requests in sync style.
> > > > > In extreme scenarios, the request may be already retry success(rq state
> > > > > change to inflight).
> > > > > Timeout processing may wrongly stop the queue and abort the request.
> > > > > teardown_lock serialize the process of timeout and teardown, but do not
> > > > > avoid the race.
> > > > > It might not be safe.
> > > > 
> > > > Not sure I understand the scenario you are describing.
> > > > 
> > > > what do you mean by "In extreme scenarios, the request may be already retry
> > > > success(rq state change to inflight)"?
> > > > 
> > > > What will retry the request? only when the host will reconnect
> > > > the request will be retried.
> > > > 
> > > > We can call nvme_sync_queues in the last part of the teardown, but
> > > > I still don't understand the race here.
> > > 
> > > Not like SCSI, NVME doesn't complete request atomically, so double
> > > completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> > > 
> > > Given request is completed remotely or asynchronously in the two code paths,
> > > the teardown_lock can't protect the case.
> > 
> > Thinking of the issue further, the race shouldn't be between timeout and
> > teardown.
> > 
> > Both nvme_cancel_request() and nvme_tcp_complete_timed_out() are called
> > with .teardown_lock, and both check if the request is completed before
> > calling blk_mq_complete_request() which marks the request as COMPLETE state.
> > So the request shouldn't be double-freed in the two code paths.
> > 
> > Another possible reason is that between timeout and normal completion(fail
> > fast pending requests after ctrl state is updated to CONNECTING).
> > 
> > Yi, can you try the following patch and see if the issue is fixed?
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index d6a3e1487354..fab9220196bd 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
> >   static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
> >   		bool remove)
> >   {
> > -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
> >   	blk_mq_quiesce_queue(ctrl->admin_q);
> >   	nvme_tcp_stop_queue(ctrl, 0);
> >   	if (ctrl->admin_tagset) {
> > @@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
> >   	if (remove)
> >   		blk_mq_unquiesce_queue(ctrl->admin_q);
> >   	nvme_tcp_destroy_admin_queue(ctrl, remove);
> > -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
> >   }
> >   static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> >   		bool remove)
> >   {
> > -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
> >   	if (ctrl->queue_count <= 1)
> > -		goto out;
> > +		return;
> >   	blk_mq_quiesce_queue(ctrl->admin_q);
> >   	nvme_start_freeze(ctrl);
> >   	nvme_stop_queues(ctrl);
> > @@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> >   	if (remove)
> >   		nvme_start_queues(ctrl);
> >   	nvme_tcp_destroy_io_queues(ctrl, remove);
> > -out:
> > -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
> >   }
> >   static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > @@ -2030,11 +2025,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >   	nvme_stop_keep_alive(ctrl);
> > +
> > +	mutex_lock(&tcp_ctrl->teardown_lock);
> >   	nvme_tcp_teardown_io_queues(ctrl, false);
> > -	/* unquiesce to fail fast pending requests */
> > -	nvme_start_queues(ctrl);
> >   	nvme_tcp_teardown_admin_queue(ctrl, false);
> > -	blk_mq_unquiesce_queue(ctrl->admin_q);
> Delete blk_mq_unquiesce_queue will cause a bug which may cause reconnect failed.
> Delete nvme_start_queues may cause another bug.

nvme_tcp_setup_ctrl() will re-start io and admin queue, and only .connect_q
and .fabrics_q are required during reconnect.

So can you explain in detail about the bug?

Thanks,
Ming


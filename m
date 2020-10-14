Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DAC433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 02:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70023221FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 02:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA1pPt3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgJNCD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 22:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgJNCD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 22:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602641007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnBS0lxFc4aRI5IPnBKqaaP5VKiZUfUv2cEuSMjVCR4=;
        b=cA1pPt3ehDDr8M/MPSbV4bKxgn5G3lBZq1o3P+GQ8YhHFhwZJMUUuCxFQ9XMURi5KwW3Et
        I3d1kuDYxufdmgw/xhVsMb/dLkib5oVbsWOeS+V/6yUH2J7XET8H9KBb5cZtfxcjZH1HMs
        +T/MAcc2XGsGZiOqRQcMI+sb/Y1+JxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-SlNewCraPw2HPxMnv_OmPQ-1; Tue, 13 Oct 2020 22:03:22 -0400
X-MC-Unique: SlNewCraPw2HPxMnv_OmPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2785E879535;
        Wed, 14 Oct 2020 02:03:21 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE29B5DA8C;
        Wed, 14 Oct 2020 02:03:06 +0000 (UTC)
Date:   Wed, 14 Oct 2020 10:02:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014020257.GB775684@T590>
References: <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
 <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 09:37:07AM +0800, Chao Leng wrote:
> rdma also need do this patch.
> We do test this patch with nvme over roce a few days, now work well.
> 
> On 2020/10/14 9:08, Ming Lei wrote:
> > On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> > > 
> > > > > > This may just reduce the probability. The concurrency of timeout
> > > > > > and teardown will cause the same request
> > > > > > be treated repeatly, this is not we expected.
> > > > > 
> > > > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > > > completion, so
> > > > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > > > 
> > > > > .teardown_lock still may cover the race with Sagi's patch because
> > > > > teardown
> > > > > actually cancels requests in sync style.
> > > > In extreme scenarios, the request may be already retry success(rq state
> > > > change to inflight).
> > > > Timeout processing may wrongly stop the queue and abort the request.
> > > > teardown_lock serialize the process of timeout and teardown, but do not
> > > > avoid the race.
> > > > It might not be safe.
> > > 
> > > Not sure I understand the scenario you are describing.
> > > 
> > > what do you mean by "In extreme scenarios, the request may be already retry
> > > success(rq state change to inflight)"?
> > > 
> > > What will retry the request? only when the host will reconnect
> > > the request will be retried.
> > > 
> > > We can call nvme_sync_queues in the last part of the teardown, but
> > > I still don't understand the race here.
> > 
> > Not like SCSI, NVME doesn't complete request atomically, so double
> > completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> > 
> > Given request is completed remotely or asynchronously in the two code paths,
> > the teardown_lock can't protect the case.
> > 
> > One solution is to apply the introduced blk_mq_complete_request_sync()
> > in both two code paths.
> > 
> > Another candidate is to use nvme_sync_queues() before teardown, such as
> > the following change:
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index d6a3e1487354..dc3561ca0074 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> >   	blk_mq_quiesce_queue(ctrl->admin_q);
> >   	nvme_start_freeze(ctrl);
> >   	nvme_stop_queues(ctrl);
> > +	nvme_sync_queues(ctrl);
> nvme_sync_queues now sync io queues and admin queues, so we may need like this:
> nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> {
> 	down_read(&ctrl->namespaces_rwsem);
> 	list_for_each_entry(ns, &ctrl->namespaces, list)
> 		blk_sync_queue(ns->queue);
> 	up_read(&ctrl->namespaces_rwsem);
> }

Looks not necessary to do that, because admin queue is quiesced in
nvme_tcp_teardown_io_queues(), so it is safe to sync admin queue here too.


Thanks,
Ming


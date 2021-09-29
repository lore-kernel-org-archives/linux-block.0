Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D763FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD78C61462
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbhI2P35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345201AbhI2P35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 11:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632929296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T93jqqgqqFV2Mt29ptOHTmBc09wsel2Yq+k09RyZmL4=;
        b=YJKwwCnpKEF9MehkKDqGZbHShcMB0BrxnSXtAAynm/MgrR7cRiVNq7NQ6aK20Y+cS5E7/v
        AjNTZGrHxIVed6FRWGFizgNwBbnBKaTGscyptDA6qzbmkX29j0ahWwOJncq2rynd+BLuh2
        gubm/k4FdlfCYpTiPY9WgrH/VHyUV3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-mEyAJEfYOHOC89svWV9gJA-1; Wed, 29 Sep 2021 11:28:12 -0400
X-MC-Unique: mEyAJEfYOHOC89svWV9gJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4553336301;
        Wed, 29 Sep 2021 15:28:11 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6DF19C59;
        Wed, 29 Sep 2021 15:28:06 +0000 (UTC)
Date:   Wed, 29 Sep 2021 23:28:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] nvme: paring quiesce/unquiesce
Message-ID: <YVSGAQqzNTjohWkn@T590>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-5-ming.lei@redhat.com>
 <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 02:49:39PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/29/21 7:15 AM, Ming Lei wrote:
> > The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> > stops and starts the queue unconditionally. And there can be concurrent
> > quiesce/unquiesce coming from different unrelated code paths, so
> > unquiesce may come unexpectedly and start queue too early.
> > 
> > Prepare for supporting nested / concurrent quiesce/unquiesce, so that we
> > can address the above issue.
> > 
> > NVMe has very complicated quiesce/unquiesce use pattern, add one mutex
> > and queue stopped state in nvme_ctrl, so that we can make sure that
> > quiece/unquiesce is called in pair.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
> >   drivers/nvme/host/nvme.h |  4 ++++
> >   2 files changed, 50 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 23fb746a8970..5d0b2eb38e43 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4375,6 +4375,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> >   	spin_lock_init(&ctrl->lock);
> >   	mutex_init(&ctrl->scan_lock);
> > +	mutex_init(&ctrl->queues_stop_lock);
> >   	INIT_LIST_HEAD(&ctrl->namespaces);
> >   	xa_init(&ctrl->cels);
> >   	init_rwsem(&ctrl->namespaces_rwsem);
> > @@ -4450,14 +4451,44 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> > +static void __nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->queues_stop_lock);
> > +
> > +	if (!ctrl->admin_queue_stopped) {
> > +		blk_mq_quiesce_queue(ctrl->admin_q);
> > +		ctrl->admin_queue_stopped = true;
> > +	}
> > +}
> > +
> > +static void __nvme_start_admin_queue(struct nvme_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->queues_stop_lock);
> > +
> > +	if (ctrl->admin_queue_stopped) {
> > +		blk_mq_unquiesce_queue(ctrl->admin_q);
> > +		ctrl->admin_queue_stopped = false;
> > +	}
> > +}
> 
> I'd make this a bit we can flip atomically.
> 
> > +
> >   static void nvme_start_ns_queue(struct nvme_ns *ns)
> >   {
> > -	blk_mq_unquiesce_queue(ns->queue);
> > +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> > +
> > +	if (test_bit(NVME_NS_STOPPED, &ns->flags)) {
> > +		blk_mq_unquiesce_queue(ns->queue);
> > +		clear_bit(NVME_NS_STOPPED, &ns->flags);
> > +	}
> >   }
> >   static void nvme_stop_ns_queue(struct nvme_ns *ns)
> >   {
> > -	blk_mq_quiesce_queue(ns->queue);
> > +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> > +
> > +	if (!test_bit(NVME_NS_STOPPED, &ns->flags)) {
> > +		blk_mq_quiesce_queue(ns->queue);
> > +		set_bit(NVME_NS_STOPPED, &ns->flags);
> > +	}
> >   }
> 
> Why not use test_and_set_bit/test_and_clear_bit for serialization?
> 
> >   /*
> > @@ -4490,16 +4521,18 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
> >   {
> >   	struct nvme_ns *ns;
> > +	mutex_lock(&ctrl->queues_stop_lock);
> >   	down_read(&ctrl->namespaces_rwsem);
> >   	/* Forcibly unquiesce queues to avoid blocking dispatch */
> >   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
> > -		nvme_start_admin_queue(ctrl);
> > +		__nvme_start_admin_queue(ctrl);
> >   	list_for_each_entry(ns, &ctrl->namespaces, list)
> >   		nvme_set_queue_dying(ns);
> >   	up_read(&ctrl->namespaces_rwsem);
> > +	mutex_unlock(&ctrl->queues_stop_lock);
> 
> This extra lock wrapping the namespaces_rwsem is scary. The
> ordering rules are not clear to me.

The rule is clear: queues_stop_lock has to be acquired before locking
->namespaces_rwsem.

Using test_and_set_bit/test_and_clear_bit could be enough for pairing
quiesce and unquiesce, I will try to remove the lock of
->queues_stop_lock in next version.


Thanks,
Ming


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E21DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D3461056
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhIPN4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238063AbhIPN4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631800502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5MT7htep4lfFb5DF7TWazpr34VmiixYifF4+r3+XCo=;
        b=iOGAzUsMlmbqmiM+CnTPp4eCK3EbQtycFctwYVbQ9vnxZXWkdYfKZ+HYtP89ZNNWJsPIEv
        zHHQIQHFtAgY9fpFt/kKBtTC5j9Z6Myo3nrnKxl2fye56RC29iBsGPwhoM0w31CeP3ANuT
        WVAggWcH3/fnW1qfFCT66YYyLTxLhg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-iEVy8uiXOMe8szfMmGzbTA-1; Thu, 16 Sep 2021 09:55:01 -0400
X-MC-Unique: iEVy8uiXOMe8szfMmGzbTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF79C802947;
        Thu, 16 Sep 2021 13:54:59 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77A675C1D5;
        Thu, 16 Sep 2021 13:54:49 +0000 (UTC)
Date:   Thu, 16 Sep 2021 21:55:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 7/7] nbd: fix uaf in nbd_handle_reply()
Message-ID: <YUNMtcDYG+Uk/gzO@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-8-yukuai3@huawei.com>
 <YUM/cNzr6PTXFVAX@T590>
 <f0a72b72-19c9-f01d-806d-d27f854dea8f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a72b72-19c9-f01d-806d-d27f854dea8f@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 09:10:37PM +0800, yukuai (C) wrote:
> On 2021/09/16 20:58, Ming Lei wrote:
> > On Thu, Sep 16, 2021 at 05:33:50PM +0800, Yu Kuai wrote:
> > > There is a problem that nbd_handle_reply() might access freed request:
> > > 
> > > 1) At first, a normal io is submitted and completed with scheduler:
> > > 
> > > internel_tag = blk_mq_get_tag -> get tag from sched_tags
> > >   blk_mq_rq_ctx_init
> > >    sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> > > ...
> > > blk_mq_get_driver_tag
> > >   __blk_mq_get_driver_tag -> get tag from tags
> > >   tags->rq[tag] = sched_tag->static_rq[internel_tag]
> > > 
> > > So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
> > > to the request: sched_tags->static_rq[internal_tag]. Even if the
> > > io is finished.
> > > 
> > > 2) nbd server send a reply with random tag directly:
> > > 
> > > recv_work
> > >   nbd_handle_reply
> > >    blk_mq_tag_to_rq(tags, tag)
> > >     rq = tags->rq[tag]
> > > 
> > > 3) if the sched_tags->static_rq is freed:
> > > 
> > > blk_mq_sched_free_requests
> > >   blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
> > >    -> step 2) access rq before clearing rq mapping
> > >    blk_mq_clear_rq_mapping(set, tags, hctx_idx);
> > >    __free_pages() -> rq is freed here
> > > 
> > > 4) Then, nbd continue to use the freed request in nbd_handle_reply
> > > 
> > > Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
> > > thus request is ensured not to be freed because 'q_usage_counter' is
> > > not zero.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   drivers/block/nbd.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > index 69dc5eac9ad3..b3a47fc6237f 100644
> > > --- a/drivers/block/nbd.c
> > > +++ b/drivers/block/nbd.c
> > > @@ -825,6 +825,7 @@ static void recv_work(struct work_struct *work)
> > >   						     work);
> > >   	struct nbd_device *nbd = args->nbd;
> > >   	struct nbd_config *config = nbd->config;
> > > +	struct request_queue *q = nbd->disk->queue;
> > >   	struct nbd_sock *nsock;
> > >   	struct nbd_cmd *cmd;
> > >   	struct request *rq;
> > > @@ -835,7 +836,20 @@ static void recv_work(struct work_struct *work)
> > >   		if (nbd_read_reply(nbd, args->index, &reply))
> > >   			break;
> > > +		/*
> > > +		 * Grab .q_usage_counter so request pool won't go away, then no
> > > +		 * request use-after-free is possible during nbd_handle_reply().
> > > +		 * If queue is frozen, there won't be any inflight requests, we
> > > +		 * needn't to handle the incoming garbage message.
> > > +		 */
> > > +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
> > > +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
> > > +				__func__);
> > > +			break;
> > > +		}
> > > +
> > >   		cmd = nbd_handle_reply(nbd, args->index, &reply);
> > > +		percpu_ref_put(&q->q_usage_counter);
> > >   		if (IS_ERR(cmd))
> > >   			break;
> > 
> > The refcount needs to be grabbed when completing the request because
> > the request may be completed from other code path, then the request pool
> > will be freed from that code path when the request is referred.
> 
> Hi,
> 
> The request can't complete concurrently, thus put ref here is safe.
> 
> There used to be a commet here that I tried to explain it... It's fine
> to me to move it behind anyway.

Never see such comment. cmd->lock isn't held here, so I believe
concurrent completion is possible here.


Thanks,
Ming


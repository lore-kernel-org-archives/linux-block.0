Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 14:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23846108B
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 14:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhINOew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhINOev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631630013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chATlUeF4N2elSt4fnYjmQllXyvDEPn10NBT5Xpx3Lc=;
        b=bPFtm/39YT0DUCi0Dh7hM3PJaoJcl3JrpSTaQIofS1dg0Mob3dAD1ZzenPEGWHmtxP/3wg
        V6qAWRU3YYndW1L4SCfCf9dcKUmhSDFuAVtmuckyaQCb7PLSk938wGyi06OzbCEuuAqUJI
        A9X0sS9ADRDoDQ+bhbrJlCWwRVkkjNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-xqTRlyvPP4GVeILmnWrUCw-1; Tue, 14 Sep 2021 10:33:31 -0400
X-MC-Unique: xqTRlyvPP4GVeILmnWrUCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 556671060DAB;
        Tue, 14 Sep 2021 14:33:30 +0000 (UTC)
Received: from T590 (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B65585D9DC;
        Tue, 14 Sep 2021 14:33:22 +0000 (UTC)
Date:   Tue, 14 Sep 2021 22:33:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YUCyvDDG0gOzaFfR@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com>
 <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
 <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com>
 <YUBTVBioqJ7qas2R@T590>
 <39e628cc-496c-ba20-b53a-fbeecc1d7e4e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e628cc-496c-ba20-b53a-fbeecc1d7e4e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 05:08:00PM +0800, yukuai (C) wrote:
> On 2021/09/14 15:46, Ming Lei wrote:
> > On Tue, Sep 14, 2021 at 03:13:38PM +0800, yukuai (C) wrote:
> > > On 2021/09/14 14:44, Ming Lei wrote:
> > > > On Tue, Sep 14, 2021 at 11:11:06AM +0800, yukuai (C) wrote:
> > > > > On 2021/09/14 9:11, Ming Lei wrote:
> > > > > > On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
> > > > > > > blk_mq_tag_to_rq() can only ensure to return valid request in
> > > > > > > following situation:
> > > > > > > 
> > > > > > > 1) client send request message to server first
> > > > > > > submit_bio
> > > > > > > ...
> > > > > > >     blk_mq_get_tag
> > > > > > >     ...
> > > > > > >     blk_mq_get_driver_tag
> > > > > > >     ...
> > > > > > >     nbd_queue_rq
> > > > > > >      nbd_handle_cmd
> > > > > > >       nbd_send_cmd
> > > > > > > 
> > > > > > > 2) client receive respond message from server
> > > > > > > recv_work
> > > > > > >     nbd_read_stat
> > > > > > >      blk_mq_tag_to_rq
> > > > > > > 
> > > > > > > If step 1) is missing, blk_mq_tag_to_rq() will return a stale
> > > > > > > request, which might be freed. Thus convert to use
> > > > > > > blk_mq_find_and_get_req() to make sure the returned request is not
> > > > > > > freed.
> > > > > > 
> > > > > > But NBD_CMD_INFLIGHT has been added for checking if the reply is
> > > > > > expected, do we still need blk_mq_find_and_get_req() for covering
> > > > > > this issue? BTW, request and its payload is pre-allocated, so there
> > > > > > isn't real use-after-free.
> > > > > 
> > > > > Hi, Ming
> > > > > 
> > > > > Checking NBD_CMD_INFLIGHT relied on the request founded by tag is valid,
> > > > > not the other way round.
> > > > > 
> > > > > nbd_read_stat
> > > > >    req = blk_mq_tag_to_rq()
> > > > >    cmd = blk_mq_rq_to_pdu(req)
> > > > >    mutex_lock(cmd->lock)
> > > > >    checking NBD_CMD_INFLIGHT
> > > > 
> > > > Request and its payload is pre-allocated, and either req->ref or cmd->lock can
> > > > serve the same purpose here. Once cmd->lock is held, you can check if the cmd is
> > > > inflight or not. If it isn't inflight, just return -ENOENT. Is there any
> > > > problem to handle in this way?
> > > 
> > > Hi, Ming
> > > 
> > > in nbd_read_stat:
> > > 
> > > 1) get a request by tag first
> > > 2) get nbd_cmd by the request
> > > 3) hold cmd->lock and check if cmd is inflight
> > > 
> > > If we want to check if the cmd is inflight in step 3), we have to do
> > > setp 1) and 2) first. As I explained in patch 0, blk_mq_tag_to_rq()
> > > can't make sure the returned request is not freed:
> > > 
> > > nbd_read_stat
> > > 			blk_mq_sched_free_requests
> > > 			 blk_mq_free_rqs
> > >    blk_mq_tag_to_rq
> > >    -> get rq before clear mapping
> > > 			  blk_mq_clear_rq_mapping
> > > 			  __free_pages -> rq is freed
> > >    blk_mq_request_started -> UAF
> > 
> > If the above can happen, blk_mq_find_and_get_req() may not fix it too, just
> 
> Hi, Ming
> 
> Why can't blk_mq_find_and_get_req() fix it? I can't think of any
> scenario that might have problem currently.

The principle behind blk_mq_find_and_get_req() is that if one request's
ref is grabbed, the queue's usage counter is guaranteed to be grabbed,
and this way isn't straight-forward.

Yeah, it can fix the issue, but I don't think it is good to call it in
fast path cause tags->lock is required.

> 
> > wondering why not take the following simpler way for avoiding the UAF?
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 5170a630778d..dfa5cce71f66 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
> >   						     work);
> >   	struct nbd_device *nbd = args->nbd;
> >   	struct nbd_config *config = nbd->config;
> > +	struct request_queue *q = nbd->disk->queue;
> >   	struct nbd_cmd *cmd;
> >   	struct request *rq;
> > +	if (!percpu_ref_tryget(&q->q_usage_counter))
> > +                return;
> > +
> 
> We can't make sure freeze_queue is called before this, thus this approch
> can't fix the problem, right?
>  nbd_read_stat
>     blk_mq_tag_to_rq
> 			elevator_switch
> 			 blk_mq_freeze_queue(q);
> 			 elevator_switch_mq
> 			  elevator_exit
> 			   blk_mq_sched_free_requests
>     blk_mq_request_started -> UAF

No, blk_mq_freeze_queue() waits until .q_usage_counter becomes zero, so
there won't be any concurrent nbd_read_stat() during switching elevator
if ->q_usage_counter is grabbed in recv_work().

Thanks,
Ming


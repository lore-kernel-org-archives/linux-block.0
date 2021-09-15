Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DEC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 03:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDD161211
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 03:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhIODrk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 23:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235956AbhIODrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 23:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631677581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laMJBZMfAA5GFR18gmCaz0BRGaBhHTinBYyhHApQWKQ=;
        b=h/tmFKgqr2JwNOUvSJXOZEtCY07s09ST+DYx8hx1sG/me9UGH7NBNHKQDuEMc5UqsAuMzi
        BQRpu2KYY4XCWfppQqmPRK3pTBffelcA7lYGmQejAFZxV0YYGD3L/f5EjKq9+YJs+eVaYG
        a6VHvULLBoPPW/PIZcclB2BiazHe1co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ZiTgKBd1PpyNzJ0dXKzqDA-1; Tue, 14 Sep 2021 23:46:19 -0400
X-MC-Unique: ZiTgKBd1PpyNzJ0dXKzqDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898F8101796D;
        Wed, 15 Sep 2021 03:46:18 +0000 (UTC)
Received: from T590 (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E493E78433;
        Wed, 15 Sep 2021 03:46:10 +0000 (UTC)
Date:   Wed, 15 Sep 2021 11:46:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YUFsja+cIxhFY7c0@T590>
References: <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
 <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com>
 <YUBTVBioqJ7qas2R@T590>
 <b8301834-5541-76ee-13a9-0fa565fce7e3@huawei.com>
 <YUCzr2ysb+vJ1x0W@T590>
 <8f1849a3-6bf2-6b14-7ef9-4969a9a5425b@huawei.com>
 <YUFldgfRYrJyxFtz@T590>
 <60f68f6b-5fff-6a39-b77b-4bbb86f1c87e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60f68f6b-5fff-6a39-b77b-4bbb86f1c87e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 11:36:47AM +0800, yukuai (C) wrote:
> On 2021/09/15 11:16, Ming Lei wrote:
> > On Wed, Sep 15, 2021 at 09:54:09AM +0800, yukuai (C) wrote:
> > > On 2021/09/14 22:37, Ming Lei wrote:
> > > > On Tue, Sep 14, 2021 at 05:19:31PM +0800, yukuai (C) wrote:
> > > > > On 在 2021/09/14 15:46, Ming Lei wrote:
> > > > > 
> > > > > > If the above can happen, blk_mq_find_and_get_req() may not fix it too, just
> > > > > > wondering why not take the following simpler way for avoiding the UAF?
> > > > > > 
> > > > > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > > > > index 5170a630778d..dfa5cce71f66 100644
> > > > > > --- a/drivers/block/nbd.c
> > > > > > +++ b/drivers/block/nbd.c
> > > > > > @@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
> > > > > >     						     work);
> > > > > >     	struct nbd_device *nbd = args->nbd;
> > > > > >     	struct nbd_config *config = nbd->config;
> > > > > > +	struct request_queue *q = nbd->disk->queue;
> > > > > >     	struct nbd_cmd *cmd;
> > > > > >     	struct request *rq;
> > > > > > +	if (!percpu_ref_tryget(&q->q_usage_counter))
> > > > > > +                return;
> > > > > > +
> > > > > >     	while (1) {
> > > > > >     		cmd = nbd_read_stat(nbd, args->index);
> > > > > >     		if (IS_ERR(cmd)) {
> > > > > > @@ -813,6 +817,7 @@ static void recv_work(struct work_struct *work)
> > > > > >     		if (likely(!blk_should_fake_timeout(rq->q)))
> > > > > >     			blk_mq_complete_request(rq);
> > > > > >     	}
> > > > > > +	blk_queue_exit(q);
> > > > > >     	nbd_config_put(nbd);
> > > > > >     	atomic_dec(&config->recv_threads);
> > > > > >     	wake_up(&config->recv_wq);
> > > > > > 
> > > > > 
> > > > > Hi, Ming
> > > > > 
> > > > > This apporch is wrong.
> > > > > 
> > > > > If blk_mq_freeze_queue() is called, and nbd is waiting for all
> > > > > request to complete. percpu_ref_tryget() will fail here, and deadlock
> > > > > will occur because request can't complete in recv_work().
> > > > 
> > > > No, percpu_ref_tryget() won't fail until ->q_usage_counter is zero, when
> > > > it is perfectly fine to do nothing in recv_work().
> > > > 
> > > 
> > > Hi Ming
> > > 
> > > This apporch is a good idea, however we should not get q_usage_counter
> > > in reccv_work(), because It will block freeze queue.
> > > 
> > > How about get q_usage_counter in nbd_read_stat(), and put in error path
> > > or after request completion?
> > 
> > OK, looks I missed that nbd_read_stat() needs to wait for incoming reply
> > first, so how about the following change by partitioning nbd_read_stat()
> > into nbd_read_reply() and nbd_handle_reply()?
> 
> Hi, Ming
> 
> The change looks good to me.
> 
> Do you want to send a patch to fix this?

I guess you may add inflight check or sort of change in nbd_read_stat(), so feel
free to fold it into your series.


Thanks,
Ming


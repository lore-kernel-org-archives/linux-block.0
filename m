Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5373F61355
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhINHsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237039AbhINHru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631605593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HViiRnu75I46+r5aoAeD0e3kDx7NMxZUbAuKksyTKDo=;
        b=AwC2ahWfEiqgh0WHluo7VygOcgwrlKmlgm2tRU4n6GnH8W09razsQU1Doobq+977qRK4C3
        uCbMkhrGU+84xqMV50TTwBiAIcBsQm3QtIyeyeqtSk+GeXMLDo+GvIceuV0YfZtmmFt4Gu
        lbXAwPBJ8ZE6BxqBj0UrXbe3OU93mEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-EytKr-llMZaAcjwQWjDUtg-1; Tue, 14 Sep 2021 03:46:29 -0400
X-MC-Unique: EytKr-llMZaAcjwQWjDUtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14FB71017965;
        Tue, 14 Sep 2021 07:46:28 +0000 (UTC)
Received: from T590 (ovpn-13-174.pek2.redhat.com [10.72.13.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D650210016F5;
        Tue, 14 Sep 2021 07:46:19 +0000 (UTC)
Date:   Tue, 14 Sep 2021 15:46:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YUBTVBioqJ7qas2R@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com>
 <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
 <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 03:13:38PM +0800, yukuai (C) wrote:
> On 2021/09/14 14:44, Ming Lei wrote:
> > On Tue, Sep 14, 2021 at 11:11:06AM +0800, yukuai (C) wrote:
> > > On 2021/09/14 9:11, Ming Lei wrote:
> > > > On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
> > > > > blk_mq_tag_to_rq() can only ensure to return valid request in
> > > > > following situation:
> > > > > 
> > > > > 1) client send request message to server first
> > > > > submit_bio
> > > > > ...
> > > > >    blk_mq_get_tag
> > > > >    ...
> > > > >    blk_mq_get_driver_tag
> > > > >    ...
> > > > >    nbd_queue_rq
> > > > >     nbd_handle_cmd
> > > > >      nbd_send_cmd
> > > > > 
> > > > > 2) client receive respond message from server
> > > > > recv_work
> > > > >    nbd_read_stat
> > > > >     blk_mq_tag_to_rq
> > > > > 
> > > > > If step 1) is missing, blk_mq_tag_to_rq() will return a stale
> > > > > request, which might be freed. Thus convert to use
> > > > > blk_mq_find_and_get_req() to make sure the returned request is not
> > > > > freed.
> > > > 
> > > > But NBD_CMD_INFLIGHT has been added for checking if the reply is
> > > > expected, do we still need blk_mq_find_and_get_req() for covering
> > > > this issue? BTW, request and its payload is pre-allocated, so there
> > > > isn't real use-after-free.
> > > 
> > > Hi, Ming
> > > 
> > > Checking NBD_CMD_INFLIGHT relied on the request founded by tag is valid,
> > > not the other way round.
> > > 
> > > nbd_read_stat
> > >   req = blk_mq_tag_to_rq()
> > >   cmd = blk_mq_rq_to_pdu(req)
> > >   mutex_lock(cmd->lock)
> > >   checking NBD_CMD_INFLIGHT
> > 
> > Request and its payload is pre-allocated, and either req->ref or cmd->lock can
> > serve the same purpose here. Once cmd->lock is held, you can check if the cmd is
> > inflight or not. If it isn't inflight, just return -ENOENT. Is there any
> > problem to handle in this way?
> 
> Hi, Ming
> 
> in nbd_read_stat:
> 
> 1) get a request by tag first
> 2) get nbd_cmd by the request
> 3) hold cmd->lock and check if cmd is inflight
> 
> If we want to check if the cmd is inflight in step 3), we have to do
> setp 1) and 2) first. As I explained in patch 0, blk_mq_tag_to_rq()
> can't make sure the returned request is not freed:
> 
> nbd_read_stat
> 			blk_mq_sched_free_requests
> 			 blk_mq_free_rqs
>   blk_mq_tag_to_rq
>   -> get rq before clear mapping
> 			  blk_mq_clear_rq_mapping
> 			  __free_pages -> rq is freed
>   blk_mq_request_started -> UAF

If the above can happen, blk_mq_find_and_get_req() may not fix it too, just
wondering why not take the following simpler way for avoiding the UAF?

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..dfa5cce71f66 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
 						     work);
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
+	struct request_queue *q = nbd->disk->queue;
 	struct nbd_cmd *cmd;
 	struct request *rq;
 
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+                return;
+
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
@@ -813,6 +817,7 @@ static void recv_work(struct work_struct *work)
 		if (likely(!blk_should_fake_timeout(rq->q)))
 			blk_mq_complete_request(rq);
 	}
+	blk_queue_exit(q);
 	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);

Thanks,
Ming


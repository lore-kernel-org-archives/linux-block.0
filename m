Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA78C433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAEB229C7
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 11:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbhAELUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 06:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbhAELUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 06:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609845544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOkwDPySrsBlNm8mdpoP6CMF0OFslXu57YAYdkM5BfA=;
        b=EKUV7wt7wEvdREpwgL28IF7zp9q9vO4w5era5/JQ9cKSGr8XQXtR0751EhD5AhiU3HLBY2
        3/koxMa2OvkA4qWJccOG6v9X/oddjpR7nc3fpXMqMabzky50rRVhYZxkCHjTSRR2/wndKp
        ObkX8n0Ihvj2ML2qyBeQIZSCfH6z8LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-CzWQa-DkMP-K4WDBKnD3YA-1; Tue, 05 Jan 2021 06:19:02 -0500
X-MC-Unique: CzWQa-DkMP-K4WDBKnD3YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25C39801B1D;
        Tue,  5 Jan 2021 11:19:01 +0000 (UTC)
Received: from T590 (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C02BE71D53;
        Tue,  5 Jan 2021 11:18:54 +0000 (UTC)
Date:   Tue, 5 Jan 2021 19:18:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared
 in hctx_may_queue
Message-ID: <20210105111850.GB3619109@T590>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
 <20210105022017.GA3594357@T590>
 <bcbe4b32-a819-8423-1849-e9a7db7fcde8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbe4b32-a819-8423-1849-e9a7db7fcde8@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 05, 2021 at 10:04:58AM +0000, John Garry wrote:
> On 05/01/2021 02:20, Ming Lei wrote:
> > On Mon, Jan 04, 2021 at 10:41:36AM +0000, John Garry wrote:
> > > On 27/12/2020 11:34, Ming Lei wrote:
> > > > In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
> > > > q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.
> > > > 
> > > > So fix it.
> > > > 
> > > > Cc: John Garry<john.garry@huawei.com>
> > > > Cc: Kashyap Desai<kashyap.desai@broadcom.com>
> > > > Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
> > > > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> > > Reviewed-by: John Garry<john.garry@huawei.com>
> > > 
> > > > ---
> > > >    block/blk-mq.h | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > > > index c1458d9502f1..3616453ca28c 100644
> > > > --- a/block/blk-mq.h
> > > > +++ b/block/blk-mq.h
> > > > @@ -304,7 +304,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
> > > >    		struct request_queue *q = hctx->queue;
> > > >    		struct blk_mq_tag_set *set = q->tag_set;
> > > > -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &q->queue_flags))
> > > > +		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> > > I wonder how this ever worked properly, as BLK_MQ_S_TAG_ACTIVE is bit index
> > > 1, and for q->queue_flags that means QUEUE_FLAG_DYING bit, which I figure is
> > > not set normally..
> > It always return true, and might just take a bit more CPU especially the tag queue
> > depth of magsas_raid and hisi_sas_v3 is quite high.
> 
> Hi Ming,
> 
> Right, but we actually tested by hacking the host tag queue depth to be
> lower such that we should have tag contention, here is an extract from the
> original series cover letter for my results:
> 
> Tag depth 		4000 (default)		260**
> 
> Baseline (v5.9-rc1):
> none sched:		2094K IOPS		513K
> mq-deadline sched:	2145K IOPS		1336K
> 
> Final, host_tagset=0 in LLDD *, ***:
> none sched:		2120K IOPS		550K
> mq-deadline sched:	2121K IOPS		1309K
> 
> Final ***:
> none sched:		2132K IOPS		1185		
> mq-deadline sched:	2145K IOPS		2097	
> 
> Maybe my test did not expose the issue. Kashyap also tested this and
> reported the original issue such that we needed this feature, so I'm
> confused.

How many LUNs are involved in above test with 260 depth?


Thanks,
Ming


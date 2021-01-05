Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74CC433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 02:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A13522581
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 02:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbhAECV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 21:21:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbhAECV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 21:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609813231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boOesN+lbkXwXf2orOxmKWzZbEIJOdgIiDADHVsF7NE=;
        b=LRzL1JRUaUpg7tLaZ6Wxz8uZEZHj4B6RFN5iG1+6FJ3m7++BTviqOhhOb2bIbcM1qyiYr/
        sn7XFZnb7nLnGXiC+XxboBtkeSUf8/o1hc7bVmmHdKiWuMnI2SQX0+qx05T1blwLtz12Gc
        b7trf3vNteregmHwGZzE579KYsaR/7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-shn4UVASOrimpdvyjQ-Ieg-1; Mon, 04 Jan 2021 21:20:29 -0500
X-MC-Unique: shn4UVASOrimpdvyjQ-Ieg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B4D1005D44;
        Tue,  5 Jan 2021 02:20:28 +0000 (UTC)
Received: from T590 (ovpn-13-45.pek2.redhat.com [10.72.13.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A882E6F94E;
        Tue,  5 Jan 2021 02:20:22 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:20:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared
 in hctx_may_queue
Message-ID: <20210105022017.GA3594357@T590>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 04, 2021 at 10:41:36AM +0000, John Garry wrote:
> On 27/12/2020 11:34, Ming Lei wrote:
> > In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
> > q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.
> > 
> > So fix it.
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> > Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> > ---
> >   block/blk-mq.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index c1458d9502f1..3616453ca28c 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -304,7 +304,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
> >   		struct request_queue *q = hctx->queue;
> >   		struct blk_mq_tag_set *set = q->tag_set;
> > -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &q->queue_flags))
> > +		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> 
> I wonder how this ever worked properly, as BLK_MQ_S_TAG_ACTIVE is bit index
> 1, and for q->queue_flags that means QUEUE_FLAG_DYING bit, which I figure is
> not set normally..

It always return true, and might just take a bit more CPU especially the tag queue
depth of magsas_raid and hisi_sas_v3 is quite high.

Thanks,
Ming


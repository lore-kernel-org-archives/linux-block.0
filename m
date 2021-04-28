Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B2C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 00:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E64A61401
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 00:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhD1AIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 20:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237104AbhD1AIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 20:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619568470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZsmYhCuHp1hFHjSy9V32ap7TaQ8LBlpLfQl9JtaTMw=;
        b=e4RQlc4ixF+V9ZFgbuN5BVcedOotHiJ+uhIEy3n0criRQ+WWJc2kkU6gAYZ/RpHHdoLPuk
        AnGQzHgTmv5OMIM0mv9ouZODOmdnCGoouRMdDeCL1C0jZatF+KWDCRZ95OupLnIBhj7ewj
        G2cI2KUHh//GbSnoT2F7BTfYKtZVxnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-1joyMRP0PhezsqBCmXEalA-1; Tue, 27 Apr 2021 20:07:49 -0400
X-MC-Unique: 1joyMRP0PhezsqBCmXEalA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E17139126F;
        Wed, 28 Apr 2021 00:07:47 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E1FA5D6D5;
        Wed, 28 Apr 2021 00:07:39 +0000 (UTC)
Date:   Wed, 28 Apr 2021 08:07:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V3 2/3] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
Message-ID: <YIinU8pb2RzzNxLi@T590>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
 <20210427151058.2833168-3-ming.lei@redhat.com>
 <ce2f315d-ffa8-8327-0633-01c06a2c23fe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2f315d-ffa8-8327-0633-01c06a2c23fe@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 27, 2021 at 01:17:06PM -0700, Bart Van Assche wrote:
> On 4/27/21 8:10 AM, Ming Lei wrote:
> > +void blk_mq_put_rq_ref(struct request *rq)
> > +{
> > +	if (is_flush_rq(rq, rq->mq_hctx))
> > +		rq->end_io(rq, 0);
> > +	else if (refcount_dec_and_test(&rq->ref))
> > +		__blk_mq_free_request(rq);
> > +}
> 
> The above function needs more work. blk_mq_put_rq_ref() may be called from
> multiple CPUs concurrently and hence must handle concurrent calls safely.
> The flush .end_io callbacks have not been designed to handle concurrent
> calls.

static void flush_end_io(struct request *flush_rq, blk_status_t error)
{
        struct request_queue *q = flush_rq->q;
        struct list_head *running;
        struct request *rq, *n;
        unsigned long flags = 0;
        struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);

        /* release the tag's ownership to the req cloned from */
        spin_lock_irqsave(&fq->mq_flush_lock, flags);

        if (!refcount_dec_and_test(&flush_rq->ref)) {
                fq->rq_status = error;
                spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
                return;
        }
		...
		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
}

Both spin lock and refcount_dec_and_test() are called at the beginning of
flush_end_io(), so it is absolutely reliable in case of concurrent
calls.

Otherwise, it is simply one issue between normal completion and timeout
since the pattern in this patch is same with timeout.

Or do I miss something?


Thanks,
Ming


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7468C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA760EE5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhJRJK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhJRJKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634548083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYhE5y9SYVehwomW1tK9izimp0Fp9sjsJ29UQfuMIu8=;
        b=J/0TLWh7Vq0dhNdJ5/Dp7Rck7YKlqRp5IIFX4Nw4r06x85uyM4TEcuQnBn3n0i40szVVRC
        KgathynRZUc2I1A6BVUB2RIGZAuOnS5KlwW2mX8z3gOY/6CfiJNiUPEjxV+/KtQwO+AYuf
        0+1a4rH645wElAZwnW1a1SJDAa2LA9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-tJPLIy7HOfiOON5Vde2j8Q-1; Mon, 18 Oct 2021 05:08:00 -0400
X-MC-Unique: tJPLIy7HOfiOON5Vde2j8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBCEA40C0;
        Mon, 18 Oct 2021 09:07:58 +0000 (UTC)
Received: from T590 (ovpn-8-37.pek2.redhat.com [10.72.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9B3794A0;
        Mon, 18 Oct 2021 09:07:45 +0000 (UTC)
Date:   Mon, 18 Oct 2021 17:07:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-ID: <YW05XGjO8KfYp9xp@T590>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590>
 <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
 <YWay/n+BJTLm1Alb@T590>
 <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
 <YWbtRm22vohvY0Ca@T590>
 <7e142559-1c96-8d84-081a-378c1f6d1306@huawei.com>
 <1065f517-c94b-5a47-34f6-52015b3ef907@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065f517-c94b-5a47-34f6-52015b3ef907@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 09:08:57AM +0100, John Garry wrote:
> On 13/10/2021 16:13, John Garry wrote:
> > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > index 72a2724a4eee..2a2ad6dfcc33 100644
> > > --- a/block/blk-mq-tag.c
> > > +++ b/block/blk-mq-tag.c
> > > @@ -232,8 +232,9 @@ static bool bt_iter(struct sbitmap *bitmap,
> > > unsigned int bitnr, void *data)
> > >       if (!rq)
> > >           return true;
> > > -    if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> > > -        ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> > > +    if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
> > > +                blk_mq_is_shared_tags(hctx->flags)))
> > > +        ret = iter_data->fn(rq->mq_hctx, rq, iter_data->data, reserved);
> > >       blk_mq_put_rq_ref(rq);
> > >       return ret;
> > >   }
> > > @@ -460,6 +461,9 @@ void blk_mq_queue_tag_busy_iter(struct
> > > request_queue *q, busy_iter_fn *fn,
> > >           if (tags->nr_reserved_tags)
> > >               bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
> > >           bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
> > > +
> > > +        if (blk_mq_is_shared_tags(hctx->flags))
> > > +            break;
> > >       }
> > >       blk_queue_exit(q);
> > >   }
> > > 
> > 
> > I suppose that is ok, and means that we iter once.
> > 
> > However, I have to ask, where is the big user of
> > blk_mq_queue_tag_busy_iter() coming from? I saw this from Kashyap's
> > mail:
> > 
> >  > 1.31%     1.31%  kworker/57:1H-k  [kernel.vmlinux]
> >  >       native_queued_spin_lock_slowpath
> >  >       ret_from_fork
> >  >       kthread
> >  >       worker_thread
> >  >       process_one_work
> >  >       blk_mq_timeout_work
> >  >       blk_mq_queue_tag_busy_iter
> >  >       bt_iter
> >  >       blk_mq_find_and_get_req
> >  >       _raw_spin_lock_irqsave
> >  >       native_queued_spin_lock_slowpath
> > 
> > How or why blk_mq_timeout_work()?
> 
> Just some update: I tried hisi_sas with 10x SAS SSDs, megaraid sas with 1x
> SATA HDD (that's all I have), and null blk with lots of devices, and I still
> can't see high usage of blk_mq_queue_tag_busy_iter().

It should be triggered easily in case of heavy io accounting:

while true; do cat /proc/diskstats; done


> So how about we get this patch processed (to fix blk_mq_tagset_busy_iter()),
> as it is independent of blk_mq_queue_tag_busy_iter()? And then wait for some
> update or some more info from Kashyap regarding blk_mq_queue_tag_busy_iter()

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


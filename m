Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3835AC433B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 11:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B9261185
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 11:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhEDLpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 07:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbhEDLpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 May 2021 07:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620128649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QU9ihjLOet5kIKVF+koaJjcljy5cIb20fT3nMkZe3gw=;
        b=b6cxF1HKTKEeUM2YprsLscsXiVZXDA2Eh+3ddR/UpsKgOUIGVwLKa3nt6BwyqmxrmPbSFE
        3Ua/9BYJ1F3gf38L/kRFjRWDBaUtdTt/NNJsvXnALCrKGnqHiA40QAoLAeTtsJ6fQvBvDT
        cEUuDIee8cjFCAyjVkRNxNYsczzhWg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Fh6b55hFNVmNTccbl0cLWg-1; Tue, 04 May 2021 07:44:05 -0400
X-MC-Unique: Fh6b55hFNVmNTccbl0cLWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60F5F8030D5;
        Tue,  4 May 2021 11:44:03 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBD65C1B4;
        Tue,  4 May 2021 11:43:55 +0000 (UTC)
Date:   Tue, 4 May 2021 19:43:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Message-ID: <YJEzd8IYtw4GXrlT@T590>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 04, 2021 at 11:15:37AM +0100, John Garry wrote:
> On 29/04/2021 03:34, Ming Lei wrote:
> > Hi Jens,
> > 
> > This patchset fixes the request UAF issue by one simple approach,
> > without clearing ->rqs[] in fast path.
> > 
> > 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> > and release it after calling ->fn, so ->fn won't be called for one
> > request if its queue is frozen, done in 2st patch
> > 
> > 2) clearing any stale request referred in ->rqs[] before freeing the
> > request pool, one per-tags spinlock is added for protecting
> > grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> > in bt_tags_iter() is avoided, done in 3rd patch.
> > 
> 
> I had a go at testing this. Without any modifications for testing, it looks
> ok.
> 
> However I also tested by adding an artificial delay in bt_iter() - otherwise
> it may not be realistic to trigger some UAF issues in sane timeframes.
> 
> So I made this change:
> 
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -215,8 +215,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned
> int bitnr, void *data)
>          * We can hit rq == NULL here, because the tagging functions
>          * test and set the bit before assigning ->rqs[].
>          */
> -       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> -               return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +       if (rq) {
> +               mdelay(50);
> +               if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> +   		  return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +       }
>         return true;
>  }

hammmm, forget to cover bt_iter(), please test the following delta
patch:


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a3be267212b9..27815114ee3f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -206,18 +206,28 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_tags *tags = hctx->tags;
 	bool reserved = iter_data->reserved;
 	struct request *rq;
+	unsigned long flags;
+	bool ret = true;
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
 
+	spin_lock_irqsave(&tags->lock, flags);
+	rq = tags->rqs[bitnr];
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
-		return iter_data->fn(hctx, rq, iter_data->data, reserved);
-	return true;
+	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
+		spin_unlock_irqrestore(&tags->lock, flags);
+		return true;
+	}
+	spin_unlock_irqrestore(&tags->lock, flags);
+
+	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
+	blk_mq_put_rq_ref(rq);
+	return ret;
 }
 
 /**

Thanks, 
Ming


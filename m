Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FDEC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 00:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15ECB61380
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 00:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhDFAY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhDFAY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 20:24:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315FC06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 17:24:19 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g15so13320797qkl.4
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 17:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YFSt9qq0EKxWDMwfjpnzof5AILcExopERcoXpZrDYo=;
        b=eBv+o0hJ39RDs7D3pXRkHCf09PTtQBjYAv/QJj9GRMqO63imfIjaq58enzTPvf9NQZ
         UPbM3KpL11EnJBIwQv2ew9+XfSUFzj62jKiWS/s01rmcy34BdGqzGupC+XUhFBv7eDzr
         o7oae6h7kT1RzAiwx1EwJOjvkI1qJTt3oyrzbH0966DNvj0ad9B/ue82krdLxf0a5ZFx
         LoFlob0eeSOTsCqmGeG91ZIW8O4tx6WA4HReCoZNzYFNP51yjE6QoFW24DwSXlnXdakJ
         +8ZAmrr/coAiqU0YmM931flAG8dWdu+m7jjQWdbR1AZ00cTxj4uCkUnWTSPpVgvL3nD4
         R89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YFSt9qq0EKxWDMwfjpnzof5AILcExopERcoXpZrDYo=;
        b=mcrz9kFFUCdcX3CDWtFySZvHMiSaGESWY2a65Dt3cM/NnP1k96h4hB1LHyPHYfnRsn
         Cj6DOjiFNHzsempi2yA+vvt5NTHl62o/px1h3nzIA2/eznfrCn2X1Aq9r5v1GTaZxXS5
         n8hIaQolvx27z8HA+8rbCf1SlaZ1uorTwPJ4f/YdGhkyDaAhEAgnyWqy2GETl8CDY++U
         V9z6HmBBML3tOLZ8SstDztV7dHC2K0nh7Zd87+oiRW5uaEF4ce2rKHdqr8s+EOjm/r92
         BRr0zesTmkBjaalNasdGrk4Ty2WvCX8Vx5hZQHubfaLDIJDvZfCnM8Gvb8gWi0r2ezCt
         rdZg==
X-Gm-Message-State: AOAM53378Y16fRJAubrzPjVUkyF2HecZnAitJovYD7YWiznS5Zjwk6+6
        9MwFJCnOFTMhoz+4t62/U8nn1dxn8RllEs8rS8rXrA==
X-Google-Smtp-Source: ABdhPJyfkoH+jSL51+8istiFrp/10xTVCX7AdAlaF9tOJ8DbAU86FfdiW2u/6+mWD+ZXHtAjA+TJrmJmGlYnzBy3WM4=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr25888424qkx.501.1617668658043;
 Mon, 05 Apr 2021 17:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210405002834.32339-1-bvanassche@acm.org> <20210405002834.32339-4-bvanassche@acm.org>
 <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com> <9e13694e-9888-1938-953b-ffceabd2e35d@acm.org>
In-Reply-To: <9e13694e-9888-1938-953b-ffceabd2e35d@acm.org>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 5 Apr 2021 17:24:06 -0700
Message-ID: <CACGdZYJaBtK9-chc_wf4+KJmTVKhJ9T-G5sXkeqT=HuA78ye+A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c3b40105bf42d5cb"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000c3b40105bf42d5cb
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 5, 2021 at 2:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/5/21 11:08 AM, Khazhy Kumykov wrote:
> > On Sun, Apr 4, 2021 at 5:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> >> index 116c3691b104..e7a6a114d216 100644
> >> --- a/block/blk-mq-tag.c
> >> +++ b/block/blk-mq-tag.c
> >> @@ -209,7 +209,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >>
> >>         if (!reserved)
> >>                 bitnr += tags->nr_reserved_tags;
> >> -       rq = tags->rqs[bitnr];
> >> +       /*
> >> +        * Protected by rq->q->q_usage_counter. See also
> >> +        * blk_mq_queue_tag_busy_iter().
> >> +        */
> >> +       rq = rcu_dereference_check(tags->rqs[bitnr], true);
> >
> > maybe I'm missing something, but if this tags struct has a shared
> > sbitmap, what guarantees do we have that while iterating we won't
> > touch requests from a queue that's tearing down? The check a few lines
> > below suggests that at the least we may touch requests from a
> > different queue.
> >
> > say we enter blk_mq_queue_tag_busy_iter, we're iterating with raised
> > hctx->q->q_usage_counter, and get to bt_iter
> >
> > say tagset has 2 shared queues, hctx->q is q1, rq->q is q2
> > (thread 1)
> > rq = rcu_deref_check
> > (rq->q != hctx->q, but we don't know yet)
> >
> > (thread 2)
> > elsewhere, blk_cleanup_queue(q2) runs (or elevator_exit), since we
> > only have raised q_usage_counter on q1, this goes to completion and
> > frees rq. if we have preempt kernel, thread 1 may be paused before we
> > read rq->q, so synchonrize_rcu passes happily by
> >
> > (thread 1)
> > we check rq && rq->q == hctx->q, use-after-free since rq was freed above
> >
> > I think John Garry mentioned observing a similar race in patch 2 of
> > his series, perhaps his test case can verify this?
> >
> > "Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
> > queue usage counter when called, and the queue cannot be frozen to switch
> > IO scheduler until all refs are dropped. This ensures no stale references
> > to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().
> >
> > However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
> > run for another queue associated with the same tagset, and it seeing
> > a stale IO scheduler request from the other queue after they are freed."
> >
> > so, to my understanding, we have a race between reading
> > tags->rq[bitnr], and verifying that rq->q == hctx->q, where if we
> > schedule off we might have use-after-free? If that's the case, perhaps
> > we should rcu_read_lock until we verify the queues match, then we can
> > release and run fn(), as we verified we no longer need it?
>
> Hi Khazhy,
>
> One possibility is indeed to protect the RCU dereference and the rq->q
> read with an RCU reader lock. However, that would require an elaborate
> comment since that would be a creative way to use RCU: protect the
> request pointer dereference with an RCU reader lock until rq->q has been
> tested and protect the remaining time during which rq is used with
> q_usage_counter.
>
> Another possibility is the patch below (needs to be split). That patch
> protects the entire time during which rq is used by bt_iter() with either
> an RCU reader lock or with the iter_rwsem semaphores. Do you perhaps have
> a preference for one of these two approaches?

to my eye the "creative" rcu_read_lock would be unusual, but should
require not much more justification than an rcu_dereference_check
without read_lock, but I would defer what constitutes smelly code to
those more experienced :) Part of why I suggested this was since it
does seem we can avoid needing to define and reason about an _atomic()
variant, and results in a smaller critical section (though this isn't
the hotpath)





>
> Thanks,
>
> Bart.
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index e7a6a114d216..a997fc2aa2bc 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -209,12 +209,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>
>         if (!reserved)
>                 bitnr += tags->nr_reserved_tags;
> -       /*
> -        * Protected by rq->q->q_usage_counter. See also
> -        * blk_mq_queue_tag_busy_iter().
> -        */
> -       rq = rcu_dereference_check(tags->rqs[bitnr], true);
> -
> +       rq = rcu_dereference_check(tags->rqs[bitnr],
> +                                  lockdep_is_held(&tags->iter_rwsem));
>         /*
>          * We can hit rq == NULL here, because the tagging functions
>          * test and set the bit before assigning ->rqs[].
> @@ -453,6 +449,63 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
>  }
>  EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>
> +static void __blk_mq_queue_tag_busy_iter(struct request_queue *q,
> +                                        busy_iter_fn *fn, void *priv)
> +{
> +       struct blk_mq_hw_ctx *hctx;
> +       int i;
> +
> +       queue_for_each_hw_ctx(q, hctx, i) {
> +               struct blk_mq_tags *tags = hctx->tags;
> +
> +               /*
> +                * If no software queues are currently mapped to this
> +                * hardware queue, there's nothing to check
> +                */
> +               if (!blk_mq_hw_queue_mapped(hctx))
> +                       continue;
> +
> +               if (tags->nr_reserved_tags)
> +                       bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
> +               bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
> +       }
> +}
> +
> +/**
> + * blk_mq_queue_tag_busy_iter_atomic - iterate over all requests with a driver tag
> + * @q:         Request queue to examine.
> + * @fn:                Pointer to the function that will be called for each request
> + *             on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
> + *             reserved) where rq is a pointer to a request and hctx points
> + *             to the hardware queue associated with the request. 'reserved'
> + *             indicates whether or not @rq is a reserved request. @fn must
> + *             not sleep.
> + * @priv:      Will be passed as third argument to @fn.
> + *
> + * Note: if @q->tag_set is shared with other request queues then @fn will be
> + * called for all requests on all queues that share that tag set and not only
> + * for requests associated with @q.
> + *
> + * Does not sleep.
> + */
> +void blk_mq_queue_tag_busy_iter_atomic(struct request_queue *q,
> +                                      busy_iter_fn *fn, void *priv)
> +{
> +       /*
> +        * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
> +        * while the queue is frozen. So we can use q_usage_counter to avoid
> +        * racing with it.
> +        */
> +       if (!percpu_ref_tryget(&q->q_usage_counter))
> +               return;
> +
> +       rcu_read_lock();
> +       __blk_mq_queue_tag_busy_iter(q, fn, priv);
> +       rcu_read_unlock();
> +
> +       blk_queue_exit(q);
> +}
> +
>  /**
>   * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
>   * @q:         Request queue to examine.
> @@ -466,13 +519,18 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>   * Note: if @q->tag_set is shared with other request queues then @fn will be
>   * called for all requests on all queues that share that tag set and not only
>   * for requests associated with @q.
> + *
> + * May sleep.
>   */
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>                 void *priv)
>  {
> -       struct blk_mq_hw_ctx *hctx;
> +       struct blk_mq_tag_set *set = q->tag_set;
> +       struct blk_mq_tags *tags;
>         int i;
>
> +       might_sleep();
> +
>         /*
>          * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
>          * while the queue is frozen. So we can use q_usage_counter to avoid
> @@ -481,20 +539,19 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>         if (!percpu_ref_tryget(&q->q_usage_counter))
>                 return;
>
> -       queue_for_each_hw_ctx(q, hctx, i) {
> -               struct blk_mq_tags *tags = hctx->tags;
> -
> -               /*
> -                * If no software queues are currently mapped to this
> -                * hardware queue, there's nothing to check
> -                */
> -               if (!blk_mq_hw_queue_mapped(hctx))
> -                       continue;
>
> -               if (tags->nr_reserved_tags)
> -                       bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
> -               bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
> +       for (i = 0; i < set->nr_hw_queues; i++) {
> +               tags = set->tags[i];
> +               if (tags)
> +                       down_read(&tags->iter_rwsem);
>         }
> +       __blk_mq_queue_tag_busy_iter(q, fn, priv);
> +       for (i = set->nr_hw_queues - 1; i >= 0; i--) {
> +               tags = set->tags[i];
> +               if (tags)
> +                       up_read(&tags->iter_rwsem);
> +       }
> +
>         blk_queue_exit(q);
>  }
>
> @@ -576,7 +633,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>
>         tags->nr_tags = total_tags;
>         tags->nr_reserved_tags = reserved_tags;
> -       init_rwsem(&tags->iter_rwsem);
> +       lockdep_register_key(&tags->iter_rwsem_key);
> +       __init_rwsem(&tags->iter_rwsem, "tags->iter_rwsem",
> +                    &tags->iter_rwsem_key);
>
>         if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
>                 return tags;
> @@ -594,6 +653,7 @@ void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
>                 sbitmap_queue_free(tags->bitmap_tags);
>                 sbitmap_queue_free(tags->breserved_tags);
>         }
> +       lockdep_unregister_key(&tags->iter_rwsem_key);
>         kfree(tags);
>  }
>
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index d1d73d7cc7df..e37f219bd36a 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -22,6 +22,7 @@ struct blk_mq_tags {
>         struct list_head page_list;
>
>         struct rw_semaphore iter_rwsem;
> +       struct lock_class_key iter_rwsem_key;
>  };
>
>  extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
> @@ -43,6 +44,8 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
>                                              unsigned int size);
>
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
> +void blk_mq_queue_tag_busy_iter_atomic(struct request_queue *q,
> +               busy_iter_fn *fn, void *priv);
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>                 void *priv);
>  void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d6c9b655c0f5..f5e1ace273e2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -117,7 +117,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
>  {
>         struct mq_inflight mi = { .part = part };
>
> -       blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_check_inflight, &mi);
>
>         return mi.inflight[0] + mi.inflight[1];
>  }
> @@ -127,7 +127,7 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
>  {
>         struct mq_inflight mi = { .part = part };
>
> -       blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_check_inflight, &mi);
>         inflight[0] = mi.inflight[0];
>         inflight[1] = mi.inflight[1];
>  }
> @@ -881,7 +881,7 @@ bool blk_mq_queue_inflight(struct request_queue *q)
>  {
>         bool busy = false;
>
> -       blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
> +       blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_rq_inflight, &busy);
>         return busy;
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);

--000000000000c3b40105bf42d5cb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNEwggO5oAMCAQICEAH+DkXtUaeOlUVJH2IZ
1xgwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMTAyMDYw
MDA5MzdaFw0yMTA4MDUwMDA5MzdaMCIxIDAeBgkqhkiG9w0BCQEWEWtoYXpoeUBnb29nbGUuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmm+puzvFjpH8jnr1tILPanikSp/NkKoR
1gAt7WoAjhldVh+JSHA5NwNnRgT8fO3hzseCe0YkY5Yz6BkOT26gg25NqElMbsdXKZEBHnHLbc0U
5xUwqOTxn1hFtOrp37lHMoMn2ZfPQ7CffSp36KrzHqFhSTZRRG2KzxV4DMwljydy1ZVQ1Mfde/kH
T7u1D0Qh6iBF1su2maouE1ar4DmyAUiyrqSbXyxWQxAEgDZoFmLLB5YdOqLS66e+sRM3HILR/hBd
y8W4UK5tpca7q/ZkY+iRF7Pl5fZLoZWveUKd/R5mkaZbWT555TEK1fsgpWIfiBc+EGlRcH9SK2lk
mDd1gQIDAQABo4IBzzCCAcswHAYDVR0RBBUwE4ERa2hhemh5QGdvb2dsZS5jb20wDgYDVR0PAQH/
BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAdBgNVHQ4EFgQUTtQGv0mu/SX8
MEvaI7F4ZN2DM20wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAIKZMQsUIWBTlSa6tHLU5L8W
YVOXfTkEXU6aeq8JjYjcj1fQD+1K0EQhvwz6SB5I0NhqfMLyQBUZHJXChsLGygbCqXbmBF143+sK
xsY5En+KQ03HHHn8pmLHFMAgvO2f8cJyJD3cBi8nMNRia/ZMy2jayQPOiiK34RpcoyXr80KWUZQh
iqPea7dSkHy8G0Vjeo4vj+RQBse+NKpyEzJilDUVpd5x307jeFjYBp2fLWt0UAZ8P2nUeSPjC2fF
kGXeiYWeVPpQCSzowcRluUVFrKApZDZpm3Ly7a5pMVFQ23m2Waaup/DHnJkgxlRQRbcxDhqLKrJj
tATPzBYapBLXne4xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAH+
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGtUETiL68FI
WHW8oo1ZpeJvTv/JzHFCf8JnGPzdTFIKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQwNjAwMjQxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqh2qIsl53zsj7gEe645nVNqZvOxC3
eo9/pzAreiiwXvdIWPaaebU/UU07z+mpMQq6ndmJvOS9Y9/Kkcx4E/PF3Syn9HFYwX+y6xW2IjTW
6j3XMWMmZ1ERcVtsP8TFWBOKMDwREAgx4mqtL0alzzOC+1MN27ys6Xy0Zx0bSfefwJhtjdxzGwzb
zk2c6vwmWzK5UOOA1rMvmrdbKGATTLa4ScwJb+t+btnb0MhzcWirFG+fyebqjGgE5rZ09ytbUOvJ
E6F38XxTyhjrxVZF1h5gho7Wwvj9WJFFb6qVx++tw4AeQi1KxCYUZNznvWoPdS+9ffOppVqC2IrI
rt/e37q6
--000000000000c3b40105bf42d5cb--

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E695C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A66E61103
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhDGADO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhDGADO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 20:03:14 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A7C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 17:03:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o11so3899976qvh.11
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE318e6zQCzTzDoM8vJ0fZtFz3E4b6aNba6zOSxfSps=;
        b=LAP3wsHOJSKsUiQ9DsrPeYPA+TG+N/1nk0HZsZOhg3OplYJaiOa6Rp4Kuh+OJbeeeq
         wGezlyxTsUVcGQ88h7gNejlueJZplgCQaj2Dj/5Eq+WHc4BHRHlq0DKbNuecrR9Zvehu
         The6SdSFUbV9m9OZ79EHgjRySCYNLsamiLVyjEjf8YuqMe7pi40Gxy7OEHtP5/6Xhna/
         9T17RAm6rJ2HqCvPkY/iOzCRXviYbgbyyTDgrG9T8BedZxpVtOJsO8mkDz+23BztBI60
         ThYZza3KjEewAmfLMdovR/7XeyU6jlGcrBTdcybf2VSnCqbcrYy/l+DBryMzalOBvZNQ
         GHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE318e6zQCzTzDoM8vJ0fZtFz3E4b6aNba6zOSxfSps=;
        b=pYDkP3KpWh81QDgyBnY8fp76F6FSI3jYDDGAhmZLX99TNxw6irH/509FoDsdaJT8wh
         bhEIgbEvXXPjXw4/V1pT/OxFNPuNxI19sXFpWhU516ywvX00FebLwZyxWWHyI16mRu2p
         EfS1WMXAiP9OaSLIgNwX2hh3ZKtqrrE8td5FQuo56gzRB4CpQ17E0jvtck0EYcEVwoow
         1+qA42pvM15gxMMnMFeoDHRzHCbmi4NFlioTIwxONs3YF7jvNkP54try2NwQwkjbJs/8
         OE1/uHozU8h7r6TSHmFYvBSiTN5/RibWr0GhDI3UPGi6Dn39WFmTTNz+AxubmigyjacZ
         VEwg==
X-Gm-Message-State: AOAM530jcw211MxincvHK3+htbjGUIhgpayj/7Ab608Dy6jptQklK+Jq
        3o6nhajuNAcFEJbL7mgC+G2WJw96WrxJUzN28oyraA==
X-Google-Smtp-Source: ABdhPJyn8aS8+Jmg/Hp2d4RoKWZpuQePVnloUmHyQoPKku+qJ9Lb9+mxGKlda38xHnKXhM2D5JapAsmRh+UXYReLxSo=
X-Received: by 2002:a0c:ed50:: with SMTP id v16mr694602qvq.54.1617753784899;
 Tue, 06 Apr 2021 17:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210406214905.21622-1-bvanassche@acm.org> <20210406214905.21622-4-bvanassche@acm.org>
In-Reply-To: <20210406214905.21622-4-bvanassche@acm.org>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 6 Apr 2021 17:02:53 -0700
Message-ID: <CACGdZYKALg4GiXza+hnhay=XbBif3v5fV7Q=AJNUE-imw=t2yQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b68b4305bf56a794"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000b68b4305bf56a794
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 6, 2021 at 2:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> When multiple request queues share a tag set and when switching the I/O
> scheduler for one of the request queues associated with that tag set, the
> following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
>   a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.
>
> Fix this race as follows:
> * Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
>   The performance impact of the assignments added to the hot path is minimal
>   (about 1% according to one particular test).
> * Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
>   semaphore. Which mechanism is used depends on whether or not it is allowed
>   to sleep and also on whether or not the callback function may sleep.
> * Wait for all preexisting readers to finish before freeing scheduler
>   requests.
>
> Another race is as follows:
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_queue_tag_busy_iter() iterates over the same tag set but for another
>   request queue than the queue for which scheduler tags are being freed.
> * bt_iter() examines rq->q after *rq has been freed.
>
> Fix this race by protecting the rq->q read in bt_iter() with an RCU read
> lock and by calling synchronize_rcu() before freeing scheduler tags.
>
> Multiple users have reported use-after-free complaints similar to the
> following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/ ):
>
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
>
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-core.c   | 34 ++++++++++++++++++++++++++++++-
>  block/blk-mq-tag.c | 51 ++++++++++++++++++++++++++++++++++++++++------
>  block/blk-mq-tag.h |  4 +++-
>  block/blk-mq.c     | 21 +++++++++++++++----
>  block/blk-mq.h     |  1 +
>  block/blk.h        |  2 ++
>  block/elevator.c   |  1 +
>  7 files changed, 102 insertions(+), 12 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9bcdae93f6d4..ca7f833e25a8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
>  }
>  EXPORT_SYMBOL(blk_dump_rq_flags);
>
> +/**
> + * blk_mq_wait_for_tag_iter - wait for preexisting tag iteration functions to finish
> + * @set: Tag set to wait on.
> + *
> + * Waits for preexisting calls of blk_mq_all_tag_iter(),
> + * blk_mq_tagset_busy_iter() and also for their atomic variants to finish
> + * accessing hctx->tags->rqs[]. New readers may start while this function is
> + * in progress or after this function has returned. Use this function to make
> + * sure that hctx->tags->rqs[] changes have become globally visible.
> + *
> + * Waits for preexisting blk_mq_queue_tag_busy_iter(q, fn, priv) calls to
> + * finish accessing requests associated with other request queues than 'q'.
> + */
> +void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
> +{
> +       struct blk_mq_tags *tags;
> +       int i;
> +
> +       if (set->tags) {
> +               for (i = 0; i < set->nr_hw_queues; i++) {
> +                       tags = set->tags[i];
> +                       if (!tags)
> +                               continue;
> +                       down_write(&tags->iter_rwsem);
> +                       up_write(&tags->iter_rwsem);
> +               }
> +       }
> +       synchronize_rcu();
> +}
> +
>  /**
>   * blk_sync_queue - cancel any pending callbacks on a queue
>   * @q: the queue
> @@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
>          * it is safe to free requests now.
>          */
>         mutex_lock(&q->sysfs_lock);
> -       if (q->elevator)
> +       if (q->elevator) {
> +               blk_mq_wait_for_tag_iter(q->tag_set);
>                 blk_mq_sched_free_requests(q);
> +       }
>         mutex_unlock(&q->sysfs_lock);
>
>         percpu_ref_exit(&q->q_usage_counter);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d8eaa38a1bd1..a73e81d75fb8 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -209,14 +209,24 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>
>         if (!reserved)
>                 bitnr += tags->nr_reserved_tags;
> -       rq = tags->rqs[bitnr];
> -
> +       rcu_read_lock();
> +       /*
> +        * The request 'rq' points at is protected by an RCU read lock until
> +        * its queue pointer has been verified and by q_usage_count while the
> +        * callback function is being invoked. an See also the
extra "an"?
> +        * percpu_ref_tryget() and blk_queue_exit() calls in
> +        * blk_mq_queue_tag_busy_iter().
> +        */
> +       rq = rcu_dereference(tags->rqs[bitnr]);
>         /*
>          * We can hit rq == NULL here, because the tagging functions
>          * test and set the bit before assigning ->rqs[].
>          */
> -       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> +       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx) {
> +               rcu_read_unlock();
>                 return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +       }
> +       rcu_read_unlock();
>         return true;
>  }
>
> @@ -254,11 +264,17 @@ struct bt_tags_iter_data {
>         unsigned int flags;
>  };
>
> +/* Include reserved tags. */
>  #define BT_TAG_ITER_RESERVED           (1 << 0)
> +/* Only include started requests. */
>  #define BT_TAG_ITER_STARTED            (1 << 1)
> +/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
>  #define BT_TAG_ITER_STATIC_RQS         (1 << 2)
> +/* The callback function may sleep. */
> +#define BT_TAG_ITER_MAY_SLEEP          (1 << 3)
>
> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
> +                          void *data)
>  {
>         struct bt_tags_iter_data *iter_data = data;
>         struct blk_mq_tags *tags = iter_data->tags;
> @@ -275,7 +291,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>         if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>                 rq = tags->static_rqs[bitnr];
>         else
> -               rq = tags->rqs[bitnr];
> +               rq = rcu_dereference_check(tags->rqs[bitnr],
> +                                          lockdep_is_held(&tags->iter_rwsem));
>         if (!rq)
>                 return true;
>         if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> @@ -284,6 +301,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>         return iter_data->fn(rq, iter_data->data, reserved);
>  }
>
> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> +{
> +       struct bt_tags_iter_data *iter_data = data;
> +       struct blk_mq_tags *tags = iter_data->tags;
> +       bool res;
> +
> +       if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
> +               down_read(&tags->iter_rwsem);
> +               res = __bt_tags_iter(bitmap, bitnr, data);
> +               up_read(&tags->iter_rwsem);
> +       } else {
> +               rcu_read_lock();
> +               res = __bt_tags_iter(bitmap, bitnr, data);
> +               rcu_read_unlock();
> +       }
> +
> +       return res;
> +}
> +
>  /**
>   * bt_tags_for_each - iterate over the requests in a tag map
>   * @tags:      Tag map to iterate over.
> @@ -357,10 +393,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  {
>         int i;
>
> +       might_sleep();
> +
>         for (i = 0; i < tagset->nr_hw_queues; i++) {
>                 if (tagset->tags && tagset->tags[i])
>                         __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> -                                             BT_TAG_ITER_STARTED);
> +                               BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
>         }
>  }
>  EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> @@ -544,6 +582,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>
>         tags->nr_tags = total_tags;
>         tags->nr_reserved_tags = reserved_tags;
> +       init_rwsem(&tags->iter_rwsem);
>
>         if (blk_mq_is_sbitmap_shared(flags))
>                 return tags;
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 0290c308ece9..d1d73d7cc7df 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -17,9 +17,11 @@ struct blk_mq_tags {
>         struct sbitmap_queue __bitmap_tags;
>         struct sbitmap_queue __breserved_tags;
>
> -       struct request **rqs;
> +       struct request __rcu **rqs;
>         struct request **static_rqs;
>         struct list_head page_list;
> +
> +       struct rw_semaphore iter_rwsem;
>  };
>
>  extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5b170faa6318..d6c9b655c0f5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -495,8 +495,10 @@ static void __blk_mq_free_request(struct request *rq)
>         blk_crypto_free_request(rq);
>         blk_pm_mark_last_busy(rq);
>         rq->mq_hctx = NULL;
> -       if (rq->tag != BLK_MQ_NO_TAG)
> +       if (rq->tag != BLK_MQ_NO_TAG) {
>                 blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> +               rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> +       }
>         if (sched_tag != BLK_MQ_NO_TAG)
>                 blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
>         blk_mq_sched_restart(hctx);
> @@ -838,9 +840,20 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>  {
> +       struct request *rq;
> +
>         if (tag < tags->nr_tags) {
> -               prefetch(tags->rqs[tag]);
> -               return tags->rqs[tag];
> +               /*
> +                * Freeing tags happens with the request queue frozen so the
> +                * rcu dereference below is protected by the request queue
> +                * usage count. We can only verify that usage count after
> +                * having read the request pointer.
> +                */
> +               rq = rcu_dereference_check(tags->rqs[tag], true);
> +               WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rq &&
> +                            percpu_ref_is_zero(&rq->q->q_usage_counter));
> +               prefetch(rq);
> +               return rq;
>         }
>
>         return NULL;
> @@ -1111,7 +1124,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
>                 rq->rq_flags |= RQF_MQ_INFLIGHT;
>                 __blk_mq_inc_active_requests(hctx);
>         }
> -       hctx->tags->rqs[rq->tag] = rq;
> +       rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
>         return true;
>  }
>
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 3616453ca28c..9ccb1818303b 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>                                            struct request *rq)
>  {
>         blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
> +       rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
>         rq->tag = BLK_MQ_NO_TAG;
>
>         if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> diff --git a/block/blk.h b/block/blk.h
> index 2ed6c684d63a..aadf0d82a028 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -185,6 +185,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>  void blk_account_io_start(struct request *req);
>  void blk_account_io_done(struct request *req, u64 now);
>
> +void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set);
> +
>  /*
>   * Internal elevator interface
>   */
> diff --git a/block/elevator.c b/block/elevator.c
> index 4b20d1ab29cc..70a10e31b336 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -201,6 +201,7 @@ static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
>  {
>         lockdep_assert_held(&q->sysfs_lock);
>
> +       blk_mq_wait_for_tag_iter(q->tag_set);
>         blk_mq_sched_free_requests(q);
>         __elevator_exit(q, e);
>  }

--000000000000b68b4305bf56a794
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
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
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
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ7KqiXbDGS7
2OqtNOSI6bmeHw0VAFT4shyfJKUNM09DMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQwNzAwMDMwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAlL9+BNe2NbaR7P6UamGyrn0NzbaXE
vIzKgQiuGFxHBmpw94TydgcAApa2FUOkQjfufrvR4vGtFPM5K71yvLz/xMK/WXhsdQI3LzwkvvJD
e6XDepe4/zapYNAoJV8GK0DppM/+P6BTVHzBbJc1sM8BhaXaWyPVjtWpMxr0/sspS2x6EwgvEnZV
yfiyryyjFbpb3hyNarUx2p3cXeSr+ZfI5Crk9i+UfELsAiZXL2reTmym42UpHSDN0054/vKJ14YL
jJHzNjGv8an2vLHn2ED4cPjLRARmJe0OxEB7awhSBDQlAKUSXKOYEFb9fn2q++LVKHo3ToE2F/Dg
pMhwdt8X
--000000000000b68b4305bf56a794--

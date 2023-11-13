Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B911C6AE
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDt53it2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DECCB
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699873294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FD/xvv1yK4vg5L5HBEnqw1gbn2ej7nJdUQPgpJCrM/k=;
	b=GDt53it2Zd0Y4e/eyiYEKEBt3EaLEeCPvbGomAt1lBoywJd0m2vJ5HED52qmiL/HZ5/S+W
	vxxhHOb0SfkCRzFw5XZRAPZURuBQeZUDQwpW8PCnKzNiqG2ZlggwZMqOEmN4MZVxHOZU1V
	0Drjx4CMfdc3HPNeTDr2SvCHqL+HNcw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-CEz5C61gN_CSaAZ74pF4aw-1; Mon, 13 Nov 2023 06:01:32 -0500
X-MC-Unique: CEz5C61gN_CSaAZ74pF4aw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2806501f8efso5467750a91.2
        for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 03:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699873291; x=1700478091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD/xvv1yK4vg5L5HBEnqw1gbn2ej7nJdUQPgpJCrM/k=;
        b=I41srEqF8yN4u325nZVX+ONTbruxEHgVHSksz+GtnHdPvTFRPW9XKIg+O6BScViAM9
         Th3x6M0dMSZg8z1cR7kTYopqugW+QN+vVKMMkoipRgZVJ1vwsL44OvjInmZfZRBaa6E5
         0Yywm3wd21oAZaItqC5kLFdvNw+/67NSgLrc188dWh5S/Y9n/kVd81pp9DMbfEnFfi8s
         n/7ImZRt8o1MxwUOkqjKWbK3eifvyxKsWRZqIexotvztLP/B5UEDi39uEPtA+Qrzx+HV
         /5x2HSv7iP0o6NvhXtOHAgw5oWo18ss66BmiXb5e24uUvj+rQkLeN3i8BcnRtoK6S0Mg
         /w5w==
X-Gm-Message-State: AOJu0YzJH6XWQwQEUyBV/37VXwLaz8OmNv7Ll1/wQkq5f64O1Bl3sapf
	NgWQlgq1ir6ExB+RpE5kJJ15FeWh7ItEB8N85/6DwWXMhVLlwIYU4T/MKpFgW9S0OcaoomupgjZ
	m3jYzAnyafjf3clSS8pvlXOJ8jj1CuarmJpeZU+fZv/8RDMtxBc3Z
X-Received: by 2002:a17:90a:9109:b0:280:3911:ae02 with SMTP id k9-20020a17090a910900b002803911ae02mr6914475pjo.16.1699873291443;
        Mon, 13 Nov 2023 03:01:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8E/QYvBDLijbcOm0bJQeNU0GzPimhSz7rfGHrQcB5BleXFARyXM7iscHx3Hi3PHWaGLRuG0CXGjdpwj2/5X0=
X-Received: by 2002:a17:90a:9109:b0:280:3911:ae02 with SMTP id
 k9-20020a17090a910900b002803911ae02mr6914451pjo.16.1699873291082; Mon, 13 Nov
 2023 03:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113035231.2708053-1-ming.lei@redhat.com>
In-Reply-To: <20231113035231.2708053-1-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 13 Nov 2023 19:01:19 +0800
Message-ID: <CAHj4cs8QJPdi3jsaArnJ0FbF58NLbDKms7rBgn4Rgpx+CBbOfQ@mail.gmail.com>
Subject: Re: [PATCH V2] blk-mq: make sure active queue usage is held for bio_integrity_prep()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Confirmed the below issue was fixed by this patch.

[  444.752629] nvme nvme0: rescanning namespaces.
[  445.371750] nvme nvme0: resetting controller
[  445.410255] nvme nvme0: Shutdown timeout set to 10 seconds
[  445.418789] nvme nvme0: 12/0/0 default/read/poll queues
[  445.464627] nvme nvme0: rescanning namespaces.
[  446.059207] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[  446.066982] #PF: supervisor read access in kernel mode
[  446.072718] #PF: error_code(0x0000) - not-present page
[  446.078452] PGD 0 P4D 0
[  446.081278] Oops: 0000 [#1] PREEMPT SMP PTI
[  446.085947] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted
6.6.0-rc3+ #1
[  446.094292] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2?Pow, BIOS
2.16.0 07/20/2022
[  446.102934] RIP: 0010:blk_mq_end_request_batch+0xa7/0x4d0
[  446.108972] Code: 10 0f 1f 44 00 00 48 85 db 74 71 8b 45 18 a9 00
00 01 00 74 1e 84 c0 75 1a 48 8b 45 00 44 89 fe 48 89 ef 48 8b 80 b8
00 00 00 <48> 8b 40 18 e8 00 4a 6d 00 44 89 fe 48 89 ef e8 45 de ff ff
eb 05
[  446.129929] RSP: 0018:ffffc90000384e60 EFLAGS: 00010046
[  446.135760] RAX: 0000000000000000 RBX: ffff8881050afa80 RCX: 00000000000=
00018
[  446.143724] RDX: 000003c493936c90 RSI: 0000000000001000 RDI: ffff888120d=
10000
[  446.151688] RBP: ffff888120d10000 R08: 0000000000000000 R09: 00000000000=
00000
[  446.159652] R10: 0000000000000000 R11: 0000000116ca1000 R12: ffffc900003=
84f38
[  446.167615] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
01000
[  446.175578] FS:  0000000000000000(0000) GS:ffff888277c40000(0000)
knlGS:0000000000000000
[  446.184609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  446.191020] CR2: 0000000000000018 CR3: 0000000355e20001 CR4: 00000000001=
706e0
[  446.198982] Call Trace:
[  446.201712]  <IRQ>
[  446.203954]  ? __die+0x20/0x70
[  446.207368]  ? page_fault_oops+0x76/0x170
[  446.211847]  ? kernelmode_fixup_or_oops+0x84/0x110
[  446.217188]  ? exc_page_fault+0x65/0x150
[  446.221571]  ? asm_exc_page_fault+0x22/0x30
[  446.226246]  ? blk_mq_end_request_batch+0xa7/0x4d0
[  446.231601]  nvme_irq+0x7f/0x90 [nvme]
[  446.235799]  ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
[  446.242222]  __handle_irq_event_percpu+0x46/0x190
[  446.247478]  handle_irq_event+0x34/0x70
[  446.251762]  handle_edge_irq+0x87/0x220
[  446.256045]  __common_interrupt+0x3d/0xb0
[  446.260525]  ? irqtime_account_irq+0x3c/0xb0
[  446.265292]  common_interrupt+0x7b/0xa0
[  446.269574]  </IRQ>
[  446.271912]  <TASK>
[  446.274251]  asm_common_interrupt+0x22/0x40


On Mon, Nov 13, 2023 at 11:52=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> From: Christoph Hellwig <hch@infradead.org>
>
> blk_integrity_unregister() can come if queue usage counter isn't held
> for one bio with integrity prepared, so this request may be completed wit=
h
> calling profile->complete_fn, then kernel panic.
>
> Another constraint is that bio_integrity_prep() needs to be called
> before bio merge.
>
> Fix the issue by:
>
> - call bio_integrity_prep() with one queue usage counter grabbed reliably
>
> - call bio_integrity_prep() before bio merge
>
> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submi=
t_bio()")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - remove blk_mq_cached_req()
>         - move blk_mq_attempt_bio_merge() out of blk_mq_can_use_cached_rq=
(),
>           so that &bio isn't needed any more for blk_mq_can_use_cached_rq=
()
>         - all are suggested from Christoph
>
>  block/blk-mq.c | 75 +++++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..900c1be1fee1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2858,11 +2858,8 @@ static struct request *blk_mq_get_new_requests(str=
uct request_queue *q,
>         };
>         struct request *rq;
>
> -       if (unlikely(bio_queue_enter(bio)))
> -               return NULL;
> -
>         if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> -               goto queue_exit;
> +               return NULL;
>
>         rq_qos_throttle(q, bio);
>
> @@ -2878,35 +2875,23 @@ static struct request *blk_mq_get_new_requests(st=
ruct request_queue *q,
>         rq_qos_cleanup(q, bio);
>         if (bio->bi_opf & REQ_NOWAIT)
>                 bio_wouldblock_error(bio);
> -queue_exit:
> -       blk_queue_exit(q);
>         return NULL;
>  }
>
> -static inline struct request *blk_mq_get_cached_request(struct request_q=
ueue *q,
> -               struct blk_plug *plug, struct bio **bio, unsigned int nse=
gs)
> +/* return true if this @rq can be used for @bio */
> +static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug=
 *plug,
> +               struct bio *bio)
>  {
> -       struct request *rq;
> -       enum hctx_type type, hctx_type;
> +       enum hctx_type type =3D blk_mq_get_hctx_type(bio->bi_opf);
> +       enum hctx_type hctx_type =3D rq->mq_hctx->type;
>
> -       if (!plug)
> -               return NULL;
> -       rq =3D rq_list_peek(&plug->cached_rq);
> -       if (!rq || rq->q !=3D q)
> -               return NULL;
> +       WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) !=3D rq);
>
> -       if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
> -               *bio =3D NULL;
> -               return NULL;
> -       }
> -
> -       type =3D blk_mq_get_hctx_type((*bio)->bi_opf);
> -       hctx_type =3D rq->mq_hctx->type;
>         if (type !=3D hctx_type &&
>             !(type =3D=3D HCTX_TYPE_READ && hctx_type =3D=3D HCTX_TYPE_DE=
FAULT))
> -               return NULL;
> -       if (op_is_flush(rq->cmd_flags) !=3D op_is_flush((*bio)->bi_opf))
> -               return NULL;
> +               return false;
> +       if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(bio->bi_opf))
> +               return false;
>
>         /*
>          * If any qos ->throttle() end up blocking, we will have flushed =
the
> @@ -2914,12 +2899,12 @@ static inline struct request *blk_mq_get_cached_r=
equest(struct request_queue *q,
>          * before we throttle.
>          */
>         plug->cached_rq =3D rq_list_next(rq);
> -       rq_qos_throttle(q, *bio);
> +       rq_qos_throttle(rq->q, bio);
>
>         blk_mq_rq_time_init(rq, 0);
> -       rq->cmd_flags =3D (*bio)->bi_opf;
> +       rq->cmd_flags =3D bio->bi_opf;
>         INIT_LIST_HEAD(&rq->queuelist);
> -       return rq;
> +       return true;
>  }
>
>  static void bio_set_ioprio(struct bio *bio)
> @@ -2949,7 +2934,7 @@ void blk_mq_submit_bio(struct bio *bio)
>         struct blk_plug *plug =3D blk_mq_plug(bio);
>         const int is_sync =3D op_is_sync(bio->bi_opf);
>         struct blk_mq_hw_ctx *hctx;
> -       struct request *rq;
> +       struct request *rq =3D NULL;
>         unsigned int nr_segs =3D 1;
>         blk_status_t ret;
>
> @@ -2960,20 +2945,36 @@ void blk_mq_submit_bio(struct bio *bio)
>                         return;
>         }
>
> -       if (!bio_integrity_prep(bio))
> -               return;
> -
>         bio_set_ioprio(bio);
>
> -       rq =3D blk_mq_get_cached_request(q, plug, &bio, nr_segs);
> -       if (!rq) {
> -               if (!bio)
> +       if (plug) {
> +               rq =3D rq_list_peek(&plug->cached_rq);
> +               if (rq && rq->q !=3D q)
> +                       rq =3D NULL;
> +       }
> +       if (rq) {
> +               if (!bio_integrity_prep(bio))
>                         return;
> -               rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
> -               if (unlikely(!rq))
> +               if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
>                         return;
> +               if (blk_mq_can_use_cached_rq(rq, plug, bio))
> +                       goto done;
> +               percpu_ref_get(&q->q_usage_counter);
> +       } else {
> +               if (unlikely(bio_queue_enter(bio)))
> +                       return;
> +               if (!bio_integrity_prep(bio))
> +                       goto fail;
> +       }
> +
> +       rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
> +       if (unlikely(!rq)) {
> +fail:
> +               blk_queue_exit(q);
> +               return;
>         }
>
> +done:
>         trace_block_getrq(bio);
>
>         rq_qos_track(q, rq, bio);
> --
> 2.41.0
>


--
Best Regards,
  Yi Zhang


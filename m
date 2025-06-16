Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C61D90DD
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089734; cv=none; b=P8SAs+7IlrjEXkQqb7mgd2y6Q/5CVnGkkod/d4rGwmCrd3DjqU3AlH45yppx8csVzuLrP1497JyeNk6TxNkvKJ192upsVBetEYqLY+df+6ag1mT6lBt2vb9839WTGcQyj6dx895CxHvoAGrUQqR4enjmM6fb5++sYeUIqrmvsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089734; c=relaxed/simple;
	bh=10Xz1Stad7SLhFWOUMkXTWZpQtQsVMdQurDF/XUJe3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4YLW8eSwEgdqlAmx8HzfPyy2rRM8X6A7u7Cof1hdaGgji/Av6s4aRFFlQlWERmfMbQ+bBUYwX18xXOKMIe/PVe1ntXKv4wTDtbcyaZMmqc1WmV0cNAZCerr3nghtJ6ZXZO3KKsp0vfTyqfthRB5znxjZB09UmgDyXG32wVClAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CZr2tAzU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CZr2tAzU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31305ee3281so796907a91.0
        for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750089731; x=1750694531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaSjeo7bbATdndprCLQnjsDfDUJDERfqYi1V5ELMjlg=;
        b=CZr2tAzUBblKJO94E8+o0caq2OT7JbFas6flZvNghzUR6w/3HpCIGTXsQ7zI80mRtj
         bayTHB9o/ErGWeRK1B/zH6sReVvPPvEy+p/PGDu6vNcg9wYuhmdFRieuB30sicNX0uAr
         xpWMZB6gqtNzqWKVDS4oEyam24ttcVRh49SAKCIdRLvLdG4bwUFJGQiXPHnTBPnUwJP5
         q2DX3J5n85N5eMaBpuzJcCPe9XnWZ3K+sIPLa58AGarDN1J4By4yeSf40fsqX/KvYB2p
         6YnG8onPAGytrfXNErpcihYa5bXRFLcETc1YxU3UTP5bewdIabuNYAf8T8oSQr3AfP3k
         ndrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089731; x=1750694531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaSjeo7bbATdndprCLQnjsDfDUJDERfqYi1V5ELMjlg=;
        b=ECbz+RqsltBKSQfFLEXphPwJ7RwdkgwKtqlTdmKCeiBcLkpKmr9bL1o0CEpJtQjwi9
         DeAE65xo05hPVwCPeLHjSjwT3FmzsMp0pTRXoYR1BVULTcYhDo1KGslXQ78K1BunHpC3
         Ta7nbg9N2riQttagidLMeMaTNZpOEuoSsyOVLv5HK3w5aurRRNRkGSlQwFsQ7kjEjyW1
         /130/zt3OQyia2jF/+68tC76MCBBbFut8MoDGfhemxSGwUE+4YnB+H/f1CBaZUXd09Pk
         gvBLZ6oh4Np5eVwSV43ZMSP5xLyJFYocZGYrJwZpvkjCCa4Sdvkg4yV0ogfa4lJEIBTV
         Ja3g==
X-Forwarded-Encrypted: i=1; AJvYcCWVeAu2VJpmUS9QKdMf/J1uAIcCg62W/xWqB3b0TFQiJj67de85XFB+zG6bRrXxyidKDY6S1DNZubAlIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9f5Nux3dezap08GC2BfQ1NxiaWicD9868qnQ9rIi7s6kIETp
	pfVuSWnVsXvXCqu2DprBEznF+bLMWdlFWl8XbUlQNAjwmPdpEonf6/CgJl+Cp9CZNmu7qWSgB08
	3wsPrBQ7IkH2fVCsJGzfxwQwPedylFaq8a8D6LqWcfQ==
X-Gm-Gg: ASbGncsN+vqFluWnxEmRjqVLEKLmWG9SGlHpXjWseMynF2T4RsQu6fDWr7rOoRMM4Mt
	FeTT6uR14JzYQcbdsyGCzwsmpA9JRvlmrHpyoT4g7B4Hc5UFPHVk/8N1YeYqgv7IusBtV07Vbvx
	HtXy5pS2W8XzMb/xrIwoAK4qJftg+XnCsWO0zEcO5gmfAy7PSIuzP3fw==
X-Google-Smtp-Source: AGHT+IGQY/5pYEXhhUiRFPMj372tlyX0x50jhD7f1brU/hEVI/Pioa+2xFaz3vPi2CDT2tELlneT3sXkDKcsod7hrQQ=
X-Received: by 2002:a17:90a:d890:b0:312:e987:11b0 with SMTP id
 98e67ed59e1d1-313f1da99e5mr5742095a91.6.1750089727212; Mon, 16 Jun 2025
 09:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com> <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org> <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org> <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
 <aErGpBWAMPyT2un9@infradead.org> <2de604b5-0f57-4f41-84a1-aa6f3130d7c8@kernel.dk>
 <aFAYDPrW4THB0ga7@infradead.org>
In-Reply-To: <aFAYDPrW4THB0ga7@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 16 Jun 2025 09:01:54 -0700
X-Gm-Features: AX0GCFuklNGcw6RoNUf4SoZ0zhMACfCa7lwkSw9HrtNWoP85M3r-Rh-RBq0WJr8
Message-ID: <CADUfDZqie84nJeBVJn94UvYqNhY73n41L+tbXOnXdMBqesLDWA@mail.gmail.com>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge attempt
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jun 12, 2025 at 06:28:47AM -0600, Jens Axboe wrote:
> > But ideally we'd have that, and just a plain doubly linked list on the
> > queue/dispatch side. Which makes the list handling there much easier to
> > follow, as per your patch.
>
> Quick hack from the weekend.  This also never deletes the requests from
> the submission list for the queue_rqs case, so depending on the workload
> it should touch either the same amount of less cache lines as the
> existing version.  Only very lightly tested, and ublk is broken and
> doesn't even compile as it's running out space in the io_uring pdu.
> I'll need help from someone who knows ublk for that.
>
> ---
> From 07e283303c63fcb694e828380a24ad51f225a228 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 13 Jun 2025 09:48:40 +0200
> Subject: block: always use a list_head for requests
>
> Use standard double linked lists for the remaining lists of queued up
> requests. This removes a lot of hairy list manipulation code and allows
> east reverse walking of the lists, which is used in
> blk_attempt_plug_merge to improve the merging, and in blk_add_rq_to_plug
> to look at the correct request.
>
> XXX: ublk is broken right now, because there is no space in the io_uring
> pdu for the list backpointer.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c              |  2 +-
>  block/blk-merge.c             | 11 +---
>  block/blk-mq.c                | 97 ++++++++++++++---------------------
>  drivers/block/null_blk/main.c | 16 +++---
>  drivers/block/ublk_drv.c      | 43 +++++++---------
>  drivers/block/virtio_blk.c    | 31 +++++------
>  drivers/nvme/host/pci.c       | 32 ++++++------
>  include/linux/blk-mq.h        |  2 +-
>  include/linux/blkdev.h        |  2 +-
>  9 files changed, 103 insertions(+), 133 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..29aad939a1e3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1127,7 +1127,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, u=
nsigned short nr_ios)
>                 return;
>
>         plug->cur_ktime =3D 0;
> -       rq_list_init(&plug->mq_list);
> +       INIT_LIST_HEAD(&plug->mq_list);
>         rq_list_init(&plug->cached_rqs);
>         plug->nr_ios =3D min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_CO=
UNT);
>         plug->rq_count =3D 0;
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..223941e9ec08 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -995,17 +995,10 @@ bool blk_attempt_plug_merge(struct request_queue *q=
, struct bio *bio,
>         struct blk_plug *plug =3D current->plug;
>         struct request *rq;
>
> -       if (!plug || rq_list_empty(&plug->mq_list))
> +       if (!plug)
>                 return false;
>
> -       rq =3D plug->mq_list.tail;
> -       if (rq->q =3D=3D q)
> -               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) =
=3D=3D
> -                       BIO_MERGE_OK;
> -       else if (!plug->multiple_queues)
> -               return false;
> -
> -       rq_list_for_each(&plug->mq_list, rq) {
> +       list_for_each_entry_reverse(rq, &plug->mq_list, queuelist) {
>                 if (rq->q !=3D q)
>                         continue;
>                 if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) =3D=
=3D
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..6d56471d4346 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1378,7 +1378,8 @@ static inline unsigned short blk_plug_max_rq_count(=
struct blk_plug *plug)
>
>  static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq=
)
>  {
> -       struct request *last =3D rq_list_peek(&plug->mq_list);
> +       struct request *last =3D
> +               list_last_entry(&plug->mq_list, struct request, queuelist=
);
>
>         if (!plug->rq_count) {
>                 trace_block_plug(rq->q);
> @@ -1398,7 +1399,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plu=
g, struct request *rq)
>          */
>         if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
>                 plug->has_elevator =3D true;
> -       rq_list_add_tail(&plug->mq_list, rq);
> +       list_add_tail(&rq->queuelist, &plug->mq_list);
>         plug->rq_count++;
>  }
>
> @@ -2780,15 +2781,15 @@ static blk_status_t blk_mq_request_issue_directly=
(struct request *rq, bool last)
>         return __blk_mq_issue_directly(hctx, rq, last);
>  }
>
> -static void blk_mq_issue_direct(struct rq_list *rqs)
> +static void blk_mq_issue_direct(struct list_head *rqs)
>  {
>         struct blk_mq_hw_ctx *hctx =3D NULL;
> -       struct request *rq;
> +       struct request *rq, *n;
>         int queued =3D 0;
>         blk_status_t ret =3D BLK_STS_OK;
>
> -       while ((rq =3D rq_list_pop(rqs))) {
> -               bool last =3D rq_list_empty(rqs);
> +       list_for_each_entry_safe(rq, n, rqs, queuelist) {
> +               list_del_init(&rq->queuelist);
>
>                 if (hctx !=3D rq->mq_hctx) {
>                         if (hctx) {
> @@ -2798,7 +2799,7 @@ static void blk_mq_issue_direct(struct rq_list *rqs=
)
>                         hctx =3D rq->mq_hctx;
>                 }
>
> -               ret =3D blk_mq_request_issue_directly(rq, last);
> +               ret =3D blk_mq_request_issue_directly(rq, list_empty(rqs)=
);
>                 switch (ret) {
>                 case BLK_STS_OK:
>                         queued++;
> @@ -2819,45 +2820,18 @@ static void blk_mq_issue_direct(struct rq_list *r=
qs)
>                 blk_mq_commit_rqs(hctx, queued, false);
>  }
>
> -static void __blk_mq_flush_list(struct request_queue *q, struct rq_list =
*rqs)
> +static void __blk_mq_flush_list(struct request_queue *q, struct list_hea=
d *rqs)
>  {
>         if (blk_queue_quiesced(q))
>                 return;
>         q->mq_ops->queue_rqs(rqs);
>  }
>
> -static unsigned blk_mq_extract_queue_requests(struct rq_list *rqs,
> -                                             struct rq_list *queue_rqs)
> -{
> -       struct request *rq =3D rq_list_pop(rqs);
> -       struct request_queue *this_q =3D rq->q;
> -       struct request **prev =3D &rqs->head;
> -       struct rq_list matched_rqs =3D {};
> -       struct request *last =3D NULL;
> -       unsigned depth =3D 1;
> -
> -       rq_list_add_tail(&matched_rqs, rq);
> -       while ((rq =3D *prev)) {
> -               if (rq->q =3D=3D this_q) {
> -                       /* move rq from rqs to matched_rqs */
> -                       *prev =3D rq->rq_next;
> -                       rq_list_add_tail(&matched_rqs, rq);
> -                       depth++;
> -               } else {
> -                       /* leave rq in rqs */
> -                       prev =3D &rq->rq_next;
> -                       last =3D rq;
> -               }
> -       }
> -
> -       rqs->tail =3D last;
> -       *queue_rqs =3D matched_rqs;
> -       return depth;
> -}
> -
> -static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned=
 depth)
> +static void blk_mq_dispatch_queue_requests(struct list_head *rqs,
> +                                          unsigned depth)
>  {
> -       struct request_queue *q =3D rq_list_peek(rqs)->q;
> +       struct request *rq =3D list_first_entry(rqs, struct request, queu=
elist);
> +       struct request_queue *q =3D rq->q;
>
>         trace_block_unplug(q, depth, true);
>
> @@ -2869,39 +2843,35 @@ static void blk_mq_dispatch_queue_requests(struct=
 rq_list *rqs, unsigned depth)
>          */
>         if (q->mq_ops->queue_rqs) {
>                 blk_mq_run_dispatch_ops(q, __blk_mq_flush_list(q, rqs));
> -               if (rq_list_empty(rqs))
> +               if (list_empty(rqs))
>                         return;
>         }
>
>         blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(rqs));
>  }
>
> -static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
> +static void blk_mq_dispatch_list(struct list_head *rqs, bool from_sched)
>  {
>         struct blk_mq_hw_ctx *this_hctx =3D NULL;
>         struct blk_mq_ctx *this_ctx =3D NULL;
> -       struct rq_list requeue_list =3D {};
> +       LIST_HEAD(list);
> +       struct request *rq, *n;
>         unsigned int depth =3D 0;
>         bool is_passthrough =3D false;
> -       LIST_HEAD(list);
> -
> -       do {
> -               struct request *rq =3D rq_list_pop(rqs);
>
> +       list_for_each_entry_safe(rq, n, rqs, queuelist) {
>                 if (!this_hctx) {
>                         this_hctx =3D rq->mq_hctx;
>                         this_ctx =3D rq->mq_ctx;
>                         is_passthrough =3D blk_rq_is_passthrough(rq);
>                 } else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq=
->mq_ctx ||
>                            is_passthrough !=3D blk_rq_is_passthrough(rq))=
 {
> -                       rq_list_add_tail(&requeue_list, rq);
>                         continue;
>                 }
> -               list_add_tail(&rq->queuelist, &list);
> +               list_move_tail(&rq->queuelist, &list);
>                 depth++;
> -       } while (!rq_list_empty(rqs));
> +       }
>
> -       *rqs =3D requeue_list;
>         trace_block_unplug(this_hctx->queue, depth, !from_sched);
>
>         percpu_ref_get(&this_hctx->queue->q_usage_counter);
> @@ -2921,17 +2891,27 @@ static void blk_mq_dispatch_list(struct rq_list *=
rqs, bool from_sched)
>         percpu_ref_put(&this_hctx->queue->q_usage_counter);
>  }
>
> -static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
> +static void blk_mq_dispatch_multiple_queue_requests(struct list_head *rq=
s)
>  {
>         do {
> -               struct rq_list queue_rqs;
> -               unsigned depth;
> +               struct request_queue *this_q =3D NULL;
> +               struct request *rq, *n;
> +               LIST_HEAD(queue_rqs);
> +               unsigned depth =3D 0;
> +
> +               list_for_each_entry_safe(rq, n, rqs, queuelist) {
> +                       if (!this_q)
> +                               this_q =3D rq->q;
> +                       if (this_q =3D=3D rq->q) {
> +                               list_move_tail(&rq->queuelist, &queue_rqs=
);
> +                               depth++;
> +                       }
> +               }
>
> -               depth =3D blk_mq_extract_queue_requests(rqs, &queue_rqs);
>                 blk_mq_dispatch_queue_requests(&queue_rqs, depth);
> -               while (!rq_list_empty(&queue_rqs))
> +               while (!list_empty(&queue_rqs))
>                         blk_mq_dispatch_list(&queue_rqs, false);
> -       } while (!rq_list_empty(rqs));
> +       } while (!list_empty(rqs));
>  }
>
>  void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> @@ -2955,15 +2935,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug=
, bool from_schedule)
>                         blk_mq_dispatch_multiple_queue_requests(&plug->mq=
_list);
>                         return;
>                 }
> -
>                 blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
> -               if (rq_list_empty(&plug->mq_list))
> +               if (list_empty(&plug->mq_list))
>                         return;
>         }
>
>         do {
>                 blk_mq_dispatch_list(&plug->mq_list, from_schedule);
> -       } while (!rq_list_empty(&plug->mq_list));
> +       } while (!list_empty(&plug->mq_list));
>  }
>
>  static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index aa163ae9b2aa..ce3ac928122f 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1694,22 +1694,22 @@ static blk_status_t null_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>         return BLK_STS_OK;
>  }
>
> -static void null_queue_rqs(struct rq_list *rqlist)
> +static void null_queue_rqs(struct list_head *rqlist)
>  {
> -       struct rq_list requeue_list =3D {};
>         struct blk_mq_queue_data bd =3D { };
> +       LIST_HEAD(requeue_list);
> +       struct request *rq, *n;
>         blk_status_t ret;
>
> -       do {
> -               struct request *rq =3D rq_list_pop(rqlist);
> -
> +       list_for_each_entry_safe(rq, n, rqlist, queuelist) {
>                 bd.rq =3D rq;
>                 ret =3D null_queue_rq(rq->mq_hctx, &bd);
>                 if (ret !=3D BLK_STS_OK)
> -                       rq_list_add_tail(&requeue_list, rq);
> -       } while (!rq_list_empty(rqlist));
> +                       list_move_tail(&rq->queuelist, &requeue_list);
> +       }
>
> -       *rqlist =3D requeue_list;
> +       INIT_LIST_HEAD(rqlist);
> +       list_splice(&requeue_list, rqlist);
>  }
>
>  static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c637ea010d34..4d5b88ca7b1b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -101,7 +101,7 @@ struct ublk_uring_cmd_pdu {
>          */
>         union {
>                 struct request *req;
> -               struct request *req_list;
> +               struct list_head req_list;
>         };
>
>         /*
> @@ -1325,24 +1325,18 @@ static void ublk_cmd_list_tw_cb(struct io_uring_c=
md *cmd,
>                 unsigned int issue_flags)
>  {
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> -       struct request *rq =3D pdu->req_list;
> -       struct request *next;
> +       struct request *rq, *n;
>
> -       do {
> -               next =3D rq->rq_next;
> -               rq->rq_next =3D NULL;
> +       list_for_each_entry_safe(rq, n, &pdu->req_list, queuelist)
>                 ublk_dispatch_req(rq->mq_hctx->driver_data, rq, issue_fla=
gs);
> -               rq =3D next;
> -       } while (rq);
>  }
>
> -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> +static void ublk_queue_cmd_list(struct ublk_io *io, struct list_head *rq=
list)
>  {
>         struct io_uring_cmd *cmd =3D io->cmd;
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
>
> -       pdu->req_list =3D rq_list_peek(l);
> -       rq_list_init(l);
> +       list_splice(&pdu->req_list, rqlist);
>         io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);

ublk_cmd_list_tw_cb() doesn't need a doubly-linked list. It should be
fine to continue storing just the first struct request * of the list
in struct ublk_uring_cmd_pdu. That would avoid growing
ublk_uring_cmd_pdu past the 32-byte limit.

Best,
Caleb

>  }
>
> @@ -1416,30 +1410,31 @@ static blk_status_t ublk_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>         return BLK_STS_OK;
>  }
>
> -static void ublk_queue_rqs(struct rq_list *rqlist)
> +static void ublk_queue_rqs(struct list_head *rqlist)
>  {
> -       struct rq_list requeue_list =3D { };
> -       struct rq_list submit_list =3D { };
>         struct ublk_io *io =3D NULL;
> -       struct request *req;
> +       struct request *req, *n;
> +       LIST_HEAD(requeue_list);
>
> -       while ((req =3D rq_list_pop(rqlist))) {
> +       list_for_each_entry_safe(req, n, rqlist, queuelist) {
>                 struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
>                 struct ublk_io *this_io =3D &this_q->ios[req->tag];
>
> -               if (io && io->task !=3D this_io->task && !rq_list_empty(&=
submit_list))
> +               if (io && io->task !=3D this_io->task) {
> +                       LIST_HEAD(submit_list);
> +
> +                       list_cut_before(&submit_list, rqlist, &req->queue=
list);
>                         ublk_queue_cmd_list(io, &submit_list);
> +               }
>                 io =3D this_io;
>
> -               if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK)
> -                       rq_list_add_tail(&submit_list, req);
> -               else
> -                       rq_list_add_tail(&requeue_list, req);
> +               if (ublk_prep_req(this_q, req, true) !=3D BLK_STS_OK)
> +                       list_move_tail(&req->queuelist, &requeue_list);
>         }
>
> -       if (!rq_list_empty(&submit_list))
> -               ublk_queue_cmd_list(io, &submit_list);
> -       *rqlist =3D requeue_list;
> +       if (!list_empty(rqlist))
> +               ublk_queue_cmd_list(io, rqlist);
> +       list_splice(&requeue_list, rqlist);
>  }
>
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30bca8cb7106..29f900eada0f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -471,15 +471,14 @@ static bool virtblk_prep_rq_batch(struct request *r=
eq)
>  }
>
>  static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> -               struct rq_list *rqlist)
> +               struct list_head *rqlist)
>  {
>         struct request *req;
>         unsigned long flags;
>         bool kick;
>
>         spin_lock_irqsave(&vq->lock, flags);
> -
> -       while ((req =3D rq_list_pop(rqlist))) {
> +       list_for_each_entry(req, rqlist, queuelist) {
>                 struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
>                 int err;
>
> @@ -498,29 +497,31 @@ static void virtblk_add_req_batch(struct virtio_blk=
_vq *vq,
>                 virtqueue_notify(vq->vq);
>  }
>
> -static void virtio_queue_rqs(struct rq_list *rqlist)
> +static void virtio_queue_rqs(struct list_head *rqlist)
>  {
> -       struct rq_list submit_list =3D { };
> -       struct rq_list requeue_list =3D { };
>         struct virtio_blk_vq *vq =3D NULL;
> -       struct request *req;
> +       LIST_HEAD(requeue_list);
> +       struct request *req, *n;
>
> -       while ((req =3D rq_list_pop(rqlist))) {
> +       list_for_each_entry_safe(req, n, rqlist, queuelist) {
>                 struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req->=
mq_hctx);
>
> -               if (vq && vq !=3D this_vq)
> +               if (vq && vq !=3D this_vq) {
> +                       LIST_HEAD(submit_list);
> +
> +                       list_cut_before(&submit_list, rqlist, &req->queue=
list);
>                         virtblk_add_req_batch(vq, &submit_list);
> +               }
>                 vq =3D this_vq;
>
> -               if (virtblk_prep_rq_batch(req))
> -                       rq_list_add_tail(&submit_list, req);
> -               else
> -                       rq_list_add_tail(&requeue_list, req);
> +               if (!virtblk_prep_rq_batch(req))
> +                       list_move_tail(&req->queuelist, &requeue_list);
>         }
>
>         if (vq)
> -               virtblk_add_req_batch(vq, &submit_list);
> -       *rqlist =3D requeue_list;
> +               virtblk_add_req_batch(vq, rqlist);
> +       INIT_LIST_HEAD(rqlist);
> +       list_splice(&requeue_list, rqlist);
>  }
>
>  #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ff12e415cb5..7bcb4b33e154 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1051,15 +1051,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>         return BLK_STS_OK;
>  }
>
> -static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *r=
qlist)
> +static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct list_head =
*rqlist)
>  {
>         struct request *req;
>
> -       if (rq_list_empty(rqlist))
> +       if (list_empty(rqlist))
>                 return;
>
>         spin_lock(&nvmeq->sq_lock);
> -       while ((req =3D rq_list_pop(rqlist))) {
> +       list_for_each_entry(req, rqlist, queuelist) {
>                 struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>
>                 nvme_sq_copy_cmd(nvmeq, &iod->cmd);
> @@ -1082,27 +1082,29 @@ static bool nvme_prep_rq_batch(struct nvme_queue =
*nvmeq, struct request *req)
>         return nvme_prep_rq(nvmeq->dev, req) =3D=3D BLK_STS_OK;
>  }
>
> -static void nvme_queue_rqs(struct rq_list *rqlist)
> +static void nvme_queue_rqs(struct list_head *rqlist)
>  {
> -       struct rq_list submit_list =3D { };
> -       struct rq_list requeue_list =3D { };
>         struct nvme_queue *nvmeq =3D NULL;
> -       struct request *req;
> +       LIST_HEAD(requeue_list);
> +       struct request *req, *n;
> +
> +       list_for_each_entry_safe(req, n, rqlist, queuelist) {
> +               if (nvmeq && nvmeq !=3D req->mq_hctx->driver_data) {
> +                       LIST_HEAD(submit_list);
>
> -       while ((req =3D rq_list_pop(rqlist))) {
> -               if (nvmeq && nvmeq !=3D req->mq_hctx->driver_data)
> +                       list_cut_before(&submit_list, rqlist, &req->queue=
list);
>                         nvme_submit_cmds(nvmeq, &submit_list);
> +               }
>                 nvmeq =3D req->mq_hctx->driver_data;
>
> -               if (nvme_prep_rq_batch(nvmeq, req))
> -                       rq_list_add_tail(&submit_list, req);
> -               else
> -                       rq_list_add_tail(&requeue_list, req);
> +               if (!nvme_prep_rq_batch(nvmeq, req))
> +                       list_move_tail(&req->queuelist, &requeue_list);
>         }
>
>         if (nvmeq)
> -               nvme_submit_cmds(nvmeq, &submit_list);
> -       *rqlist =3D requeue_list;
> +               nvme_submit_cmds(nvmeq, rqlist);
> +       INIT_LIST_HEAD(rqlist);
> +       list_splice(&requeue_list, rqlist);
>  }
>
>  static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index de8c85a03bb7..76c7ec906481 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -574,7 +574,7 @@ struct blk_mq_ops {
>          * empty the @rqlist completely, then the rest will be queued
>          * individually by the block layer upon return.
>          */
> -       void (*queue_rqs)(struct rq_list *rqlist);
> +       void (*queue_rqs)(struct list_head *rqlist);
>
>         /**
>          * @get_budget: Reserve budget before queue request, once .queue_=
rq is
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 332b56f323d9..1cc87e939b40 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1083,7 +1083,7 @@ struct rq_list {
>   * blk_flush_plug() is called.
>   */
>  struct blk_plug {
> -       struct rq_list mq_list; /* blk-mq requests */
> +       struct list_head mq_list; /* blk-mq requests */
>
>         /* if ios_left is > 1, we can batch tag/rq allocations */
>         struct rq_list cached_rqs;
> --
> 2.47.2
>
>

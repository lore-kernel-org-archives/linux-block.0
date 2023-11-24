Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYvsyhpk"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38958CB
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 03:28:59 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c878e228b4so22519611fa.1
        for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 03:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700825337; x=1701430137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7QDyjJzKLoxYWCVV5lrZ+/gJmyheU8uuEqTM1EF3oU=;
        b=RYvsyhpkiEMEPCur0R08NIcR5574filWj3Y+4RF2f3w2OHTxNajAx9Rq1c7wiUWMc4
         k/T4Ga9w0NNmmbWevHupCkJbg4lLrFHnzrFPJL9ent6mrrdjL55EaaHjipNaw4zQMVts
         G8Lty3iz7zpVBso0GPT7iI+A0BaiJZVCt+LSv6HAUqSwctvPotC8UdKba8WbnofKkDdB
         Wa/NKs45vcaAC8E+X/BccQbPQBf3K0SFmLP62nzINF1HciXw/k2HO3U0xAj+zBduIU7O
         PyKrX5xhsBYN/t+CuCBK02WPp8TMHbNYrxiROsfb6KgjGzp5RnhWsh6SyKgR5FY0iHAS
         2E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825337; x=1701430137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7QDyjJzKLoxYWCVV5lrZ+/gJmyheU8uuEqTM1EF3oU=;
        b=O4aXQBRcCNp1tzDbZxGwFU/Pf5BgG0ivhIsuLTOYO1OldzfXCQUC1xrnCrAwfVlD7a
         sEo1f5cO1QWicEpmCTYieTYyh9s0jARakFtASWidCFEQvoGHIJlW9WyVlWl/bGUqimGz
         4Z3JmQjrBYsRf81k6XJeQ+clWT7i1Se9ZIiKzWFvKBBm+8yG0Z/wOFsF4cFVYLR845kk
         z1DiUKBliRA9ICMWLG8Iov68+5Z5rFwHQAAGlJOv3+LbWbp2iof6Jr8+XkJrAwKSPIxH
         IYaZiytChntK2q/9f7ltRE6VPWol8f40qrzwbqpFDYowdH2RkbhWFSp8tLnyRgas8STt
         Nh6Q==
X-Gm-Message-State: AOJu0YwZdYUeCnaT/l6YAdk5hO0OEEGoFbD613WvqyUWjtIZLYis23CX
	41SYMO+DBrtvrW8lkCcogquP/7WPGUAp5p0ycO8=
X-Google-Smtp-Source: AGHT+IGMTNf/cYIIrpcgHU+m52+HQBpXmaW7ckHi/VawYoKs7aYKNh2rocDs4DluyVugKnuC7QIY3j6iHDTf/d4gVXc=
X-Received: by 2002:a2e:9bc6:0:b0:2c7:7b65:60b9 with SMTP id
 w6-20020a2e9bc6000000b002c77b6560b9mr1875714ljj.4.1700825336885; Fri, 24 Nov
 2023 03:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
 <20231123102431.6804-1-kundan.kumar@samsung.com> <20231123153007.GA3853@lst.de>
 <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com> <37d9ca26-2ec2-4c51-8d33-a736f54ef93f@kernel.dk>
 <fba18f05-ae51-4d46-932a-5f4f9d2aab07@kernel.dk>
In-Reply-To: <fba18f05-ae51-4d46-932a-5f4f9d2aab07@kernel.dk>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Fri, 24 Nov 2023 16:58:44 +0530
Message-ID: <CALYkqXp36aJbu+2PgHQhSaXh38zTtcnVza+pexqJyDEDaq=V7Q@mail.gmail.com>
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>, 
	"kundan.kumar" <kundan.kumar@samsung.com>, kbusch@kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 2:07=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/23/23 1:19 PM, Jens Axboe wrote:
> > On 11/23/23 11:12 AM, Kanchan Joshi wrote:
> >> On 11/23/2023 9:00 PM, Christoph Hellwig wrote:
> >>> The rest looks good, but that stats overhead seems pretty horrible..
> >>
> >> On my setup
> >> Before[1]: 7.06M
> >> After[2]: 8.29M
> >>
> >> [1]
> >> # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2
> >> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> >> submitter=3D0, tid=3D2076, file=3D/dev/ng0n1, node=3D-1
> >> submitter=3D1, tid=3D2077, file=3D/dev/ng1n1, node=3D-1
> >> polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D25=
6
> >> Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
> >> polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D25=
6
> >> Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
> >> IOPS=3D6.95M, BW=3D3.39GiB/s, IOS/call=3D32/31
> >> IOPS=3D7.06M, BW=3D3.45GiB/s, IOS/call=3D32/32
> >> IOPS=3D7.06M, BW=3D3.45GiB/s, IOS/call=3D32/31
> >> Exiting on timeout
> >> Maximum IOPS=3D7.06M
> >>
> >> [2]
> >>   # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n=
2
> >> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> >> submitter=3D0, tid=3D2123, file=3D/dev/ng0n1, node=3D-1
> >> submitter=3D1, tid=3D2124, file=3D/dev/ng1n1, node=3D-1
> >> polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D25=
6
> >> Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
> >> IOPS=3D8.27M, BW=3D4.04GiB/s, IOS/call=3D32/31
> >> IOPS=3D8.29M, BW=3D4.05GiB/s, IOS/call=3D32/31
> >> IOPS=3D8.29M, BW=3D4.05GiB/s, IOS/call=3D31/31
> >> Exiting on timeout
> >> Maximum IOPS=3D8.29M
> >
> > It's all really down to how expensive getting the current time is on
> > your box, some will be better and some worse
> >
> > One idea that has been bounced around in the past is to have a
> > blk_ktime_get_ns() and have it be something ala:
> >
> > u64 blk_ktime_get_ns(void)
> > {
> >       struct blk_plug *plug =3D current->plug;
> >
> >       if (!plug)
> >               return ktime_get_ns();
> >
> >       if (!plug->ktime_valid)
> >               plug->ktime =3D ktime_get_ns();
> >
> >       return plug->ktime;
> > }
> >
> > in freestyle form, with the idea being that we don't care granularity t=
o
> > the extent that we'd need a new stamp every time.
> >
> > If the task is scheduled out, the plug is flushed anyway, which should
> > invalidate the stamp. For preemption this isn't true iirc, so we'd need
> > some kind of blk_flush_plug_ts() or something for that case to
> > invalidate it.
> >
> > Hopefully this could then also get away from passing in a cached value
> > that we do in various spots, exactly because all of this time stamping
> > is expensive. It's also a bit of a game of whack-a-mole, as users get
> > added and distro kernels tend to turn on basically everything anyway.
>
> Did a quick'n dirty (see below), which recoups half of the lost
> performance for me. And my kernel deliberately doesn't enable all of the
> gunk in block/ that slows everything down, I suspect it'll be a bigger
> win for you percentage wise:
>
> IOPS=3D121.42M, BW=3D59.29GiB/s, IOS/call=3D31/31
> IOPS=3D121.47M, BW=3D59.31GiB/s, IOS/call=3D32/32
> IOPS=3D121.44M, BW=3D59.30GiB/s, IOS/call=3D31/31
> IOPS=3D121.47M, BW=3D59.31GiB/s, IOS/call=3D31/31
> IOPS=3D121.45M, BW=3D59.30GiB/s, IOS/call=3D32/32
> IOPS=3D119.95M, BW=3D58.57GiB/s, IOS/call=3D31/32
> IOPS=3D115.30M, BW=3D56.30GiB/s, IOS/call=3D32/31
> IOPS=3D115.38M, BW=3D56.34GiB/s, IOS/call=3D32/32
> IOPS=3D115.35M, BW=3D56.32GiB/s, IOS/call=3D32/32
>
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..6e74af442b94 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1055,6 +1055,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, u=
nsigned short nr_ios)
>         plug->rq_count =3D 0;
>         plug->multiple_queues =3D false;
>         plug->has_elevator =3D false;
> +       plug->cur_ktime =3D 0;
>         INIT_LIST_HEAD(&plug->cb_list);
>
>         /*
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 3f4d41952ef2..e4e9f7eed346 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -143,7 +143,7 @@ static void blk_account_io_flush(struct request *rq)
>         part_stat_lock();
>         part_stat_inc(part, ios[STAT_FLUSH]);
>         part_stat_add(part, nsecs[STAT_FLUSH],
> -                     ktime_get_ns() - rq->start_time_ns);
> +                     blk_ktime_get_ns() - rq->start_time_ns);
>         part_stat_unlock();
>  }
>
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 089fcb9cfce3..d06cea625462 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -829,7 +829,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gend=
isk *disk)
>
>         /* step up/down based on the vrate */
>         vrate_pct =3D div64_u64(ioc->vtime_base_rate * 100, VTIME_PER_USE=
C);
> -       now_ns =3D ktime_get_ns();
> +       now_ns =3D blk_ktime_get_ns();
>
>         if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <=3D vrate_pct=
) {
>                 if (!ioc->autop_too_fast_at)
> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now=
 *now)
>         unsigned seq;
>         u64 vrate;
>
> -       now->now_ns =3D ktime_get();
> +       now->now_ns =3D blk_ktime_get();
>         now->now =3D ktime_to_us(now->now_ns);
>         vrate =3D atomic64_read(&ioc->vtime_rate);
>
> @@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, stru=
ct request *rq)
>                 return;
>         }
>
> -       on_q_ns =3D ktime_get_ns() - rq->alloc_time_ns;
> +       on_q_ns =3D blk_ktime_get_ns() - rq->alloc_time_ns;
>         rq_wait_ns =3D rq->start_time_ns - rq->alloc_time_ns;
>         size_nsec =3D div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_=
NSEC);
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 900c1be1fee1..9c96dee9e584 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -323,7 +323,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
>         RB_CLEAR_NODE(&rq->rb_node);
>         rq->tag =3D BLK_MQ_NO_TAG;
>         rq->internal_tag =3D BLK_MQ_NO_TAG;
> -       rq->start_time_ns =3D ktime_get_ns();
> +       rq->start_time_ns =3D blk_ktime_get_ns();
>         rq->part =3D NULL;
>         blk_crypto_rq_set_defaults(rq);
>  }
> @@ -333,7 +333,7 @@ EXPORT_SYMBOL(blk_rq_init);
>  static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_tim=
e_ns)
>  {
>         if (blk_mq_need_time_stamp(rq))
> -               rq->start_time_ns =3D ktime_get_ns();
> +               rq->start_time_ns =3D blk_ktime_get_ns();
>         else
>                 rq->start_time_ns =3D 0;
>
> @@ -444,7 +444,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
>
>         /* alloc_time includes depth and tag waits */
>         if (blk_queue_rq_alloc_time(q))
> -               alloc_time_ns =3D ktime_get_ns();
> +               alloc_time_ns =3D blk_ktime_get_ns();
>
>         if (data->cmd_flags & REQ_NOWAIT)
>                 data->flags |=3D BLK_MQ_REQ_NOWAIT;
> @@ -629,7 +629,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
>
>         /* alloc_time includes depth and tag waits */
>         if (blk_queue_rq_alloc_time(q))
> -               alloc_time_ns =3D ktime_get_ns();
> +               alloc_time_ns =3D blk_ktime_get_ns();
>
>         /*
>          * If the tag allocator sleeps we could get an allocation for a
> @@ -1037,7 +1037,7 @@ static inline void __blk_mq_end_request_acct(struct=
 request *rq, u64 now)
>  inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
>         if (blk_mq_need_time_stamp(rq))
> -               __blk_mq_end_request_acct(rq, ktime_get_ns());
> +               __blk_mq_end_request_acct(rq, blk_ktime_get_ns());
>
>         blk_mq_finish_request(rq);
>
> @@ -1080,7 +1080,7 @@ void blk_mq_end_request_batch(struct io_comp_batch =
*iob)
>         u64 now =3D 0;
>
>         if (iob->need_ts)
> -               now =3D ktime_get_ns();
> +               now =3D blk_ktime_get_ns();
>
>         while ((rq =3D rq_list_pop(&iob->req_list)) !=3D NULL) {
>                 prefetch(rq->bio);
> @@ -1249,7 +1249,7 @@ void blk_mq_start_request(struct request *rq)
>         trace_block_rq_issue(rq);
>
>         if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
> -               rq->io_start_time_ns =3D ktime_get_ns();
> +               rq->io_start_time_ns =3D blk_ktime_get_ns();
>                 rq->stats_sectors =3D blk_rq_sectors(rq);
>                 rq->rq_flags |=3D RQF_STATS;
>                 rq_qos_issue(q, rq);
> @@ -3066,7 +3066,7 @@ blk_status_t blk_insert_cloned_request(struct reque=
st *rq)
>         blk_mq_run_dispatch_ops(q,
>                         ret =3D blk_mq_request_issue_directly(rq, true));
>         if (ret)
> -               blk_account_io_done(rq, ktime_get_ns());
> +               blk_account_io_done(rq, blk_ktime_get_ns());
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 13e4377a8b28..5919919ba1c3 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1813,7 +1813,7 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg=
)
>         time =3D min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_thr=
eshold);
>         ret =3D tg->latency_target =3D=3D DFL_LATENCY_TARGET ||
>               tg->idletime_threshold =3D=3D DFL_IDLE_THRESHOLD ||
> -             (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
> +             (blk_ktime_get_ns() >> 10) - tg->last_finish_time > time ||
>               tg->avg_idletime > tg->idletime_threshold ||
>               (tg->latency_target && tg->bio_cnt &&
>                 tg->bad_bio_cnt * 5 < tg->bio_cnt);
> @@ -2058,7 +2058,7 @@ static void blk_throtl_update_idletime(struct throt=
l_grp *tg)
>         if (last_finish_time =3D=3D 0)
>                 return;
>
> -       now =3D ktime_get_ns() >> 10;
> +       now =3D blk_ktime_get_ns() >> 10;
>         if (now <=3D last_finish_time ||
>             last_finish_time =3D=3D tg->checked_last_finish_time)
>                 return;
> @@ -2325,7 +2325,7 @@ void blk_throtl_bio_endio(struct bio *bio)
>         if (!tg->td->limit_valid[LIMIT_LOW])
>                 return;
>
> -       finish_time_ns =3D ktime_get_ns();
> +       finish_time_ns =3D blk_ktime_get_ns();
>         tg->last_finish_time =3D finish_time_ns >> 10;
>
>         start_time =3D bio_issue_time(&bio->bi_issue) >> 10;
> diff --git a/block/blk.h b/block/blk.h
> index 08a358bc0919..4f081a00e644 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -518,4 +518,17 @@ static inline int req_ref_read(struct request *req)
>         return atomic_read(&req->ref);
>  }
>
> +static inline u64 blk_ktime_get_ns(void)
> +{
> +       struct blk_plug *plug =3D current->plug;
> +
> +       if (!plug)
> +               return ktime_get_ns();
> +       if (!(plug->cur_ktime & 1ULL)) {
> +               plug->cur_ktime =3D ktime_get_ns();
> +               plug->cur_ktime |=3D 1ULL;
> +       }
> +       return plug->cur_ktime;
> +}
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 51fa7ffdee83..081830279f70 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -972,6 +972,9 @@ struct blk_plug {
>         bool multiple_queues;
>         bool has_elevator;
>
> +       /* bit0 set if valid */
> +       u64 cur_ktime;
> +
>         struct list_head cb_list; /* md requires an unplug callback */
>  };
>
>
> --
> Jens Axboe
>
>

Hi Jens,

This is what I see with your changes on my setup.

Before[1]: 7.06M
After[2]: 7.52M

[1]
# taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 \
-u1 -r4 /dev/ng0n1 /dev/ng1n1
submitter=3D0, tid=3D2076, file=3D/dev/ng0n1, node=3D-1
submitter=3D1, tid=3D2077, file=3D/dev/ng1n1, node=3D-1
polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D256
Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D256
Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
IOPS=3D6.95M, BW=3D3.39GiB/s, IOS/call=3D32/31
IOPS=3D7.06M, BW=3D3.45GiB/s, IOS/call=3D32/32
IOPS=3D7.06M, BW=3D3.45GiB/s, IOS/call=3D32/31
Exiting on timeout
Maximum IOPS=3D7.06M

[2]
# taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 \
-u1 -r4 /dev/ng0n1 /dev/ng1n1
submitter=3D0, tid=3D2204, file=3D/dev/ng0n1, node=3D-1
submitter=3D1, tid=3D2205, file=3D/dev/ng1n1, node=3D-1
polled=3D1, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D256
Engine=3Dio_uring, sq_ring=3D256, cq_ring=3D256
IOPS=3D7.40M, BW=3D3.62GiB/s, IOS/call=3D32/31
IOPS=3D7.51M, BW=3D3.67GiB/s, IOS/call=3D32/31
IOPS=3D7.52M, BW=3D3.67GiB/s, IOS/call=3D32/32
Exiting on timeout
Maximum IOPS=3D7.52M

The original patch avoids processing throttle stats and wbt_issue/done
stats for passthrough-io path.

Improvement with original-patch :
7.06M -> 8.29M

It seems that both the optimizations are different. The original patch is a=
bout
"completely disabling stats for passthrough-io" and your changes
optimize getting the
current time which would improve performance for everyone.

I think both of them are independent.

--
Kundan Kumar

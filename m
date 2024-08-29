Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E87446DC
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899918; cv=none; b=LEzGKshlaDATGw7i+dnuTDiwpQakTocKGoDj7EWdfXgOVLH+9LOkIykW9JOCkkzLGPb1dqaOtDf0l7v8M0D4TaZxk0dsVuJE8YG9VD35TK8mD+JNzZkzRYwOtF0Wg0nNFJh+8YmJpe6uBdFyAK5zDkuqOgWohZEA+fiMZ3pe7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899918; c=relaxed/simple;
	bh=5eH319rL3ljbFSk7F9xxud1+f6rGBTTAhosJkOfbG5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6zFT+yKqcfPS/8OpRNpIszeB2vPNuu5ifaIdEddqUnabP1wUhNWQf8rjf+1VEOR9RkJ5baQdoNX0DpzXHlfb+DU/Kv+x1KvDXCa9XpUX7BqBJjTpMstskfxHNcHJ2o9RllipLOMTTwNA2i4u2Ho8406uRxkmiry+4KlHr7LgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kra+ztun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kra+ztun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724899913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y5X/HAwi8YQWAeolryJhZ/So/sg9D9zgxA+LGf3kZ4=;
	b=Kra+ztuniNKg1bPqysdI6pv2PLsVG8ixcJ+gd4PPwTgLkIPnRKzUnQo9D9HENWqPvOfX8u
	sbMZoXlWsOq8wlVNwu/mJmJv1ihY7XVUZgJbXMRvfgZoRN1gegB+TEeVuRErvJ2KaZgdYp
	Xc3x58fGiUW9jdJfEO7ipdXt5Fi1W9E=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-tF-QhwsTNneDu0V_9pCx3g-1; Wed, 28 Aug 2024 22:51:49 -0400
X-MC-Unique: tF-QhwsTNneDu0V_9pCx3g-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-844c44e9f43so99055241.0
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 19:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899908; x=1725504708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y5X/HAwi8YQWAeolryJhZ/So/sg9D9zgxA+LGf3kZ4=;
        b=J8vXzsefKQHOqkrZr9ho3Xyjn/s7yw0rr44HsEdfJOd7YKdzYKx7IwKEOiWSGdqnD2
         AysMCytxwpsiBF1hzhNm+1K/fD+O5jaWlyiGr0BMr5pertVq5DaPO1UbdOo8lb+0N3DF
         SryApUo6y2putHZ9hiJ2h110oIRqcNnXEhNnK6nUNvu20j4GOtp+59JZkGdaxuxaThAq
         /+QxU27livaj5UNGzqANlEiErXQtZ7b+1uLUWrc3GVLvYX5uK7Wwl9+gFbz1T2/q+4N7
         uRxcfX6WP4+uN4SmDUP7MEGdy08A0lrRsijg/FFXVYT/Yk5CgGhM7fdaoXj9J11K+Dye
         R0eA==
X-Forwarded-Encrypted: i=1; AJvYcCXysEcoNcVfJdayuwEllx0iQJAM7dXiWr698Yjf8PlJo4i3qm84LwA+cRVcU4BfysOMhWOB5rvPUxPyLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvRqVgVFXSwaZgq0o53eJiDxBvsRBkW/TVAgHLy9wdW+oZOjs
	3kefQ3trC0EcZDYGyw0U2sZfMzZxufd5Tz4p4oghIn9b6ab2hYYtAbflphhEjOV/NxO2gY7bTrm
	YvLZ4dmU8f4NWhjOXfRDjo9vSX43J/yK1Ahl/AnaL4E8UhHt9Y/11eK81cb1hZ9T5y1Dx3hnnj+
	E8KvU99o1GkQV2kAObyNeHesLYC6Qbabj/2Ok=
X-Received: by 2002:a05:6102:3907:b0:498:dd44:32c with SMTP id ada2fe7eead31-49a5af81969mr2061389137.28.1724899907925;
        Wed, 28 Aug 2024 19:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMCwdJWqQ7UGqEm2eD2QZkKdrnPhDXz9a+VFDGRXzvmXdVehEBkxYt8vxSUIGJFAXz0GgrUNUZJFb+iSlI/mw=
X-Received: by 2002:a05:6102:3907:b0:498:dd44:32c with SMTP id
 ada2fe7eead31-49a5af81969mr2061377137.28.1724899907529; Wed, 28 Aug 2024
 19:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
 <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev> <ZsxI6uCbGpQh1XrF@fedora>
 <1929CA74-3770-4B5D-B0A5-759911E97815@linux.dev> <D53C1E55-80A4-4F71-B93D-D357F424D2FF@linux.dev>
In-Reply-To: <D53C1E55-80A4-4F71-B93D-D357F424D2FF@linux.dev>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 29 Aug 2024 10:51:36 +0800
Message-ID: <CAFj5m9KmQZM8+nMORaQOJC-tzM0AOMz+kUyDa1r8V0NTcOVXtg@mail.gmail.com>
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:17=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Aug 27, 2024, at 15:24, Muchun Song <muchun.song@linux.dev> wrote:
> >
> >
> >
> >> On Aug 26, 2024, at 17:20, Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> On Mon, Aug 26, 2024 at 03:33:18PM +0800, Muchun Song wrote:
> >>>
> >>>
> >>>> On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> wr=
ote:
> >>>>
> >>>> On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei <ming.lei@redhat.co=
m> wrote:
> >>>>>
> >>>>> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
> >>>>>> Supposing the following scenario.
> >>>>>>
> >>>>>> CPU0                                                              =
  CPU1
> >>>>>>
> >>>>>> blk_mq_request_issue_directly()                                   =
  blk_mq_unquiesce_queue()
> >>>>>>  if (blk_queue_quiesced())                                        =
   blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
> >>>>>>      blk_mq_insert_request()                                      =
   blk_mq_run_hw_queues()
> >>>>>>          /*                                                       =
       blk_mq_run_hw_queue()
> >>>>>>           * Add request to dispatch list or set bitmap of         =
           if (!blk_mq_hctx_has_pending())     4) load
> >>>>>>           * software queue.                  1) store             =
               return
> >>>>>>           */
> >>>>>>      blk_mq_run_hw_queue()
> >>>>>>          if (blk_queue_quiesced())           2) load
> >>>>>>              return
> >>>>>>          blk_mq_sched_dispatch_requests()
> >>>>>>
> >>>>>> The full memory barrier should be inserted between 1) and 2), as w=
ell as
> >>>>>> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QU=
IESCED is
> >>>>>> cleared or CPU1 sees dispatch list or setting of bitmap of softwar=
e queue.
> >>>>>> Otherwise, either CPU will not re-run the hardware queue causing s=
tarvation.
> >>>>>
> >>>>> Memory barrier shouldn't serve as bug fix for two slow code paths.
> >>>>>
> >>>>> One simple fix is to add helper of blk_queue_quiesced_lock(), and
> >>>>> call the following check on CPU0:
> >>>>>
> >>>>>      if (blk_queue_quiesced_lock())
> >>>>>       blk_mq_run_hw_queue();
> >>>>
> >>>> This only fixes blk_mq_request_issue_directly(), I think anywhere th=
at
> >>>> matching this
> >>>> pattern (inserting a request to dispatch list and then running the
> >>>> hardware queue)
> >>>> should be fixed. And I think there are many places which match this
> >>>> pattern (E.g.
> >>>> blk_mq_submit_bio()). The above graph should be adjusted to the foll=
owing.
> >>>>
> >>>> CPU0                                        CPU1
> >>>>
> >>>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> >>>> blk_mq_run_hw_queue()
> >>>> blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
> >>>>  if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >>>>      return                                      blk_mq_run_hw_queue=
()
> >>>>  blk_mq_sched_dispatch_requests()                    if
> >>>> (!blk_mq_hctx_has_pending())     4) load
> >>>>                                                          return
> >>>
> >>> Sorry. There is something wrong with my email client. Resend the grap=
h.
> >>>
> >>> CPU0                                        CPU1
> >>>
> >>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> >>> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEU=
E_FLAG_QUIESCED)       3) store
> >>>   if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >>>       return                                      blk_mq_run_hw_queue=
()
> >>>   blk_mq_sched_dispatch_requests()                    if (!blk_mq_hct=
x_has_pending())     4) load
> >>>                                                           return
> >>
> >> OK.
> >>
> >> The issue shouldn't exist if blk_queue_quiesced() return false in
> >> blk_mq_run_hw_queue(), so it is still one race in two slow paths?
> >>
> >> I guess the barrier-less approach should work too, such as:
> >>
> >
> > If we prefer barrier-less approach, I think the following solution
> > will work as well, I'll use it in v2. Thanks.
> >
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index e3c3c0c21b55..632261982a77 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -2202,6 +2202,12 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw=
_ctx *hctx, unsigned long msecs)
> >> }
> >> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
> >>
> >> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hct=
x)
> >> +{
> >> +    return !blk_queue_quiesced(hctx->queue) &&
> >> +            blk_mq_hctx_has_pending(hctx);
> >> +}
> >> +
> >> /**
> >> * blk_mq_run_hw_queue - Start to run a hardware queue.
> >> * @hctx: Pointer to the hardware queue to run.
> >> @@ -2231,11 +2237,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx =
*hctx, bool async)
> >> * quiesced.
> >> */
> >>      __blk_mq_run_dispatch_ops(hctx->queue, false,
> >> -            need_run =3D !blk_queue_quiesced(hctx->queue) &&
> >> -            blk_mq_hctx_has_pending(hctx));
> >> +            need_run =3D blk_mq_hw_queue_need_run(hctx));
> >>
> >> -    if (!need_run)
> >> -            return;
> >> +    if (!need_run) {
> >> +            unsigned long flags;
> >> +
> >> +            /* sync with unquiesce */
> >> +            spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>
> After some time thought, I think here we need a big comment to explain
> why we need to sync. Because there are other caller of blk_queue_quiesced=
()
> which do not need to hold ->queue_lock to sync. Then, I am thinking
> is ->queue_lock really easier to be maintained than mb? For developers,
> we still need to care about this, right? I don't see any obvious benefit.
> And the mb approach seems more efficient than spinlock. Something like:
>
>         if (!need_run) {
>                 /* Add a comment here to explain what's going on here. */
>                 smp_mb();
>                 need_run =3D blk_mq_hw_queue_need_run(hctx);
>                 if (!need_run)
>                         return;
>         }
>
> I am not objecting to your approach, I want to know if you insist on
> barrier-less approach here. If yes, I'm fine with this approach. I can
> use it in v2.

Yes, as I mentioned, the race only exists on two slow code paths,
we seldom use barrier in slow paths, in which traditional lock
can provide a simpler & more readable solution.  Anytime,
READ/WRITE dependency implied in any barrier is hard to follow.

Thanks,


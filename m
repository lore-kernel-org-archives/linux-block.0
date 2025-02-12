Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FD1ACEA7
	for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402697; cv=none; b=ABzmFi1hX0gXR9ZiXMDLyYLrrT3p6TGzNKU3F1i591vbeQ2EEz/aUgb6m8MqWcR+YdsOwmdtqy9FozwUb5NMozt/FW3GGO9idIkFZmOpkkf4NcPIdCgg3J5Gv9hpNXneeiu7o+BgjddzA+GZniGUFHNgnhHvQimGct2scJKzrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402697; c=relaxed/simple;
	bh=VYCkVQ4ody9Oy8bqLeslS9U3ZkNrghuobPyucIsnfeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8CVXnEZu0W9tmgvrVUx9IABdmjsICEXQVq4s0/p55i1OFCDbuoFhZQ5YkA2cVmfzisyqybVwxbPSlP6tfbOlHzc7aFfEuwGpwpnugAsShUsypfWhousK8DKsPOJ3sXM4d+0ONPTddvO5Sgln5g6sfqDgYKC0nEbnROenWWmMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqM3kVne; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqM3kVne"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so275185276.2
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739402694; x=1740007494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7teNv0hSoJvgGAZj2lwT+a9xeFBveA/EnoNMOsv9DKc=;
        b=WqM3kVneP3lUqjST9hE3ECsv1AhM6XTWOaKxIjl/HnLwYIlpQw/YaOh4xhR7/las5s
         CtopfXkpZ93zjJMSLsqhcWu0FNdvvMLXKma3h0uOR+pQcatIb6rWGReulMl9BVCz41t8
         R+e1nNmeFlrphTBhDWnrKzEhv5w3EaVzUTEx0NHlNJtBfYixZV6SNAZW2/dQNL7simxC
         KLnX01NvwPpKatDroMHDWiMqIyAUIP+2qeXXvc6qInczZhQ1r57jTjbsCvi5PlXyg7iA
         j2FMFuKQMAsU9ot191D8TeqX6YO6tvboW8AiCPh78X11HdOjsZL18PCT7sxY/nh7+3+k
         hShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402694; x=1740007494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7teNv0hSoJvgGAZj2lwT+a9xeFBveA/EnoNMOsv9DKc=;
        b=JUymOOuXpw+MrFRf9ZsSdyMup2bXwK6ZVwZctz8pHvbrImPDdWqKLXoLP70/75mybF
         sXKzPsTEH0+mHq8vxzgaMPq8ZRQVX64d6olvLGs7SXkHUvg5m+nD8608lER5gZ2G90Am
         ka4ca5qU/mG93e1dSOQkh0cuEOIN6mLU9y2mlmLWYB/CSPg1WUmpZHHXOFeHC/rvPqzM
         iPAXcbKGBmIQEsAqeQtQw1PvH5p2ku+U5R9FnGWOt58jjazQgsLNKnEWuhRViXfZKxhE
         z0XY7v1YVz2+0YedTpYNzN8qwxMQ6BDeoIU4VB6zzNw8g1Te4VEDPZjcQtb10Ttdrckb
         6VUg==
X-Gm-Message-State: AOJu0YyAfOlbuu5vlVjf/n7mow+EQLVPtYeyDDepqOZ+lC3sWQfokglS
	bsAsJFcf+tyiNGONOm+GJ3+f+6yNyUQ3TrtBRlaSinHCKczAwxy/anlAoXxavjmqnJ+y5OKSdsN
	8a3PWSQVoDAhLjO2eRSA8nMXoFqZomwUx
X-Gm-Gg: ASbGnculvHrnZGhn7TcuaGweKEFqImbaw4H6j4iOq/Nq3ew+kigcwo1TkYUPEKtil15
	lwmVm3cyY+rI+39pXnb8uxtmts0oXCyxSstI7lwWFTfhfmze6GIf6IAINZmh/mLcjJYSkTAcX
X-Google-Smtp-Source: AGHT+IHN+fQeJ+J28d4csFOOiJ3gTrnwCOIYr1wPnXps9avB5I1ajrHWchkyV9Oc32+y+7tdiKEb8m+MIcWQIvFnmA8=
X-Received: by 2002:a05:6902:2601:b0:e5b:2427:8480 with SMTP id
 3f1490d57ef6-e5d9f115bd9mr5311533276.28.1739402694186; Wed, 12 Feb 2025
 15:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
 <Z6s-3LndN-Gt5sZB@fedora> <Z6tss9YS98AEIwQy@fedora>
In-Reply-To: <Z6tss9YS98AEIwQy@fedora>
From: Cheyenne Wills <cheyenne.wills@gmail.com>
Date: Wed, 12 Feb 2025 16:24:43 -0700
X-Gm-Features: AWEUYZka7c0aWfHBECJIqnZwJFv_KRtVWcXMdudAJMTmUbv8zhU88Tts8gth6TY
Message-ID: <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 8:29=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Feb 11, 2025 at 08:13:16PM +0800, Ming Lei wrote:
> > On Fri, Feb 07, 2025 at 07:09:39PM -0700, Cheyenne Wills wrote:
> > > While I was setting up to test with linux 6.14-rc1 (under Xen), I ran
> > > into a consistent NULL ptr dereference within __blk_rq_map_sg when
> > > booting the system.
> > >
> > > Using git bisect I was able to narrow down the "bad" commit to:
> > >
> > > block: add a dma mapping iterator (b7175e24d6acf79d9f3af9ce9d3d50de1f=
a748ec)
> > >
> > > Building a kernel with the parent commit
> > > (2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab) using the same .config doe=
s
> > > not fail.
> > >
> > > Following is the console log showing the error as well as the Xen
> > > (libvirt) configuration for the guest that I'm using.
> > >
> > > Please let me know if there is any additional information that I can =
provide.
> >
> > Can you test the following patch?
> >
>
> Please try the revised one:
>
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..a66d087a6b55 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -493,7 +493,7 @@ static bool blk_map_iter_next(struct request *req,
>                 return true;
>         }
>
> -       if (!iter->iter.bi_size)
> +       if (!iter->bio || !iter->iter.bi_size)
>                 return false;
>
>         bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
> @@ -514,6 +514,8 @@ static bool blk_map_iter_next(struct request *req,
>                         if (!iter->bio->bi_next)
>                                 break;
>                         iter->bio =3D iter->bio->bi_next;
> +                       if (!iter->bio)
> +                               break;
>                         iter->iter =3D iter->bio->bi_iter;
>                 }
>
>
>
>
> Thanks,
> Ming
>

Still getting a BUG at the same location.

I was able to capture the BUG using a xen gdbsx / gdb session (the
offending instruction is a mov  0x28(%rdx),%r13d and the bug is that
%rdx is zero. -- break *__blk_rq_map_sg+0x5e if $rdx =3D=3D 0)

It appears in __blk_rq_map_sg that the rq->bio is NULL at the start of
the routine.

Breakpoint 1, __blk_rq_map_sg (q=3D<optimized out>,
rq=3Drq@entry=3D0xffff888102231300, sglist=3D0xffff88810222f600,
last_sg=3Dlast_sg@entry=3D0xffffc90000137c08) at block/blk-merge.c:568
(gdb) bt
#0  __blk_rq_map_sg (q=3D<optimized out>,
rq=3Drq@entry=3D0xffff888102231300, sglist=3D0xffff88810222f600,
last_sg=3Dlast_sg@entry=3D0xffffc90000137c08) at block/blk-merge.c:568
#1  0xffffffff81db3a27 in blk_rq_map_sg (sglist=3D<optimized out>,
rq=3D0xffff888102231300, q=3D<optimized out>) at
./include/linux/blk-mq.h:1165
#2  blkif_queue_rw_req (rinfo=3D0xffff88810088c000,
req=3D0xffff888102231300) at drivers/block/xen-blkfront.c:754
#3  blkif_queue_request (rinfo=3D0xffff88810088c000,
req=3D0xffff888102231300) at drivers/block/xen-blkfront.c:880
#4  blkif_queue_rq (hctx=3D0xffff888102205c00, qd=3D<optimized out>) at
drivers/block/xen-blkfront.c:921
#5  0xffffffff818c1867 in blk_mq_dispatch_rq_list
(hctx=3Dhctx@entry=3D0xffff888102205c00,
list=3Dlist@entry=3D0xffffc90000137d38, nr_budgets=3Dnr_budgets@entry=3D0) =
at
block/blk-mq.c:2120
#6  0xffffffff818c7ca0 in __blk_mq_sched_dispatch_requests
(hctx=3Dhctx@entry=3D0xffff888102205c00) at block/blk-mq-sched.c:301
#7  0xffffffff818c820d in blk_mq_sched_dispatch_requests
(hctx=3Dhctx@entry=3D0xffff888102205c00) at block/blk-mq-sched.c:331
#8  0xffffffff818bdbdc in blk_mq_run_hw_queue
(hctx=3D0xffff888102205c00, async=3Dasync@entry=3Dfalse) at
block/blk-mq.c:2354
#9  0xffffffff818bec87 in blk_mq_run_hw_queues
(q=3Dq@entry=3D0xffff888100d49b00, async=3Dasync@entry=3Dfalse) at
block/blk-mq.c:2403
#10 0xffffffff818bfc52 in blk_mq_requeue_work
(work=3D0xffff888100d49cf8) at block/blk-mq.c:1568
#11 0xffffffff812c5528 in process_one_work
(worker=3Dworker@entry=3D0xffff888100c253c0, work=3D0xffff888100d49cf8) at
kernel/workqueue.c:3236
#12 0xffffffff812c668b in process_scheduled_works (worker=3D<optimized
out>) at kernel/workqueue.c:3317
#13 worker_thread (__worker=3D0xffff888100c253c0) at kernel/workqueue.c:339=
8
#14 0xffffffff812cfaf1 in kthread (_create=3D<optimized out>) at
kernel/kthread.c:464
#15 0xffffffff812502d4 in ret_from_fork (prev=3D<optimized out>,
regs=3D0xffffc90000137f58, fn=3D0xffffffff812cfa00 <kthread>,
fn_arg=3D0xffff888100c26340) at arch/x86/kernel/process.c:148
#16 0xffffffff812024aa in ret_from_fork_asm () at arch/x86/entry/entry_64.S=
:244
#17 0x0000000000000000 in ?? ()
(gdb) print *rq
$1 =3D {
  q =3D 0xffff888100d49b00,
  mq_ctx =3D 0xffff888206c37b00,
  mq_hctx =3D 0xffff888102205c00,
  cmd_flags =3D 262146,
  rq_flags =3D 2,
  tag =3D 2,
  internal_tag =3D 59,
  timeout =3D 30000,
  __data_len =3D 0,
  __sector =3D 18446744073709551615,
  bio =3D 0x0 <fixed_percpu_data>,
  biotail =3D 0x0 <fixed_percpu_data>,
  {
    queuelist =3D {
      next =3D 0xffff888102231348,
      prev =3D 0xffff888102231348
    },
    rq_next =3D 0xffff888102231348
  },
  part =3D 0x0 <fixed_percpu_data>,
  start_time_ns =3D 62585793058,
  io_start_time_ns =3D 0,
  stats_sectors =3D 0,
  nr_phys_segments =3D 0,
  nr_integrity_segments =3D 0,
  state =3D MQ_RQ_IN_FLIGHT,
  ref =3D {
    counter =3D 1
  },
  deadline =3D 4294759798,
  {
    hash =3D {
      next =3D 0x0 <fixed_percpu_data>,
      pprev =3D 0x0 <fixed_percpu_data>
    },
    ipi_list =3D {
      next =3D 0x0 <fixed_percpu_data>
    }
  },
  {
    rb_node =3D {
      __rb_parent_color =3D 18446612686400852888,
      rb_right =3D 0x0 <fixed_percpu_data>,
      rb_left =3D 0x0 <fixed_percpu_data>
    },
    special_vec =3D {
      bv_page =3D 0xffff888102231398,
      bv_len =3D 0,
      bv_offset =3D 0
    }
  },
  elv =3D {
    icq =3D 0x0 <fixed_percpu_data>,
    priv =3D {0x0 <fixed_percpu_data>, 0x0 <fixed_percpu_data>}
  },
  flush =3D {
    seq =3D 0,
    saved_end_io =3D 0x0 <fixed_percpu_data>
  },
  fifo_time =3D 0,
  end_io =3D 0xffffffff818b56b0 <flush_end_io>,
  end_io_data =3D 0x0 <fixed_percpu_data>
}


I suspect that the NULL dereference is in the initialization of the
req_iterator itself:

struct req_iterator iter =3D {
.bio =3D rq->bio,
.iter =3D rq->bio->bi_iter,        <<< here
};

Again let me know if there is any other information that I can provide.

Cheyenne

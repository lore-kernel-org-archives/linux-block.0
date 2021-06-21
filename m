Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F25DC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699816115B
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFUUGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhFUUGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:06:22 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537FC061574;
        Mon, 21 Jun 2021 13:04:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u2so6142370ilk.7;
        Mon, 21 Jun 2021 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oA+i7cyjpo0snGDbQFSo3up3eY3Q0ygdCA7tM5B6xdw=;
        b=Gmd5CVayHLlJ/ntmxBSN0XIQGAbesIBlcKHcago/BzdgI4ecmMBFXxDoyWtkMRQgk+
         5sh5ecBmpK1H/BLQZjnKdIKX63TJdJ7s3cwCl/kbQ5kVKSsIz2B7cSN63Y0szv7MfURn
         hmxBbiWcpW/lWJP8P+g+2aro8Wbbv18a/TKFhLJ3KlHzqP1n77RPspJK51x8Yx56QfHe
         0KSpJM22s17fwvAUZfoxxVg90qxWaEYPn7LXSsvU2dDjfV0RcXRe0e1BKwsiUFeM74I7
         Ah0arY3eX4zdZOT7dVZZfJyGlxThYkYtSz4+kq3q+kOrQX7FwAJYFoXjaAQRCa/dc4Rj
         G30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oA+i7cyjpo0snGDbQFSo3up3eY3Q0ygdCA7tM5B6xdw=;
        b=ibTMXgYVuEhoRFYnYAQLw80oXtqk9PKhyziZw6pM7vAI1KT2LQVgEmg5gidPjrRy/a
         hdhQCHiGu/FTXO0I3Y3bAAghdH/s4Ejm2E342rocLVQ/+IQrFhmdTk4c9vm5w9t9z642
         Y7lCvJ1Rhzr1YWLdaN1GJ8pPfy31sne8mYJMM+6J8ZQbp3/rwVYmI9N+AEWuegHgIouX
         M1vrBR8Vohx43X6erPBUK+WzbOkrVk6S3Uow7pRHsecBC9DPtFBvbk/mhtV3jEfSvlp2
         OZcXBv5Xpe/nOeRsuZNeoA7AQ5AuyHLhYUC1vMtLJlgwZ+7Y7SJFGPDbDTOmkczVvXMw
         zEEA==
X-Gm-Message-State: AOAM5314mEnzhIa7heGDyshu3QHIQFs563YCN8F2tJccDer1Jyde+PuQ
        qZTfXFsfZv3EyFb6w4qwXY9lGF+JHrAeQhygd98=
X-Google-Smtp-Source: ABdhPJzH65UFNyt41ipMYT/6WP4zzWtJR9CDsqrOFrHMWwnfW+zU8sPbxzcGJsAJDwvYkz+FqyQsWoVd5Yh6MfFShxg=
X-Received: by 2002:a92:b30b:: with SMTP id p11mr18089430ilh.114.1624305847680;
 Mon, 21 Jun 2021 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210619140948.98712-1-paolo.valente@linaro.org> <3533087.dJKXTdksHR@spock>
In-Reply-To: <3533087.dJKXTdksHR@spock>
From:   =?UTF-8?Q?Piotr_G=C3=B3rski?= <lucjan.lucjanov@gmail.com>
Date:   Mon, 21 Jun 2021 22:03:56 +0200
Message-ID: <CAL2Yj0QVe9PYTSmt2s294DS=P-UPTbGFC91fLLJnu15jQNCO5w@mail.gmail.com>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mariottiluca1@hotmail.it,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        pedroni.pietro.96@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have tested this with myself and this error does not occur with me
and I have not noticed any regressions. I have applied almost exactly
the same patches as Oleksandr.

pon., 21 cze 2021 o 21:55 Oleksandr Natalenko
<oleksandr@natalenko.name> napisa=C5=82(a):
>
> Hello.
>
> On sobota 19. =C4=8Dervna 2021 16:09:41 CEST Paolo Valente wrote:
> > Hi Jens,
> > this series contains an already proposed patch by Luca, plus six new
> > patches. The goals of these patches are summarized in the subject of
> > this cover letter. I'm including Luca's patch here, because it enabled
> > the actual use of stable merge, and, as such, triggered an otherwise
> > silent bug. This series contains also the fix for that bug ("block,
> > bfq: avoid delayed merge of async queues"), tested by Holger [1].
> >
> > Thanks,
> > Paolo
> >
> > [1] https://lkml.org/lkml/2021/5/18/384
> >
> > Luca Mariotti (1):
> >   block, bfq: fix delayed stable merge check
> >
> > Paolo Valente (5):
> >   block, bfq: let also stably merged queues enjoy weight raising
> >   block, bfq: consider also creation time in delayed stable merge
> >   block, bfq: avoid delayed merge of async queues
> >   block, bfq: check waker only for queues with no in-flight I/O
> >   block, bfq: reset waker pointer with shared queues
> >
> > Pietro Pedroni (1):
> >   block, bfq: boost throughput by extending queue-merging times
> >
> >  block/bfq-iosched.c | 68 +++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 53 insertions(+), 15 deletions(-)
> >
> > --
> > 2.20.1
>
> Not sure everything goes fine here. After applying this series on top of =
the
> latest stable 5.12 kernel I got this:
>
> ```
> [16730.963248] kernel BUG at block/elevator.c:236!
> [16730.963254] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [16730.963257] CPU: 11 PID: 109170 Comm: kworker/u64:5 Tainted: G        =
W
> 5.12.0-pf7 #1
> [16730.963260] Hardware name: ASUS System Product Name/Pro WS X570-ACE, B=
IOS
> 3601 05/26/2021
> [16730.963263] Workqueue: dm-thin do_worker [dm_thin_pool]
> [16730.963270] RIP: 0010:elv_rqhash_find+0xcc/0xd0
> [16730.963274] Code: 41 89 f0 81 e2 00 40 06 00 41 81 e0 1a 00 04 00 44 0=
9 c2
> 75 a9 be 09 00 00 00 c4 e2 4b f7 50 28 48 03 50 30 48 39 fa 75 c6 c3 <0f>=
 0b
> 66 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 47 68 48
> [16730.963276] RSP: 0018:ffffa558d13b7af8 EFLAGS: 00010046
> [16730.963279] RAX: ffff8a0007782d00 RBX: ffff8a0014b93000 RCX: ffffa558d=
13b7b78
> [16730.963281] RDX: ffff8a0014b93000 RSI: 0000000000063082 RDI: 000000001=
e0fdc00
> [16730.963283] RBP: ffff8a000731c770 R08: ffff8a000731c770 R09: fffffff0f=
fffddfb
> [16730.963284] R10: 0000000000000000 R11: 0000000000000400 R12: ffff8a033=
0365c00
> [16730.963286] R13: ffffa558d13b7b30 R14: 0000000000000000 R15: ffff8a021=
2fc4000
> [16730.963288] FS:  0000000000000000(0000) GS:ffff8a070ecc0000(0000) knlG=
S:
> 0000000000000000
> [16730.963290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16730.963292] CR2: 00007f1514d90f4c CR3: 0000000315952000 CR4:
> 0000000000350ee0
> [16730.963294] Call Trace:
> [16730.963297]  elv_merge+0x96/0x120
> [16730.963300]  blk_mq_sched_try_merge+0x3e/0x370
> [16730.963303]  bfq_bio_merge+0xd3/0x130
> [16730.963306]  blk_mq_submit_bio+0x11e/0x6c0
> [16730.963309]  submit_bio_noacct+0x457/0x530
> [16730.963312]  raid10_unplug+0x13f/0x1a0 [raid10]
> [16730.963316]  blk_flush_plug_list+0xa9/0x110
> [16730.963319]  blk_finish_plug+0x21/0x30
> [16730.963322]  process_prepared_discard_passdown_pt1+0x204/0x2d0
> [dm_thin_pool]
> [16730.963327]  do_worker+0x18e/0xce0 [dm_thin_pool]
> [16730.963335]  process_one_work+0x217/0x3e0
> [16730.963338]  worker_thread+0x4d/0x470
> [16730.963343]  kthread+0x182/0x1b0
> [16730.963349]  ret_from_fork+0x22/0x30
> =E2=80=A6
> [16730.963419] ---[ end trace dd7e037f2028257b ]---
> [16730.963524] RIP: 0010:elv_rqhash_find+0xcc/0xd0
> =E2=80=A6
> [16730.963547] note: kworker/u64:5[109170] exited with preempt_count 1
> [16747.948467] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waitin=
g for
> fences timed out!
> ```
>
> Which is:
>
> ```
> 229 struct request *elv_rqhash_find(struct request_queue *q, sector_t off=
set)
> 230 {
> =E2=80=A6
> 235     hash_for_each_possible_safe(e->hash, rq, next, hash, offset) {
> 236         BUG_ON(!ELV_ON_HASH(rq));
> =E2=80=A6
> ```
>
> Yes, I carry some extra patches besides this series (the list is against =
v5.12
> GA):
>
> ```
> block, bfq: reset waker pointer with shared queues
> block, bfq: check waker only for queues with no in-flight I/O
> block, bfq: avoid delayed merge of async queues
> block, bfq: boost throughput by extending queue-merging times
> block, bfq: consider also creation time in delayed stable merge
> block, bfq: fix delayed stable merge check
> block, bfq: let also stably merged queues enjoy weight raising
> block: Do not pull requests from the scheduler when we cannot dispatch th=
em
> blk: Fix lock inversion between ioc lock and bfqd lock
> bfq: Remove merged request already in bfq_requests_merged()
> block, bfq: avoid circular stable merges
> bfq: remove unnecessary BFQ_DEFAULT_GRP_IOPRIO
> bfq: reset entity->prio_changed in bfq_init_entity()
> bfq: optimize the calculation of bfq_weight_to_ioprio()
> bfq: remove unnecessary initialization logic
> bfq: keep the minimun bandwidth for CLASS_BE
> bfq: limit the IO depth of CLASS_IDLE to 1
> bfq: convert the type of bfq_group.bfqd to bfq_data*
> bfq: introduce bfq_entity_to_bfqg helper method
> bfq/mq-deadline: remove redundant check for passthrough request
> blk-mq: bypass IO scheduler's limit_depth for passthrough request
> block,bfq: fix the timeout calculation in bfq_bfqq_charge_time
> block, bfq: merge bursts of newly-created queues
> block, bfq: keep shared queues out of the waker mechanism
> block, bfq: fix weight-raising resume with !low_latency
> block, bfq: make shared queues inherit wakers
> block, bfq: put reqs of waker and woken in dispatch list
> block, bfq: always inject I/O of queues blocked by wakers
> ```
>
> but nothing from there triggered this for quite some time.
>
> Paolo, what do you think?
>
> --
> Oleksandr Natalenko (post-factum)
>
>

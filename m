Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187EC48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A51260FF1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 19:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFUT6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:58:04 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:59528 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFUT6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 15:58:03 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E819EAEF2DB;
        Mon, 21 Jun 2021 21:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1624305338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfMnv1hAPpBDenMisM/ic2ybNve50XEt6xLNZNWwwdk=;
        b=bCWr771Yaf9x68FTv2Eq5A4ecO+TBq4HAfiB48B56v021YKlcJlsF2Xnp3DHNIqiDTvPOA
        un5QIEjtZpkef85kmJJZL6szd3BR5G1nMREAJSQdSBjxcWhNuKLeq+VpAzRN0WnAwKLjaT
        FBVqDz+lV9Durkba6xAFVWsDbEngX2c=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control, boost throughput, fix bugs
Date:   Mon, 21 Jun 2021 21:55:36 +0200
Message-ID: <3533087.dJKXTdksHR@spock>
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On sobota 19. =C4=8Dervna 2021 16:09:41 CEST Paolo Valente wrote:
> Hi Jens,
> this series contains an already proposed patch by Luca, plus six new
> patches. The goals of these patches are summarized in the subject of
> this cover letter. I'm including Luca's patch here, because it enabled
> the actual use of stable merge, and, as such, triggered an otherwise
> silent bug. This series contains also the fix for that bug ("block,
> bfq: avoid delayed merge of async queues"), tested by Holger [1].
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2021/5/18/384
>=20
> Luca Mariotti (1):
>   block, bfq: fix delayed stable merge check
>=20
> Paolo Valente (5):
>   block, bfq: let also stably merged queues enjoy weight raising
>   block, bfq: consider also creation time in delayed stable merge
>   block, bfq: avoid delayed merge of async queues
>   block, bfq: check waker only for queues with no in-flight I/O
>   block, bfq: reset waker pointer with shared queues
>=20
> Pietro Pedroni (1):
>   block, bfq: boost throughput by extending queue-merging times
>=20
>  block/bfq-iosched.c | 68 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 15 deletions(-)
>=20
> --
> 2.20.1

Not sure everything goes fine here. After applying this series on top of th=
e=20
latest stable 5.12 kernel I got this:

```
[16730.963248] kernel BUG at block/elevator.c:236!
[16730.963254] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[16730.963257] CPU: 11 PID: 109170 Comm: kworker/u64:5 Tainted: G        W =
       =20
5.12.0-pf7 #1
[16730.963260] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIO=
S=20
3601 05/26/2021
[16730.963263] Workqueue: dm-thin do_worker [dm_thin_pool]
[16730.963270] RIP: 0010:elv_rqhash_find+0xcc/0xd0
[16730.963274] Code: 41 89 f0 81 e2 00 40 06 00 41 81 e0 1a 00 04 00 44 09 =
c2=20
75 a9 be 09 00 00 00 c4 e2 4b f7 50 28 48 03 50 30 48 39 fa 75 c6 c3 <0f> 0=
b=20
66 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 47 68 48
[16730.963276] RSP: 0018:ffffa558d13b7af8 EFLAGS: 00010046
[16730.963279] RAX: ffff8a0007782d00 RBX: ffff8a0014b93000 RCX: ffffa558d13=
b7b78
[16730.963281] RDX: ffff8a0014b93000 RSI: 0000000000063082 RDI: 000000001e0=
fdc00
[16730.963283] RBP: ffff8a000731c770 R08: ffff8a000731c770 R09: fffffff0fff=
fddfb
[16730.963284] R10: 0000000000000000 R11: 0000000000000400 R12: ffff8a03303=
65c00
[16730.963286] R13: ffffa558d13b7b30 R14: 0000000000000000 R15: ffff8a0212f=
c4000
[16730.963288] FS:  0000000000000000(0000) GS:ffff8a070ecc0000(0000) knlGS:
0000000000000000
[16730.963290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16730.963292] CR2: 00007f1514d90f4c CR3: 0000000315952000 CR4:=20
0000000000350ee0
[16730.963294] Call Trace:
[16730.963297]  elv_merge+0x96/0x120
[16730.963300]  blk_mq_sched_try_merge+0x3e/0x370
[16730.963303]  bfq_bio_merge+0xd3/0x130
[16730.963306]  blk_mq_submit_bio+0x11e/0x6c0
[16730.963309]  submit_bio_noacct+0x457/0x530
[16730.963312]  raid10_unplug+0x13f/0x1a0 [raid10]
[16730.963316]  blk_flush_plug_list+0xa9/0x110
[16730.963319]  blk_finish_plug+0x21/0x30
[16730.963322]  process_prepared_discard_passdown_pt1+0x204/0x2d0=20
[dm_thin_pool]
[16730.963327]  do_worker+0x18e/0xce0 [dm_thin_pool]
[16730.963335]  process_one_work+0x217/0x3e0
[16730.963338]  worker_thread+0x4d/0x470
[16730.963343]  kthread+0x182/0x1b0
[16730.963349]  ret_from_fork+0x22/0x30
=E2=80=A6
[16730.963419] ---[ end trace dd7e037f2028257b ]---
[16730.963524] RIP: 0010:elv_rqhash_find+0xcc/0xd0
=E2=80=A6
[16730.963547] note: kworker/u64:5[109170] exited with preempt_count 1
[16747.948467] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting =
for=20
fences timed out!
```

Which is:

```
229 struct request *elv_rqhash_find(struct request_queue *q, sector_t offse=
t)
230 {
=E2=80=A6
235     hash_for_each_possible_safe(e->hash, rq, next, hash, offset) {
236         BUG_ON(!ELV_ON_HASH(rq));
=E2=80=A6
```

Yes, I carry some extra patches besides this series (the list is against v5=
=2E12=20
GA):

```
block, bfq: reset waker pointer with shared queues
block, bfq: check waker only for queues with no in-flight I/O
block, bfq: avoid delayed merge of async queues
block, bfq: boost throughput by extending queue-merging times
block, bfq: consider also creation time in delayed stable merge
block, bfq: fix delayed stable merge check
block, bfq: let also stably merged queues enjoy weight raising
block: Do not pull requests from the scheduler when we cannot dispatch them
blk: Fix lock inversion between ioc lock and bfqd lock
bfq: Remove merged request already in bfq_requests_merged()
block, bfq: avoid circular stable merges
bfq: remove unnecessary BFQ_DEFAULT_GRP_IOPRIO
bfq: reset entity->prio_changed in bfq_init_entity()
bfq: optimize the calculation of bfq_weight_to_ioprio()
bfq: remove unnecessary initialization logic
bfq: keep the minimun bandwidth for CLASS_BE
bfq: limit the IO depth of CLASS_IDLE to 1
bfq: convert the type of bfq_group.bfqd to bfq_data*
bfq: introduce bfq_entity_to_bfqg helper method
bfq/mq-deadline: remove redundant check for passthrough request
blk-mq: bypass IO scheduler's limit_depth for passthrough request
block,bfq: fix the timeout calculation in bfq_bfqq_charge_time
block, bfq: merge bursts of newly-created queues
block, bfq: keep shared queues out of the waker mechanism
block, bfq: fix weight-raising resume with !low_latency
block, bfq: make shared queues inherit wakers
block, bfq: put reqs of waker and woken in dispatch list
block, bfq: always inject I/O of queues blocked by wakers
```

but nothing from there triggered this for quite some time.

Paolo, what do you think?

=2D-=20
Oleksandr Natalenko (post-factum)



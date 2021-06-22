Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B02C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074D6112D
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVHLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVHLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:11:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E5C061574
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 00:08:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c7so21275381edn.6
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ouoLlOX37fOnMdmhy/nvOY3q7XIh3oXIRronn/3MsjY=;
        b=zh9ca6MgxtzYxeLBDTVnja3YfYMjS/8KEto6OOACTGLnOWu1hz/t0f+ZuhXkiSPfr6
         mVWtg2Ii5Bh8de+A9444FYKfGXeOpZriIVD3bNo16UiEMavbK7fgGvfzxuXQvxzeK1He
         HEOcyPYK0z0OC5bRbH0sbrVIVjafqK/bkmBgHSZvSnJjDrB4lktsM/UzUjJCqUo6us0K
         hr+eEItCXB0pRd2GyuB6VDbtsGuCOemrQWUecOCxRgeq/AvHd5EJx+lpB+hUSib/CX6c
         ydZJWPSNOfogFBkU7XDuOckOcGnInaPKxmDPzLcu4HSbYSryy6Nlq9hjkV+7mNdEWB3r
         kXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ouoLlOX37fOnMdmhy/nvOY3q7XIh3oXIRronn/3MsjY=;
        b=H5D+WAYP8KOrj/y9WzQsNZ3xpNZqdyY0a/IgNe0nvclbeJqI35uPUiY88E4p0rDLlG
         cdMfI8jfv9D4B/KC0FKfTfHw2eQAyjEKSlERcdzeJD6RhJxQFeNhMg1qLOeXc5GQ/+rw
         Zo2KCSlZVnSyPGWWtph0BP2eSILSNi3hlBjHlICp96VZOpUaAopPQ/8zOcrSsZ/uhXir
         PTGb1yo0+VgDkqLPmxmtyt9Nxp0MMkf1ng28go/wey7HMc0vZf7VBc+KcJLl2C/UwHap
         nDPResmfYERAt/tPr6FyjGfhxrGqF5X2gEsvCGI6WVM43252pJ2Wc7yEatkwgLzk5hm3
         z8KA==
X-Gm-Message-State: AOAM533kzrIGAQHvS1ZuFHDBxgB7QjLzivDWoDrtIDVszLKfxoOA3F0g
        bvNXrTMgYhJPoXtX8lo6Ij+jq/cSewjBmCF/
X-Google-Smtp-Source: ABdhPJwqOTz+onUGGxsjYuoWrnecMlmXlInaI3F81PKHVBujT8cqjGxoBn4HTfndSLYcXhF11UR24Q==
X-Received: by 2002:aa7:d853:: with SMTP id f19mr2944976eds.1.1624345725131;
        Tue, 22 Jun 2021 00:08:45 -0700 (PDT)
Received: from ?IPv6:2a00:6020:440d:e400:95b3:cd1a:4cd9:d43f? ([2a00:6020:440d:e400:95b3:cd1a:4cd9:d43f])
        by smtp.gmail.com with ESMTPSA id s18sm5826731ejh.12.2021.06.22.00.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:08:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3533087.dJKXTdksHR@spock>
Date:   Tue, 22 Jun 2021 09:08:43 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CDC43F9-9CD9-4F7F-BD36-CCEB168B5245@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
 <3533087.dJKXTdksHR@spock>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
CCing also Jan and Khazhy, because in your commit log I see also the
commit on bfq_requests_merged().

Is this OOPS reproducible for you?

Thanks,
Paolo


> Il giorno 21 giu 2021, alle ore 21:55, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hello.
>=20
> On sobota 19. =C4=8Dervna 2021 16:09:41 CEST Paolo Valente wrote:
>> Hi Jens,
>> this series contains an already proposed patch by Luca, plus six new
>> patches. The goals of these patches are summarized in the subject of
>> this cover letter. I'm including Luca's patch here, because it =
enabled
>> the actual use of stable merge, and, as such, triggered an otherwise
>> silent bug. This series contains also the fix for that bug ("block,
>> bfq: avoid delayed merge of async queues"), tested by Holger [1].
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2021/5/18/384
>>=20
>> Luca Mariotti (1):
>>  block, bfq: fix delayed stable merge check
>>=20
>> Paolo Valente (5):
>>  block, bfq: let also stably merged queues enjoy weight raising
>>  block, bfq: consider also creation time in delayed stable merge
>>  block, bfq: avoid delayed merge of async queues
>>  block, bfq: check waker only for queues with no in-flight I/O
>>  block, bfq: reset waker pointer with shared queues
>>=20
>> Pietro Pedroni (1):
>>  block, bfq: boost throughput by extending queue-merging times
>>=20
>> block/bfq-iosched.c | 68 =
+++++++++++++++++++++++++++++++++++----------
>> 1 file changed, 53 insertions(+), 15 deletions(-)
>>=20
>> --
>> 2.20.1
>=20
> Not sure everything goes fine here. After applying this series on top =
of the=20
> latest stable 5.12 kernel I got this:
>=20
> ```
> [16730.963248] kernel BUG at block/elevator.c:236!
> [16730.963254] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [16730.963257] CPU: 11 PID: 109170 Comm: kworker/u64:5 Tainted: G      =
  W        =20
> 5.12.0-pf7 #1
> [16730.963260] Hardware name: ASUS System Product Name/Pro WS =
X570-ACE, BIOS=20
> 3601 05/26/2021
> [16730.963263] Workqueue: dm-thin do_worker [dm_thin_pool]
> [16730.963270] RIP: 0010:elv_rqhash_find+0xcc/0xd0
> [16730.963274] Code: 41 89 f0 81 e2 00 40 06 00 41 81 e0 1a 00 04 00 =
44 09 c2=20
> 75 a9 be 09 00 00 00 c4 e2 4b f7 50 28 48 03 50 30 48 39 fa 75 c6 c3 =
<0f> 0b=20
> 66 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 47 68 48
> [16730.963276] RSP: 0018:ffffa558d13b7af8 EFLAGS: 00010046
> [16730.963279] RAX: ffff8a0007782d00 RBX: ffff8a0014b93000 RCX: =
ffffa558d13b7b78
> [16730.963281] RDX: ffff8a0014b93000 RSI: 0000000000063082 RDI: =
000000001e0fdc00
> [16730.963283] RBP: ffff8a000731c770 R08: ffff8a000731c770 R09: =
fffffff0ffffddfb
> [16730.963284] R10: 0000000000000000 R11: 0000000000000400 R12: =
ffff8a0330365c00
> [16730.963286] R13: ffffa558d13b7b30 R14: 0000000000000000 R15: =
ffff8a0212fc4000
> [16730.963288] FS:  0000000000000000(0000) GS:ffff8a070ecc0000(0000) =
knlGS:
> 0000000000000000
> [16730.963290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16730.963292] CR2: 00007f1514d90f4c CR3: 0000000315952000 CR4:=20
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
> [16730.963322]  process_prepared_discard_passdown_pt1+0x204/0x2d0=20
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
> [16747.948467] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* =
Waiting for=20
> fences timed out!
> ```
>=20
> Which is:
>=20
> ```
> 229 struct request *elv_rqhash_find(struct request_queue *q, sector_t =
offset)
> 230 {
> =E2=80=A6
> 235     hash_for_each_possible_safe(e->hash, rq, next, hash, offset) {
> 236         BUG_ON(!ELV_ON_HASH(rq));
> =E2=80=A6
> ```
>=20
> Yes, I carry some extra patches besides this series (the list is =
against v5.12=20
> GA):
>=20
> ```
> block, bfq: reset waker pointer with shared queues
> block, bfq: check waker only for queues with no in-flight I/O
> block, bfq: avoid delayed merge of async queues
> block, bfq: boost throughput by extending queue-merging times
> block, bfq: consider also creation time in delayed stable merge
> block, bfq: fix delayed stable merge check
> block, bfq: let also stably merged queues enjoy weight raising
> block: Do not pull requests from the scheduler when we cannot dispatch =
them
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
>=20
> but nothing from there triggered this for quite some time.
>=20
> Paolo, what do you think?
>=20
> --=20
> Oleksandr Natalenko (post-factum)
>=20
>=20


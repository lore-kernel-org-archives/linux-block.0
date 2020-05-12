Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB3C54E4A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 12:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2A206CC
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl3B7tV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELMVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 08:21:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1CC061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 05:21:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 190so7676517qki.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNMj2rlG1OSgpA+oBJt35eCfiwJl9nzXzYioojneHy8=;
        b=Nl3B7tV7hZLLJWSBQ4GCnKOfFNaqdDKSCAVLGH2I3h4zesUJ9JQyzbtwo/33+Ng8Cq
         VWt/PNKo9m23T9BcglY2QtbebDxKl9ruG+37iDgigFTM5xrlEq8BO4VGGSfswKtiyVsF
         i6SvZ+U8GEamfqeS+y0SGOwTH+U3X07d/Fi5cteyimzGPl4fASPHLRvBjNzssZbPZPMz
         vpZ05e0X8mLVZvq7eiYMAU1uTAEUZUBEpHHG3jM3ZtDFUj23zIqFKsl/42IhPYNPOn98
         W7hFm0sJJsr7k03KMoSr7e2FdeiVGR025giJxXVQn53DYU7Mow1F56owVwl3JmKdmfAy
         ig+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNMj2rlG1OSgpA+oBJt35eCfiwJl9nzXzYioojneHy8=;
        b=Ax0C5H1QcFzTcIo2O7agVvw+nz4X3bN8xX2gBPFjD6TcxAZdjrofVG7NcG2Dnb1KzW
         FTTFDLey5FugEAk/HhnidxAHivuc95OI+s131vvduuy7mZGC/7Mr0sD8RyGBrUevUuuj
         IaP5fUodv7Y414jxv6AheVYliGBRNTnD5vHQD0cH62GFXzU6OMgToQkvdN/VmnCykkMx
         iL9FhN6vqow/fzsQHV3Ty2Xx5HrRlZaDthXmGKi8HhpYh3Ye9P7gTkUOkY9N1t+dd6KJ
         J7cB9yfCf/Pq+yzCPc8cFDf3H0zshxKfMvInY9hMp/nq8aez2iKxmJmrlGxKoMNgvtjl
         3Dng==
X-Gm-Message-State: AGi0PuYXPVGooaBZMSEjy+5OHUnir1AIY+Kcwti8vnTwEldLWo4SQZGs
        GskMB8zy/UQORYDvLvnRtK5mnHfxePTaKM8aKBQ=
X-Google-Smtp-Source: APiQypKiSW6QgMhROJMQFqlXL1SkwRlxkr/Ts2zPd9G7s2noLh7I8BarOMU0o8NarmHQCBAJoF2BlH3eCYh83obpThk=
X-Received: by 2002:a37:6203:: with SMTP id w3mr20963763qkb.477.1589286063451;
 Tue, 12 May 2020 05:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org> <CAA70yB6iG3YmMzHDbhv864wi9dOonb9wFY8GiOMjD6DLSHokNA@mail.gmail.com>
In-Reply-To: <CAA70yB6iG3YmMzHDbhv864wi9dOonb9wFY8GiOMjD6DLSHokNA@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 12 May 2020 20:20:52 +0800
Message-ID: <CAA70yB42BDtpgkpM1UL_CkBjNAFAWOaWuoga+1eDPd=LoHWnbg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware queue
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, tom.leiming@gmail.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 12, 2020 at 8:09 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> On Tue, May 12, 2020 at 9:31 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2020-05-07 06:03, Weiping Zhang wrote:
> > > This series mainly fix the kernel panic when increase hardware queue,
> > > and also fix some other misc issue.
> >
> > Does this patch series survive blktests? I'm asking this because
> > blktests triggers the crash shown below for Jens' block-for-next branch.
> > I think this report is the result of a recent change.
> >
> > run blktests block/030
> >
> > null_blk: module loaded
> > Increasing nr_hw_queues to 8 fails, fallback to 1
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2f2/0x830
> > Read of size 8 at addr 0000000000000128 by task nproc/8541
> >
> > CPU: 5 PID: 8541 Comm: nproc Not tainted 5.7.0-rc4-dbg+ #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> > Call Trace:
> >  dump_stack+0xa5/0xe6
> >  __kasan_report.cold+0x65/0xbb
> >  kasan_report+0x45/0x60
> >  check_memory_region+0x15e/0x1c0
> >  __kasan_check_read+0x15/0x20
> >  blk_mq_map_swqueue+0x2f2/0x830
> >  __blk_mq_update_nr_hw_queues+0x3df/0x690
> >  blk_mq_update_nr_hw_queues+0x32/0x50
> >  nullb_device_submit_queues_store+0xde/0x160 [null_blk]
> >  configfs_write_file+0x1c4/0x250 [configfs]
> >  __vfs_write+0x4c/0x90
> >  vfs_write+0x14b/0x2d0
> >  ksys_write+0xdd/0x180
> >  __x64_sys_write+0x47/0x50
> >  do_syscall_64+0x6f/0x310
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> > Thanks,
> >
>
> Hi Bart,
>
> I don't test block/030, since I don't pull blktest very often.
>
> It's a different problem,
> because the mapping cann't be reset when do fallback, so the
> cpu[>=1] will point to a hctx(!=0).
>
>  it should be fixed by:
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bc34d6b572b6..d82cefb0474f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3365,8 +3365,8 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>                 goto reregister;
>
>         set->nr_hw_queues = nr_hw_queues;
> -       blk_mq_update_queue_map(set);
>  fallback:
> +       blk_mq_update_queue_map(set);
>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
>                 blk_mq_realloc_hw_ctxs(set, q);
>                 if (q->nr_hw_queues != set->nr_hw_queues) {

And block/030 should also be improved ?

 35         # Since older null_blk versions do not allow "submit_queues" to be
 36         # modified, check first whether that configs attribute is writeable.
 37         # Each iteration of the loop below triggers $(nproc) + 1
 38         # null_init_hctx() calls. Since <interval>=$(nproc), all possible
 39         # blk_mq_realloc_hw_ctxs() error paths will be triggered. Whether or
 40         # not this test succeeds depends on whether or not _check_dmesg()
 41         # detects a kernel warning.
 42         if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
 43                 for ((i = 0; i < 100; i++)); do
 44                         echo 1 > $sq
 45                         nproc > $sq  # this line output lots
"nproc: write error: Cannot allocate memory"
 46                 done
 47         else
 48                 SKIP_REASON="Skipping test because $sq cannot be modified"
 49         fi


The test result show this test case [failed], actually it [pass],
there is no warning detect
in kernel log, if apply above patch.

block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [failed]
    runtime  1.999s  ...  2.115s
    --- tests/block/030.out 2020-05-12 10:42:26.345782849 +0800
    +++ /data1/zwp/src/blktests/results/nodev/block/030.out.bad
2020-05-12 20:14:59.878915218 +0800
    @@ -1 +1,51 @@
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    +nproc: write error: Cannot allocate memory
    ...
    (Run 'diff -u tests/block/030.out
/data1/zwp/src/blktests/results/nodev/block/030.out.bad' to see the
entire diff)

Thanks
Weiping

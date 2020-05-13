Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F5C2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 00:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0971620753
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 00:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqbQKYPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEMAnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 20:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 20:43:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D4C061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 17:43:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so15703783qke.7
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4i8WTDWXLYbo/YZA/qMySToEPxRwfa4E3QTm5p1yFng=;
        b=QqbQKYPDE/om2GYvpKow7hfwh6aoVtODRetlrXdK1Byj4wti6NAfr9Jnbyf2fmIyJH
         NHhck6kzMw1exXjDRcScu+8xc92rE1ADVLyM3WrpCagmXjOugZbEqFbXZZ/wqqXEY5CO
         6aJvEc5RhD44sa3NW6795q724kUnAEX7u3+xoW7pab4KzmJqORlthej7IKWnHpy4CrLW
         VMFfwKLDw1mGxD6mBSQ4ejrIyt7ufEJnv1Mld3H7/SfbtdOk14U/L+D8/swFZ40ArF4T
         VdqyrBImuTjZ5Aaq33NudrrGrHOnF5B1JIeHCG0E+kwcExEHr2keuwIU0pLEuXtehmky
         OwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4i8WTDWXLYbo/YZA/qMySToEPxRwfa4E3QTm5p1yFng=;
        b=kaoiGq0edgMJDPyxttZeSpPZJ6rZrlRQ8XqupVeVwrsgbWuScXWjE0MW/dtuSj4ScS
         pmcSPcs3mga0nY1H0hL3njSHnHFjTGwBfwrliZX6BVCexyG+pp9tqKgQNDuTrTvctgaq
         H1bPnmEOBVngBjwkvdiUCFDac7VIPcGlRbqSvoYWEkk0GyuXBNmfQDefwzeSpK3haodX
         2P1OEnlxhbzLHcqxuNfEAG0U06zjasx656F6gfNUkaa+2TQe33rsNkCUy8cfh8PUzjXA
         RZlxg/0u/OLk+I64Ea3ZDgqXMctqOiCyGkyUiHoFgrhh85Hvejoqrhj2xK8e7hp1tdn1
         4ruw==
X-Gm-Message-State: AGi0PubtYTQ7VnVC8nzzRDwHtts5icLR5T7vEArZ+2tlTIwzqud6mQ+R
        azfYMedfefZTPs1+XRXsoTHENAnOQgoYRIQTNxE=
X-Google-Smtp-Source: APiQypLB77srblqgg33YNsuq6mTvviqCOPQgNK8Z4/mVxcS49j0BpMAEG1P/avJQ/2sFLu3n53tGFTeeBE3mMnpFY4s=
X-Received: by 2002:a37:6203:: with SMTP id w3mr24031221qkb.477.1589330629247;
 Tue, 12 May 2020 17:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org> <CAA70yB6iG3YmMzHDbhv864wi9dOonb9wFY8GiOMjD6DLSHokNA@mail.gmail.com>
 <CAA70yB42BDtpgkpM1UL_CkBjNAFAWOaWuoga+1eDPd=LoHWnbg@mail.gmail.com> <beb354c0-d2db-ccfb-476c-03f03594c78e@acm.org>
In-Reply-To: <beb354c0-d2db-ccfb-476c-03f03594c78e@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 13 May 2020 08:43:37 +0800
Message-ID: <CAA70yB6XPiZijWZmpevN709w0U5sDH5kY_WmxwmOYEqtN0iu5w@mail.gmail.com>
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

On Wed, May 13, 2020 at 7:08 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-05-12 05:20, Weiping Zhang wrote:
> > On Tue, May 12, 2020 at 8:09 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> >> I don't test block/030, since I don't pull blktest very often.
>
> That's unfortunate ...
>
> >> It's a different problem,
> >> because the mapping cann't be reset when do fallback, so the
> >> cpu[>=1] will point to a hctx(!=0).
> >>
> >>  it should be fixed by:
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index bc34d6b572b6..d82cefb0474f 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -3365,8 +3365,8 @@ static void __blk_mq_update_nr_hw_queues(struct
> >> blk_mq_tag_set *set,
> >>                 goto reregister;
> >>
> >>         set->nr_hw_queues = nr_hw_queues;
> >> -       blk_mq_update_queue_map(set);
> >>  fallback:
> >> +       blk_mq_update_queue_map(set);
> >>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >>                 blk_mq_realloc_hw_ctxs(set, q);
> >>                 if (q->nr_hw_queues != set->nr_hw_queues) {
>
> If this is posted as a patch, feel free to add:
>
> Tested-by: Bart van Assche <bvanassche@acm.org>
>
Post it latter, thank you

> > And block/030 should also be improved ?
> >
> >  35         # Since older null_blk versions do not allow "submit_queues" to be
> >  36         # modified, check first whether that configs attribute is writeable.
> >  37         # Each iteration of the loop below triggers $(nproc) + 1
> >  38         # null_init_hctx() calls. Since <interval>=$(nproc), all possible
> >  39         # blk_mq_realloc_hw_ctxs() error paths will be triggered. Whether or
> >  40         # not this test succeeds depends on whether or not _check_dmesg()
> >  41         # detects a kernel warning.
> >  42         if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
> >  43                 for ((i = 0; i < 100; i++)); do
> >  44                         echo 1 > $sq
> >  45                         nproc > $sq  # this line output lots
> > "nproc: write error: Cannot allocate memory"
> >  46                 done
> >  47         else
> >  48                 SKIP_REASON="Skipping test because $sq cannot be modified"
> >  49         fi
> >
> >
> > The test result show this test case [failed], actually it [pass],
> > there is no warning detect
> > in kernel log, if apply above patch.
> >
> > block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [failed]
> >     runtime  1.999s  ...  2.115s
> >     --- tests/block/030.out 2020-05-12 10:42:26.345782849 +0800
> >     +++ /data1/zwp/src/blktests/results/nodev/block/030.out.bad
> > 2020-05-12 20:14:59.878915218 +0800
> >     @@ -1 +1,51 @@
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     +nproc: write error: Cannot allocate memory
> >     ...
> >     (Run 'diff -u tests/block/030.out
> > /data1/zwp/src/blktests/results/nodev/block/030.out.bad' to see the
> > entire diff)
>
> That's weird. I have not yet encountered this. Test block/030 passes on
> my setup.
>
> Thanks,
>
> Bart.

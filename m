Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F29C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 05:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKAFGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 01:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAFGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 01:06:10 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D513D3F
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 22:06:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i12so9680086qvs.2
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTThmV3apwKutx5mPZ6rLFzjTx0EoNpOu6L39fUT9iw=;
        b=jichQ0BIDVucR1JWEy0sMvwEeqTZ44mioH3txbRMI8WZtdk1yf/zYtJLo5WGUygq1D
         qp9dPW3+F3mU5rV+iNPfzCEppOl3qxasop7zzWxpcKRe8QxYU/bLTocT/I22AbBAq7w4
         DkpBR4DvurqRwdfbRezK0+SxKcYgazT8TPaRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTThmV3apwKutx5mPZ6rLFzjTx0EoNpOu6L39fUT9iw=;
        b=FJ2q6jQRZcjLXRqjwV91PXzTQgOub0AVpVyoGlwHMNPkIVS7tkQSC76hsZD6SUkBg+
         ysu/+NrNwSiPEYb/oTxgcTrj5/VWiouQGtM71QjiuMF4qp5jZhZaBHJkZvtNQnXsFy9e
         tq4BFWJRDW/LcPdlgv9SFsLAlFhG1l8AouBPK/Tu7IAWVbhw642GCkKUK/mgcifF7WZJ
         K9q0oFV5FV2UTRmsyJYab/j7xw1DD0MzQFDzLLk0VzlhkXgocSHVWK0ys838fJjuhDKd
         7rX42retgmnMpz4Z1T9GKXQbwOUM2Wd9cfhiV0PUEwpk3qKD82NNANRb0M00Vb5HE05J
         KcRQ==
X-Gm-Message-State: ACrzQf1FY4ZQFtN8wyorXiEL52x7AUQFNvbNzg1e7CW4OYPahKJgtbSL
        rVJftQmOjE3wGWgMsgDfsqz62lF5NJgWWA==
X-Google-Smtp-Source: AMsMyM5n3rPS+JUw6ui0+GYhqe8P3W1lKWL8vPpvIR+Tp5MpPoq0hqeN5pkOa0IWELifts7819vzyg==
X-Received: by 2002:a05:6214:2342:b0:473:e142:f758 with SMTP id hu2-20020a056214234200b00473e142f758mr14322506qvb.83.1667279166094;
        Mon, 31 Oct 2022 22:06:06 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm5832613qkd.134.2022.10.31.22.06.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 22:06:05 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id z1so3064849qkl.9
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 22:06:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:6ee:d68b:5b26 with SMTP id
 v9-20020a05620a440900b006eed68b5b26mr11943094qkp.47.1667279164717; Mon, 31
 Oct 2022 22:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
In-Reply-To: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 31 Oct 2022 22:05:52 -0700
X-Gmail-Original-Message-ID: <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
Message-ID: <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
Subject: Re: Why don't we always grab bfqd->lock for bio_bfqq?
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 9:37 PM Khazhy Kumykov <khazhy@chromium.org> wrote:
>
> I'm investigating a NULL deref crash in bfq_add_bfqq_busy(), wherein
> bfqq->woken_list_node is hashed, but bfqq->waker_bfqq is NULL - which
> seems inconsistent per my reading of the code.
>
> Wherein I see bfq_allow_bio_merge() both accesses and modifies
> accesses bfqd->bio_bfqq without bfqd->lock, which strikes me as odd.
> The call there though to bfq_setup_cooperator and bfq_merge_bfqqs()
> seem wrong to me. In particular, the call to bfq_merge_bfqqs() I am
> suspecting can cause the inconsistency seen above, since it's the only
> place I've found that modifies bfqq->waker_bfqq without bfqd->lock.
>
> But I'm curious in general - what's special about bio_bfqq? Should we
> grab bfqd->lock when touching it? e.g. bfq_request_merge() also
> accesses bio_bfqq without grabbing the lock, where-in we traverse
> bfqq->sort_list - that strikes me as odd as well, but I'm not fully
> familiar with the locking conventions here. But it feels like,
> especially since we can merge bfqqs, so bio_bfqq is shared - this
> lockless access seems wrong.

Something on this front, since it does look like in *some* paths we do
call blk_mq_sched_allow_merge()/bfq_allow_bio_merge() with the lock
held, and some paths we do not - e.g. blk_mq_sched_try_merge gets
called directly by the schedulers (and bfq calls it under the lock).

However, blk_attempt_bio_merge also calls blk_mq_sched_allow_merge(),
and it's called by blk-mq directly on the submission path
(blk_bio_list_merge <- blk_mq_sched_bio_merge <-
blk_mq_attempt_bio_merge <- blk_mq_get_new_requests <-
blk_mq_submit_bio), and so we'll call bfq_allow_bio_merge without
bfqd->lock held in this path only.

I can see also for bfq_request_merge(), it gets called under
bfqd->lock, since the only path to ->request_merge() is through
blk_mq_sched_try_merge() - which is called by the schedulers. If I'm
understanding this correctly, and the functions are intended to be
called under the locks, perhaps it'd be appropriate to add some
lockdep_held annotations?

Khazhy

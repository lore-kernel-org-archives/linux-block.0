Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C5C677F1
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjBTWwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 17:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjBTWwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 17:52:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B889222D3
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 14:52:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec43so9629921edb.8
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 14:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pSE7wovrJ+19+kaPmt+dDnKGunQwppXMgjPl6shrdyA=;
        b=Ungmk6R4CKTKX8tUx0vh1FtsymRIy8ovuaAmUX4SPe5ucxvs4SyjXPCi3iyGDLGAER
         6cPzEWUngH836lmdR2EwTp5OQUb2Q7BCBfLnt6cKtrvIs38epGLHp3kDH79hDYSTG8R7
         ttYuzfeloL3Vr1BZrR6cSO3JR9nYeAWGgIrQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSE7wovrJ+19+kaPmt+dDnKGunQwppXMgjPl6shrdyA=;
        b=uI0vn59u6XIeyKNpoaO7bakW3lZ5c1HYcj/nC51uaszMv3WzmkMUPiPlFa0VyV5lyx
         JS3K9zCiS7kI0YLe1JzOJ9Nm+pV5R9M7v90ql75PBYhP8wdGm8MArKJB0AjbC1IF4U7e
         0rpoKCejf5KI43Iu9lrgeNGxD6msjRTXOV9ViKUxrj53N/qlCQvnLnoq0WRwJxoRZU3m
         3ZbMlQLqMxhChpRTR1fgK0gBFmXa0iIC8t2HwZdrWHpzHBKTNsTonq5AREj0Bn57o+S8
         iv4rz69bkEKOeEGqEdyM1ZmtH2qVE4pcnoKQKSkNH2HkDnR8v83/uedJe0w/tdZMLtGH
         Vs5A==
X-Gm-Message-State: AO0yUKUUBRsel0dXGBSwaOM/2eyDyswfg1rDVOHRQMf6ZXXBwo89oHsS
        +JJoYy2LCb0h7H+CuP1BUE2qr9v80TUiyl8Voi4=
X-Google-Smtp-Source: AK7set+ed3jBnOiHpawCcEbgU+Lx5BTDBVQjbxQGJiwjFqjIVZF4JdOGgUwsSI1Sd9udtPwY5ZnZng==
X-Received: by 2002:aa7:d88f:0:b0:4ac:cb71:42c with SMTP id u15-20020aa7d88f000000b004accb71042cmr3730921edq.37.1676933549313;
        Mon, 20 Feb 2023 14:52:29 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id c14-20020a50d64e000000b004a249a97d84sm1580934edj.23.2023.02.20.14.52.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 14:52:28 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id da10so11364510edb.3
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 14:52:28 -0800 (PST)
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr5925873ejx.15.1676933548452; Mon, 20
 Feb 2023 14:52:28 -0800 (PST)
MIME-Version: 1.0
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
In-Reply-To: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Feb 2023 14:52:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
Message-ID: <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 6:54 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I've pushed a merged branch here:
>
> https://git.kernel.dk/cgit/linux-block/log/?h=for-6.3/block-merged

Hmm. I do verify against suggested merges after doing my own (even
when your suggested merge was then made stale by another later
addition), and I think your merge was wrong wrt bfq_sync_bfqq_move(),
which in your version does the bfq_release_process_ref() before doing
the bic_set_bfqq().

IOW, I think your merge essentially dropped one of the fixes in commit
b600de2d7d3a ("block, bfq: fix uaf for bfqq in bic_set_bfqq()").

Maybe there were reasons why that ordering wasn't required any more,
but it looks funky (and you appear to have correctly merged the other
case in bfq_check_ioprio_change()).

Anyway, this is just a nit-picky email saying that I'm pretty sure
I've done the merge right, but since it doesn't match what you did, I
thought I'd mention it.

Worth double-checking this, in other words. I realize you're mostly
afk this week, so whenever you're back.

                Linus

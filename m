Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FEEC636D7
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 01:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBVBHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVBHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 20:07:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E1311E8
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 17:07:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g1so24032393edz.7
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2g0RHZVEIiWO3OIqRkyUcoO3R3WE+Le7mW/S4WakV5c=;
        b=A9WV4GetEaql6salGaVyyg4900VenlaFWyxwzzZanIBH2hTt/KIv6Of2U9KimFs3Sj
         qTxCOSXrQplkpJEUaZ0fJXoNlE3eqM/srrGvyU29F+RyGwYbl5dhM/BRhmetvcLXqfsH
         o86IB6ieaorCOVW7MvQM2KzYQ21IHXZZd+890=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g0RHZVEIiWO3OIqRkyUcoO3R3WE+Le7mW/S4WakV5c=;
        b=yddO4649pHjM1NS0X8T6AHqms7MgizYN3HsRNIYKQKdRxmaedG+fwSNIJ1CcSk30HJ
         dSksO+fcqbQPRDwf825RzJP8znUsxt0SmYb29Jqd/QloAxKhE9pjjF/Y881E/KsJ8qXj
         ta5U6GLbBokDtN2nOwBODl19s/SWRoEs/hIETp5fUL/QFWQ9J3ZlAw4etbLiIG3nwa6O
         c+AdLyYJjGOkwElM/Ue+Cn4X2Dx7No1qF9w/XsqxWDbStqHg82jP5T9b8QbL/RnmOgoe
         N0+FFZWJG3YaP36v4JyMNHzy4PlcwQxUhor6CPg6Z3H9cECqPiwPTXCwiu7ikAvBhHcM
         PpGg==
X-Gm-Message-State: AO0yUKWAkgWNqH7ML0VZ75Uiq9nRImIVmFlRWFfnqFhX4+9EAyMceE6V
        FbkPDaDBrjRa3dYb7Qv7CZFyoXEVaE5AnRR2JAk=
X-Google-Smtp-Source: AK7set9RB0CXQpZJYE5huYEL3teWDDHInJ57Csq4E6b+wZ1RIKElwDvIPcRG9ug/vCK2Zb6mhbB5HQ==
X-Received: by 2002:a05:6402:783:b0:4ac:bbaa:842f with SMTP id d3-20020a056402078300b004acbbaa842fmr6614805edy.39.1677028051151;
        Tue, 21 Feb 2023 17:07:31 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id p11-20020a056402074b00b004acc1374849sm1835895edy.82.2023.02.21.17.07.30
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 17:07:30 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ec43so23756574edb.8
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 17:07:30 -0800 (PST)
X-Received: by 2002:a17:906:a402:b0:8cf:8bd6:8b8c with SMTP id
 l2-20020a170906a40200b008cf8bd68b8cmr4028929ejz.0.1677028050206; Tue, 21 Feb
 2023 17:07:30 -0800 (PST)
MIME-Version: 1.0
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
 <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com> <9a048f21-1938-084d-b328-8a345bd20263@kernel.dk>
In-Reply-To: <9a048f21-1938-084d-b328-8a345bd20263@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 17:07:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimXoc_vsdfzVKAu6cHd_M1U3d5Dxtib1U4JdXMNUxLoQ@mail.gmail.com>
Message-ID: <CAHk-=wimXoc_vsdfzVKAu6cHd_M1U3d5Dxtib1U4JdXMNUxLoQ@mail.gmail.com>
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 21, 2023 at 4:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'll double check it. The merge doesn't end up touching any of
> bfq_sync_bfqq_move()

It absolutely does.

Or rather - your merge doesn't end up touching it, and I claim that's
exactly the problem.

My merge *does* touch it, and I think my merge is the right thing to do..

> just conflicting with:
>
> bfq_check_ioprio_change(), where the release ordering should be upheld,

That's the trivial case.

But:

> __bfq_bic_change_cgroup(), where it's still done after assigning the
> async_bfqq.

No.

That's where bfq_sync_bfqq_move() *comes* from. See commit
9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator
basis").

The whole bfq_sync_bfqq_move() function didn't exist at all in the
tree that fixed the bfq_release_process_ref() ordering.

It was split out of the __bfq_bic_change_cgroup() code, so the change
to __bfq_bic_change_cgroup() needed to now instead be done in that
bfq_sync_bfqq_move() code.

           Linus

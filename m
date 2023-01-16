Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F313DC677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAPSWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjAPSVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:21:25 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516042DF6
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:07:30 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d16so12292867qtw.8
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=hC8rifHiuHXCPgttcmOOf/xO+1ZeeDOeIZfW9Ym8Ory+CkzNJPkrfO/C3JXy2EE1LL
         2kTaAysayLbTpr+7RDLLrKq0FCECx/EKRPZa3mKY+K67nyLJZ8f7PA4gCRWG73mV4Yn4
         5cdNgXBpvhk8M9iRXw8+R8fW3tOu/c3Ashp10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=A0uOF2ddQ65biKC471Ry75wuAiYFgRznGy6GKX4/OK2A1CMR896Pj3cQx33u7IIs5J
         xvlWXFhvZLqdsKluudXHGgBXeYxavcRwQNWO1NZGrQy6sIaOFV9AI9dFRwIVeI/S2DHA
         1bfZyWNtWEZil1U4Wy+8v7ZuZdiLCzXkvnwf8UCsFys/+tn9w0yXLATaT9RfPyATcq8q
         DrPbLyXBryvT1pDYY6jvI+FgGdlZUNJod5IFMHu1Nmaig/bpKFqYPPNBctDSXC+iuLBB
         9pS8ny2VCjGsiksWnSzz1mLwUiqa39dXxS5J+rgN2ODUJvpQ7NZa1wo1Jl9idmgRoN/D
         zDpQ==
X-Gm-Message-State: AFqh2ko4MhNpwoIJ0ysBAP3UiJc2o5vfIRFI6GsjiAjEVxgYbSzAUgwe
        BLFjtItRHqHtoBBCMLm5BcMG9AXEEEnTzMrU
X-Google-Smtp-Source: AMrXdXt68QTSP14I7/B5f/LJAZRgzJNh7zOiWH1CCHUwSOo7lxMwm0/OjzXeEYx9+zPCLKyt2HlJnw==
X-Received: by 2002:ac8:450d:0:b0:3b6:30e1:f480 with SMTP id q13-20020ac8450d000000b003b630e1f480mr6056439qtn.32.1673892443742;
        Mon, 16 Jan 2023 10:07:23 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id e7-20020ac80647000000b003a69225c2cdsm14885574qth.56.2023.01.16.10.07.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:07:23 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id s19so1367063qkg.7
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:07:23 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr364175qtb.452.1673892068650; Mon, 16
 Jan 2023 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:00:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[ Back from travel, so trying to make sense of this series.. ]

On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.

Ugh. I hate how this adds random patterns like

        if (timeout == MAX_SCHEDULE_TIMEOUT)
                sdt_might_sleep_strong(NULL);
        else
                sdt_might_sleep_strong_timeout(NULL);
   ...
        sdt_might_sleep_finish();

to various places, it seems so very odd and unmaintainable.

I also recall this giving a fair amount of false positives, are they all fixed?

Anyway, I'd really like the lockdep people to comment and be involved.
We did have a fairly recent case of "lockdep doesn't track page lock
dependencies because it fundamentally cannot" issue, so DEPT might fix
those kinds of missing dependency analysis. See

    https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

for some context to that one, but at teh same time I would *really*
want the lockdep people more involved and acking this work.

Maybe I missed the email where you reported on things DEPT has found
(and on the lack of false positives)?

               Linus

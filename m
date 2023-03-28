Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6368AC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 15:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjC1PWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjC1PW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 11:22:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2866FF1F
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:20:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z83so15542514ybb.2
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONZYLiGDk21RMFgMpaXH7s4UWxHkNsJ+wUGHRFEkuCc=;
        b=c8ynwXPsqcK1BZ6E1vrYfDJcqWTKC225pVcmZQQIcGa+4WzKkC/FwoXCPTIZP0uqNW
         jalQxGai5+TUgtreV4lGVmixYr6hAEF97bJP6udFm1yicUDr3KPFXDmLE2aJHchJhqAj
         7J4XebvBwK691HXXFYm5J21xAY8msOd5k/OOZSjNYpGC2QnLfu+09Jc4Pbhux+Hpz5l/
         35fyjYPGGFQ/WwDLWWO9LuBpYSShrGA9j+zLmlaXc44UkvAaGsRQX8zqrH4aOojgeFnH
         DBkes4tXkEWXNeFd/n9ARofjF5njrlz0PZjoz9j8BGF67LqPGhfa7EH16H69NZfFsNx5
         Xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONZYLiGDk21RMFgMpaXH7s4UWxHkNsJ+wUGHRFEkuCc=;
        b=01feMrNkOACbNRQ6FbNq8dXbMyzytIauA8EbENltpMrW6vaxFk72K2kTfj02J3zwEh
         lsn9QkffYfWOpchKzdIBrbqIJzuuuub99S1dMRTIIGVV+moQVOMpjt+A4bEvYZ3yoKBs
         atg127ZRHwTD9NjtsBXG96FkbOCqADIsyTO9sYYZcBRSRM3EOl6IXELC7ySEsOd567jT
         DN+VPV6cTcNX1KW/9DKiQnK3agK26WTKm69wr0grbc3k64d67XOxAKboFcU+V0UIkZ1H
         TG65AwsBxvAX+Ii1tB18LDZawd4lIA/h2auwI7v0ipx4ou2kucJmpaoGHdzskJflakZt
         v0hw==
X-Gm-Message-State: AAQBX9eh5W+y0XI5qJSMCYe8NBpAQLr6dAdBpBAPWTzxjuEFqcKPGFar
        QNBy/vSLRnVgXC1tMMMaunFvcyn9iOmRHh4j8zit7g==
X-Google-Smtp-Source: AKy350Z1lvsH1c3O1jHKo+DM2HBpLRhmt4Hwp7gRiZRJb5+27sNfylAL7/FK3qaRf4mMZ9UmJB/3uw0wBUSKxNqtrno=
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr9838517ybu.12.1680016826025; Tue, 28
 Mar 2023 08:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-10-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-10-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:20:15 -0700
Message-ID: <CALvZod4boccrKxrCm9aDBCupror1zC0J3spHeidSiAZgei_r9Q@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] memcg: do not modify rstat tree for zero updates
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 11:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In some situations, we may end up calling memcg_rstat_updated() with a
> value of 0, which means the stat was not actually updated. An example is
> if we fail to reclaim any pages in shrink_folio_list().
>
> Do not add the cgroup to the rstat updated tree in this case, to avoid
> unnecessarily flushing it.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

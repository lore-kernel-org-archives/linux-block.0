Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9C8C761AF
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1N02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC1N01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 09:26:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC71BFF
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 06:26:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z83so15017824ybb.2
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bJymL0yBKvMYTD1Xc/qu3GglkLI9FvB8Lv/yuqvRQc=;
        b=eZy1jM+Kd53ZIzWNbOqgWbWL45Dr+Nw9ANo2PWtQbmVaWtrjCdrDAwPWv3yK9p7pwn
         NdX2H4aYwg5QRk1CBz5Q+PDjxvTvxqOymyHBX8fhYiwV1krbMVJo3/thEa0eeD2ncqtr
         11MW+NX2xIo4RJWivNGz5B/TSrAzZmnzZLla0MAE4rR5mfGrSLcqNM08TimNues3s+u/
         7Y5UuSgD0RzJHWmkNAiahoW2q/TpdkuXvww90IJ4ZT0HDPDLUtzwosiL6k1Ay9MagttR
         Xll6pq0j7ma1HAlACEp1cDHFcxilfs9tVtLUSpSaT3tswN2NAz96yvtBv6Q2jzszETWW
         11rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bJymL0yBKvMYTD1Xc/qu3GglkLI9FvB8Lv/yuqvRQc=;
        b=MVcsOPYdHDdI7D+A9NO4K3ku/MyweMBn+NJyA23NNXRcSQvmMnO39ZKI/sauMwRHtZ
         92p2MT7rJHtjiboYsaRstGTpVK01QSq+Ei5EwUX+cVSCajOjxYq3CmflifzYTB8RiPt9
         85/cBeJV0cIv/qWI90hDJ5RBGlAFkdFrMpAeMI7MQOEFuPZqweMl3mduOCWluXIsrOr/
         Qt9cCNTaEvVgCo44jD7b7gkBEwnHI7vJYWBBVknynPDshrsydAZl+b9lbvJu4f14Ub/F
         eUjOgvzGtaLwaUCSTq9hrtZHR1coFMcjJ3kHHCEWehJ24h3mHjCQ2F6P9ph5jT7vR6Ak
         k3Kw==
X-Gm-Message-State: AAQBX9fhkiIsBd6dEgtKIlXCRxZGV89jJ2qR/6nu4GMNkERJh52HmtD3
        FRsLJOgc2+qU92gmGc6tvZXsy290Ezr2Se5vnfG1QA==
X-Google-Smtp-Source: AKy350Zja1hP9WxwT3nbR4kgm/32+esIcZm0ttA35DlxybRpCP5Bjc/9FU70PICjQ5T/32D5BoknkSe4x+2lmAwB5IY=
X-Received: by 2002:a25:e054:0:b0:b6b:d3f3:45af with SMTP id
 x81-20020a25e054000000b00b6bd3f345afmr9852686ybg.1.1680009985214; Tue, 28 Mar
 2023 06:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-4-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-4-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 06:26:14 -0700
Message-ID: <CALvZod6n64b80+ZPX13bBiJWagcMJBstAcLauQoiT=UMdx0QGw@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] memcg: do not flush stats in irq context
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

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Currently, the only context in which we can invoke an rstat flush from
> irq context is through mem_cgroup_usage() on the root memcg when called
> from memcg_check_events(). An rstat flush is an expensive operation that
> should not be done in irq context, so do not flush stats and use the
> stale stats in this case.
>
> Arguably, usage threshold events are not reliable on the root memcg
> anyway since its usage is ill-defined.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

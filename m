Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA45C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 07:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjC3H4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjC3H4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 03:56:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2746A63
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:55:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w9so73112646edc.3
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=ZD9aj6n0GX26RjIgVcV8XWHXeXxhiTySnXtfLlIh2Y4ULsYer620/o/Gxai5NDEyx0
         U9cLhrKkIyrcXCb9H0C1LsSrI3aYqgf3GO6P4vMGibxu+NJs5rV7tQbNe7/BuzZ9ngD4
         QlTJGq/55WJCvX0baHxwlbOU546xXFXX3rhwhxfTlPe1DtgL+SZFj+3v/M/zynT9IjDn
         ZyadAB66teMDMbs9xKwieRC4GEnlOFheMYpz1xGF7yvvoKjAofsoTZMoVDKAnSS6/+pv
         n2YA0BsqSmXP4EqjlRt/DgekBF6qWk4ejPD+mZWis8RRK9kN76WGkT00+z0dkPShQagp
         7beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=17eAluZM61G1Ioo2TM9DtnpWr0+tzQBAO7QLNAbLCUmbhnXA4RlKUwWwnADE5yS8eB
         Kfc9+PfuXSpMu7zm3vksxqH/IcSzw1BCA1dQclIVa6rYA+vBArmZ3XXMXbLFzcKw5ING
         J4ZqMw0vAs07BDxneeguQRNvCWhhzPTKWKrg4m1RogXa+BcG7kr/8FIXGHxmhInFN4mi
         J7DP1L/C4jNvP19M5P7W3DKZjvKPkbtUMRM9pw7vCkYK6MQ1sMlggDqdsD1cW+oLPdir
         G5VLD2thRgNRs7WVpEUGynVAeZ25lgZh9pNTm4IYLHVAR0fvncOKsPdKqASQfTZmNcBy
         /JWA==
X-Gm-Message-State: AAQBX9eb8hkSYgh84WUQ0+jwFca4Y2FVwN4LC7rYosaDrdb41j0o+Ti+
        s5EWSzfcfHzZIBZ5C2tD5m+ClqvpKefnGA0FjV2jPw==
X-Google-Smtp-Source: AKy350ZKBVchKo8yL5qnCRGOKj6HMXymGhCHv0sbs5xG5akH53sSrKAZcQmbeW6Sz+oAWJWB2Er2VE8WUpb+CRjLT3s=
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr10952473ejb.15.1680162953989; Thu, 30
 Mar 2023 00:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com> <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
 <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com> <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
In-Reply-To: <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:55:17 -0700
Message-ID: <CAJD7tkZfexGoyZx0ormVzp_KkYmOczxBPfFaffKqd_TD4gvGCg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Thu, Mar 30, 2023 at 12:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 30-03-23 00:42:36, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > > > In workingset_refault(), we call
> > > > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within a=
n
> > > > RCU read section and with sleeping disallowed. Move the call above
> > > > the RCU read section and allow sleeping to avoid unnecessarily
> > > > performing a lot of work without sleeping.
> > >
> > > Could you say few words why the flushing is done before counters are
> > > updated rather than after (the RCU section)?
> >
> > It's not about the counters that are updated, it's about the counters
> > that we read. Stats readers do a flush first to read accurate stats.
> > We flush before a read, not after an update.
>
> Right you are, my bad I have misread the intention here.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> --
> Michal Hocko
> SUSE Labs

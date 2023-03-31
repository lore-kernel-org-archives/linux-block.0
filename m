Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A84C77B6C
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 19:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCaTE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCaTE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 15:04:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536122E84
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 12:04:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so93592309edd.1
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680289464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBgtdWro37xy0xED7gYpWdnIpcRD6CvxaVJDB91GKvs=;
        b=fL6JQwfkCzg5k8MIp2yW1eevTYpumo4axpAUWjeQVnxZ023oShCKTwLmnAc/fye6xx
         neR98ZJVj6piv4J9ecd7xjjIQYyACuTq59qmaCS3yTQOGPhA91OF92s4v9CkBWSpvvKM
         rz65GCEGOOJ8yjBjMqwAS3b3tgCOZKNxFJajWQaJRjRdc4CSg/cA57O8D+Oq6Oe1LAJ4
         2mVn/cvkii1QVT3GcQW/mRwIrCzXmOwHpOMN8C/onm9XRgMZ288OdnZgwdQUr7MMj8+8
         RRbSZfC/Y3QYlXMJZsdEzOOnNaU20+AvLyLZyFhObvmRedEK5bFf9W0VpJPo3NjJ/PlU
         ADqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBgtdWro37xy0xED7gYpWdnIpcRD6CvxaVJDB91GKvs=;
        b=hZ88YC7Ax1RESFRK4WnNKtAcakdFm6JYfzJLRSpz17DSaq/Klpigu4TiAELvcdw+c0
         7z1d9i92dK2f02Fy6N3nIzEU1Irlh9KDFC/dl6P7FXzgSxeLK6buCEBhWUTzPM2b398r
         TITp2Uikhi1NY37ms0n5F1lMCbIJvrNMSBBjKPbvzoqutMCqVVTng3GLgGTtmyIzNe67
         h24EUzx+VfLM1hsX/d+ioLiGje8+e03iCTpTGvotvWy2LASzSN+028heqk03SqLU6/Q8
         noIGqYnhC0P4GvuapoPAlYFz12WXm5HZt+6WjgUkg4luWMX8ZPLw2PLoDeGxp6aQR7wb
         XRKA==
X-Gm-Message-State: AAQBX9cKCcY4pD5OqcJe5pTpd2pLrBQEQAroT+b2mOyBMurjfv4OHgvV
        H5tqdRJ1dHSddXcGlzT3LxTDMDgmMkbZoFMlke5x9Q==
X-Google-Smtp-Source: AKy350Zu5bBwTsywOca+UGIcS/HARlLbeBWAVVNB4lZtMspaiROXuzs3nwneenpby7qGskVTJooNUd+2uG/N2dk1CQM=
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr14495139ejb.15.1680289464033; Fri, 31
 Mar 2023 12:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz> <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz> <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
 <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz> <CAJD7tkYEOVRcXs-Ag3mWn69EwE4rjFt9j5MAcTGCNE8BuhTd+A@mail.gmail.com>
 <ZCa9sixp3GJcjf8Y@dhcp22.suse.cz>
In-Reply-To: <ZCa9sixp3GJcjf8Y@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 12:03:47 -0700
Message-ID: <CAJD7tka-2vNn25=NdrKQoMf4ntdbWtojY0k4eAa-c9D+v7J=HQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Fri, Mar 31, 2023 at 4:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-03-23 01:53:38, Yosry Ahmed wrote:
> [...]
> > Maybe we can add a primitive like might_sleep() for this, just food for=
 thought.
>
> I do not think it is the correct to abuse might_sleep if the function
> itself doesn't sleep. If it does might_sleep is already involved.

Oh, sorry if I wasn't clear, I did not mean to reuse might_sleep() --
I meant introducing a new similar debug primitive that shouts if irqs
are disabled.

> --
> Michal Hocko
> SUSE Labs

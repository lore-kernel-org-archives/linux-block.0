Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCDCC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C3F20748
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iaf2NJFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHUUXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUUXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:23:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AAC061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:23:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so3196156ljn.11
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3D+TqH2GckoXVS0G3AVPPpXHl/Ts1q0PzrQAkDG5DxU=;
        b=Iaf2NJFcLLPjJhCFY4NPJilmEIWG1EFZPPdHf4a8cj0cg5EIjHpega0AiSsQdtW2bk
         gfJ+fc6kt7IQS7SnbVWnC7nVl1NCVvIvAYMA+W7ZX4lygUpP1+w1ZAYWXppaTBAf8FnJ
         HLiubgJccGNPYTJixoFrXXnbWGuO3t08zDeHSeMZCXjnotaLbkFq91VPkpSg8AOzFma2
         6iZ7V4Oefj3vBgGenVmlNikMMYEnqUWK1a+A4pNOYTR11AA0IqAS6HeY4XIaHwSMRWmH
         w3QNtXRLNxeUZuRdcDTgKqZ6ih6/11rJX2eAqK4u7o5a+KWL4L4g4AZjl5yls4ZEKP7/
         G2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3D+TqH2GckoXVS0G3AVPPpXHl/Ts1q0PzrQAkDG5DxU=;
        b=t3AMuxP0tHfHq2+piRW0yfB2b2EMdniGEoe7uKiXcHa0ec5C+EBnZ3GL++ZrgeHXF5
         itBUqfdIKYlnL/ESjyGLdCF/laeWm1NfCB5elyD4y6S2Hdm3k14V1YWu3jucjPFZb7y/
         QNtWXE7OqllX0aQvjZWbv6GWcDkxDaKX/mvJoA5gDqNoac6PY5MldOnaI2HuEn8ty/np
         KfiVb1rao4SkCnSX5gprrZTryBDiswWsR37hMszAbp9eHgOFStodUx9MOMWaa5icBS73
         xkC+T+W5qqMg4vDSK5jMEw20spRT0knrzCRXSqv7FpT0wNaduORU9GXId6wKIFBvSwtD
         FlkQ==
X-Gm-Message-State: AOAM530hYgbCE/D4GMHjgjKvshUJ9BcDJNujISHZiKIgz/ti6/JKfX0Q
        2NbMpMQOCkwE9qkb7PxGFOdAiBVVTdZJpC0MrAusNg==
X-Google-Smtp-Source: ABdhPJxtB3gytKgy43PrfoEOXffDzmegXgekhXTFkNzcg9j+nkrkWcOxp0q7UZtL0bR4N1sDGWoc4+ZBzIS8qEtpwWY=
X-Received: by 2002:a05:651c:330:: with SMTP id b16mr2290021ljp.77.1598041411383;
 Fri, 21 Aug 2020 13:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
 <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <20200821160128.GA2233370@carbon.dhcp.thefacebook.com> <CALvZod69w5UoCjfWcqVAejpKWzRAUxX7dEPzqDUknHhUFV_XEA@mail.gmail.com>
 <20200821200530.GA2250889@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200821200530.GA2250889@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Aug 2020 13:23:20 -0700
Message-ID: <CALvZod7mfgOab_NSBegCcJ4jL6pb98CfckUhk7QgNCLsmiB4aQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 1:05 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Aug 21, 2020 at 09:27:56AM -0700, Shakeel Butt wrote:
> > On Fri, Aug 21, 2020 at 9:02 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Fri, Aug 21, 2020 at 11:04:05AM -0400, Dan Schatzberg wrote:
> > > > On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
> > > > > On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > > > > >
> > > > > > Much of the discussion about this has died down. There's been a
> > > > > > concern raised that we could generalize infrastructure across loop,
> > > > > > md, etc. This may be possible, in the future, but it isn't clear to me
> > > > > > how this would look like. I'm inclined to fix the existing issue with
> > > > > > loop devices now (this is a problem we hit at FB) and address
> > > > > > consolidation with other cases if and when those need to be addressed.
> > > > > >
> > > > >
> > > > > What's the status of this series?
> > > >
> > > > Thanks for reminding me about this. I haven't got any further
> > > > feedback. I'll bug Jens to take a look and see if he has any concerns
> > > > and if not send a rebased version.
> > >
> > > Just as a note, I stole a patch from this series called
> > > "mm: support nesting memalloc_use_memcg()" to use for the bpf memory accounting.
> > > I rewrote the commit log and rebased to the tot with some trivial changes.
> > >
> > > I just sent it upstream:
> > > https://lore.kernel.org/bpf/20200821150134.2581465-1-guro@fb.com/T/#md7edb6b5b940cee1c4d15e3cef17aa8b07328c2e
> > >
> > > It looks like we need it for two independent sub-systems, so I wonder
> > > if we want to route it first through the mm tree as a standalone patch?
> > >
> >
> > Another way is to push that patch to 5.9-rc2 linus tree, so both block
> > and mm branches for 5.10 will have it. (Not sure if that's ok.)
>
> Ok, it looks like the patch provides a generally useful API enhancement.
> And we do have at least two potential use cases for it.
> Let me send it as a standalone patch to linux-mm@.
>
> Btw, Shakeel, what do you think of s/memalloc_use_memcg()/set_active_memcg() ?
>

I am fine with it.

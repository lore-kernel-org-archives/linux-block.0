Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927EC28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 08:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE5F2184D
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 08:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvJi5Oqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgEII6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgEII6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 04:58:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C65AC061A0C;
        Sat,  9 May 2020 01:58:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so4157685ljb.9;
        Sat, 09 May 2020 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sBoYn3WeTZFCcqj57bcpCNR9WzBcjBDg78zlrXn2Bo=;
        b=IvJi5OqftthYrAXQhCGJSEsNr2Ugk0p4lQGhUpMXBi99TyDjBaGPGU98kHtcygIgoM
         dl7DoUhZYDjjoo87SDHBuPdevJlXBve6Oha7wQhCl6jYtbCM9UE4PSu5hV31mzRsSahr
         wZLitRfkJMNIvWhTpo4PgkNHNQlioQYMslFX9wyHmSQJOAGx14vlZt3mu0MN/rl9nKqB
         LtllpntMrN72NK9ou1yLBxOk7PovAncUkEPgztLCKA72CRBehtj6TjqznyxZ1s4vKPlo
         VYrRD4vlhkowpqWcqeQ2wvZWrnBjVbZvy153zB4K8b+b+cYWX9DQzaiooNv3jWd+5ApN
         a4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sBoYn3WeTZFCcqj57bcpCNR9WzBcjBDg78zlrXn2Bo=;
        b=Z2HdyHLUexIeF46kIOIvH8nSiNWx6u1bznKgjg7v4Qb1r+iCnGMaeG3Qs39PB/cAsN
         wgv8yHW2X+s/vd8C50QfHc5APz6nYPFzyWPDu9mUu0CVGK2NgN4anfP80+j0+hT/pxAh
         MD5riivrw60279ShzSnqVET6Mgzi2BIHTvrJvZ2j02IxdiJdoDoI08SEzBK4F9BIBWnI
         LZNq4E+EOJKZW///KMfgeEol5tzVWPA53dDeVx6hkJSQu0WFkBmun1Zaj/8kNCR+6kKU
         ZX/dWNIjsqKB62NL59TPNe8fZaV8qXSOKrbEz+vNHJ/iNtAUbEva0W3SZZiRpvZKp7DC
         29zA==
X-Gm-Message-State: AOAM533XrzV8Nu4NUp+SKO2xsRiIC6+/oESGso3yeZGtJmuLwS41Z7pw
        we9TuYNhI6aHUuM8myf395RYJyxx8o+m6coTfdg=
X-Google-Smtp-Source: ABdhPJyRTtqcpC3jRUEkt6dyiDw0ymbF4WnirRlZbb3xJW+dnVzaS2G2GlylUAI5l/EqveHhvpmoQIn3N+E4jEcdptg=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr4048684ljc.48.1589014679642;
 Sat, 09 May 2020 01:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587888520.git.baolin.wang7@gmail.com> <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org> <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590> <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
In-Reply-To: <20200508232222.GA1391368@T590>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sat, 9 May 2020 16:57:48 +0800
Message-ID: <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch processing
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 9, 2020 at 7:22 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Sagi,
>
> On Fri, May 08, 2020 at 03:19:45PM -0700, Sagi Grimberg wrote:
> > Hey Ming,
> >
> > > > Would it make sense to elevate this flag to a request_queue flag
> > > > (QUEUE_FLAG_ALWAYS_COMMIT)?
> > >
> > > request queue flag usually is writable, however this case just needs
> > > one read-only flag, so I think it may be better to make it as
> > > tagset/hctx flag.
> >
> > I actually intended it to be writable.
> >
> > > > I'm thinking of a possibility that an I/O scheduler may be used
> > > > to activate this functionality rather than having the driver set
> > > > it necessarily...
> > >
> > > Could you explain a bit why I/O scheduler should activate this
> > > functionality?
> >
> > Sure, I've recently seen some academic work showing the benefits
> > of batching in tcp/ip based block drivers. The problem with the
> > approaches taken is that I/O scheduling is exercised deep down in the
> > driver, which is not the direction I'd like to go if we are want
> > to adopt some of the batching concepts.
> >
> > I spent some (limited) time thinking about this, and it seems to
> > me that there is an opportunity to implement this as a dedicated
> > I/O scheduler, and tie it to driver specific LLD stack optimizations
> > (net-stack for example) relying on the commit_rq/bd->last hints.
> >
> > When scanning the scheduler code, I noticed exactly the phenomenon that
> > this patchset is attempting to solve and Christoph referred me to it.
> > Now I'm thinking if we can extend this batching optimization for both
> > use-cases.
>
> Got it, thanks for the sharing.
>
> >
> > > batching submission may be good for some drivers, and currently
> > > we only do it in limited way. One reason is that there is extra
> > > cost for full batching submission, such as this patch requires
> > > one extra .commit_rqs() for each dispatch, and lock is often needed
> > > in this callback.
> >
> > That is not necessarily the case at all.
>
> So far, all in-tree .commit_rqs() implementation requires lock.
>
> >
> > > IMO it can be a win for some slow driver or device, but may cause
> > > a little performance drop for fast driver/device especially in workload
> > > of not-batching submission.
> >
> > You're mostly correct. This is exactly why an I/O scheduler may be
> > applicable here IMO. Mostly because I/O schedulers tend to optimize for
> > something specific and always present tradeoffs. Users need to
> > understand what they are optimizing for.
> >
> > Hence I'd say this functionality can definitely be available to an I/O
> > scheduler should one exist.
> >
>
> I guess it is just that there can be multiple requests available from
> scheduler queue. Actually it can be so for other non-nvme drivers in
> case of none, such as SCSI.
>
> Another way is to use one per-task list(such as plug list) to hold the
> requests for dispatch, then every drivers may see real .last flag, so they
> may get chance for optimizing batch queuing. I will think about the
> idea further and see if it is really doable.

How about my RFC v1 patch set[1], which allows dispatching more than
one request from the scheduler to support batch requests?

[1]
https://lore.kernel.org/patchwork/patch/1210034/
https://lore.kernel.org/patchwork/patch/1210035/

-- 
Baolin Wang

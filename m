Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696C8C4363A
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 02:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3243207EA
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 02:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKoycxCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374738AbgJWCsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374737AbgJWCsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 22:48:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F898C0613CE
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 19:48:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so29166qvz.4
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 19:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUlXLFHHO2pz9gCLOpYoVRPu8zwA6xOAQj1aUQFi4ok=;
        b=JKoycxCdLN7pQ3Y94zPKy1Wa37yZ0EUrnPRlISLHIzQaXBV0nU/Y7pWp697rWXqnsT
         ziZIoet8B/Ys288HkjKieHn3UkgI0tRaJc1VBUvr3kZ+poh3g5qolM3gnGfric2Vd0gL
         O5FG71KCaM8QZDhXAkfQbFT+PgUiyaiWhOVpcjiuogGOIaKe0mYa9joNz+vkef2zBxe6
         e1nXafSWLWrzxf+bff5RMH/9yrUanyIbXvfkpGnZd1QT65As0LT3mlcwTSV4eiW6bZD5
         CC4mjnBggW/JxWrK/r5v22/JUU/7NGedOmv580dynBIwhBBz7lcjMh7TNyVTdWHm6XJE
         YzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUlXLFHHO2pz9gCLOpYoVRPu8zwA6xOAQj1aUQFi4ok=;
        b=HvNLyfexL3u0WlWpkEaRmOWpNxkfSeSImFcuymt5em4GFd0P1FyJexTkHjJZkZMDMB
         /iSftOYtpnoR6RZ01CZvYA+TgUNFfWjtpdV6eslyitfLUou8Azh4MtqRFVsPZ3+XPlR2
         kU0sqgmQ1I8PTCNHABrNQ3+qmCYEPt9i2oFv/bWORXcHoLAYfIBRnwtlpIysxh0AIIrS
         UrPYylV/+7yyqAoewPONpzOd/n9k+seZW9FYuwHwIAspeT5AAs7UTBQrWgwkbqoH+eTR
         NNST/CzPZirA3AoMzArCEr/ZUUYk14kRJYikdaby11kklO6hj837QbaaXvRJN0Pwn+/A
         35lg==
X-Gm-Message-State: AOAM533lbafl1ynY3U43w2Up8RqGVXA6YTB1X0dyrvDDthDq/N4dGTUe
        szN2H3dGR0VSQ58iZOTsaXjbkL5AReZnYROZZF8IyT0EdMUtUg==
X-Google-Smtp-Source: ABdhPJyLUEmt74jdPGc7EV50U2CN3d2htrta1R374iYpMUXJAZVyNtViOajxuSMAJWfYYxPFTOA20FWYMdzMh7mlINE=
X-Received: by 2002:a05:6214:122a:: with SMTP id p10mr368082qvv.0.1603421310190;
 Thu, 22 Oct 2020 19:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200324031942.GA3060@ming.t460p> <20200324035313.GE30700@redhat.com>
In-Reply-To: <20200324035313.GE30700@redhat.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 23 Oct 2020 10:48:19 +0800
Message-ID: <CAA70yB5mFgKKBbJRQ=3Nv+XbVXbSUjmnAGOsUtBT2+s9f4az+Q@mail.gmail.com>
Subject: Re: very inaccurate %util of iostat
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, mpatocka@redhat.com,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 24, 2020 at 11:54 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Mon, Mar 23 2020 at 11:19pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
>
> > Hi Guys,
> >
> > Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > changes calculation of 'io_ticks' a lot.
> >
> > In theory, io_ticks counts the time when there is any IO in-flight or in-queue,
> > so it has to rely on in-flight counting of IO.
> >
> > However, commit 5b18b5a73760 changes io_ticks's accounting into the
> > following way:
> >
> >       stamp = READ_ONCE(part->stamp);
> >       if (unlikely(stamp != now)) {
> >               if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> >                       __part_stat_add(part, io_ticks, 1);
> >       }
> >
> > So this way doesn't use any in-flight IO's info, simply adding 1 if stamp
> > changes compared with previous stamp, no matter if there is any in-flight
> > IO or not.
> >
> > Now when there is very heavy IO on disks, %util is still much less than
> > 100%, especially on HDD, the reason could be that IO latency can be much more
> > than 1ms in case of 1000HZ, so the above calculation is very inaccurate.
> >
> > Another extreme example is that if IOs take long time to complete, such
> > as IO stall, %util may show 0% utilization, instead of 100%.
>
> Hi Ming,
>
> Your email triggered a memory of someone else (Konstantin Khlebnikov)
> having reported and fixed this relatively recently, please see this
> patchset: https://lkml.org/lkml/2020/3/2/336
>
> Obviously this needs fixing.  If you have time to review/polish the
> proposed patches that'd be great.
>
> Mike
>

Hi,

commit 5b18b5a73760   makes io.util larger than the real, when IO
inflight count <= 1,
even with the commit 2b8bd423614, the problem is exist too.

static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
{
        unsigned long stamp;
again:
        stamp = READ_ONCE(part->stamp);
        if (unlikely(stamp != now)) {
                if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
                        __part_stat_add(part, io_ticks, end ? now - stamp : 1);
        }

when a new start, blk_account_io_start => update_io_ticks and add 1 jiffy to
io_ticks, even there is no IO before, so it will always add an extra 1 jiffy.
So we should know is there any inflight IO before.



Before commit 5b18b5a73760,
The io_ticks will not be added, if there is no inflight when start a new IO.
static void part_round_stats_single(struct request_queue *q,
                                    struct hd_struct *part, unsigned long now,
                                    unsigned int inflight)
{
        if (inflight) {
                __part_stat_add(part, time_in_queue,
                                inflight * (now - part->stamp));
                __part_stat_add(part, io_ticks, (now - part->stamp));
        }
        part->stamp = now;
}


Reproduce:
fio -name=test -ioengine=sync -bs=4K -rw=write
-filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
-runtime=300 -rate=2m,2m

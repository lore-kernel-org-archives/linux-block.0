Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36177 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbcJFIEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 04:04:43 -0400
Received: by mail-oi0-f51.google.com with SMTP id m72so13103615oik.3
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2016 01:04:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161004191427.GG4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com> <20161004132805.GB28808@redhat.com>
 <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Oct 2016 10:04:41 +0200
Message-ID: <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
To: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@unimore.it>, Shaohua Li <shli@fb.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 4, 2016 at 9:14 PM, Tejun Heo <tj@kernel.org> wrote:

> I get that bfq can be a good compromise on most desktop workloads and
> behave reasonably well for some server workloads with the slice
> expiration mechanism but it really isn't an IO resource partitioning
> mechanism.

Not just desktops, also Android phones.

So why not have BFQ as a separate scheduling policy upstream,
alongside CFQ, deadline and noop?

I understand the CPU scheduler people's position that they want
one scheduler for everyone's everyday loads (except RT and
SCHED_DEADLINE) and I guess that is the source of the highlander
"there can be only one" argument, but note this:

kernel/Kconfig.preempt:

config PREEMPT_NONE
        bool "No Forced Preemption (Server)"
config PREEMPT_VOLUNTARY
        bool "Voluntary Kernel Preemption (Desktop)"
config PREEMPT
        bool "Preemptible Kernel (Low-Latency Desktop)"

We're already doing the per-usecase Kconfig thing for preemption.
But maybe somebody already hates that and want to get rid of it,
I don't know.

Yours,
Linus Walleij

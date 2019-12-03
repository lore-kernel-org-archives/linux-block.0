Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506BC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1052064B
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTItXRhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfLCJpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:45:53 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41165 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:45:52 -0500
Received: by mail-lj1-f169.google.com with SMTP id h23so2981390ljc.8
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neTWFwuJR4Jukr2kV185rqamwxRtM5mkOfSfynGkp0Q=;
        b=xTItXRhlAS9cxWUEh9q8wXyZXw8qmon9lBOU+YKk3+jsr5zYrJpuOg82lsWCWE9x9X
         5ADlxer0aiEW2iYzfNSLNiOj63PrR3F1nhK2PdD9hq2kxZiTHUou7Za4v3ekOJ7tCxNy
         uRMpB5tImy3zbNIFsWsk4L7/gH0FrKa1N+yCJoJNBcz+PC4S+b23G+oB15oopcBSChz8
         vw7VojQo7xfiSfrnHHarbkiSjhP5VOgbvWWWTzDRZWe8vebQavuihtriA4mlUGNONjmQ
         +H1/t6RNLmdxVGu0iujLQM/DXgUOSvnjT5FObcWKUE4m/qL+FYOTUVsV0EepEalnzDnn
         /Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neTWFwuJR4Jukr2kV185rqamwxRtM5mkOfSfynGkp0Q=;
        b=HdbdBjrwujRa/hsD5Xh/zmfyCa8ElhnVcLRzjXKFcy7+RE2dwyvLeMV1oEDZk6Co90
         Ty0th/Dy6wI/x3J/+yUvfuk6PbEMeIhW4z4fzmxV5MJ6dZHOtjgd/qEgGkThucnw/TxQ
         Aek3jPERUXy0v3eJkSSVhWZiZHMrw9NhBcg3NbDw7DD6qjoZrlxPJC49kTeSXb/jyXMA
         lceIS5L4U5QbUwBlqBtetuKi0S6opxMvqvd6Uohp+jJKsmPoCJgHlqv734dDbEtphUbu
         j3BI/nPboJSdFIRk784mtt6CDPMteuRvrC/cijJhNDcyaFTrcSZwVdltkguqYwmKWd47
         DkNg==
X-Gm-Message-State: APjAAAUQ5BlM5RdqfyzgXbVRd4R9rPrC4MF8j1jDHnChicSi0msiE11R
        +bH6aP896/WYfxn6D+JHtumcQUntvfYSxmUKuDDz5A==
X-Google-Smtp-Source: APXvYqxO6Zl+Be503YP0jAYAavrPaOI2DIRf25Dn1MebkTGcAo5eS2qEtOQyNDnZeVQ/ba9f3n7gueV/EICnAEhnbiU=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1372846ljj.206.1575366350405;
 Tue, 03 Dec 2019 01:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20191114113153.GB4213@ming.t460p> <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p> <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p> <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p> <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com> <20191202212210.GA32767@lorien.usersys.redhat.com>
In-Reply-To: <20191202212210.GA32767@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Dec 2019 10:45:38 +0100
Message-ID: <CAKfTPtC7uycC3b2ngOFUqOh9-Fcz7h-151aaYJbLJFXrNq-gkw@mail.gmail.com>
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Phil Auld <pauld@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Ming Lei <ming.lei@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2 Dec 2019 at 22:22, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Mon, Dec 02, 2019 at 02:45:42PM +0100 Vincent Guittot wrote:
> > On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote:
>
> ...
>
> > > So, we can fiddle with workqueues, but it doesn't address the
> > > underlying issue that the scheduler appears to be migrating
> > > non-bound tasks off a busy CPU too easily....
> >
> > The root cause of the problem is that the sched_wakeup_granularity_ns
> > is in the same range or higher than load balance period. As Peter
> > explained, This make the kworker waiting for the CPU for several load
> > period and a transient unbalanced state becomes a stable one that the
> > scheduler to fix. With default value, the scheduler doesn't try to
> > migrate any task.
>
> There are actually two issues here.   With the high wakeup granularity
> we get the user task actively migrated. This causes the significant
> performance hit Ming was showing. With the fast wakeup_granularity
> (or smaller IOs - 512 instead of 4k) we get, instead, the user task
> migrated at wakeup to a new CPU for every IO completion.

Ok, I haven't noticed that this one was a problem too. Do we have perf
regression ?

>
> This is the 11k migrations per sec doing 11k iops.  In this test it
> is not by itself causing the measured performance issue. It generally
> flips back and forth between 2 cpus for large periods. I think it is
> crossing cache boundaries at times (but I have not looked closely
> at the traces compared to the topology, yet).

At task wake up, scheduler compares local and previous CPU to decide
where to place the task and will then try to find an idle one which
shares cache so I don't expect that it will cross cache boundary as
local and previous are in your case.

>
> The active balances are what really hurts in thie case but I agree
> that seems to be a tuning problem.
>
>
> Cheers,
> Phil
>
>
> >
> > Then, I agree that having an ack close to the request makes sense but
> > forcing it on the exact same CPU is too restrictive IMO. Being able to
> > use another CPU on the same core should not harm the performance and
> > may even improve it. And that may still be the case while CPUs share
> > their cache.
> >
> > >
> > > -Dave.
> > >
> > > [*] Pay attention to the WQ_POWER_EFFICIENT definition for a work
> > > queue: it's designed for interrupt routines that defer work via work
> > > queues to avoid doing work on otherwise idle CPUs. It does this by
> > > turning the per-cpu wq into an unbound wq so that work gets
> > > scheduled on a non-idle CPUs in preference to the local idle CPU
> > > which can then remain in low power states.
> > >
> > > That's the exact opposite of what using WQ_UNBOUND ends up doing in
> > > this IO completion context: it pushes the work out over idle CPUs
> > > rather than keeping them confined on the already busy CPUs where CPU
> > > affinity allows the work to be done quickly. So while WQ_UNBOUND
> > > avoids the user task being migrated frequently, it results in the
> > > work being spread around many more CPUs and we burn more power to do
> > > the same work.
> > >
> > > --
> > > Dave Chinner
> > > david@fromorbit.com
> >
>
> --
>

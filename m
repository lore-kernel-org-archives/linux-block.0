Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F8C2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB06124B
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 20:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhFNU3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:29:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43903 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhFNU3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 16:29:48 -0400
Received: by mail-ot1-f49.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso12093734otu.10
        for <linux-block@vger.kernel.org>; Mon, 14 Jun 2021 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ts6cskZpYZLzn+VG3z+4mQRtRkwZaGPkXu3D5tLq4P0=;
        b=t+iAbj2o6Hcbg0PoIucP+FQPi5oqhoGnNElnJ6cv2ql/a5xJkKTRlkGpEw0DeVniRv
         k1yKRMUGsJGSnV0FJOsyfgBZVbApkpqPEOcfsovCGJrZ/1zuuyUskbYqwAe980M6/5qK
         WBBHWDwruYkpok88z/OHPJovziBikiiLolhvWljc436uk5fwau+KKBX+o3OiGs6zFpsv
         +sc7V3HkvTIRmYLEmrXJhj+cifO6zDaO1B5ctB8CIMeDFhpd1R43tcVZWl9mNQOeN0mZ
         QO7lic6CNinTExZYSRy+q4Zav+yZm4baxCcPbkWpZ4Q8Z0xMBl0gIefT+tOjfK8B1Wwo
         r/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ts6cskZpYZLzn+VG3z+4mQRtRkwZaGPkXu3D5tLq4P0=;
        b=r/ChfDtLKlg2GanWQi11gBD0PzEzbbSiovfEkHoxtt3i5aJQViioy8dV8DVdq+8kpR
         Z4rtzOtJs5VRPUbpOZOXHneysP46SuPOrIiFIJiUz5oqWKzW0A9284wb2LCQhsbZfXGu
         eJwsAT4Pu9HxOwa28nFHRoeWqVvY7U36wdbXSzzYQCZeLWs+J15vrU9oxxkcfTL0irFe
         J8cJ8SF20P8ulOjzy3t/J/yU3BMVcOnBdCzBzMfl1vlqmyOBFDLuLalD8vcZ5Gncn+SR
         Dg7i7RJDCe2vPUiGlGAIGsrcaOw+mrvA3IxGDUXPGMlbPvtqvYlxdjW4Vgo+66BEB/vr
         zm5g==
X-Gm-Message-State: AOAM5330BBxEH+jY4MSGONv1l0+HovpxzfPKllhLjGjntvnjYsB6WC4o
        VUPv1omJ7ds4sJhh8JA0J3JmE8Qr/anILp1eokIIwitQol4=
X-Google-Smtp-Source: ABdhPJzElNPriTEby2aJMIpU4XfMx3TsT3UqzTrLGsj+2oNv2i94qDT3AA4PwCYdfJ2QrelXdsGcwb50n7eqGkCs5RM=
X-Received: by 2002:a9d:644f:: with SMTP id m15mr14760737otl.99.1623702404435;
 Mon, 14 Jun 2021 13:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
 <CA+8F9hjJF8e4U7W9tUgGu7dUR_hz-y_EDuq-McHS-GBiZm0-rQ@mail.gmail.com>
In-Reply-To: <CA+8F9hjJF8e4U7W9tUgGu7dUR_hz-y_EDuq-McHS-GBiZm0-rQ@mail.gmail.com>
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Mon, 14 Jun 2021 13:26:33 -0700
Message-ID: <CA+8F9hhyUUXep9_g6b9efejLFu8X8R4usnb6VvksmBiB-2zHBw@mail.gmail.com>
Subject: Re: Deadlock in wbt / rq-qos
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I improved the logging output:

https://gist.github.com/omarkilani/2ad526c3546b40537b546450c8f685dc

And deadlocked again:

https://gist.githubusercontent.com/omarkilani/3d870b6dc440e04357add8c66d371d86/raw/29437a909af475b92fe4d259ff059beea65cdb8e/wbt.deadlock-002.log

On Sun, Jun 13, 2021 at 10:03 AM Omar Kilani <omar.kilani@gmail.com> wrote:
>
> Just looking at blk-wbt.c...
>
> Should...
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-wbt.c?h=v5.13-rc5&id=482e302a61f1fc62b0e13be20bc7a11a91b5832d#n164
>
> if (!inflight || diff >= rwb->wb_background / 2)
>
> Be:
>
> if (!inflight || diff >= limit / 2)
>
> ?
>
> On Sun, Jun 13, 2021 at 8:49 AM Omar Kilani <omar.kilani@gmail.com> wrote:
> >
> > Hi there,
> >
> > I appear to have stumbled upon a deadlock in wbt or rq-qos.
> >
> > My journal of a lot of data points is over here:
> >
> > https://github.com/openzfs/zfs/issues/12204
> >
> > I initially deadlocked on RHEL 8.4's 4.18.0-305.3.1.el8_4.x86_64
> > kernel, but the code in blk-wbt.c / blk-rq-qos.c is functionally
> > identical to 5.13.0-rc5, so I tried that and I'm able to deadlock that
> > as well. I believe the same code exists all the way back to 5.0.1.
> >
> > The Something Weird (tm) about this is that it possibly only happens
> > on AMD EPYC CPUs. I just don't have the necessary setup to confirm
> > that either way, but it's a hunch because I can't reproduce it on an
> > Ice Lake VM (but the Ice Lake VM also has more storage bandwidth so
> > that could be the thing, and I can't decrease that storage bandwidth,
> > so I can't do a like-for-like test.)
> >
> > I "instrumented" wbt / rq-qos with a bunch of printk's which you can
> > see with this patch:
> >
> > https://gist.github.com/omarkilani/2ad526c3546b40537b546450c8f685dc
> >
> > I then ran my repro workload to cause the deadlock, here's the dmesg
> > output just before the deadlock and then the backtraces with my printk
> > patch applied:
> >
> > https://gist.githubusercontent.com/omarkilani/ff0a96d872e09b4fb648272d104e0053/raw/d3da3974162f8aa87b7309317af80929fadf250f/dmesg.wbt.deadlock.log
> >
> > Happy to apply whatever / run whatever to get more data.
> >
> > Thanks!
> >
> > Regards,
> > Omar

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2860C433FE
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 02:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353106AbiCYCM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357693AbiCYCMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 22:12:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488EA1470
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 19:10:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id d134so823031ybc.13
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKwNBEs3tASJWL7vN74tIrUm9dV+sBlNlNaJ5KwKgTs=;
        b=cbc3BGe5+zL07UFEV9pbFjATQyTFfHkL8NRVARYGOxWmh0lxE1dNlskSSeW2JkMs2k
         sFZgeI9XI06R2An17rGJRCrVBd+4KlMmefFE0nM82JlLERTRrgyL+1O3jRbO/hSqr9ZS
         Pvf+cXGQaP182cb0VU8dTVUGy9z7Ic0Nmx+vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKwNBEs3tASJWL7vN74tIrUm9dV+sBlNlNaJ5KwKgTs=;
        b=R7HsVOxye6z/kuCsVnPWELNCG/R6z9J3drhknYBUXxZ+Hsa5tpl+Z+lNyA+zyo7sCI
         ZP6QnAtp6zBgidrrWzON+pFlxiqWp8y3vAEo6S0gSC0Nj55x7W8wKp2hXSTdqo4MH88F
         2OCKjskKLWhSsSm/d3hLi70ZVJwc8Qx5sBlScOw1iQZu+C1MNT4Z2F3AsCxui0ssJVJt
         W3izJ77kv094+lQJ3+kNnnSddCyEz3Pn/x74AS1qINts7VsETSH11NsLpatpmSZCVhK+
         CdYe7pKu0/5uMxD1B7C6LIwl5cHSj3sn0ZDvMy/e1CYjZ8n8P5aoVKNNqmC1iOAD3VeD
         jLQA==
X-Gm-Message-State: AOAM533bIgKtoQGwbT74XuChJwG4wm80CYAL1J2kBrZRmWRm9rDs0DA6
        u2Rze2ilApzBryMKIY31eN0tLa1fnSs8oknn64oMAg==
X-Google-Smtp-Source: ABdhPJz3y4TlNL1JF4KJF+1yuPmc8LbezhlJz2o/4Jb79VASFUj+QoEgLFnQxvm0LwiSP+zSpCA553HDqMC/wZi0OFI=
X-Received: by 2002:a25:3f43:0:b0:633:bdd8:4ae6 with SMTP id
 m64-20020a253f43000000b00633bdd84ae6mr7423462yba.134.1648174224922; Thu, 24
 Mar 2022 19:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com>
 <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
 <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
 <YjTCF37cUNz9FwGi@google.com> <YjTVVxIAsnKAXjTd@google.com>
In-Reply-To: <YjTVVxIAsnKAXjTd@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 24 Mar 2022 19:10:14 -0700
Message-ID: <CABWYdi0tgau=trCiGWULY88Wu1-=13ck8NikV0KxfDQHFCCiMA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 18, 2022 at 11:54 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 10:32:07AM -0700, Minchan Kim wrote:
> > On Fri, Mar 18, 2022 at 09:30:09AM -0700, Ivan Babrou wrote:
> > > On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > I'm making an internal build and will push it to some location to see
> > > > how it behaves, but it might take a few days to get any sort of
> > > > confidence in the results (unless it breaks immediately).
> > > >
> > > > I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> > > > locations yesterday to see how it fares.
> > >
> > > I have some updates before the weekend. There are two experimental groups:
> > >
> > > * My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
> > > machines in this group across 5 datacenters with cumulative uptime of
> > > 916 days.
> > > * Minchan's patch to remove swap_slot_free_notify. There are 376
> > > machines in this group across 3 datacenters with cumulative uptime of
> > > 240 days.
> > >
> > > Our machines take a couple of hours to start swapping anything after
> > > boot, and I discounted these two hours from the cumulative uptime.
> > >
> > > Neither of these two groups experienced unexpected coredumps or
> > > rocksdb corruptions.
> > >
> > > I think at this point it's reasonable to proceed with Minchan's patch
> > > (including a backport).
> >
> > Let me cook the patch and then will post it.
> >
> > Thanks for the testing as well as reporting, Ivan!
>
> From 1ede54d46f0b1958bfc624f17fe709637ef8f12a Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 15 Mar 2022 14:14:23 -0700
> Subject: [PATCH] mm: fix unexpected zeroed page mapping with zram swap

Is there any action needed from me to make sure that this lands into
the mm tree and eventually into stable releases?

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF0C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiCRQcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbiCRQbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:53 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD001B7542
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 09:30:20 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d07ae0b1c4so96091347b3.11
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAE3uuJYaI6bZvK1JirdmvyIyu+ZeP4A7IF2vH7oYhI=;
        b=mOYCnnUxwb1osdLgXKMQa4A9q4QPWM9rhR+WhIZaDXV9nNkbEQeKnyjoT4a99+aSuN
         eF3SZaDvHbMGMLFbwS5OYwy0MsweHwpZZw5JzmfyW7ivcIWJ6uf0ZgB9B0CW5MC6OAdp
         W0TeQxoZCujax5Mn72w3oTLaCYhWpd3zCAEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAE3uuJYaI6bZvK1JirdmvyIyu+ZeP4A7IF2vH7oYhI=;
        b=wBepnN6hkC/JbBeaEmJrpQGjec99HAkym76HsOKZeEfxZnC3wTVy9/M5W396ojcGVf
         7h+FU6xJDvk++teHx2wRy11H4ljPfQhBCH5yiB1VGciP0n2QdXiiFmKJbFp0Jp+VFeDp
         xooC1NAYVAIiZNfiKaL4ljGjVjRchb2K5ohfXFXBDyv9iytXi7OVF5U9mri/LdcS7VtF
         YiqbGBXc2i4y9lXckUbPkqlrwz+MpJ4V2WDrMnT+stG7tw0R1Jph/f5vXY2Ky8diWVML
         PVC3jpREsd1EXGIE2x7hNvagMb8BG9YpdGUj3JJRg/T3g5tPDTh8R2bflnoBGAvb/mJE
         MQZg==
X-Gm-Message-State: AOAM533ONRzcZl2kj+88jpPVN3uup2z2cxldW+7LpQiNSVC4OeXF8A61
        lP7IZc1QFc8qV7i/aIWO2V9YWKDC0rik5ecqNipXx0rXarpWbA==
X-Google-Smtp-Source: ABdhPJzl1HaVxL6M7wATA0aA7ue2teOSdQFdYnb3ZCTBjjtSXetDYzZ2exTvmluualwMq/4vLF3w3ZbC725ewFt67Vo=
X-Received: by 2002:a81:a842:0:b0:2db:562a:3f13 with SMTP id
 f63-20020a81a842000000b002db562a3f13mr11684645ywh.322.1647621020015; Fri, 18
 Mar 2022 09:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com> <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
In-Reply-To: <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 18 Mar 2022 09:30:09 -0700
Message-ID: <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> I'm making an internal build and will push it to some location to see
> how it behaves, but it might take a few days to get any sort of
> confidence in the results (unless it breaks immediately).
>
> I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> locations yesterday to see how it fares.

I have some updates before the weekend. There are two experimental groups:

* My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
machines in this group across 5 datacenters with cumulative uptime of
916 days.
* Minchan's patch to remove swap_slot_free_notify. There are 376
machines in this group across 3 datacenters with cumulative uptime of
240 days.

Our machines take a couple of hours to start swapping anything after
boot, and I discounted these two hours from the cumulative uptime.

Neither of these two groups experienced unexpected coredumps or
rocksdb corruptions.

I think at this point it's reasonable to proceed with Minchan's patch
(including a backport).

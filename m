Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13FBC433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1F023A57
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbhAUQ7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388305AbhAUQ7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 11:59:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E25C0613ED
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 08:59:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o10so3445506lfl.13
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wlC8jXsMe1HIuwZiVJ+3vAtunYXGcJMzh+yYd+DdBME=;
        b=TheRvIxPi3twaM1+OG/+oewoB/tUMjA8hzpYfCPxtI2yKHER/D8+BzqHXNBqbRzmSW
         Up0YyXLqtbFKlowz5YuO/LPUHMqtKlUGVstdI73+vdoMuQckEMlck34fetxGj3DMQJfd
         rQZNHm2vdV+4wNHejgurPIKJ24SUvGor6ZklOU12R4lSXdzN9X4xRrqX+qb+bAbWauwr
         WF/XtBDCgSllLg4DIPcjR6a9lfQE3u0GxQiph6q2HrXUoHWQtRNqnkGrl0xwB+ta9amV
         M3Pp3xLVqgxF0JH552Jz2DALPjF1Cz9PIalIlRCilUSJNsp/rKvH/j+zrAdT/ssRA+Be
         sc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wlC8jXsMe1HIuwZiVJ+3vAtunYXGcJMzh+yYd+DdBME=;
        b=cacyHebfQ6bL4LnF5mKgE+z7t+mg9OeQOacjy7JAIeMvQ1vsvt0YttifR7aQtc9eLo
         d8AXWzbo3qjricUdXpU221aCoEpNTbch0Xz5iKYxNHDotJgEb7s4xJJ6G73av78T0P8u
         1OgF/r830AlrbzGqd6re6j1c0hFV/UW86giprLjWSHGOzLR1VSMihuWSQ8sLLjrbTqoL
         uNjEFRwa+CMlJRjH5pSeuOn0bUthRD/AHgQYdFIyerDaZ1Zb6BapByBfEXvVQ6x+Xpjo
         qC3vgKx1gO2HiL7Po0KIN4FM2W+C8tm4D0Q63ppJ/Dls+owu5auiq+a2pZiA9rgOcnTb
         35aw==
X-Gm-Message-State: AOAM530fo9BQc0q9DovdX4f7vwhgiGvBQ6CC6VyO8zv9PgXlSby5aQ0z
        xD7zPTU3lzZPbuj3S23Vol2CTHKE1XilnqLxgFeFuaj1kDo=
X-Google-Smtp-Source: ABdhPJxftuch7sATRvzaCLPmYLdgyQX0HyB1LAh7L3aD8SCIly8XBPIRllhm863QyqbI+lzhvDJsSUaHTIDHdShweDM=
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr46056lfq.457.1611248349473;
 Thu, 21 Jan 2021 08:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20210121072202.120810-1-bianpan2016@163.com> <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
In-Reply-To: <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 21 Jan 2021 08:58:58 -0800
Message-ID: <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't think that ZNS supersedes OCSSD. OCSSDs provide much more
flexibility and device control and remain valuable for academia. For
us, PBLK is the most accurate "SSD Emulator" out there that, as
another benefit, enables real-time performance measurements.
That being said, I understand that this may not be a good enough
reason to keep it around, but I wouldn't mind if it stayed for another
while.

On Thu, Jan 21, 2021 at 5:57 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 21/01/2021 13.47, Jens Axboe wrote:
> > On 1/21/21 12:22 AM, Pan Bian wrote:
> >> The allocated page is not released if error occurs in
> >> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
> >> possible memory leak issue.
> > Applied, thanks.
> >
> > General question for Matias - is lightnvm maintained anymore at all, or
> > should we remove it? The project seems dead from my pov, and I don't
> > even remember anyone even reviewing fixes from other people.
> >
> Hi Jens,
>
> ZNS has superseded OCSSD/lightnvm. As a result, the hardware and
> software development around OCSSD have also moved on to ZNS. To my
> knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially at
> this point, and what has been deployed in production does not utilize
> the Linux kernel stack.
>
> I do not mind continuing to keep an eye on it, but on the other hand, it
> has served its purpose. It enabled the "Open-Channel SSD architectures"
> of the world to take hold in the market and thereby gained enough
> momentum to be standardized in NVMe as ZNS.
>
> Would you like me to send a PR to remove lightnvm immediately, or should
> we mark it as deprecated for a while before pulling it?
>
> Best, Matias
>
>

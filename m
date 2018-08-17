Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36736 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeHRCtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 22:49:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so8680463wmc.1
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 16:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
In-Reply-To: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 18 Aug 2018 07:43:46 +0800
Message-ID: <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: ricardo.ribalda@gmail.com
Cc: linux-block <linux-block@vger.kernel.org>, ben@decadent.org.uk,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Aug 18, 2018 at 1:32 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Hello
>
> Coming from: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=906328
>
> bmaptools is kind of a "smart dd" tool, that lets you write images
> very fast and securely. Since the last Debian Kernel update it has
> become 5-8 times slower.
>
> After some debugging, we have figured out that the reason for that
> slowness is the Multi-Queue Block IO Queueing Mechanism.
>
> Debian maintainer has pointed out that in the near future the single
> queue will be deprecated.
>
> My question is if we can get a similar perfomance for bmaptools with
> blk-mq and how?

It suppose to be not worse than non-blk-mq, and maybe there is bug
somewhere.

Could you use 'iostat -dx $DISK_PATH 1' to collect io stat when running
bmaptools in both blk-mq and non-blk-mq?

BTW, don't change the default io scheduler as none, which shouldn't
work well for slow disk, such as non-SSD.

Thanks,
Ming Lei

Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB6ACA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B7421734
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jx9U/l+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKARuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:50:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43544 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKARuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 13:50:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id c26so13922110qtj.10
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/HIlvTupFMQoaRKWu7IMXMsRW7xNinsS93O5DkPvF4=;
        b=Jx9U/l+A7Vbfll2pRMnzIa5vrkwv+VQlkzE907HDssInUY6UQK3NMfc4TLKfAJ3FGO
         WiVHTVuYKdZmgLiivyXL7y5LxeV1+yFflkgY1bywhlBv3u70rayWxDmZ/+oq1OH2MXHz
         MYkE+j/F0yqWWdDhOy8X+GIQXqtTZWsZxO04/J7VS4W8l5fxC6AERlOlYzvrOGgSIeIC
         zlEgF2I5RdIESCm5gcTFyVRKC13Siay55avawNuE6dAZwcnZxmcuGqqtCpGLhyPtJtTm
         VuYNIXsXNFvTw5NORMo5xB4KtGTPXCJAsrGAiabEQ5bGV9PvOhv8VcIxNWcQrJBWQr2B
         8+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/HIlvTupFMQoaRKWu7IMXMsRW7xNinsS93O5DkPvF4=;
        b=OS1eRXFu5dVfDZ6T4Ht6vW+Wmuf8RN/K1eWplpTSQrVTc4B4cKbzH2FRoQx35/C5W9
         1aicFwgc6r3wk0J1xfZIgRTUwEV3UMXYOcV/twTVPIYuuFEr+FQJv81Rq89FpzdOYO9K
         paNqy/7EQBhWcUgxdC/zFormxpYm+7/oTKWcV5fDozrd61c5iAE72lT5E5lkH8N4wI1q
         RSTxFtxuyaAJhcq8NyM/bo/tgvuXrQzGNLfe1wy2Yt7JA13+8XggQfAcrnFuYs3mZxt1
         X/PnJ25QtSiU4T7TXfQVZPkz4l3AcOnp0cduiP7hFTbqM+inx25JWUEk8BWb9Ck1xAQ9
         ObKQ==
X-Gm-Message-State: APjAAAXBAn4KIj8jVOdZUgVq4Sp0Xfquvo/16TnxxXWfBs1uqj1tjyEH
        XNJmVSgDWWSnVk3n9PHYTNDlWHFOsUOTGChxkylA3g==
X-Google-Smtp-Source: APXvYqxl5rSWiJzhWwcYLy3ZtNg94HxJBCqVkEA/w8Lp+6nwvi5CxRu14yY3bTSBJ4+4GlBxnyCCeeF6CZpU2JSqZMU=
X-Received: by 2002:ac8:4157:: with SMTP id e23mr577642qtm.158.1572630617052;
 Fri, 01 Nov 2019 10:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069801e05961be5fb@google.com> <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
In-Reply-To: <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Nov 2019 18:50:05 +0100
Message-ID: <CACT4Y+asiAtMVmA2QiNzTJC8OsX2NDXB7Dmj+v-Uy0tG5jpeFw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mchehab+samsung@kernel.org,
        Ingo Molnar <mingo@redhat.com>, patrick.bellasi@arm.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 30, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/30/19 1:44 AM, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit ef0524d3654628ead811f328af0a4a2953a8310f
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Oct 24 13:25:42 2019 +0000
> >
> >       io_uring: replace workqueue usage with io-wq
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
> > start commit:   c57cf383 Add linux-next specific files for 20191029
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
> >
> > Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
> > Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")
>
> Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
> the below fix.

Hi Jens,

Please either add the syzbot tag to commit, or close manually with
"#syz fix" (though requires waiting until the fixed commit is in
linux-next).
See https://goo.gl/tpsmEJ#rebuilt-treesamended-patches for details.
Otherwise, the bug will be considered open and will waste time of
humans looking at open bugs and prevent syzbot from reporting new bugs
in io_uring.

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index af1937d66aee..76d653085987 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3534,8 +3534,9 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>         /* Do QD, or 4 * CPUS, whatever is smallest */
>         concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
>         ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
> -       if (!ctx->io_wq) {
> -               ret = -ENOMEM;
> +       if (IS_ERR(ctx->io_wq)) {
> +               ret = PTR_ERR(ctx->io_wq);
> +               ctx->io_wq = NULL;
>                 goto err;
>         }
>
>
> --
> Jens Axboe
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa%40kernel.dk.

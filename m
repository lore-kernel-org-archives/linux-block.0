Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35385C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJRWRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJRWRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 18:17:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3739B276C
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:17:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g16so5800658qtu.2
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OiL3fDoOAQJeFptIwHV4F791d26lnzffLbOKVpkXRA=;
        b=Ed8nYkGa2bMWkVa8E6tUIOFyVZpWxTcgqzxH76/BWuzKX6TyOAqjMs9s20Q5C1AIon
         G7UnhPLYn9WRWtlACbs7aJET2AQMVYbndWqp+6EXIxu8sqr0Vpa06M8uXGhwXnfuGE3V
         STrwvSDF9vmdIyoFJiFds/4I2+dDtpAZu4rZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OiL3fDoOAQJeFptIwHV4F791d26lnzffLbOKVpkXRA=;
        b=Gau+8n+qeWEpw2oUsU5Qw3QXavN29CW5UujViLG662nlVvsseizFO8HGEemW0JzFRz
         l6VVf3HpmwSxkyykT6NXg6sgsT4zC7IlC1Vzws44n2VuTRCJK9NvmdGJ/sBusEaA+ZTS
         a0im6ntECFGm0twn+kI6zVS8spAlqu5lw6DXU/oRkU+CCmcsv/PN+iFwIzfR0l2igSca
         T2Tzk0rv/1ZbdRWP8NYyNeev6wt107PknluTMmnaYc4WdU127tsU9PjhEc670BnuN1xJ
         q5SiAroLRrV6Yd9S55833WdO9AADKw8JnVyBuyq6RL3D6UxYJiFstif2+QDBGsmZCDAR
         hYmg==
X-Gm-Message-State: ACrzQf1HmM4gtkMycJfdo9huAhCNGbYkXPWut8skMF3YKI20ztMF2QjB
        s3vsQHDwEBJ1Roi4X9KweyZ4ThvFiJX3Xg==
X-Google-Smtp-Source: AMsMyM6+VroGqdc5zUgQBfH0atJSFx98YFZEJAcL7O1Miy2kTfTN4jfkS69xS/TlSlap8YhT5FuJCg==
X-Received: by 2002:ac8:7e96:0:b0:39c:d833:e8c3 with SMTP id w22-20020ac87e96000000b0039cd833e8c3mr4000121qtj.303.1666131440003;
        Tue, 18 Oct 2022 15:17:20 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id e18-20020a05622a111200b00393c2067ca6sm2914998qty.16.2022.10.18.15.17.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:17:19 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-35befab86a4so150666847b3.8
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:17:18 -0700 (PDT)
X-Received: by 2002:a81:5843:0:b0:361:2d0:7d9 with SMTP id m64-20020a815843000000b0036102d007d9mr4529569ywb.58.1666131438524;
 Tue, 18 Oct 2022 15:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com> <alpine.LRH.2.02.2210181515170.23349@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2210181515170.23349@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Oct 2022 15:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTgPg3H=2BPtTdHdM5=4wvEA3YCaDEm4P6TQnjvw-CEA@mail.gmail.com>
Message-ID: <CAHk-=wjTgPg3H=2BPtTdHdM5=4wvEA3YCaDEm4P6TQnjvw-CEA@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 6.1
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 1:29 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> The error string is not intended to be parsed by userspace (I agree that
> parsing the error string is a horrible idea, but this is not going to
> happen).

I am happy we agree on that fundamental issue.

But it's also why error strings are a HORRIBLE HORRIBLE idea.

They are literally worse than just plain 'errno', exactly because user
space MUST NOT parse them.

They are worse because:

 - user space will parse them anyway, for localization reasons, so the
whole design is garbage

 - user space that correctly doesn't parse them cannot use them for
any helpful thing apart from just displaying them, which makes them
actively worse than having a number that you *can* make actual
decision on.

In other words, user space either can violate the fundamental rule of
"don't parse it", or they are actively weaker than then errno numbers
we already have.

Either way, they are worse. See?

>  It is intended to be displayed to the user by tools such as
> cryptsetup or integritysetup. The tool can't read the log, extract
> messages from it and display them.

Bullshit.

The tools could just use the error number and together with the
operation that failed, make a very good assumption on what went wrong.

And even when that assumption isn't some 100% "this is the reason",
the tool can easily print out helpful hints, like "This is often
because of Xyz".

And guess what? With an errno, the tool can do this MUCH BETTER.

It can localize the error messages.

It can do different things for different error messages.

And it will work with old kernels too.

> With "just use errno", the user sees messages like "device-mapper: reload
> ioctl on test (254:0) failed: No such file or directory" and it's not much
> useful because it doesn't tell what went wrong.

Again, I call bullshit.

You are saying "the tools isn't helpful, so let's change the kernel interface".

And that's just plain stupid.

if the tool isn't helpful, then FIX THE TOOL.

It's that simple.

The fact is, dm isn't special. We use 'errno' absolutely everywhere
else. What makes dm so special that the dm tools can't deal well with
them?

Look at the profile tools (just to give an example of a tool that is
in the kernel tree, so i can grep for it). Sometimes it does just

                if (aio_errno != EINTR)
                        pr_err("failed to write perf data, error: %m\n");

and prints that error string. But sometimes it does things like

                if (errno == EPERM) {
                        pr_err("Permission error mapping pages.\n"
                               "Consider increasing "
                               "/proc/sys/kernel/perf_event_mlock_kb,\n"
                               "or try again with a smaller value of
-m/--mmap_pages.\n"
                               "(current value: %u,%u)\n",
                               opts->mmap_pages, opts->auxtrace_mmap_pages);

because the tool isn't garbage.

You are basically saying that the kernel should generate those strings.

And I'm saying you are completely wrong, and that no, I will not pull
this kind of silly interface, because it's an actively horribly broken
garbage interface.

Furthermore, I'm telling you that you need to really *understand* that
no, device-mapper isn't some super-special thing that magically should
do string errors.

This is not something worth discussing. This is something where you
need to just realize that you are wrong.

End of story.

                  Linus

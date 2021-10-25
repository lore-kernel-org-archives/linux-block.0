Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0438604D2
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhJYIt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhJYItZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:49:25 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487AC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 01:47:03 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id w10-20020a4a274a000000b002b6e972caa1so3411367oow.11
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QD6S5FcXqbMWnr2NhEbAy6feKFx0sh0idDAxYvo4UWA=;
        b=sygHC/VOYcly0K34H6f+G/9jVVFyNzaaI0rIUf/2HPloUI5E5b7L6u/6Kr9GqjMNIj
         31oj9Wj7ZylE/zaHSup06g+cQ8AML1nHrYqo139tQ8UI+yN/J6v/cf4pgskmxAT00PeE
         s3ho9bL8M8Zr5m8lvJFG9lL3vh796cl9hPObufKgDYkD4n+Fvz3XmAjKLhlaW23tSPzq
         ZxTfVrYWUANJeaE+fu4gcGTE/Hnllut8n5RYkcLo5GEfyvcgNtD64AC9g5ugn1iywCqU
         W/CD+r77Goc592kGebk2POeFo/H0UGQhkkJQb2UmmRLiZwBR3PpVlSI2IYw3Ner/bwCg
         3neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD6S5FcXqbMWnr2NhEbAy6feKFx0sh0idDAxYvo4UWA=;
        b=vuhcY4QAiZKLVjyMJDdNG/rFA6LU4qKRmnvl0QrWSWhUwB8d89qqkSlvIfr6ZZyH4+
         XvaBn/z38k2Mw1uMFTEaOtorB+6L212RSmJPAXw4+ynnqEIN1+MqQIub1JimSqBFmoZF
         zIvqAe4nyz7kMsPOjTivXITDACtpQCdTTKLoBAE90AHdYwSmxahGHJvKiP7MqsrYkDgd
         3h9kritSj55U/N2yCJ2vB/A9eVYEB6velXQw4ut/s+N6To4M9qkwsxYNyhYE3hgFCNsJ
         WOBtf7UjiobIYaR5zkgFYNIIXfJZn4aSbNca3YaZq6d+LCngatTtzEeg1ZMfIOeJbw2Z
         sd2g==
X-Gm-Message-State: AOAM530Km2L6NFM9F8jLxwXOzQJ5lq3w6kxOpvWaX1cngwFnpJpwh6Mu
        XQ3ffSZLHFn6FfCAxmj9CEulBF06E5NNlo6Jt1X2JA==
X-Google-Smtp-Source: ABdhPJzRvj0Lq8NOJOOfTnmTc0kuAGX3WevBNcmF8DvEpgpKBbKX0g1yV0hUJ9yXTFboNOIAfsIzf6KGrK8XFDEAaMQ=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr11131804oot.18.1635151622652;
 Mon, 25 Oct 2021 01:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d4e1e105cf235f15@google.com> <a189d065-fb64-b76f-9f45-f866f9d5638c@huawei.com>
In-Reply-To: <a189d065-fb64-b76f-9f45-f866f9d5638c@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Oct 2021 10:46:51 +0200
Message-ID: <CACT4Y+acFmP4kiSTAWniyqVfGf2cHfqNqvy7vfa-Hc1RVigFzg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in blk_mq_sched_tags_teardown
To:     John Garry <john.garry@huawei.com>
Cc:     syzbot <syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Oct 2021 at 10:39, John Garry <john.garry@huawei.com> wrote:
>
> On 25/10/2021 02:35, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    51dba6e335ff Add linux-next specific files for 20211020
> > git tree:       linux-next
> > console output:https://syzkaller.appspot.com/x/log.txt?x=10171dc8b00000
> > kernel config:https://syzkaller.appspot.com/x/.config?x=1adca843ed814d57
> > dashboard link:https://syzkaller.appspot.com/bug?extid=412ca156285f619b8b62
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:https://syzkaller.appspot.com/x/repro.syz?x=14f768b4b00000
> > C reproducer:https://syzkaller.appspot.com/x/repro.c?x=1295a8c7300000
> >
> > The issue was bisected to:
> >
> > commit 645db34e50501aac141713fb47a315e5202ff890
>
> I think that it should be e155b0c238b2 ("blk-mq: Use shared tags for
> shared sbitmap support")
>
> > Author: John Garry<john.garry@huawei.com>
> > Date:   Tue Oct 5 10:23:36 2021 +0000
> >
> >      blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()
> >
> > bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=1597e130b00000
> > final oops:https://syzkaller.appspot.com/x/report.txt?x=1797e130b00000
> > console output:https://syzkaller.appspot.com/x/log.txt?x=1397e130b00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by:syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com
> > Fixes: 645db34e5050 ("blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()")
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in blk_mq_sched_tags_teardown+0x2a1/0x2d0 block/blk-mq-sched.c:544
> > Read of size 4 at addr ffff8880760b81e0 by task systemd-udevd/6750
>
> #syz fix: blk-mq-sched: Don't reference queue tagset in
> blk_mq_sched_tags_teardown()

Hi John,

Thanks for updating the bug.
It looks like the title was line wrapped. There is a hack specifically
for gmail to put the title onto separate line, it's still parsable
this way (if the whole title fits into 78 cols of course :))

#syz fix:
blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67DC5517A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C43C2076E
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuFMYk0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgKKLNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKKLNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 06:13:20 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A8C0613D4
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 03:13:19 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so676510qvb.6
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G25H3cRGlnqgYp9qHwhX1vczcSDgPbi+Ig9bY020mP0=;
        b=LuFMYk0dUlPR4FVrsNh5uk1umraI3MMg3mRmkuVk63xZv/LMdVaDxOtmuISraXdmiu
         UKgk7K9acPBkbNd769WbQNAn09tEAJWByf8wi9Mgnl5wFZtywKSQYUfQ66tgAEbq0r0k
         Rizv5JWEieM46t96h8fnk0/M4EOOEnS9dzd3kd8H79mDZ3OlTmWv97UbsSo+U7OUp5ts
         AT1fhh+uAxruSeumevEQIRGkKjU+p3qmFrVLRkFzEWFip4RL0bGK7YmBH0+ojSVSVOFr
         yI+aEuPz4c8ZyDe7ncItC/NQqJ5HyLESYlxYaUMCKbfNTi7fFhNCOi47apfNHoaYVD8G
         qLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G25H3cRGlnqgYp9qHwhX1vczcSDgPbi+Ig9bY020mP0=;
        b=JRA2qQDTp2BYzEqN8C1eyZG9tR9nyuKrJ/X2NLPy+sqjfdeI3+4dacVI7Dgqcv2aN4
         hmTkL9QgHHrI2MhgF72heJ3j1UTWnx2E8zbAcNzO6ueEZO8At6aFy7cli98LtXPV3wS7
         GaKAuOgAfQKIXuGBmO/o20mvWhQ29idElVgIfFZML9iwZsW9+Xxi/eaKS6hGnJ/1gw+W
         sZ3RflwKjGiAwFZ/Wtewx4IMzfRHW843SK5gi9RMlvF8IeiYCtBjS1+k8YfXG+jotYWN
         yRuZvxrgokfDeQ9n73hvyJV4BlneMOwCos0GvplapOA4RLywArmnsLS0uXXoLUWTi8Zj
         QCjw==
X-Gm-Message-State: AOAM532dRQJCB0jn6F+6EcAImGFg50XtdmZdm5AP3o0oxvCogfULRjwO
        s9zguHLWptJPgIm3ppzU+LgLXYijSU3UkkZ57kCLxQ==
X-Google-Smtp-Source: ABdhPJyg+2GPaoQR0835u3ehaZDK5bPh7OzIzQ+ehRY2+fCdQNAjE/kWDN0+UK+JeflqywTVYJzDTAQlIzWcj2Yj2r4=
X-Received: by 2002:a05:6214:9c4:: with SMTP id dp4mr3755509qvb.44.1605093198973;
 Wed, 11 Nov 2020 03:13:18 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009323e705ae870d48@google.com> <0000000000008dab1205b1208fe6@google.com>
In-Reply-To: <0000000000008dab1205b1208fe6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:13:07 +0100
Message-ID: <CACT4Y+ba6jB8h1AptYx31AKsW=adXfgSyr1AdEEyqLmy=d6b9w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in delete_partition
To:     syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>, dragonjetli@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, hl1998@protonmail.com,
        Jan Kara <jack@suse.cz>, jean-philippe@linaro.org,
        johannes.thumshirn@wdc.com, jroedel@suse.de,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 8, 2020 at 5:38 AM syzbot
<syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 08fc1ab6d748ab1a690fd483f41e2938984ce353
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Sep 1 09:59:41 2020 +0000
>
>     block: fix locking in bdev_del_partition
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1259b1e7900000
> start commit:   f75aef39 Linux 5.9-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8639c8dcb5ec4483d4f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c43c79900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173dfa1e900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: block: fix locking in bdev_del_partition
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: block: fix locking in bdev_del_partition

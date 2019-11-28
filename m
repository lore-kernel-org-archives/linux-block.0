Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB760C432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DF21775
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqLbd+9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK1I7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:59:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46860 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1I7r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 03:59:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id f5so3720816qkm.13
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2019 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZDOmo+mPfnPdaN//xLxORxFeLKUGqLr+J7G6xlCcv0=;
        b=SqLbd+9oTES7vGoU6eGRMkOpdFNV40HLc8s+9TAEtizxbar9kUpZ2tYAOwvaCY1zJ+
         h2RoTvo57zIm/phFl00V8pNUu++Ie3H2YdWs5duONa6ZKlqZcd3g5I+xw9BtKTc+uUCg
         mkSzYl/52v0L6ZFbszaSXtmAE+0/SOnzVv8g/2TvaZz1fGjnWDca/ilGBsMv/qxl8KSL
         xQAZnM9roykuNy0O/hXzxcFl4RG9lANGbs8Syy6W6Bf5a02XsRcE9w5/+oZcjCQaB01w
         hwiQPa9y/o5RMKSE8pPl9j5Evo2S4Nyk5RdMnwDFqxg8avw58AnnFNmJXvs343DJaTt9
         oMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZDOmo+mPfnPdaN//xLxORxFeLKUGqLr+J7G6xlCcv0=;
        b=jskyhgIoDNMiXr4l9h4pDykD/mf3WgJVen6Wli7FseCeWOVUJNF99kFwDTxUU7Xmgx
         ZTmDEjDvA+zh7f3gAoUvriGW4dHFlByXRLS/l84NkspTkFtMOLUrW4JplVabGGRyZ8cQ
         U4omA+wEnVwcRJ5t04ZsNNPlNKL42+jkw+QX49dHeUEmnV1l6J6IgC3hlmdb+j5Q+kko
         4405pL8c3AGbC3FGoR299Bz0scXK+KT8K8V8/Sd2hHkhCO8ZNy7T3dNKVpr9JN7uRvjR
         iSQUII9olMek+rbRLeuYYAkN8w7U14H5kQew0JtfnN2wtKP/3vbzEjKT3Ch4MIOHUsu3
         ZBXA==
X-Gm-Message-State: APjAAAXBefV6gPmGSk669uEKpwQznBXcb6mLP8I8lUkI4JEkcslKOjtq
        QjJJ4KMfoZcrSoZ00WVNKx7Y4t3rFxpiO7M9lSBf5d5i
X-Google-Smtp-Source: APXvYqxQ8DtLmeAzs+5VWeB2Gdz5ZzKRF7gLOdRvhy2DWqwJIHm23YKNcX22+xkzBrqhwZiFwlBokOtLC2TXudHDan0=
X-Received: by 2002:a37:e312:: with SMTP id y18mr5456024qki.250.1574931134398;
 Thu, 28 Nov 2019 00:52:14 -0800 (PST)
MIME-Version: 1.0
References: <201911262053.C6317530@keescook> <00000000000085ce5905984f2c8b@google.com>
 <201911271124.F01A0B37@keescook>
In-Reply-To: <201911271124.F01A0B37@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Nov 2019 09:52:03 +0100
Message-ID: <CACT4Y+aEeUaTQioc85nPXG9GM_ODojdoywNoVEOf5b6yXXU0cg@mail.gmail.com>
Subject: Re: WARNING in generic_make_request_checks
To:     Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>,
        00moses.alexander00@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, joseph.qi@linux.alibaba.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, wgh@torlan.ru,
        zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 27, 2019 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 26, 2019 at 11:45:00PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
> > git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
> > dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Note: testing is done by a robot and is best-effort only.
>
> It seems for successful tests, I still need to tell syzbot that this is
> fixed?

+syzkaller mailing list for syzbot discussion

Yes.
You used a commit. But patch testing may work with raw attached
patches, or on trees that are not merged, or it may just a trial run
on HEAD or run with additional debugging only and it may incidentally
succeed; or may be not incidentally but the patch disables part of
functionality just to check if it affects the crash or not, but it's
totally not a fix for the bug.
Nobody ever figured out how all of this could work; allocate time to
write a complete proposal for the workflow and implement this.
So at the moment patch testing functionality is completely unrelated
to the rest of the workflow. It's a convenience feature.


> #syz fix: block: don't warn when doing fsync on read-only devices
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/201911271124.F01A0B37%40keescook.

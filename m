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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD761C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 02:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8EC61930
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 02:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVCgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCVCfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Mar 2021 22:35:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C5C061574;
        Sun, 21 Mar 2021 19:35:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 8so4977681ybc.13;
        Sun, 21 Mar 2021 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H65xqC/42bEDo/g9LibtM4BW4p82F576E0w0zkL8lbE=;
        b=QjRuYHaudxq6sEJhoC0naVghi/C5FFmmzliXbS7ycrvCuLnt/ho/UVb7680tshKpqS
         d8y+5FAR5qBLBPksiTEeEj2+n+PyF5G1JHSHAYfn/zTKBKQ1gmQT0n+YdqWOryeBTdgw
         aEscEymhMC6Y1dhUsxPgIFUI/u9guz4XH9AdV2tgLqKk1E28qnaQou1TJfTplWC9qEb3
         nigmcyXNXdSgBU5a1NEdKZSMk6HNOnZEBKLkxYwYLt2J1wmimjy45kesr/In7xWLysCn
         a+oIGFv1CsJyfGgTw8Ih1ZlFFlo8uya5bfZTB7j3nCS11pk12nn2sLCh0HjN5Slk9n0I
         O/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H65xqC/42bEDo/g9LibtM4BW4p82F576E0w0zkL8lbE=;
        b=KeUi9q2Df0ahfnKYNHvKke5eFRrRQCYtjagqOfv7D22mJGkN6419eyQq9T58RLCZsv
         +xhY9teMCJzBRnCu7dRYDYFQx0NJQRvlkkxlhJ0LdZc0hO9IH7RnpQOh85QztZWpyu/v
         wykBWYj62WyGlVGoibpaQsPo3deQRXQTG6n4rYiXGjYfNtJalXzq7XJ27rh2/KBPf6oR
         NNTfKiGpads1Wbc1pY+ze8fUBUsJJT3wVB4MabTLcO5ESfwuvA7P7cdzflDR998anc4k
         us/uE2JOjyjEwk76AwSttcODjCXI3k34UQJP7DbcADLLB4VHlvu+1nViOyf6W2MZhSgi
         fCUg==
X-Gm-Message-State: AOAM5328BeUsGfB3NoLwH6ztOazijl37VMdTMe7DatWmEleZL0CKnMLs
        5qhK43chmuc/3moEtfxZ7ySqv8oSw45OfOOHL/Y=
X-Google-Smtp-Source: ABdhPJzpnWGyC6kV/B25esel4glhfHMWbxfjyAjZ8FXkmdTF54pdIkwKcPdxZFgQfKHvja3095ildw0iB9qIK45vCKk=
X-Received: by 2002:a25:1883:: with SMTP id 125mr20994232yby.465.1616380554310;
 Sun, 21 Mar 2021 19:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000053da9405bd7d2644@google.com> <f40ed33d-8ca2-a2f2-e534-9db9920570ad@acm.org>
In-Reply-To: <f40ed33d-8ca2-a2f2-e534-9db9920570ad@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 22 Mar 2021 10:35:43 +0800
Message-ID: <CACVXFVP0un7xv0_rZHV9d-jtDSSKpJcrFcmDsDiaj4j2CqV+DQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 7:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/14/21 4:08 AM, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
>
> #syz test: https://github.com/bvanassche/linux a5f35387ebdc

It should be the same issue which was addressed by

   aebf5db91705 block: fix use-after-free in disk_part_iter_next

but converting to xarray introduced the issue again.

-- 
Ming Lei

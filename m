Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B6AC7EE22
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 08:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEKH77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjEKH7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 03:59:54 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3E8A7D
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:59:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a14807e4cso147701337b3.1
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683791986; x=1686383986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oawR0w6UD60BU+9b68HboOl8QgKLMm6czgIlQXRKuBU=;
        b=uoF+36ErrVzTnitQ4WVF4ZyhB4N3KRqjVHBnqdIbrsSgbBqNQs6x/yW1dTvrcs4EZz
         5ufrMHn/z+gbTVdpSoDs9/rdfECVm3p850ZbLiII3M1Dr3QlajcTOHqxzNIw4ZPb5+kD
         wq+nb7R2MR8eX9Uz+M3bsZKGJi+BlSBguqJuzaBCFLrWIhrFVIDxLoMj56DoSLDshc0j
         BfzRYeAvlYJF90+eI7ggh1Dl8/BUTPfb4pv20fACqhAbuUXCUKxmdEn2J/c/45pOWXCC
         ydma2mnvhLJeIk66ollO9gLbfHXnguP/dEuzPX5AkxfLdqacR/UyWo5G4Hsb+MWso0nI
         Ao+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791986; x=1686383986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oawR0w6UD60BU+9b68HboOl8QgKLMm6czgIlQXRKuBU=;
        b=Ku6odhSzke3MywvGLmRkSJpDXNsHt7bcM7VUzfHz4TWEu1l7qnb15JYRFcpe75rXFC
         fVX8YWd5lWs7rcDji/hOGVBRjhQ7Mgv4NzvfiT4ciQbU8XB1jRzm18DuSY79WKu3Uy9b
         QtrST76L3f3Hmv5sU4r7O6HamJNucxJiOB/iiRkO1Pc8tN8dzgBQRzr13rU2RxEqxpRq
         8vcbkh5XN63FMgIS9AsI69t9lTsfvRUwMWdxDmJF1p1kr+ABkGqWHQY6JlLEeVOOPZtP
         hNoS8LXxJv3579CPdrrBvP1BOYrodrH7as+X979EvsdTbY4FjtFPcAxqtC1SXTXm/3PI
         QUlw==
X-Gm-Message-State: AC+VfDy2+vMPmQ1cL/sIsHz9FanloyAl8CITgqW3iWNfXNloS/Z3PH3p
        dvzBrmQf+aupt3j78SetbaVakvVveWi0uJCIceGLEVB4Vg1n+sV5mUkbHQ==
X-Google-Smtp-Source: ACHHUZ5H5lzljaWxci91tEcXgt6jxUa+m/W0KUORaesRDaJDm74QacCax3bmBd/piuw7EC9IQN5Lez1ZnokFOEVRgaE=
X-Received: by 2002:a25:6fc6:0:b0:b9e:6894:289c with SMTP id
 k189-20020a256fc6000000b00b9e6894289cmr18378218ybc.59.1683791986485; Thu, 11
 May 2023 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a294db05fb6584a4@google.com> <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
In-Reply-To: <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:59:08 +0200
Message-ID: <CAG_fn=Vd9WCk_=YGAzK+ZOr6Tf-sCz2FD8Fx0YRmQYS3ja_aCg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in unregister_blkdev
To:     syzbot <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 9:07=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
> <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confu=
sio..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c0674c280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b=
7bdce
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da66467b3864e8=
2f8559f
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
>
> Sorry for the noise, I was trying to switch KMSAN bots to the upstream
> tree (it is not ready yet, needs one more patch), and accidentally
> sent this report to LKML. Please disregard it.

#syz invalid

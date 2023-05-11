Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD3C7EE22
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 08:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjEKIAE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjEKIAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 04:00:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F14213
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 01:00:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so39984771276.0
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683791999; x=1686383999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLedi3hVqxdWr/OA7+QyOEQ+v1I2KL3cVmpY7bRy76c=;
        b=6FBEEljZk9zb9AJ2Y6Ynq3Mh+oBSaQ6ySOyjIK42cxxCdlO1BbKVTXo9qKZhOfJ+3Z
         6yACC97sKr+qKP9PGIjJD0C2u9tSf4ETzMA9eNatUVyDw9OA18w3fLZ8YXfhhMO4dwhE
         0NrMlvda5NAq/IOq8HSjLnjeAdeOvQK4U38jiaRDkUkziQ0zVeII/0opN4kGV6TDtTKq
         EmMU+lWrV4n6CNHrorcSH4hxel5O7DnIXMjF235kfBltqENmZX7gMCYLws1TD9VKPZQC
         RSoVNRc54ExuoguwYkCzNJVvANSjEA49ScWyvvwHSqUy9cbpZzYt2QZoJ5xd6Zmx/6Bd
         i4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791999; x=1686383999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLedi3hVqxdWr/OA7+QyOEQ+v1I2KL3cVmpY7bRy76c=;
        b=GEmYF/vDDOvbj1EixtbJ1lsawDuXeF6fxd8pT+7g+MIFOr3+/zSXEWzcAjr4/EpMi0
         58feM/4qJzWNO8WKF/XWKPEiVV5WMevfQHkcoBqy3Z163hv5H2pKVuSgQifNNO5XJIB3
         r2xpJaleUk1BvupHSRhefXdD/XQ5qpcBJ/nKxxueEHKjTAHwKAKi2Qent5kvdZPzDu+J
         KnbTanBgs+BguOyMHGQsIMJSGCtru4QgraHj3ISU85lLRaakLNL+rSCBlUFRZQqeR3gX
         rWqgwM77LsioriKLazGdeQm1yt0QrgiFtKekIEdtQYyVC4gKvINlrCrnglzXIUL6oc7N
         OJag==
X-Gm-Message-State: AC+VfDxNmZFwdwIQC0H/Mf9Hc1zWLyFie7cEfkJ7+gxxI5BP12qZrxH5
        jOZ3kUBYkodZLffzFNaYOXTpGCPNQt5YHN5pnfLkOA==
X-Google-Smtp-Source: ACHHUZ5XeLYnAgTnNAPYINTjUZ3CysgP034aVICvD8N6VjAM29zNXayOTGWxPB7hbvhUjplQxGEgFdW20FH3eRj+54w=
X-Received: by 2002:a25:1d7:0:b0:b9e:7b1d:4d4d with SMTP id
 206-20020a2501d7000000b00b9e7b1d4d4dmr25075363ybb.12.1683791999085; Thu, 11
 May 2023 00:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a686ca05fb6584ea@google.com> <CAG_fn=XUQUpt69a66i7XM9tHeQL96WnzNJ9X60OTm3ZB5=khZA@mail.gmail.com>
In-Reply-To: <CAG_fn=XUQUpt69a66i7XM9tHeQL96WnzNJ9X60OTm3ZB5=khZA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:59:23 +0200
Message-ID: <CAG_fn=WsX6260u+_oj+srT-_M0LqkoVtNTHeK0vk+364=W__7A@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in strlcat
To:     syzbot <syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com>
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
> <syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confu=
sio..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10811e34280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b=
7bdce
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D26836cb949db3=
d40c992
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
>
> Sorry for the noise, I was trying to switch KMSAN bots to the upstream
> tree (it is not ready yet, needs one more patch), and accidentally
> sent this report to LKML. Please disregard it.

#syz invalid

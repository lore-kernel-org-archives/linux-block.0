Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14578C761AF
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 15:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjCaPtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCaPtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 11:49:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059437AB0
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:49:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e392e10cc4so722831cf.0
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680277746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUOEBkfqFyDCBC8ECDHsPP9QVPu8ZlPnlnebW3bc4Wk=;
        b=FY953/CnzlwXU3r1VaUDCjpKU3/FnptXqMVBTcFFdpOiaNBzMrpEDeIuFcWlKor7Kn
         lFFhCvjaBgKh7SxjnFBNv6uNosDKUfuW+LTfhRPMIGnHdUBybMPH5KDYKg6w3JBVeZ/n
         F5uogEgSeVOqBktcX9OhMBmv+FrZZfr/IjS0BXLmTTrF7l5ZBRroUkUuNIbCYyR4B/W6
         t28pBBawCuMqIJJz4+Wh+CgPl/+vVNMjWsydcdfM+IL3qpUZOFD1MdF8zDa1BH5QXuze
         rYmP4lyHFFYJIlB7R5kOYJfyGsOPqtYBIFlBha4fzASc93k/j1FT75YboKPSc8W3T0V1
         fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUOEBkfqFyDCBC8ECDHsPP9QVPu8ZlPnlnebW3bc4Wk=;
        b=5VsDdCfz4I1RmysobEv7BWzdNdViApLwUrH58/zV6ox16L5FXkU3C4AoDpEyx5BKxR
         yWPTKeK+uohQURT5wbI5HvUPujRnNZ6+xcMTrf9KPtmkf6lZ0Esj/1lISUJkkw9FDuWV
         IKk3bF1ppzGxf97d40e3b4VdbBbbBSsskEKoplI0VfMjPqkR2J1fYD+OilI3miF14tx6
         tErpNfuYNeW+iHfiCETr1bDaQGhLS8yfd+3rUGsG1NSP5ps89oPIBX9vNyAciSeELqap
         IUmEEhSgri+5Yut8Eb3e2AFiKSqAJPUX5VF0JAB+8F4iG2whIzXFq3+8E+lDpYaRXDat
         GRQw==
X-Gm-Message-State: AAQBX9fsnPDc77uwKr253/XybDBL7PAXqnIBJa30vM8BeDtGNurCTpkl
        Qfe5UwgU/77PPtJXWOnRNJ/c/Z+fGfthBudz4S8jWQ==
X-Google-Smtp-Source: AKy350ag99cJ/JEGuKnsMSmBASTRl+ZXG21PE7l3bKosWkqKptj6CG0C5aWUVPT4lPH4wD1HF4kzYv2oTCBy7ERfqKQ=
X-Received: by 2002:ac8:5bca:0:b0:3e2:3de:3732 with SMTP id
 b10-20020ac85bca000000b003e203de3732mr346582qtb.7.1680277746464; Fri, 31 Mar
 2023 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a5c9be05ed85b31b@google.com> <00000000000020d46805f8340e6b@google.com>
In-Reply-To: <00000000000020d46805f8340e6b@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 31 Mar 2023 17:48:54 +0200
Message-ID: <CANp29Y4gA0D=O5CL3bxhYjT3mYtifXU-J-SXBiOTxfpYsfvTdw@mail.gmail.com>
Subject: Re: [syzbot] [block?] KASAN: use-after-free Read in netdev_core_pick_tx
To:     syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, gakula@marvell.com, hdanton@sina.com,
        jiasheng@iscas.ac.cn, justin@coraid.com, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.swiatkowski@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 31, 2023 at 5:42=E2=80=AFPM syzbot
<syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f038f3917baf04835ba2b7bcf2a04ac93fbf8a9c
> Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Date:   Fri Mar 17 06:43:37 2023 +0000
>
>     octeontx2-vf: Add missing free for alloc_percpu
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D133a3d2ec8=
0000
> start commit:   42226c989789 Linux 5.18-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd84df8e1a4c4d=
5a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D10a7a8ca6e94600=
110ec
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11ed1369f00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D166b22cef0000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, the commit is unfortunately unrelated.

>
> #syz fix: octeontx2-vf: Add missing free for alloc_percpu
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000020d46805f8340e6b%40google.com.

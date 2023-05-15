Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB0C77B75
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 06:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjEOGwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 02:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjEOGw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 02:52:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B65330CA
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 23:52:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so108425583a12.0
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684133522; x=1686725522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU8VcqrDU7sJUn4u+5JJZPRJmTQMF1Ie++cSMBnZmbk=;
        b=VPoFLeW/EP7IQ6ApuNtJmILHwlZiXKiHziXggBTKICmpDRONQPMVeXfgU8kQqBphej
         Ib1ToEvOf8wovIuptyixe9HmQYQEk6bpZ30zzuZL3nZs1g2OdIvWd+7EYPKoEZrrDWZ3
         Yi5p9DuVEJeCSPS3ChrLpjI24CU0Zs2H/fhxfxKDShdMdWcWM7MUI4x5haRMNgQ7zx/E
         pbARCgZOv67GjAO5jsnoi3mT5fP5PVFxre7Z0JKDEoYG7UVWvSWKq3Va7ouHfzVf/qqj
         Ppy7/kSOlGqbOqz/wSk7hbw+auTOBnOEqOWEPO7FAfShiYXCqlwybH0QMrUm9uAkB+Ux
         q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133522; x=1686725522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU8VcqrDU7sJUn4u+5JJZPRJmTQMF1Ie++cSMBnZmbk=;
        b=FXDUHT9UhI0E95jCgEH73OYq58XXNnAF01dsohllFR4FTKhubVJ2PWH/mxfcptPYbz
         go1W68XNptziOeEZZmHqBBY5RQjfn2gMjdH8B9PAUgfz8wEXDD0+hQGztjyC1IXRibsu
         V6b1icvR0AU7KLbCzfcHMwgi/gNttpaZJQaGMedEHzDM87GM5MNrLwpbPOSJqsK/vTSV
         jPv1Rp0ryq/QVvIsaWJqi4aFRHLbdxbHNe9wKtUAQ7P2f4I6fyP/ibjGsKY1esLpwTwN
         XR9aEt6d7a/wtXIT7tAQrw2D/geccS86zrsBSG07vDBfOjdwtZNtj1qXSQJ0H/sXNZKq
         A2HQ==
X-Gm-Message-State: AC+VfDzTFhB9grE9D5ABWJ0jGKUss75CB2EinYxi2+j2B/Hk41HQKmh1
        PTdza/NhvdqkKlaP/4dgwIk0lCDr7JEjbkKAETGyWQ==
X-Google-Smtp-Source: ACHHUZ5ML0xi3eLAmhRruA3P0xCAg8JPxhOZ8HrC7Ajf/1M6JzYUdPKicjkxyoefbUOozLbQl6EJ5pcOLfPVgaTAFFA=
X-Received: by 2002:a17:907:7295:b0:94e:bf3e:638 with SMTP id
 dt21-20020a170907729500b0094ebf3e0638mr27534772ejc.11.1684133521742; Sun, 14
 May 2023 23:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230512034631.28686-1-guoqing.jiang@linux.dev> <168390417558.869582.12806498816427316733.b4-ty@kernel.dk>
In-Reply-To: <168390417558.869582.12806498816427316733.b4-ty@kernel.dk>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 15 May 2023 08:51:50 +0200
Message-ID: <CAMGffEnf3tVNLX4=8LkB06TMrTVy8SRMZDCWtEm=z+95As6M8w@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
To:     Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, hch@infradead.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 5:09=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Fri, 12 May 2023 11:46:31 +0800, Guoqing Jiang wrote:
> > Since flush bios are implemented as writes with no data and
> > the preflush flag per Christoph's comment [1].
> >
> > And we need to change it in rnbd accordingly. Otherwise, I
> > got splatting when create fs from rnbd client.
> >
> > [  464.028545] ------------[ cut here ]------------
> > [  464.028553] WARNING: CPU: 0 PID: 65 at block/blk-core.c:751 submit_b=
io_noacct+0x32c/0x5d0
> > [ ... ]
> > [  464.028668] CPU: 0 PID: 65 Comm: kworker/0:1H Tainted: G           O=
E      6.4.0-rc1 #9
> > [  464.028671] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> > [  464.028673] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> > [  464.028717] RIP: 0010:submit_bio_noacct+0x32c/0x5d0
> > [  464.028720] Code: 03 0f 85 51 fe ff ff 48 8b 43 18 8b 88 04 03 00 00=
 85 c9 0f 85 3f fe ff ff e9 be fd ff ff 0f b6 d0 3c 0d 74 26 83 fa 01 74 21=
 <0f> 0b b8 0a 00 00 00 e9 56 fd ff ff 4c 89 e7 e8 70 a1 03 00 84 c0
> > [  464.028722] RSP: 0018:ffffaf3680b57c68 EFLAGS: 00010202
> > [  464.028724] RAX: 0000000000060802 RBX: ffffa09dcc18bf00 RCX: 0000000=
000000000
> > [  464.028726] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffa09=
dde081d00
> > [  464.028727] RBP: ffffaf3680b57c98 R08: ffffa09dde081d00 R09: ffffa09=
e38327200
> > [  464.028729] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa09=
dde081d00
> > [  464.028730] R13: ffffa09dcb06e1e8 R14: 0000000000000000 R15: 0000000=
000200000
> > [  464.028733] FS:  0000000000000000(0000) GS:ffffa09e3bc00000(0000) kn=
lGS:0000000000000000
> > [  464.028735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  464.028736] CR2: 000055a4e8206c40 CR3: 0000000119f06000 CR4: 0000000=
0003506f0
> > [  464.028738] Call Trace:
> > [  464.028740]  <TASK>
> > [  464.028746]  submit_bio+0x1b/0x80
> > [  464.028748]  rnbd_srv_rdma_ev+0x50d/0x10c0 [rnbd_server]
> > [  464.028754]  ? percpu_ref_get_many.constprop.0+0x55/0x140 [rtrs_serv=
er]
> > [  464.028760]  ? __this_cpu_preempt_check+0x13/0x20
> > [  464.028769]  process_io_req+0x1dc/0x450 [rtrs_server]
> > [  464.028775]  rtrs_srv_inv_rkey_done+0x67/0xb0 [rtrs_server]
> > [  464.028780]  __ib_process_cq+0xbc/0x1f0 [ib_core]
> > [  464.028793]  ib_cq_poll_work+0x2b/0xa0 [ib_core]
> > [  464.028804]  process_one_work+0x2a9/0x580
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
>       commit: 5e6e08087a4acb4ee3574cea32dbff0f63c7f608
>
> Best regards,
> --
> Jens Axboe
Thanks guoqing for fixing up, and Jens for merging the fix and review
from Chaitanya and Chirstoph
>
>
>

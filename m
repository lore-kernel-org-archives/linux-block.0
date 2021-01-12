Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D042AC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13D52311D
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbhALR2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbhALR2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 12:28:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01DAC061786;
        Tue, 12 Jan 2021 09:27:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j13so2119026pjz.3;
        Tue, 12 Jan 2021 09:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=npotAZCC1jToC7oCL12H8ovzJebkL5GEsCr1/71ZxUo=;
        b=JCgKB/l6rtTbEkpjkPT7WHQs5o9KnhVLUGPnbEYMshrJPARa0sD2XT0iy9CbN64rcG
         UdUCxBHUg/JA2ei6wzczZS32if9smlxCmq5GNHY21VNUj3Ns8aGhAwnzMh6+RGFVrOyG
         vN3hQLTeqbLfONXPBuIwaf9mFNmGDt8j/eNV3uueb3ZiGdrCs2nHqJ6/R3wYZLHY0u19
         X78eN+s5Fut8KLHG43eOVDijdzs8CA9qW3ud+twVqoFzN+iIJzV3qmkDidJdL/zQdtUM
         /pYS8LUVRhQ8rpaAyaYXIpwOprK7RSqNSBOkF4U46tge0EMxTgXk1hAHa835pVRWtEOA
         2Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=npotAZCC1jToC7oCL12H8ovzJebkL5GEsCr1/71ZxUo=;
        b=iseda7H2JfKdxFKRJdkY/RJHecY9F9UdpBHvKT2OGOxui/4tm9vSWq1DWlo6O4cxg6
         j7T/rgZJpu2kwOPyu6sNSwVKuvHTavsFirL7UvgX2H4pml8BhplrpZNnDBvNQ+xloQOh
         6bPRLIy6e9I38i87PViaWIs4KwBxUIw5EXsxGDgM07GBL2DgpuWaIP8yUs9fg+FRz25H
         MlLFcCCbhkvfkubirMdh5nbicQWiW3sf+S1sl6NPq/9gDcf09efuvS+w76j4smkFGvsL
         C6YdlVko4DNPmRvCHPEFBE/mqNpEudMF1WJYu275vpyOCTyU9BNgVq4q/cCgql2WSvf/
         nqgg==
X-Gm-Message-State: AOAM5318izqNPArGJfpaLMPYgTNB2Wt2meEXrN3Wbmi8cU3I9muUr+Tq
        ZiwiGQQUxBhP49woP3wtyEhyti/ygvIRBz1NkVQ=
X-Google-Smtp-Source: ABdhPJx+lF4bUfgSCXTXQofVnEf0+9bjdcWJsYxz6aWyDycugUMUpTgt+En4Z+jYXIIToZ6MdnhFI3ytZqliqubAzZA=
X-Received: by 2002:a17:902:7789:b029:dc:9a9b:6919 with SMTP id
 o9-20020a1709027789b02900dc9a9b6919mr187537pll.4.1610472457117; Tue, 12 Jan
 2021 09:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20210112152951.154024-1-fengli@smartx.com> <20210112155502.426331-1-fengli@smartx.com>
 <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Wed, 13 Jan 2021 01:27:10 +0800
Message-ID: <CAEK8JBALYE0_OzfhrppF38=dD7HKSn-U0ggPJTGgx5849Gfiiw@mail.gmail.com>
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

I use the nvme-tcp as the host, the target is spdk nvme-tcp target,
and set a wrong block size(i.g. bs=3D8), then the host prints this oops:

[   63.153018] nvme nvme0: creating 3 I/O queues.
[   63.181644] nvme nvme0: mapped 3/0/0 default/read/poll queues.
[   63.185568] nvme nvme0: new ctrl: NQN
"nqn.2018-11.io.spdk:nvmf-test", addr 192.168.64.217:4421
[   63.189440] divide error: 0000 [#1] SMP NOPTI
[   63.190963] CPU: 0 PID: 122 Comm: kworker/u8:2 Not tainted
5.9.9-200.fc33.x86_64 #1
[   63.193426] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-1.fc33 04/01/2014
[   63.196263] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[   63.198015] RIP: 0010:blk_stack_limits+0x189/0x440
[   63.199549] Code: 43 28 0f b6 45 62 08 43 62 8b 4d 2c 39 4d 38 0f
43 4d 38 31 d2 45 31 f6 48 8b 04 24 8b 75 34 89 cf 44 8b 43 34 c1 ef
09 09
[   63.203169] RSP: 0018:ffffb312001ffc98 EFLAGS: 00010202
[   63.204034] RAX: 0000000000000000 RBX: ffff9463b270ecc8 RCX: 00000000000=
00008
[   63.205205] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000000=
00000
[   63.206377] RBP: ffff9463b27083f8 R08: 0000000000000000 R09: 00000000000=
00008
[   63.207553] R10: ffff9463b81d6420 R11: 0000035f00000000 R12: ffff9463b2b=
ea000
[   63.208725] R13: ffff9463b6d31258 R14: 0000000000000000 R15: ffff9463b6c=
22800
[   63.209914] FS:  0000000000000000(0000) GS:ffff9463bec00000(0000)
knlGS:0000000000000000
[   63.211239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.212186] CR2: 000055d73270e690 CR3: 0000000036b32000 CR4: 00000000000=
006f0
[   63.213383] Call Trace:
[   63.213826]  ? blk_mq_freeze_queue_wait+0x13/0x80
[   63.214609]  __nvme_revalidate_disk+0x191/0x2d0 [nvme_core]
[   63.215528]  nvme_validate_ns+0x3fa/0x960 [nvme_core]
[   63.216374]  nvme_scan_work+0x165/0x3c0 [nvme_core]
[   63.217183]  process_one_work+0x1b4/0x370
[   63.217852]  worker_thread+0x53/0x3e0
[   63.218458]  ? process_one_work+0x370/0x370
[   63.219156]  kthread+0x11b/0x140
[   63.219700]  ? __kthread_bind_mask+0x60/0x60
[   63.220403]  ret_from_fork+0x22/0x30

Martin K. Petersen <martin.petersen@oracle.com> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=
=93=EF=BC=9A
>
>
> Li,
>
> > If the physical_block_size and io_min is less than a sector,
>
> That's not supposed to happen. What device/driver is this?
>
> --
> Martin K. Petersen      Oracle Linux Engineering

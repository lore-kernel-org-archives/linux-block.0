Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C9C19F2A
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHAQz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHAQzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 12:55:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857AC0B
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 09:55:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk8so21461312ejc.7
        for <linux-block@vger.kernel.org>; Mon, 01 Aug 2022 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KG5UFHLdXkEG8GpHewm6HOmLKgUyGZYGaXAcRTral+U=;
        b=OmNLZepixW4Q5Qyml6soJXKQ3E1F53BlIAiVAx1agH91+QrXLoaNCwj6YvmmMn7G/q
         dOvAouAvzNLouJhZf2dJaxeA+WGwl/Zv5jUbUI1SvpZT5Vz4AVSMdygYft25xSAxXEzo
         9yXRPWQaBlXaQIOT4kENbGEGLduF0b34UXMuvzXqxyRxHramSa3AUA0BgBMPjjhJZFrN
         HsGPcWAuTfHl5h0WXR/hsvuVUy+tqi4iqJC11l+31fqdQ7SCONGP5AlOS9oLItDhsAWg
         GbAaKrTPHChok1IY3W1FQRAwe+JGovqD65eiro2QcvrUf3FRVNVyy1ShZPUTXsVxtOfC
         ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KG5UFHLdXkEG8GpHewm6HOmLKgUyGZYGaXAcRTral+U=;
        b=5zgfkQbd2PwZv/qZ+qSKIHOb0c7BmvaAf8Ln1zoSP7jQEX+R9TEeB7B+n6GKOgydVD
         V7HJo4a9MslvvBJwh6q3MkbRGM8/JcDW5Z8iJv+3JleRBGOdAprQa2BVrUwClNEV24/k
         5ypN7hZWvqRQ9wpgKBGCottKb+2Zu0Iubjm/ra0HusjNZFsiKgWKYZhnm+HWTVvobzp/
         +3P3ojy5n00Bq0hJKEwVNe1yEn0+pRM+yjiHZ0nmCH7Jz02Y57u49w7mwSMJKnUIDTJt
         yy0+TyoTbU0Km1r/vt9UiJ7Seyftu3D6sJ/btL51h1J1Jas9zwe0TNbwmQGN4NwXos2U
         VYaw==
X-Gm-Message-State: ACgBeo2A7NaBhyLukb8VI/RFHML4LYG/yNQ71Nk3nzAEwZL/qCFKkCEw
        8IunyVpAe9L2E6+Hlt1XABnenAKV+IJ1h/RbY/M=
X-Google-Smtp-Source: AA6agR76Y/g6DD/U2kdBvO0uqO9M86ulB2TO8Hhe05o0GuUGMVFdKC0CT3+fBPfTKA5+a/bKgK+ATr5lVSSc7WET3Sg=
X-Received: by 2002:a17:906:98c8:b0:730:8bfb:6cd with SMTP id
 zd8-20020a17090698c800b007308bfb06cdmr3383949ejb.334.1659372922274; Mon, 01
 Aug 2022 09:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
In-Reply-To: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
From:   Kim Suwan <suwan.kim027@gmail.com>
Date:   Tue, 2 Aug 2022 01:55:11 +0900
Message-ID: <CAFNWusbavuD9vMuTjV0fEFjTCnMCd1+HPkUC+GsF2FYewrDJ_Q@mail.gmail.com>
Subject: Re: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alexandre,

Thanks for reporting the issue.

I think a possible scenario is that request fails at
virtio_queue_rqs() and it is passed to normal path (virtio_queue_rq).

In this procedure, It is possible that blk_mq_start_request()
was called twice changing request state from MQ_RQ_IN_FLIGHT to
MQ_RQ_IN_FLIGHT.

Could I know if the issue occurs every booting time?

Regards,
Suwan Kim


On Mon, Aug 1, 2022 at 3:11 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi,
>
> I am getting this warning when booting a 5.19 Linux guest on crosvm
> (5.18 did not have this issue):
>
> [    1.890468] ------------[ cut here ]------------
> [    1.890776] WARNING: CPU: 2 PID: 122 at block/blk-mq.c:1143
> blk_mq_start_request+0x8a/0xe0
> [    1.891045] Modules linked in:
> [    1.891250] CPU: 2 PID: 122 Comm: journal-offline Not tainted 5.19.0+ #44
> [    1.891504] Hardware name: ChromiumOS crosvm, BIOS 0
> [    1.891739] RIP: 0010:blk_mq_start_request+0x8a/0xe0
> [    1.891961] Code: 12 80 74 22 48 8b 4b 10 8b 89 64 01 00 00 8b 53
> 20 83 fa ff 75 08 ba 00 00 00 80 0b 53 24 c1 e1 10 09 d1 89 48 34 5b
> 41 5e c3 <0f> 0b eb b8 65 8b 05 2b 39 b6 7e 89 c0 48 0f a3 05 39 77 5b
> 01 0f
> [    1.892443] RSP: 0018:ffffc900002777b0 EFLAGS: 00010202
> [    1.892673] RAX: 0000000000000000 RBX: ffff888004bc0000 RCX: 0000000000000000
> [    1.892952] RDX: 0000000000000000 RSI: ffff888003d7c200 RDI: ffff888004bc0000
> [    1.893228] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888004bc0100
> [    1.893506] R10: ffffffffffffffff R11: ffffffff8185ca10 R12: ffff888004bc0000
> [    1.893797] R13: ffffc90000277900 R14: ffff888004ab2340 R15: ffff888003d86e00
> [    1.894060] FS:  00007ffa143a4640(0000) GS:ffff88807dd00000(0000)
> knlGS:0000000000000000
> [    1.894412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.894682] CR2: 00005648577d9088 CR3: 00000000053da004 CR4: 0000000000170ee0
> [    1.894953] Call Trace:
> [    1.895139]  <TASK>
> [    1.895303]  virtblk_prep_rq+0x1e5/0x280
> [    1.895509]  virtio_queue_rq+0x5c/0x310
> [    1.895710]  ? virtqueue_add_sgs+0x95/0xb0
> [    1.895905]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> [    1.896133]  ? virtio_queue_rqs+0x340/0x390
> [    1.896453]  ? sbitmap_get+0xfa/0x220
> [    1.896678]  __blk_mq_issue_directly+0x41/0x180
> [    1.896906]  blk_mq_plug_issue_direct+0xd8/0x2c0
> [    1.897115]  blk_mq_flush_plug_list+0x115/0x180
> [    1.897342]  blk_add_rq_to_plug+0x51/0x130
> [    1.897543]  blk_mq_submit_bio+0x3a1/0x570
> [    1.897750]  submit_bio_noacct_nocheck+0x418/0x520
> [    1.897985]  ? submit_bio_noacct+0x1e/0x260
> [    1.897989]  ext4_bio_write_page+0x222/0x420
> [    1.898000]  mpage_process_page_bufs+0x178/0x1c0
> [    1.899451]  mpage_prepare_extent_to_map+0x2d2/0x440
> [    1.899603]  ext4_writepages+0x495/0x1020
> [    1.899733]  do_writepages+0xcb/0x220
> [    1.899871]  ? __seccomp_filter+0x171/0x7e0
> [    1.900006]  file_write_and_wait_range+0xcd/0xf0
> [    1.900167]  ext4_sync_file+0x72/0x320
> [    1.900308]  __x64_sys_fsync+0x66/0xa0
> [    1.900449]  do_syscall_64+0x31/0x50
> [    1.900595]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    1.900747] RIP: 0033:0x7ffa16ec96ea
> [    1.900883] Code: b8 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3
> 48 83 ec 18 89 7c 24 0c e8 e3 02 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 43 03 f8 ff 8b
> 44 24
> [    1.901302] RSP: 002b:00007ffa143a3ac0 EFLAGS: 00000293 ORIG_RAX:
> 000000000000004a
> [    1.901499] RAX: ffffffffffffffda RBX: 0000560277ec6fe0 RCX: 00007ffa16ec96ea
> [    1.901696] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000016
> [    1.901884] RBP: 0000560277ec5910 R08: 0000000000000000 R09: 00007ffa143a4640
> [    1.902082] R10: 00007ffa16e4d39e R11: 0000000000000293 R12: 00005602773f59e0
> [    1.902459] R13: 0000000000000000 R14: 00007fffbfc007ff R15: 00007ffa13ba4000
> [    1.902763]  </TASK>
> [    1.902877] ---[ end trace 0000000000000000 ]---
>
> Apparently the state of the queue is not as expected, for some reason:
>
>     WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>
> Reverting 0e9911fa768f removes the warning, as does commenting out the
> queue_rqs op of the virtio-blk device.
>
> I am not particularly versed in the block device layer so thought I
> would report this first. Please let me know if I can provide more
> information.
>
> Cheers,
> Alex.

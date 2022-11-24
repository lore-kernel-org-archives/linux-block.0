Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DDCC43217
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 14:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKXO6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 09:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiKXO6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 09:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB397CBBA
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669301836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XO7Fm1s0VW6Jx3XmvRaSlkUcjpk9LYlYZoyUOKReOG8=;
        b=Zu686336dyO0FwiPEly9yjOp0w2EuGlG1YWMU75iPAnCZtuMVp17iH3qAAG4Z9vqnQTbpA
        DjitrE69ohrv24lZUoSvGtdQDntobgUjfUaIsuzvRF63SOQXCOUsuqQgXxD/uxVll7jxj2
        WFpOxNxKzhuw3LObf7t2pDJJIspqdNo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-0itDBJ2zNySJz3LesNL9nA-1; Thu, 24 Nov 2022 09:57:15 -0500
X-MC-Unique: 0itDBJ2zNySJz3LesNL9nA-1
Received: by mail-pl1-f199.google.com with SMTP id c1-20020a170902d48100b0018723580343so1503636plg.15
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 06:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO7Fm1s0VW6Jx3XmvRaSlkUcjpk9LYlYZoyUOKReOG8=;
        b=ppVnEV1+/l4K1Elc68YHdxdX0hu5WWbPbTmEnBJMjFnUtW1/VHfgsOccHUgBWwjnmD
         76uQdwjAjo8vxJVhq1QMcoWJ3eTyp8JOzvVtnuLoD90UOEJZGFt3a9+yjQ9SYBBSFZ53
         95oJffd/8nTMoRTIv1oR21En9980rFklF9rDzqeqicAqhCka6iKvllDDKhnxOJaOT7pi
         z1sc4EyVKuVNXcA4aoEVKdV0td5MSzpalv81SSxy7xGZGOZ2+3LqYt0TE8D6wEohEJma
         rNpph0Eh/NiicfQX0esq5pgKf55QtUYLrp8VdpO9aNC26eWVl66BoVYarh+2onDuMg2X
         vdRQ==
X-Gm-Message-State: ANoB5pntDmNRdLwm2Kj63qCRatNDYqPTns/yowUvSgEQwcElG9Fk+j9E
        sDAnpb4of+QwP6Zk/hD+979SoPsP213g0kaYFzuI8QERz+K6iCbsITBUHPUCdL7BPMJ/r2KVCMT
        pAzyt0KDPyohcPfhAH+Di+4xpuoWGmp2NSN+nce0=
X-Received: by 2002:a63:c046:0:b0:477:b0d0:bbff with SMTP id z6-20020a63c046000000b00477b0d0bbffmr9374509pgi.364.1669301833820;
        Thu, 24 Nov 2022 06:57:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4g2SnJzGC92qPR6fsYlx9g41Gi3RxXh6dlwg6a3PyHqFCplGOdzVNYceKfy2SN/lJy9ZY7rqEUWIbcDtjNw3A=
X-Received: by 2002:a63:c046:0:b0:477:b0d0:bbff with SMTP id
 z6-20020a63c046000000b00477b0d0bbffmr9374495pgi.364.1669301833499; Thu, 24
 Nov 2022 06:57:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
In-Reply-To: <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 24 Nov 2022 15:57:02 +0100
Message-ID: <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
Subject: Re: kernel BUG at lib/list_debug.c:30! (list_add corruption.
 prev->next should be nex)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Nov 2022 at 14:46, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/23/22 1:48=E2=80=AFAM, Bruno Goncalves wrote:
> > Hello,
> >
> > We recently started to hit the following panic when testing the block
> > tree (for-next branch).
> >
> > [ 5076.172749] list_add corruption. prev->next should be next
> > (ffff91cd6f7fa568), but was ffff91c991ca6670. (prev=3Dffff91c991ca6670)=
.
> > [ 5076.173863] ------------[ cut here ]------------
> > [ 5076.174853] kernel BUG at lib/list_debug.c:30!
> > [ 5076.175523] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [ 5076.175853] CPU: 15 PID: 16415 Comm: kworker/15:13 Tainted: G
> >    I        6.1.0-rc6 #1
> > [ 5076.176799] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24/2=
019
> > [ 5076.177198] Workqueue: cgwb_release cgwb_release_workfn
> > [ 5076.177497] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > [ 5076.177788] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 48
> > c7 c7
> > [ 5076.179173] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > [ 5076.179472] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 0000000=
000000000
> > [ 5076.180241] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 0000000=
0ffffffff
> > [ 5076.181069] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa1c=
98a6afc60
> > [ 5076.182209] R10: 0000000000000003 R11: ffff91cd7ff42fe8 R12: ffff91c=
d6f7fa568
> > [ 5076.183002] R13: ffff91c991ca6670 R14: ffff91c991ca6670 R15: ffff91c=
d6f7f1440
> > [ 5076.183902] FS:  0000000000000000(0000) GS:ffff91cd6f7c0000(0000)
> > knlGS:0000000000000000
> > [ 5076.184377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5076.185084] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 0000000=
0000606e0
> > [ 5076.185945] Call Trace:
> > [ 5076.186110]  <TASK>
> > [ 5076.186916]  insert_work+0x46/0xc0
> > [ 5076.187533]  __queue_work+0x1d4/0x460
> > [ 5076.187788]  queue_work_on+0x37/0x40
> > [ 5076.187993]  blkcg_unpin_online+0x1ad/0x1b0
> > [ 5076.188244]  cgwb_release_workfn+0x6a/0x200
> > [ 5076.188464]  process_one_work+0x1c7/0x380
> > [ 5076.188675]  worker_thread+0x4d/0x380
> > [ 5076.188881]  ? rescuer_thread+0x380/0x380
> > [ 5076.189089]  kthread+0xe9/0x110
> > [ 5076.189716]  ? kthread_complete_and_exit+0x20/0x20
> > [ 5076.190407]  ret_from_fork+0x22/0x30
> > [ 5076.190677]  </TASK>
> > [ 5076.190816] Modules linked in: nvme nvme_core nvme_common loop tls
> > rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> > intel_powerclamp coretemp sunrpc kvm_intel kvm iTCO_wdt iapl
> > intel_cstate intel_uncore pcspkr lpc_ich ipmi_ssif hpilo tg3 acpi_ipmi
> > ioatdma ipmi_si ipmi_devintf dca ipmi_msghandler acpi_power_meter fuse
> > zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> > polyval_generic ghash_clmulni_intel sha512_ssse3 serio_raw hpsa
> > mgag200 scsi_transport_sas [last unloaded: scsi_debug]
> > [ 5076.293315] ---[ end trace 0000000000000000 ]---
> > [ 5076.295226] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > [ 5076.295587] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 48
> > c7 c7
> > [ 5076.296921] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > [ 5076.297239] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 0000000=
000000000
> > [ 5076.297983] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 0000000=
0ffffffff
> > [ 5076.298768] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa1c=
98a6afc60
> > [ 5076.299525] R10: 0000S:  0000000000000000(0000)
> > GS:ffff91cd6f7c0000(0000) knlGS:0000000000000000
> > [ 5076.700351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5076.701046] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 0000000=
0000606e0
> > [ 5076ernel panic - not syncing: Fatal exception
> > [ 5077.924713] Shutting down cpus with NMI
> > [ 5077.924986] Kernel Offset: 0x2b000000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [ 5077.927946] ---[ end Kernel panic - not syncing: Fatal exception ]--=
-
> >
> > It seems to happen often during different tests.
> >
> > full console.log:
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/da=
tawarehouse-public/2022/11/21/redhat:700955106/build_x86_64_redhat:70095510=
6_x86_64/tests/1/results_0001/console.log/console.log
> >
> > kernel tarball:
> > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifac=
ts/700955106/publish%20x86_64/3356091217/artifacts/kernel-block-redhat_7009=
55106_x86_64.tar.gz
> >
> > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/=
trusted-artifacts/700955106/build%20x86_64/3356091207/artifacts/kernel-bloc=
k-redhat_700955106_x86_64.config
> >
> > test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> >
> > We didn't bisect, but the first commit we hit the problem was
> > "f65d92c600fe6eecdbd6e7fab7893c9c094dfcbf
> > (io_uring-6.1-2022-11-18-2180-gf65d92c600fe)" and the last one where
> > we didn't hit the problem was
> > "40fa774af7fd04d06014ac74947c351649b6f64f
> > (io_uring-6.1-2022-11-11-1843-g40fa774af7fd)"
> >
> > test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> > cki issue tracker: https://datawarehouse.cki-project.org/issue/1732
>
> Please just try and clone for-6.2/block from the block tree and bisect
> it?
>

Hi,
I've tried with commit 93c68cc46a070775cc6675e3543dd909eb9f6c9e (drbd:
use consistent license), but I was not able to hit the panic with it.


Bruno

> --
> Jens Axboe
>
>


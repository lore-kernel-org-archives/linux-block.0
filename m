Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF7C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29ED60C51
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhJSJpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234764AbhJSJps (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 05:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634636615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9aTZbqcvn/jav246EtrvcBxJ0XUz1/bgWtUWvk310E=;
        b=Bgs4GtQ8ISjjEaSmzCB9cxKThRsTkybNeWHjhuFilUUulwicaA4fSKsW6ybtoYNO8s7K9N
        qCQBbzQHJiovoqwOjZ0D/2YLEXiWy2eDQUPfLHbs4E2nEtMGcRyYhO74rTeei7x/UNTJlg
        uvTpq+OyYcZni6h8E3bnorPT13gd0Ro=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-aJInQkXdOeudS-am28jCIg-1; Tue, 19 Oct 2021 05:43:34 -0400
X-MC-Unique: aJInQkXdOeudS-am28jCIg-1
Received: by mail-oi1-f199.google.com with SMTP id w26-20020a056808019a00b00298e7b4523cso1548325oic.9
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 02:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9aTZbqcvn/jav246EtrvcBxJ0XUz1/bgWtUWvk310E=;
        b=RnzY2o8Yqj6n304VnGcJ7sc5WOY2l30wxyC73xx0vqtk8psfM+5xvjr5aRUmAe1Ij6
         IohKerPeHARvU6flAiWhsxmI2eyleaxh3MdeIJgBoa0PAw+lIAxuT5tE+/pHMittaTn7
         dNALZRAZBnkdhUqRsZrcKcgwTNQdg61vdg6S558gk0cSEBesCwsuYCQ0liH7UlADsMcm
         YeFFwiJeU1rVpRXWpaLjvjBADomWPQ3vatb5cCzIyL+6WjKflczAJj+IQ5uTNktlvVQ3
         Hvis1nAD5IiGKLIJvFwmo59bPyUr3H9B8Wchd3rlDsoWV7JK4yJ3QhgQTR+DfgGhFlAI
         JQzA==
X-Gm-Message-State: AOAM532SPzp66SnwmfraWbXqeIHH99UiOVG2h7hVih0a3t3wYF0PgxND
        5XFSBmdm3S6hD3Ny23cenkxZBCyBXQ3QMKPbFtZejF+z/2uppc74ZHSAl6+dvCah5zrBK62DoQk
        xiDiN0qaJB7H3r4wxTS1pscnKo0XRjr/+1KfJBWw=
X-Received: by 2002:a05:6830:3184:: with SMTP id p4mr4293498ots.219.1634636612889;
        Tue, 19 Oct 2021 02:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdozApRAUPNbnCiReyBxV1/j32YV/pBeWyB1tmBEizCGrBAWRkDLsDvXuQdDAk0khFx4krw4ZHx5MiTNF0Mxc=
X-Received: by 2002:a05:6830:3184:: with SMTP id p4mr4293473ots.219.1634636612619;
 Tue, 19 Oct 2021 02:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <cki.1BB6AA01C6.FWO6ZHIQNG@redhat.com> <CAHj4cs_3MSAHXaxwwCreLhpL7c+Tak4+y-Hv_Ld7kDT0ZbCRtw@mail.gmail.com>
 <8543f0bf-66b8-8688-313a-0d9e21fce184@kernel.dk> <CAHj4cs8ooypxnhqmdRiJ56i0V0mrxnpo7VYy6RAndaQ=qTbpug@mail.gmail.com>
In-Reply-To: <CAHj4cs8ooypxnhqmdRiJ56i0V0mrxnpo7VYy6RAndaQ=qTbpug@mail.gmail.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 19 Oct 2021 11:43:21 +0200
Message-ID: <CA+QYu4rK8csEBjKNxkT0_TeB-NxySYq8gxK8xzCE6uCDRZrcSw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Waiting_for_review=3A_Test_report_f?=
        =?UTF-8?Q?or_kernel_5=2E15=2E0=2Drc6_=28block=2C_1983520d=29?=
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        skt-results-master@redhat.com,
        CKI Project <cki-project@redhat.com>,
        Changhui Zhong <czhong@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 5:41 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Tue, Oct 19, 2021 at 10:52 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/18/21 8:13 PM, Yi Zhang wrote:
> > > Hello
> > >
> > > With this commit, the servers boots with NULL pointer[1], pls help ch=
eck it.
> > >
> > >>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/=
axboe/linux-block.git
> > >>             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' =
into for-next
> > > [1]
> > > [    8.614036] Kernel attempted to read user page (f) - exploit
> > > attempt? (uid: 0)
> > > [    8.614071] BUG: Kernel NULL pointer dereference on read at 0x0000=
000f
> > > [    8.614099] Faulting instruction address: 0xc00000000093b5b4
> > > [    8.614118] Oops: Kernel access of bad area, sig: 11 [#1]
> > > [    8.614143] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA=
 PowerNV
> > > [    8.614192] Modules linked in: zram ip_tables ast i2c_algo_bit
> > > drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
> > > fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto crc32c_vpmsum
> > > i2c_core drm_panel_orientation_quirks
> > > [    8.614285] CPU: 52 PID: 0 Comm: swapper/52 Not tainted 5.15.0-rc6=
+ #1
> > > [    8.614323] NIP:  c00000000093b5b4 LR: c00000000093b5a4 CTR: c0000=
00000972c50
> > > [    8.614371] REGS: c000000018d3b430 TRAP: 0300   Not tainted  (5.15=
.0-rc6+)
> > > [    8.614409] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
> > > 44004284  XER: 00000000
> > > [    8.614464] CFAR: c000000000972cd0 DAR: 000000000000000f DSISR:
> > > 40000000 IRQMASK: 1
> > > [    8.614464] GPR00: c00000000093b5a4 c000000018d3b6d0
> > > c0000000028aa100 c000000044582a00
> > > [    8.614464] GPR04: 00000000ffff8e2c 0000000000000001
> > > 0000000000000004 c000000001212930
> > > [    8.614464] GPR08: 00000000000001d7 0000000000000007
> > > c000000044361f80 0000000000000000
> > > [    8.614464] GPR12: c000000000972c50 c000001ffffa7200
> > > 0000000000000000 0000000000000100
> > > [    8.614464] GPR16: 0000000000000004 0000000004200042
> > > 0000000000000000 0000000000000001
> > > [    8.614464] GPR20: c0000000028d3a00 c000000002167888
> > > 00000000ffff8e2d c000000002167888
> > > [    8.614464] GPR24: c0000000021f0580 0000000000000001
> > > c000000044582ae0 0000000000000801
> > > [    8.614464] GPR28: c000000044361f80 c000000044361f80
> > > c00000003b81f800 c000000044582a00
> > > [    8.614852] NIP [c00000000093b5b4] blk_mq_free_request+0x74/0x210
> > > [    8.614898] LR [c00000000093b5a4] blk_mq_free_request+0x64/0x210
> > > [    8.614942] Call Trace:
> > > [    8.614961] [c000000018d3b6d0] [c00000000093b8ec]
> > > __blk_mq_end_request+0x19c/0x1d0 (unreliable)
> > > [    8.615020] [c000000018d3b710] [c00000000092fdfc]
> > > blk_flush_complete_seq+0x1ac/0x3d0
> > > [    8.615077] [c000000018d3b770] [c0000000009302dc] flush_end_io+0x2=
bc/0x390
> > > [    8.615122] [c000000018d3b7d0] [c00000000093b7cc]
> > > __blk_mq_end_request+0x7c/0x1d0
> > > [    8.615174] [c000000018d3b810] [c000000000c20684]
> > > scsi_end_request+0x124/0x270
> > > [    8.615228] [c000000018d3b860] [c000000000c21458]
> > > scsi_io_completion+0x1f8/0x740
> > > [    8.615250] [c000000018d3b900] [c000000000c13e14]
> > > scsi_finish_command+0x134/0x190
> > > [    8.615292] [c000000018d3b990] [c000000000c21068] scsi_complete+0x=
a8/0x200
> > > [    8.615345] [c000000018d3ba10] [c000000000939870] blk_complete_req=
s+0x80/0xa0
> > > [    8.615409] [c000000018d3ba40] [c00000000115dfe0] __do_softirq+0x1=
70/0x3fc
> > > [    8.615475] [c000000018d3bb30] [c00000000015df38] __irq_exit_rcu+0=
x168/0x1a0
> > > [    8.615535] [c000000018d3bb60] [c00000000015e140] irq_exit+0x20/0x=
40
> > > [    8.615583] [c000000018d3bb80] [c000000000054670]
> > > doorbell_exception+0x120/0x300
> > > [    8.615616] [c000000018d3bbc0] [c000000000016cc4]
> > > replay_soft_interrupts+0x1e4/0x2c0
> > > [    8.615639] [c000000018d3bda0] [c000000000016ed8]
> > > arch_local_irq_restore+0x138/0x1a0
> > > [    8.615694] [c000000018d3bdd0] [c000000000de1714]
> > > cpuidle_enter_state+0x104/0x540
> > > [    8.615741] [c000000018d3be30] [c000000000de1bec] cpuidle_enter+0x=
4c/0x70
> > > [    8.615795] [c000000018d3be70] [c0000000001aef18] do_idle+0x2f8/0x=
3f0
> > > [    8.615839] [c000000018d3bf00] [c0000000001af238] cpu_startup_entr=
y+0x38/0x40
> > > [    8.615901] [c000000018d3bf30] [c00000000005be6c] start_secondary+=
0x29c/0x2b0
> > > [    8.615969] [c000000018d3bf90] [c00000000000d254]
> > > start_secondary_prolog+0x10/0x14
> > > [    8.616025] Instruction dump:
> > > [    8.616074] 41820048 e93d0008 e9290000 e9890068 2c2c0000 41820010
> > > 7d8903a6 4e800421
> > > [    8.616136] e8410018 e93f00d8 2c290000 41820140 <e8690008> 4bff6b9=
1
> > > 60000000 39400000
> > > [    8.616184] ---[ end trace cc3215be892e1be7 ]---
> > > [    8.644628] systemd-journald[1408]: Received client request to
> > > flush runtime journal.
> > > [  OK  ] Finished Create Static Device Nodes in /dev.
> > >          Starting Rule-based Manage=E2=80=A6for Device Events and Fil=
es...
> > > [  OK  ] Finished Coldplug All udev Devices.
> > >          Starting Wait for udev To =E2=80=A6plete Device Initializati=
on...
> > > [    8.690954] fuse: init (API version 7.34)
> > > [  OK  ] Finished Load Kernel Module fuse.
> > > [    8.694411]
> > >          Mounting FUSE Control File System...
> > > [  OK  ] Mounted FUSE Control File System.
> > > [  OK  ] Started Rule-based Manager for Device Events and Files.
> > >          Starting Load Kernel Module configfs...
> > > [  OK  ] Finished Load Kernel Module configfs.
> > > [    8.950307] IPMI message handler: version 39.2
> > > [  OK  ] Found device /dev/zram0.
> > >          Starting Create swap on /dev/zram0...
> > > [    9.008355] zram0: detected capacity change from 0 to 16777216
> > > [    9.694430] Kernel panic - not syncing: Aiee, killing interrupt ha=
ndler!
> > > [   11.080031] ---[ end Kernel panic - not syncing: Aiee, killing
> > > interrupt handler! ]---
> >
> > Can you try this?
> >
>
> Yeah, the boot panic issue was fixed on ppc64le from my testing, how
> about wait CKI re-test it on other arches?

Thanks, CKI is running for
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3D3da791d43d00f7f8c824ac7b619c9f73e44fea13,
the boot issue is fixed.

Bruno

>
> >
> > diff --git a/block/blk-flush.c b/block/blk-flush.c
> > index 4201728bf3a5..e9c0b300a177 100644
> > --- a/block/blk-flush.c
> > +++ b/block/blk-flush.c
> > @@ -129,6 +129,9 @@ static void blk_flush_restore_request(struct reques=
t *rq)
> >         /* make @rq a normal request */
> >         rq->rq_flags &=3D ~RQF_FLUSH_SEQ;
> >         rq->end_io =3D rq->flush.saved_end_io;
> > +       /* clear pointers overlapping with flush data */
> > +       rq->elv.icq =3D NULL;
> > +       rq->elv.priv[0] =3D rq->elv.priv[1] =3D NULL;
> >  }
> >
> >  static void blk_flush_queue_rq(struct request *rq, bool add_front)
> >
> > --
> > Jens Axboe
> >
>
>
> --
> Best Regards,
>   Yi Zhang
>


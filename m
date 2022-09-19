Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7AECAAD3
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 16:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiISQ0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiISQ0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 12:26:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08B3C170
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 09:26:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s18so17979654qtx.6
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=X1OyhjBs/SxF57/DaWVIdEn3t2yZdbQjIBGRUhoOoCs=;
        b=JMZohlnN8EsrHpvxadXbFV2LUHKnwQ5PWSjElHS3J4zsPtP0HD2zbEaKwE42cNzwM6
         UNUCC+ksd3cqtJgTmCzWjnf92WGeUerT3sHQUYws8iQerldhLGIm5GovWRmpUw1NYweP
         h6yxpqKIrjxysPtsGo10E1MPIpVfxxEl1d3Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X1OyhjBs/SxF57/DaWVIdEn3t2yZdbQjIBGRUhoOoCs=;
        b=rwi2RkAfx42YPqzPXfdYN6U3UWjHgGf9UXzuYc1qVSTtjLGlXA1F/XpENXfAkNoE1T
         pAmc+2baCqXR9pQOSuzUTtTxK80Z1A4EJsrKPnK4ODpAcLg6Nwi1boxuEpoZ1/Zspo4O
         rKHRf+0tCtoZ57Kh1j/I8deaY1CrpugoE3gUEHw0SnOoX3ayMoEhDOmBLDoAda00NFFl
         ShU5GbCZZZzqt/J2uylkKeopZCAXsz80TsIZn95S3KElD7OLxVfYRmt6uRSucvWIli5a
         /Zc65iVxotmHG3IHVeEw6uV+mKF3TCrnA8gIL7lOtvaA8fh3eIzWxwh7z3appjzLZ1uP
         HjTA==
X-Gm-Message-State: ACrzQf1FzvNXBfNSyBr2J+/RbvVGK3o3rWuuDtGhnAASJO9QOWBoIC8n
        oJrG0atXmOAnCEsuoTdWprXDjuMxshiTmXH66OD+ag==
X-Google-Smtp-Source: AMsMyM5Zisso7jkTcUKx+deJTX8yyu2sUQdPBhEp35s2Roe43uH1BnHIfvl0+8pvqKVl1DwsGqzREL3mFbVx1s9A/S4=
X-Received: by 2002:ac8:5d8c:0:b0:35c:ce79:29c1 with SMTP id
 d12-20020ac85d8c000000b0035cce7929c1mr13928364qtx.118.1663604789785; Mon, 19
 Sep 2022 09:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8fFZ49A8O1h3cZm8niZuiY11SdZWcMcGXwL4mLPn-i3eApXg@mail.gmail.com>
 <CAFNWusYoJRqh3s+HqRycGuzR1hXmb80O=1pC72tc_r+mS+jowg@mail.gmail.com>
In-Reply-To: <CAFNWusYoJRqh3s+HqRycGuzR1hXmb80O=1pC72tc_r+mS+jowg@mail.gmail.com>
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Mon, 19 Sep 2022 18:26:04 +0200
Message-ID: <CAK8fFZ4PbKy+AQBkvB50H96gGZ2V3sp832zVir8iuOKbZJbUbQ@mail.gmail.com>
Subject: Re: RIP: 0010:blk_mq_start_request when [none] elevator is used with
 kernel 5.19.y
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

I tested the "[v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()"
patch and it fixed the issue so it looks to be the same problem.

Best,
Jaroslav Pulchart


po 19. 9. 2022 v 15:40 odes=C3=ADlatel Suwan Kim <suwan.kim027@gmail.com> n=
apsal:
>
> Hi Jaroslav,
>
> On Mon, Sep 19, 2022 at 4:27 PM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
> >
> > Hello
> >
> > I'm observing an issue in blk when [none] elevator is used with kernel
> > 5.19.y, the issue is not observed in 5.18.y kernel line.
> >
> > The issue is reproducible: 100% time with [none] io scheduler (no
> > issue with mq--deadline)
> >
> > The command in dmesg trace depends about time when [none] io scheduler
> > was chosen by:
> >    echo "none" > /sys/block/vda/queue/scheduler
> > it can be mkfs, systemd-logind, flush, ... the first command which was
> > executed and doing some IO after the io scheduler change to [none],
> >
> > PS: the system is still working after the issue report.
> >
> > Example of issue report from booting firecracker micro vm:
> >
> > [  671.000798] ------------[ cut here ]------------
> > [  671.002062] WARNING: CPU: 3 PID: 1926 at block/blk-mq.c:1143
> > blk_mq_start_request+0x127/0x130
> > [  671.004722] Modules linked in: intel_rapl_msr(E)
> > intel_rapl_common(E) libnvdimm(E) kvm_intel(E) kvm(E) irqbypass(E)
> > rapl(E) virtio_balloon(E) ext4(E) mbcache(E) jbd2(E)
> > crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) virtio_net(E)
> > net_failover(E) failover(E) virtio_blk(E) ghash_clmulni_intel(E)
> > serio_raw(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> > [  671.004746] Unloaded tainted modules: nfit(E):4 intel_cstate(E):4
> > intel_uncore(E):4
> > [  671.016268] CPU: 3 PID: 1926 Comm: kworker/u8:1 Tainted: G
> >   E     5.19.6-2.gdc.el8.x86_64 #1
> > [  671.019020] Workqueue: writeback wb_workfn (flush-252:0)
> > [  671.020642] RIP: 0010:blk_mq_start_request+0x127/0x130
> > [  671.022228] Code: c1 e8 09 66 89 43 7a 48 8b 7d 28 48 85 ff 0f 84
> > 10 ff ff ff 48 89 de e8 f7 40 01 00 8b 83 94 00 00 00 85 c0 0f 84 08
> > ff ff ff <0f> 0b e9 01 ff ff ff 66 90 0f 1f 44 00 00 48 8b bf 18 01 00
> > 00 40
> > [  671.027634] RSP: 0018:ffffc90000f1b6f8 EFLAGS: 00010202
> > [  671.029263] RAX: 0000000000000001 RBX: ffff88817d6a1a40 RCX: 0000000=
000000017
> > [  671.031385] RDX: 000000000080002a RSI: ffff88817d6a1a40 RDI: ffff888=
17e9c1058
> > [  671.033479] RBP: ffff88817d6b2a00 R08: 00000000047eb630 R09: ffff888=
17d6a1b60
> > [  671.035631] R10: 000000017d6a2000 R11: 0000000000000002 R12: ffff888=
17d6a1b60
> > [  671.037749] R13: ffff88817d6a1b60 R14: ffff88817fb08e00 R15: ffff888=
17fb08200
> > [  671.039881] FS:  0000000000000000(0000) GS:ffff888259780000(0000)
> > knlGS:0000000000000000
> > [  671.042304] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  671.044126] CR2: 00007f38b4001d88 CR3: 000000017fa1e003 CR4: 0000000=
000770ee0
> > [  671.046267] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  671.048432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  671.050533] PKRU: 55555554
> > [  671.051388] Call Trace:
> > [  671.052137]  <TASK>
> > [  671.052821]  virtblk_prep_rq.isra.19+0xb4/0x290 [virtio_blk]
> > [  671.054626]  virtio_queue_rq+0x47/0x194 [virtio_blk]
> > [  671.056121]  __blk_mq_try_issue_directly+0x153/0x1c0
> > [  671.057587]  blk_mq_plug_issue_direct.constprop.75+0x85/0x120
> > [  671.059385]  blk_mq_flush_plug_list+0x287/0x2f0
> > [  671.060842]  ? blk_mq_rq_ctx_init.isra.47+0x177/0x190
> > [  671.062517]  blk_add_rq_to_plug+0x62/0x110
> > [  671.063754]  blk_mq_submit_bio+0x20e/0x540
> > [  671.065043]  __submit_bio+0xf5/0x180
> > [  671.066244]  submit_bio_noacct_nocheck+0x25a/0x2b0
> > [  671.067737]  submit_bio+0x3e/0xd0
> > [  671.068805]  submit_bh_wbc+0x117/0x140
> > [  671.070050]  __block_write_full_page+0x231/0x550
> > [  671.071519]  ? create_page_buffers+0x90/0x90
> > [  671.072807]  ? blkdev_bio_end_io_async+0x80/0x80
> > [  671.074161]  __writepage+0x16/0x70
> > [  671.075209]  write_cache_pages+0x187/0x4d0
> > [  671.076518]  ? dirty_background_bytes_handler+0x30/0x30
> > [  671.078171]  generic_writepages+0x4f/0x80
> > [  671.079355]  do_writepages+0xd2/0x1b0
> > [  671.080452]  __writeback_single_inode+0x41/0x360
> > [  671.081871]  writeback_sb_inodes+0x1f0/0x460
> > [  671.083192]  __writeback_inodes_wb+0x5f/0xd0
> > [  671.084407]  wb_writeback+0x235/0x2d0
> > [  671.085387]  wb_workfn+0x348/0x4a0
> > [  671.086392]  ? put_prev_task_fair+0x1b/0x40
> > [  671.087670]  ? __update_idle_core+0x1b/0xb0
> > [  671.088862]  process_one_work+0x1c5/0x390
> > [  671.090041]  ? process_one_work+0x390/0x390
> > [  671.091326]  worker_thread+0x30/0x360
> > [  671.092401]  ? process_one_work+0x390/0x390
> > [  671.093639]  kthread+0xd7/0x100
> > [  671.094578]  ? kthread_complete_and_exit+0x20/0x20
> > [  671.095996]  ret_from_fork+0x1f/0x30
> > [  671.097128]  </TASK>
> > [  671.097768] ---[ end trace 0000000000000000 ]---
> >
> > Does somebody have any suggestions on what is wrong and how to fix it?
> >
> > Best regards,
> > Jaroslav Pulchart
>
> This issue looks similar to the link below.
>
> https://lore.kernel.org/all/CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=3DB=
2oFECF3w@mail.gmail.com/t/
>
> We have fix for this issue. Could you test the below patch?
>
> https://patchwork.kernel.org/project/linux-block/patch/20220830150153.126=
27-1-suwan.kim027@gmail.com/
>
> Regards,
> Suwan Kim

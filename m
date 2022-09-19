Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB6C54EE9
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 13:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiISNlA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiISNk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 09:40:59 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1915FF4
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 06:40:54 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id w39-20020a4a97aa000000b0044dfa1ddc67so4656923ooi.6
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7fb500EP/IbAEc7ZktV3431PF6kJ04Pw8cA9a2rZZT4=;
        b=byPiO3q+CwqRJdzlA4H4YGbh2SnCkgSn8B2tpvm8hkDOQBH8GXasdIs65VtqLlKPmj
         y4b49poHDUAFs62AEFkZSFUecjMTNRoN+OmT2awmH1TCE8tD6mjCJHtAw3kISCNbTUrt
         K3o3Cv6uZFn02IYe2m42bRvn10Ipmm9wEv5RGPPFqo52ZmzLz7zq6OimbtG8Tm6EDNOV
         b3HDG8AUlJZ+hdypnRz+yRMaYMQo+ARrfgzB/RIA0I30u1QnFnLVaISxQ/LPv69yhc8z
         3jhGnRYOBdiDcixcySmKDKu0ADISd1vIqPOWY3KDQv0A153QMlg0mYPYYl+lIPmGRIcf
         3YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7fb500EP/IbAEc7ZktV3431PF6kJ04Pw8cA9a2rZZT4=;
        b=A9gu6WVXELeBQgcWqrf962/f8F7UdiKu156rpWHTVw2iiwTyspqe3e6rvONxP2GTbk
         pzHHFFH1RzQ9/MvblJj9n1fuAGZqxZ7/tljtv+jj6IR38wnbFlmHN4Ycnp4AzmPMe1qN
         cUiV2ORWjHB6di2vs81ni9Q8xaIxOXmybeVqlKrhec60jqoTe+sy61BmRz4FtKdMA6Os
         jPPY6+4XxVpQtBVvKSmyKI45VoQCrQZYT3hUwYu/OGBO/qgRQCFXsoGpYInfwZmkh3Rn
         8Ev0tQCqffypj3F9Be1/tFWKomUoXrrnrH19rrA/SgHDy0vXrEp7/jy+UoKxRLyK+mfb
         T9Kw==
X-Gm-Message-State: ACrzQf0Ji/AUyY8xBgtr22OWYQ1TK6gXzS5dtIjH/CzJtJtx+aoTrXYL
        IQQKDpOcfFG9UMlNJdwXevw2FF9cDs+MBmayJOI=
X-Google-Smtp-Source: AMsMyM66htPksmvd4jgpsTX5crFI01QHjRcUBUWVMzuUyRYv4SZCmh5tUgC8Je260BBvDE39ojs71uOX6JuW6d+iOcw=
X-Received: by 2002:a4a:8c12:0:b0:435:9dbd:6c46 with SMTP id
 u18-20020a4a8c12000000b004359dbd6c46mr6757234ooj.10.1663594853278; Mon, 19
 Sep 2022 06:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8fFZ49A8O1h3cZm8niZuiY11SdZWcMcGXwL4mLPn-i3eApXg@mail.gmail.com>
In-Reply-To: <CAK8fFZ49A8O1h3cZm8niZuiY11SdZWcMcGXwL4mLPn-i3eApXg@mail.gmail.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Mon, 19 Sep 2022 22:40:42 +0900
Message-ID: <CAFNWusYoJRqh3s+HqRycGuzR1hXmb80O=1pC72tc_r+mS+jowg@mail.gmail.com>
Subject: Re: RIP: 0010:blk_mq_start_request when [none] elevator is used with
 kernel 5.19.y
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jaroslav,

On Mon, Sep 19, 2022 at 4:27 PM Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> wrote:
>
> Hello
>
> I'm observing an issue in blk when [none] elevator is used with kernel
> 5.19.y, the issue is not observed in 5.18.y kernel line.
>
> The issue is reproducible: 100% time with [none] io scheduler (no
> issue with mq--deadline)
>
> The command in dmesg trace depends about time when [none] io scheduler
> was chosen by:
>    echo "none" > /sys/block/vda/queue/scheduler
> it can be mkfs, systemd-logind, flush, ... the first command which was
> executed and doing some IO after the io scheduler change to [none],
>
> PS: the system is still working after the issue report.
>
> Example of issue report from booting firecracker micro vm:
>
> [  671.000798] ------------[ cut here ]------------
> [  671.002062] WARNING: CPU: 3 PID: 1926 at block/blk-mq.c:1143
> blk_mq_start_request+0x127/0x130
> [  671.004722] Modules linked in: intel_rapl_msr(E)
> intel_rapl_common(E) libnvdimm(E) kvm_intel(E) kvm(E) irqbypass(E)
> rapl(E) virtio_balloon(E) ext4(E) mbcache(E) jbd2(E)
> crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) virtio_net(E)
> net_failover(E) failover(E) virtio_blk(E) ghash_clmulni_intel(E)
> serio_raw(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [  671.004746] Unloaded tainted modules: nfit(E):4 intel_cstate(E):4
> intel_uncore(E):4
> [  671.016268] CPU: 3 PID: 1926 Comm: kworker/u8:1 Tainted: G
>   E     5.19.6-2.gdc.el8.x86_64 #1
> [  671.019020] Workqueue: writeback wb_workfn (flush-252:0)
> [  671.020642] RIP: 0010:blk_mq_start_request+0x127/0x130
> [  671.022228] Code: c1 e8 09 66 89 43 7a 48 8b 7d 28 48 85 ff 0f 84
> 10 ff ff ff 48 89 de e8 f7 40 01 00 8b 83 94 00 00 00 85 c0 0f 84 08
> ff ff ff <0f> 0b e9 01 ff ff ff 66 90 0f 1f 44 00 00 48 8b bf 18 01 00
> 00 40
> [  671.027634] RSP: 0018:ffffc90000f1b6f8 EFLAGS: 00010202
> [  671.029263] RAX: 0000000000000001 RBX: ffff88817d6a1a40 RCX: 0000000000000017
> [  671.031385] RDX: 000000000080002a RSI: ffff88817d6a1a40 RDI: ffff88817e9c1058
> [  671.033479] RBP: ffff88817d6b2a00 R08: 00000000047eb630 R09: ffff88817d6a1b60
> [  671.035631] R10: 000000017d6a2000 R11: 0000000000000002 R12: ffff88817d6a1b60
> [  671.037749] R13: ffff88817d6a1b60 R14: ffff88817fb08e00 R15: ffff88817fb08200
> [  671.039881] FS:  0000000000000000(0000) GS:ffff888259780000(0000)
> knlGS:0000000000000000
> [  671.042304] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  671.044126] CR2: 00007f38b4001d88 CR3: 000000017fa1e003 CR4: 0000000000770ee0
> [  671.046267] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  671.048432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  671.050533] PKRU: 55555554
> [  671.051388] Call Trace:
> [  671.052137]  <TASK>
> [  671.052821]  virtblk_prep_rq.isra.19+0xb4/0x290 [virtio_blk]
> [  671.054626]  virtio_queue_rq+0x47/0x194 [virtio_blk]
> [  671.056121]  __blk_mq_try_issue_directly+0x153/0x1c0
> [  671.057587]  blk_mq_plug_issue_direct.constprop.75+0x85/0x120
> [  671.059385]  blk_mq_flush_plug_list+0x287/0x2f0
> [  671.060842]  ? blk_mq_rq_ctx_init.isra.47+0x177/0x190
> [  671.062517]  blk_add_rq_to_plug+0x62/0x110
> [  671.063754]  blk_mq_submit_bio+0x20e/0x540
> [  671.065043]  __submit_bio+0xf5/0x180
> [  671.066244]  submit_bio_noacct_nocheck+0x25a/0x2b0
> [  671.067737]  submit_bio+0x3e/0xd0
> [  671.068805]  submit_bh_wbc+0x117/0x140
> [  671.070050]  __block_write_full_page+0x231/0x550
> [  671.071519]  ? create_page_buffers+0x90/0x90
> [  671.072807]  ? blkdev_bio_end_io_async+0x80/0x80
> [  671.074161]  __writepage+0x16/0x70
> [  671.075209]  write_cache_pages+0x187/0x4d0
> [  671.076518]  ? dirty_background_bytes_handler+0x30/0x30
> [  671.078171]  generic_writepages+0x4f/0x80
> [  671.079355]  do_writepages+0xd2/0x1b0
> [  671.080452]  __writeback_single_inode+0x41/0x360
> [  671.081871]  writeback_sb_inodes+0x1f0/0x460
> [  671.083192]  __writeback_inodes_wb+0x5f/0xd0
> [  671.084407]  wb_writeback+0x235/0x2d0
> [  671.085387]  wb_workfn+0x348/0x4a0
> [  671.086392]  ? put_prev_task_fair+0x1b/0x40
> [  671.087670]  ? __update_idle_core+0x1b/0xb0
> [  671.088862]  process_one_work+0x1c5/0x390
> [  671.090041]  ? process_one_work+0x390/0x390
> [  671.091326]  worker_thread+0x30/0x360
> [  671.092401]  ? process_one_work+0x390/0x390
> [  671.093639]  kthread+0xd7/0x100
> [  671.094578]  ? kthread_complete_and_exit+0x20/0x20
> [  671.095996]  ret_from_fork+0x1f/0x30
> [  671.097128]  </TASK>
> [  671.097768] ---[ end trace 0000000000000000 ]---
>
> Does somebody have any suggestions on what is wrong and how to fix it?
>
> Best regards,
> Jaroslav Pulchart

This issue looks similar to the link below.

https://lore.kernel.org/all/CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com/t/

We have fix for this issue. Could you test the below patch?

https://patchwork.kernel.org/project/linux-block/patch/20220830150153.12627-1-suwan.kim027@gmail.com/

Regards,
Suwan Kim

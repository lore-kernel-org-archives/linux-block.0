Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE54C433E6
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 09:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E730165004
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEJ1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhCEJ1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 04:27:13 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE94C061574;
        Fri,  5 Mar 2021 01:27:12 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c131so1230138ybf.7;
        Fri, 05 Mar 2021 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goE6F5kYY+C+1TCfVwltExRcHw+wq2XvTofLIyekX4o=;
        b=AVRB+Fh6+e3Xyf/Pqs1yQup+3Ms9s/GvOw4xcw4Ph65UZZCpS/IfukLtxTl1hyNKhU
         T+h8OxVw/kxE37yYH8RtE8nJsTu6kX8Csxo9kbyGkwVS4Nsobi2uiW14wxMUsPNhvecR
         y4714hwlgBy/EwTc8HthdH2pBiRaD9hl4ycovim8jfY5tXq8s3rwDnOceuU7Rp+FHxrm
         j/p3aUeKvyF223k14fDRsPJHqK2iSb38+9q6yUo/joMfpRDjJoHU4G1mHFdMs2GX9XIj
         6ZIwDLbvbiXqIyNLQLKIfkWwLTQl84h3UeWdhIAyNU76nlMvx+A3pXOmU8SXbpt9HRtQ
         TCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goE6F5kYY+C+1TCfVwltExRcHw+wq2XvTofLIyekX4o=;
        b=ikjM5p4uP5JVe+6RLX7KaeNtPCA2LezO0YdG+mevGZB/7Jc71GVEFAvgYbhMGJeVMh
         lJ3WVVVw6ItSO1p3e3Z0i7NhgihasKsZDZVMCdnfCau2EuSIm/QF1RWLYgHyrJQBcViR
         oHaVitnO5zBKXcca7F2jpkKtAX/lZyu4DP9NnhqMze7wDfZtMbkHWGShlPyc9d8JmTRh
         XuGmOpXWfsyHTSjNiVJrT13dRhiVFghtv28JcpZz96ry6pOqcbXD1DIut9dDIJ+nqNTd
         JZQsYnW1pyekBrrGMbu4FLWKvOl+PO7gQP7jAv5GDr4jVbEfv4B2ePvOIxsZV2Fqnvnh
         rttg==
X-Gm-Message-State: AOAM5324pglScUBVQX9y0oL26xnAbn1CBYI9MPVF0EvhkiPLZ3q/p6pP
        jaLEV2ZeXjDxhHh60xdziVZcau1ACPmQMzBDJ/c=
X-Google-Smtp-Source: ABdhPJxDIdfnW5QXirVgwOFFoSd44Eq2D9DV2Pn4CtfbYOu88hLKM6NSq5DtKKBolOQaon4Zph4qXTys8kJtE5vKKK8=
X-Received: by 2002:a25:b881:: with SMTP id w1mr13415994ybj.498.1614936431877;
 Fri, 05 Mar 2021 01:27:11 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
 <CACVXFVOy8928GNowCQRGQKQxuLtHn0V+pYk1kzeOyc0pyDvkjQ@mail.gmail.com> <20210305090022.1863-1-hdanton@sina.com>
In-Reply-To: <20210305090022.1863-1-hdanton@sina.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 5 Mar 2021 17:27:00 +0800
Message-ID: <CACVXFVPp_byzrYVwyo05u0v3zoPP42FKZhfWMb6GMBno1rCZRw@mail.gmail.com>
Subject: Re: [bugreport 5.9-rc8] general protection fault, probably for
 non-canonical address 0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Hillf,

Thanks for the debug patch.

On Fri, Mar 5, 2021 at 5:00 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 4 Mar 2021 16:42:30 +0800  Ming Lei wrote:
> > On Sat, Oct 10, 2020 at 1:40 PM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > Paolo, Jens I am sorry for the noise.
> > > But today I hit the kernel panic and git blame said that you have
> > > created the file in which happened panic (this I saw from trace)
> > >
> > > $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> > > /lib/debug/lib/modules/`uname -r`/vmlinux
> > > __bfq_deactivate_entity+0x15a
> > > __bfq_deactivate_entity+0x15a/0x240:
> > > bfq_gt at block/bfq-wf2q.c:20
> > > (inlined by) bfq_insert at block/bfq-wf2q.c:381
> > > (inlined by) bfq_idle_insert at block/bfq-wf2q.c:621
> > > (inlined by) __bfq_deactivate_entity at block/bfq-wf2q.c:1203
> > >
> > > https://github.com/torvalds/linux/blame/master/block/bfq-wf2q.c#L1203
> > >
> > > $ head /sys/block/*/queue/scheduler
> > > ==> /sys/block/nvme0n1/queue/scheduler <==
> > > [none] mq-deadline kyber bfq
> > >
> > > ==> /sys/block/sda/queue/scheduler <==
> > > mq-deadline kyber [bfq] none
> > >
> > > ==> /sys/block/zram0/queue/scheduler <==
> > > none
> > >
> > > Trace:
> > > general protection fault, probably for non-canonical address
> > > 0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
> > > CPU: 27 PID: 1018 Comm: kworker/27:1H Tainted: G        W
> > > --------- ---  5.9.0-0.rc8.28.fc34.x86_64 #1
> > > Hardware name: System manufacturer System Product Name/ROG STRIX
> > > X570-I GAMING, BIOS 2606 08/13/2020
> > > Workqueue: kblockd blk_mq_run_work_fn
> > > RIP: 0010:__bfq_deactivate_entity+0x15a/0x240
> > > Code: 48 2b 41 28 48 85 c0 7e 05 49 89 5c 24 18 49 8b 44 24 08 4d 8d
> > > 74 24 08 48 85 c0 0f 84 d6 00 00 00 48 8b 7b 28 eb 03 48 89 c8 <48> 8b
> > > 48 28 48 8d 70 10 48 8d 50 08 48 29 f9 48 85 c9 48 0f 4f d6
> > > RSP: 0018:ffffadf6c0c6fc00 EFLAGS: 00010002
> > > RAX: 46b1b0f0d8856e4a RBX: ffff8dc2773b5c88 RCX: 46b1b0f0d8856e4a
> > > RDX: ffff8dc7d02ed0a0 RSI: ffff8dc7d02ed0a8 RDI: 0000584e64e96beb
> > > RBP: ffff8dc2773b5c00 R08: ffff8dc9054cb938 R09: 0000000000000000
> > > R10: 0000000000000018 R11: 0000000000000018 R12: ffff8dc904927150
> > > R13: 0000000000000001 R14: ffff8dc904927158 R15: ffff8dc2773b5c88
> > > FS:  0000000000000000(0000) GS:ffff8dc90e0c0000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000003e8ebe4000 CR3: 00000007c2546000 CR4: 0000000000350ee0
> > > Call Trace:
> > >  bfq_deactivate_entity+0x4f/0xc0
> >
> > Hello,
> >
> > The same stack trace was observed in RH internal test too, and kernel
> > is 5.11.0-0.rc6,
> > but there isn't reproducer yet.
> >
> >
> > --
> > Ming Lei
>
> Add some debug info.
>
> --- x/block/bfq-wf2q.c
> +++ y/block/bfq-wf2q.c
> @@ -647,8 +647,10 @@ static void bfq_forget_entity(struct bfq
>
>         entity->on_st_or_in_serv = false;
>         st->wsum -= entity->weight;
> -       if (bfqq && !is_in_service)
> +       if (bfqq && !is_in_service) {
> +               WARN_ON(entity->tree != NULL);
>                 bfq_put_queue(bfqq);
> +       }
>  }
>
>  /**
> @@ -1631,6 +1633,7 @@ bool __bfq_bfqd_reset_in_service(struct
>                  * bfqq gets freed here.
>                  */
>                 int ref = in_serv_bfqq->ref;
> +               WARN_ON(in_serv_entity->tree != NULL);
>                 bfq_put_queue(in_serv_bfqq);
>                 if (ref == 1)
>                         return true;

This kernel oops isn't easy to be reproduced, and  we have got another crash
report[1] too, still on __bfq_deactivate_entity(), and not easy to
trigger.  Can your
debug patch cover the report[1]? If not, feel free to add more debug messages,
then I will try to reproduce the two.

[1] another kernel oops log on __bfq_deactivate_entity

[  899.790606] systemd-sysv-generator[25205]: SysV service
'/etc/rc.d/init.d/anamon' lacks a native systemd unit file.
Automatically generating a unit file for compatibility. Please update
package to include a native systemd unit file, in order to make it
more safe and robust.
[  901.937047] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  901.944005] #PF: supervisor read access in kernel mode
[  901.949143] #PF: error_code(0x0000) - not-present page
[  901.954285] PGD 0 P4D 0
[  901.956824] Oops: 0000 [#1] SMP NOPTI
[  901.960490] CPU: 13 PID: 22966 Comm: kworker/13:0 Tainted: G
  I    X --------- ---  5.11.0-1.el9.x86_64 #1
[  901.970829] Hardware name: Dell Inc. PowerEdge R740xd/0WXD1Y, BIOS
2.5.4 01/13/2020
[  901.978480] Workqueue: cgwb_release cgwb_release_workfn
[  901.983705] RIP: 0010:__bfq_deactivate_entity+0x5b/0x240
[  901.989016] Code: b8 30 00 00 00 75 18 48 81 ff 88 00 00 00 74 0f
0f b7 47 8a 83 e8 01 48 8d 04 40 48 c1 e0 04 4c 8b 73 68 48 63 73 40
48 89 df <4d> 8b 3e 4d 8d 64 06 10 e8 48 f0 ff ff 49 39 df 0f 84 87 01
00 00
[  902.007763] RSP: 0018:ffffb77107f0bd98 EFLAGS: 00010002
[  902.012986] RAX: 0000002fffffffd0 RBX: ffff9853ca9c6098 RCX: 0000000000000046
[  902.020119] RDX: 0000000000000001 RSI: 00000000474b1168 RDI: ffff9853ca9c6098
[  902.027253] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff985470c2fed0
[  902.034383] R10: 0000000000000001 R11: ffff9853c9287d98 R12: ffff9853ca8b8000
[  902.041515] R13: 00000000000000ff R14: 0000000000000000 R15: ffff985b44308098
[  902.048647] FS:  0000000000000000(0000) GS:ffff98631f980000(0000)
knlGS:0000000000000000
[  902.056732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  902.062479] CR2: 0000000000000000 CR3: 00000001c0ac2002 CR4: 00000000007706e0
[  902.069611] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  902.076744] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  902.083876] PKRU: 55555554
[  902.086589] Call Trace:
[  902.089042]  bfq_pd_offline+0x89/0xd0
[  902.092708]  blkg_destroy+0x52/0xf0
[  902.096200]  blkcg_destroy_blkgs+0x46/0xc0
[  902.100300]  cgwb_release_workfn+0xbe/0x150
[  902.104485]  process_one_work+0x1e6/0x380
[  902.108497]  worker_thread+0x53/0x3d0
[  902.112161]  ? process_one_work+0x380/0x380
[  902.116346]  kthread+0x11b/0x140
[  902.119581]  ? kthread_associate_blkcg+0xa0/0xa0
[  902.124199]  ret_from_fork+0x1f/0x30
[  902.127780] Modules linked in: sunrpc scsi_debug iscsi_tcp
libiscsi_tcp libiscsi scsi_transport_iscsi nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
rfkill intel_rapl_msr intel_rapl_common isst_if_common skx_edac nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
ipmi_ssif irqbypass mgag200 rapl i2c_algo_bit iTCO_wdt drm_kms_helper
intel_cstate iTCO_vendor_support syscopyarea sysfillrect sysimgblt
acpi_ipmi mei_me fb_sys_fops intel_uncore pcspkr dell_smbios dcdbas
dell_wmi_descriptor wmi_bmof mei cec i2c_i801 ipmi_si acpi_power_meter
lpc_ich i2c_smbus ipmi_devintf ipmi_msghandler drm fuse xfs libcrc32c
sd_mod t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel ahci libahci
megaraid_sas tg3 ghash_clmulni_intel libata wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: ip_tables]
[  902.208546] CR2: 0000000000000000
[  902.211881] ---[ end trace 827b8521dc634ca4 ]---


-- 
Ming Lei

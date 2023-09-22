Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6284ACD4F2B
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjIVHve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVHvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 03:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722B199
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695369041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YgTZKRN/M+sNZqaeBiece5PYy1E05VXC2/QsqB2itAM=;
        b=EloguhjUgyTQbtuRjfqvBRyGBRPCvzbSgzfa1VUsbvEQ2YENVxCeX4EntI/Wdp5X7ThCi7
        Tn1BtXAhfwALXGmOOP7lGEjxclizmS2TGt+TdiCMrDElQD6EpwQqK03hY4FhXCDnggaoWI
        3FfBgW2ineuqzYBH8DxqfSe63eLbxPw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-k2SN6XZKMJ-94ZTKSzUU3w-1; Fri, 22 Sep 2023 03:50:39 -0400
X-MC-Unique: k2SN6XZKMJ-94ZTKSzUU3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54A213C108E6;
        Fri, 22 Sep 2023 07:50:39 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF24E140E953;
        Fri, 22 Sep 2023 07:50:35 +0000 (UTC)
Date:   Fri, 22 Sep 2023 15:50:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [bug report] RIP: 0010:throtl_trim_slice+0xc6/0x320 caused
 kernel panic
Message-ID: <ZQ1HRZJ8b/EPOo8E@fedora>
References: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 22, 2023 at 10:10:45AM +0800, Changhui Zhong wrote:
> Hello,
> 
> triggered below issue with branch 'for-next',please help check,

The recent throttle change is form Yu Kuai, so Cc him.

> 
> INFO: HEAD of cloned kernel:
> commit d975b468819a142a49c8e7db83feb07c3018c550
> Merge: 58fac6aac7a2 df137dff93fc
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Sep 13 13:16:19 2023 -0600
> 
>     Merge branch 'io_uring-futex' into for-next
> 
>     * io_uring-futex:
>       io_uring: add support for vectored futex waits
>       futex: make the vectored futex operations available
>       futex: make futex_parse_waitv() available as a helper
>       futex: add wake_data to struct futex_q
>       io_uring: add support for futex wake and wait
>       futex: abstract out a __futex_wake_mark() helper
>       futex: factor out the futex wake handling
>       futex: move FUTEX2_VALID_MASK to futex.h
>       futex: Validate futex value against futex size
>       futex: Flag conversion
>       futex: Extend the FUTEX2 flags
>       futex: Clarify FUTEX2 flags
> 
> 
> reproduce steps:
> echo "+cpuset +cpu +io" > /sys/fs/cgroup/cgroup.subtree_control
> mkdir /sys/fs/cgroup/test
> MAJ=$(ls -l /dev/"$disk" | awk -F ',' '{print $1}' | awk -F ' ' '{print $NF}')
> MIN=$(ls -l /dev/"$disk" | awk -F ',' '{print $2}' | awk -F ' ' '{print $1}')
> echo "$MAJ:$MIN wbps=1024" > /sys/fs/cgroup/test/io.max
> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> dd if=/dev/zero of=/dev/$disk bs=10k count=1 oflag=direct &
> dd if=/dev/zero of=/dev/$disk bs=10k count=1 oflag=direct &
> wait
> 
> console log:
> [ 1979.303330] divide error: 0000 [#1] PREEMPT SMP NOPTI
> [ 1979.308393] CPU: 28 PID: 0 Comm: swapper/28 Not tainted 6.6.0-rc1+ #1
> [ 1979.314837] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS
> 2.6.6 01/13/2022
> [ 1979.322402] RIP: 0010:throtl_trim_slice+0xc6/0x320
> [ 1979.327195] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> ff ff
> [ 1979.345942] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> [ 1979.351169] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 00000000000003e8
> [ 1979.358300] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5486a99800
> [ 1979.365435] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f565a67b818
> [ 1979.372565] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000000000001
> [ 1979.379698] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000000000021
> [ 1979.386833] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> knlGS:0000000000000000
> [ 1979.394916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1979.400663] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000000350ee0
> [ 1979.407797] Call Trace:
> [ 1979.410250]  <IRQ>
> [ 1979.412270]  ? die+0x33/0x90
> [ 1979.415157]  ? do_trap+0xe0/0x110
> [ 1979.418476]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.422662]  ? do_error_trap+0x65/0x80
> [ 1979.426412]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.430600]  ? exc_divide_error+0x36/0x50
> [ 1979.434612]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.438800]  ? asm_exc_divide_error+0x16/0x20
> [ 1979.443163]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.447347]  tg_dispatch_one_bio+0xf0/0x1e0
> [ 1979.451533]  throtl_pending_timer_fn+0x1e5/0x510
> [ 1979.456152]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> [ 1979.461287]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> [ 1979.466427]  call_timer_fn+0x27/0x130
> [ 1979.470096]  __run_timers.part.0+0x1ee/0x280
> [ 1979.474368]  ? srso_return_thunk+0x5/0x10
> [ 1979.478379]  ? __hrtimer_run_queues+0x121/0x2b0
> [ 1979.482914]  ? srso_return_thunk+0x5/0x10
> [ 1979.486925]  ? srso_return_thunk+0x5/0x10
> [ 1979.490939]  ? srso_return_thunk+0x5/0x10
> [ 1979.494953]  run_timer_softirq+0x26/0x50
> [ 1979.498878]  __do_softirq+0xcb/0x2ab
> [ 1979.502459]  __irq_exit_rcu+0xa1/0xc0
> [ 1979.506124]  sysvec_apic_timer_interrupt+0x72/0x90
> [ 1979.510917]  </IRQ>
> [ 1979.513021]  <TASK>
> [ 1979.515128]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 1979.520265] RIP: 0010:mwait_idle+0x4f/0x70
> [ 1979.524365] Code: 31 d2 48 89 d1 65 48 8b 04 25 80 18 03 00 0f 01
> c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 96 f3 36 00 31 c0 48 89 c1 fb
> 0f 01 c9 <fa> 65 48 8b 04 25 80 18 03 00 f0 80 60 02 df e9 6d 3f 01 00
> 0f ae
> [ 1979.543111] RSP: 0018:ffffadf9c04a7ed0 EFLAGS: 00000246
> [ 1979.548338] RAX: 0000000000000000 RBX: ffff8f548019cd40 RCX: 0000000000000000
> [ 1979.555471] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 000000000016e484
> [ 1979.562605] RBP: 0000000000000000 R08: ffff8f5677d22a80 R09: 0000000000000000
> [ 1979.569738] R10: 00000000000001dc R11: 0000000000000000 R12: 0000000000000000
> [ 1979.576868] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 1979.584009]  default_idle_call+0x28/0xd0
> [ 1979.587938]  cpuidle_idle_call+0x125/0x160
> [ 1979.592036]  ? sched_clock_cpu+0xb/0x190
> [ 1979.595963]  do_idle+0x7b/0xe0
> [ 1979.599022]  cpu_startup_entry+0x19/0x20
> [ 1979.602949]  start_secondary+0x115/0x140
> [ 1979.606875]  secondary_startup_64_no_verify+0x17d/0x18b
> [ 1979.612104]  </TASK>
> [ 1979.614293] Modules linked in: binfmt_misc dm_crypt raid10 raid1
> raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
> async_xor xor async_tx raid6_pq loop tls rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc
> dm_multipath ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac
> edac_mce_amd kvm_amd kvm mgag200 i2c_algo_bit dcdbas acpi_ipmi
> drm_shmem_helper irqbypass ipmi_si drm_kms_helper dell_smbios rapl
> wmi_bmof pcspkr dell_wmi_descriptor ipmi_devintf k10temp ptdma
> i2c_piix4 ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c
> sd_mod t10_pi sg ahci libahci crct10dif_pclmul crc32_pclmul
> crc32c_intel libata ghash_clmulni_intel tg3 ccp sp5100_tco wmi
> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> [ 1979.681931] ---[ end trace 0000000000000000 ]---
> [ 1979.706620] pstore: backend (erst) writing error (-22)
> [ 1979.711761] RIP: 0010:throtl_trim_slice+0xc6/0x320
> [ 1979.716555] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> ff ff
> [ 1979.735301] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> [ 1979.740527] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 00000000000003e8
> [ 1979.747659] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5486a99800
> [ 1979.754793] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f565a67b818
> [ 1979.761924] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000000000001
> [ 1979.769056] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000000000021
> [ 1979.776190] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> knlGS:0000000000000000
> [ 1979.784278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1979.790023] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000000350ee0
> [ 1979.797155] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1979.805797] Kernel Offset: 0x30600000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1979.835382] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> 
> Thanks,
> 

-- 
Ming


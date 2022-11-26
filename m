Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FAC4321E
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 14:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKZOaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZOaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Nov 2022 09:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A971B791
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669472961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XnleFzSdIRNj2A8FHG6F13Azx7vfF+hVRhqpDtNrK8g=;
        b=RxGx2lUCFdgYLvJvCcS6qq4JiDnYJVUvLBRqh1yzgOqAQFnLoJb18wB0JaxBb/nXXOdVwh
        3E61EjGC/zOHT/LGCwKgXDOrp8HgDPq7tTNyBfj1ycmJbR5pYt1KXbIYhGnzXoZQMHiK/Z
        ItLqzHxk5qFCZPw3NJAOnJL7dMPiOHI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-2rH0WKSINmGahFpFHXtjUw-1; Sat, 26 Nov 2022 09:29:19 -0500
X-MC-Unique: 2rH0WKSINmGahFpFHXtjUw-1
Received: by mail-pj1-f72.google.com with SMTP id 94-20020a17090a09e700b002191897f70aso1274886pjo.9
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 06:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnleFzSdIRNj2A8FHG6F13Azx7vfF+hVRhqpDtNrK8g=;
        b=c0q56LCJ8gfIR7dxcip3hqnPtnTi5PSqSphONJV5XZ+LmRSbq7kBzZYjdiGnETCq6T
         L9n3fAJjp/K19UUdbjLFBna+mNmBuUoe2vouFxm/nqhIYNKmd3croUSJCGlTOKWqbZ9H
         Hb6BPmg9+7TZj3fcVqZRTHcihLygZrRRG2o+6vsDhMVc+ONsOTXGYg4uERVbReGy4UMX
         m7D8ttaNq6bRltyU6tKg3JX8qEOOsZ+nH6iMW6kavXDOA9UmkDUIuyMtV1KsZXvrMGhi
         lGi1RFUEBLA++3CN0MsRnvt2S6jbF57RRbFo1LpFiJwAeX3wc33dT3ZjE1eDaFwShnmO
         +2jA==
X-Gm-Message-State: ANoB5pn85fkr/3UjdlSARboFEMAfLThm/ca0Xjp+tS26uOZbCTyln7Bk
        sADkGTy7B8qdZs3jQnqgUq06t2ze1ZohmC6jMoRIka3uezfuMlXjrS94y/QI25luuC0BxGiES+A
        /BhBA0UhJtNdmSQ8WoenrO2NUqyLIM9tBH6EYvpk=
X-Received: by 2002:a63:5421:0:b0:438:5cd8:9382 with SMTP id i33-20020a635421000000b004385cd89382mr19805502pgb.304.1669472958035;
        Sat, 26 Nov 2022 06:29:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6oMgKKNICMG94Q6N7h2rj+NJpM+OfoxnDvN7u6JfwcDKlVSiIZ2pxRbqUQHRk4c44BAQC74Z5ibGxqJVDIvPs=
X-Received: by 2002:a63:5421:0:b0:438:5cd8:9382 with SMTP id
 i33-20020a635421000000b004385cd89382mr19805462pgb.304.1669472957659; Sat, 26
 Nov 2022 06:29:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk> <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
 <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
In-Reply-To: <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 26 Nov 2022 22:29:06 +0800
Message-ID: <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
Subject: Re: [bisected]kernel BUG at lib/list_debug.c:30! (list_add
 corruption. prev->next should be nex)
To:     Jens Axboe <axboe@kernel.dk>, Waiman Long <longman@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens
Sorry for the delay as I couldn't reproduce it with the original
for-6.2/block branch.
Finally, I rebased the for-6.2/block branch on 6.1-rc6 and was able to
bisect it=EF=BC=9A


951d1e94801f95a3fc1c75ff342431c9f519dd14 is the first bad commit
commit 951d1e94801f95a3fc1c75ff342431c9f519dd14
Author: Waiman Long <longman@redhat.com>
Date:   Fri Nov 4 20:59:02 2022 -0400

    blk-cgroup: Flush stats at blkgs destruction path

    As noted by Michal, the blkg_iostat_set's in the lockless list
    hold reference to blkg's to protect against their removal. Those
    blkg's hold reference to blkcg. When a cgroup is being destroyed,
    cgroup_rstat_flush() is only called at css_release_work_fn() which is
    called when the blkcg reference count reaches 0. This circular dependen=
cy
    will prevent blkcg from being freed until some other events cause
    cgroup_rstat_flush() to be called to flush out the pending blkcg stats.

    To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush=
()
    function to flush stats for a given css and cpu and call it at the blkg=
s
    destruction path, blkcg_destroy_blkgs(), whenever there are still some
    pending stats to be flushed. This will ensure that blkcg reference
    count can reach 0 ASAP.

    Signed-off-by: Waiman Long <longman@redhat.com>
    Acked-by: Tejun Heo <tj@kernel.org>
    Link: https://lore.kernel.org/r/20221105005902.407297-4-longman@redhat.=
com
    Signed-off-by: Jens Axboe <axboe@kernel.dk>


On Fri, Nov 25, 2022 at 4:38 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> I reproduced this issue even when system boot with the latest
> linux-block/for-next, will try to bisect it later.
>
> 43f3ae1898c9 (HEAD -> for-next, origin/for-next) Merge branch
> 'for-6.2/writeback' into for-next
> d6798bc243fa writeback: Add asserts for adding freed inode to lists
>
> [   24.183829] list_add corruption. prev->next should be next
> (ffff9a1d9f337f68), but was ffff9a1a02119e70. (prev=3Dffff9a1a02119e70).
> [   24.195478] ------------[ cut here ]------------
> [   24.200088] kernel BUG at lib/list_debug.c:30!
> [   24.204532] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   24.209751] CPU: 4 PID: 167 Comm: kworker/4:1 Not tainted 6.1.0-rc6+ #=
1
> [   24.216365] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
> 2.8.5 08/18/2022
> [   24.223930] Workqueue: cgwb_release cgwb_release_workfn
> [   24.229157] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> [   24.234208] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 20 23 65 a8 e8 d2
> a2 fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 c8 22 65 a8 e8 bb
> a2 fe ff <0f> 0b 4c 89 c1 48 c7 c7 70 22 65 a8 e8 aa a2 fe ff 0f 0b 48
> c7 c7
> [   24.252953] RSP: 0018:ffffb035407e7da8 EFLAGS: 00010046
> [   24.258172] RAX: 0000000000000075 RBX: ffff9a1a02119e68 RCX: 000000000=
0000000
> [   24.265303] RDX: 0000000000000000 RSI: ffff9a1d9f31f840 RDI: ffff9a1d9=
f31f840
> [   24.272428] RBP: ffff9a1d9f337f00 R08: 0000000000000000 R09: 00000000f=
fff7fff
> [   24.279560] R10: ffffb035407e7c50 R11: ffffffffa8be75e8 R12: ffff9a1d9=
f337f68
> [   24.286683] R13: ffff9a1a02119e70 R14: ffff9a1a02119e70 R15: ffff9a1d9=
f330340
> [   24.293808] FS:  0000000000000000(0000) GS:ffff9a1d9f300000(0000)
> knlGS:0000000000000000
> [   24.301894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.307641] CR2: 000055b5f1f28050 CR3: 0000000104e38000 CR4: 000000000=
0350ee0
> [   24.314772] Call Trace:
> [   24.314774]  <TASK>
> [   24.314774]  insert_work+0x46/0xc0
> [   24.314780]  __queue_work+0x1d5/0x380
> [   24.326376]  queue_work_on+0x24/0x30
> [   24.329955]  blkcg_unpin_online+0x1b5/0x1c0
> [   24.334143]  cgwb_release_workfn+0x6a/0x200
> [   24.338327]  process_one_work+0x1e5/0x3b0
> [   24.342342]  ? rescuer_thread+0x390/0x390
> [   24.346352]  worker_thread+0x50/0x3a0
> [   24.350019]  ? rescuer_thread+0x390/0x390
> [   24.354030]  kthread+0xd9/0x100
> [   24.357177]  ? kthread_complete_and_exit+0x20/0x20
> [   24.361970]  ret_from_fork+0x22/0x30
> [   24.365550]  </TASK>
> [   24.367742] Modules linked in: sunrpc intel_rapl_msr
> intel_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd kvm
> mgag200 ledtrig_audio rfkill video i2c_algo_bit drm_shmem_helper
> dcdbas drm_kms_helper irqbypass dell_smbios rapl dell_wmi_descriptor
> wmi_bmof pcspkr syscopyarea acpi_ipmi sysfillrect sysimgblt
> fb_sys_fops ipmi_si ipmi_devintf ptdma i2c_piix4 k10temp
> ipmi_msghandler acpi_power_meter vfat fat acpi_cpufreq drm fuse xfs
> libcrc32c sd_mod sg ahci crct10dif_pclmul crc32_pclmul libahci
> crc32c_intel ghash_clmulni_intel mpt3sas nvme tg3 libata nvme_core ccp
> raid_class nvme_common t10_pi sp5100_tco scsi_transport_sas wmi
> dm_mirror dm_region_hash dm_log dm_mod
> [   24.426475] ---[ end trace 0000000000000000 ]---
> [   24.505278] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> [   24.510331] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 20 23 65 a8 e8 d2
> a2 fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 c8 22 65 a8 e8 bb
> a2 fe ff <0f> 0b 4c 89 c1 48 c7 c7 70 22 65 a8 e8 aa a2 fe ff 0f 0b 48
> c7 c7
> [   24.510332] RSP: 0018:ffffb035407e7da8 EFLAGS: 00010046
> [   24.510333] RAX: 0000000000000075 RBX: ffff9a1a02119e68 RCX: 000000000=
0000000
> [   24.510334] RDX: 0000000000000000 RSI: ffff9a1d9f31f840 RDI: ffff9a1d9=
f31f840
> [   24.510335] RBP: ffff9a1d9f337f00 R08: 0000000000000000 R09: 00000000f=
fff7fff
> [   24.510337] R10: ffffb035407e7c50 R11: ffffffffa8be75e8 R12: ffff9a1d9=
f337f68
> [   24.562805] R13: ffff9a1a02119e70 R14: ffff9a1a02119e70 R15: ffff9a1d9=
f330340
> [   24.569929] FS:  0000000000000000(0000) GS:ffff9a1d9f300000(0000)
> knlGS:0000000000000000
> [   24.578017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.578018] CR2: 000055b5f1f28050 CR3: 0000000104e38000 CR4: 000000000=
0350ee0
> [   24.578019] Kernel panic - not syncing: Fatal exception
> [   24.578653] Kernel Offset: 0x26200000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   24.682013] ---[ end Kernel panic - not syncing: Fatal exception ]---
> [   24.339396] r[-- MARK -- Fri Nov 25 06:25:00 2022]
>
>
> On Thu, Nov 24, 2022 at 11:00 PM Bruno Goncalves <bgoncalv@redhat.com> wr=
ote:
> >
> > On Wed, 23 Nov 2022 at 14:46, Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > On 11/23/22 1:48=E2=80=AFAM, Bruno Goncalves wrote:
> > > > Hello,
> > > >
> > > > We recently started to hit the following panic when testing the blo=
ck
> > > > tree (for-next branch).
> > > >
> > > > [ 5076.172749] list_add corruption. prev->next should be next
> > > > (ffff91cd6f7fa568), but was ffff91c991ca6670. (prev=3Dffff91c991ca6=
670).
> > > > [ 5076.173863] ------------[ cut here ]------------
> > > > [ 5076.174853] kernel BUG at lib/list_debug.c:30!
> > > > [ 5076.175523] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > > [ 5076.175853] CPU: 15 PID: 16415 Comm: kworker/15:13 Tainted: G
> > > >    I        6.1.0-rc6 #1
> > > > [ 5076.176799] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/=
24/2019
> > > > [ 5076.177198] Workqueue: cgwb_release cgwb_release_workfn
> > > > [ 5076.177497] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > > > [ 5076.177788] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5=
a
> > > > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 4=
3
> > > > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b=
 48
> > > > c7 c7
> > > > [ 5076.179173] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > > > [ 5076.179472] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 000=
0000000000000
> > > > [ 5076.180241] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 000=
00000ffffffff
> > > > [ 5076.181069] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: fff=
fa1c98a6afc60
> > > > [ 5076.182209] R10: 0000000000000003 R11: ffff91cd7ff42fe8 R12: fff=
f91cd6f7fa568
> > > > [ 5076.183002] R13: ffff91c991ca6670 R14: ffff91c991ca6670 R15: fff=
f91cd6f7f1440
> > > > [ 5076.183902] FS:  0000000000000000(0000) GS:ffff91cd6f7c0000(0000=
)
> > > > knlGS:0000000000000000
> > > > [ 5076.184377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 5076.185084] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 000=
00000000606e0
> > > > [ 5076.185945] Call Trace:
> > > > [ 5076.186110]  <TASK>
> > > > [ 5076.186916]  insert_work+0x46/0xc0
> > > > [ 5076.187533]  __queue_work+0x1d4/0x460
> > > > [ 5076.187788]  queue_work_on+0x37/0x40
> > > > [ 5076.187993]  blkcg_unpin_online+0x1ad/0x1b0
> > > > [ 5076.188244]  cgwb_release_workfn+0x6a/0x200
> > > > [ 5076.188464]  process_one_work+0x1c7/0x380
> > > > [ 5076.188675]  worker_thread+0x4d/0x380
> > > > [ 5076.188881]  ? rescuer_thread+0x380/0x380
> > > > [ 5076.189089]  kthread+0xe9/0x110
> > > > [ 5076.189716]  ? kthread_complete_and_exit+0x20/0x20
> > > > [ 5076.190407]  ret_from_fork+0x22/0x30
> > > > [ 5076.190677]  </TASK>
> > > > [ 5076.190816] Modules linked in: nvme nvme_core nvme_common loop t=
ls
> > > > rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_therma=
l
> > > > intel_powerclamp coretemp sunrpc kvm_intel kvm iTCO_wdt iapl
> > > > intel_cstate intel_uncore pcspkr lpc_ich ipmi_ssif hpilo tg3 acpi_i=
pmi
> > > > ioatdma ipmi_si ipmi_devintf dca ipmi_msghandler acpi_power_meter f=
use
> > > > zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> > > > polyval_generic ghash_clmulni_intel sha512_ssse3 serio_raw hpsa
> > > > mgag200 scsi_transport_sas [last unloaded: scsi_debug]
> > > > [ 5076.293315] ---[ end trace 0000000000000000 ]---
> > > > [ 5076.295226] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > > > [ 5076.295587] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5=
a
> > > > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 4=
3
> > > > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b=
 48
> > > > c7 c7
> > > > [ 5076.296921] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > > > [ 5076.297239] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 000=
0000000000000
> > > > [ 5076.297983] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 000=
00000ffffffff
> > > > [ 5076.298768] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: fff=
fa1c98a6afc60
> > > > [ 5076.299525] R10: 0000S:  0000000000000000(0000)
> > > > GS:ffff91cd6f7c0000(0000) knlGS:0000000000000000
> > > > [ 5076.700351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 5076.701046] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 000=
00000000606e0
> > > > [ 5076ernel panic - not syncing: Fatal exception
> > > > [ 5077.924713] Shutting down cpus with NMI
> > > > [ 5077.924986] Kernel Offset: 0x2b000000 from 0xffffffff81000000
> > > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > [ 5077.927946] ---[ end Kernel panic - not syncing: Fatal exception=
 ]---
> > > >
> > > > It seems to happen often during different tests.
> > > >
> > > > full console.log:
> > > > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-publi=
c/datawarehouse-public/2022/11/21/redhat:700955106/build_x86_64_redhat:7009=
55106_x86_64/tests/1/results_0001/console.log/console.log
> > > >
> > > > kernel tarball:
> > > > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-art=
ifacts/700955106/publish%20x86_64/3356091217/artifacts/kernel-block-redhat_=
700955106_x86_64.tar.gz
> > > >
> > > > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifa=
cts/trusted-artifacts/700955106/build%20x86_64/3356091207/artifacts/kernel-=
block-redhat_700955106_x86_64.config
> > > >
> > > > test logs: https://datawarehouse.cki-project.org/kcidb/tests/606167=
7
> > > >
> > > > We didn't bisect, but the first commit we hit the problem was
> > > > "f65d92c600fe6eecdbd6e7fab7893c9c094dfcbf
> > > > (io_uring-6.1-2022-11-18-2180-gf65d92c600fe)" and the last one wher=
e
> > > > we didn't hit the problem was
> > > > "40fa774af7fd04d06014ac74947c351649b6f64f
> > > > (io_uring-6.1-2022-11-11-1843-g40fa774af7fd)"
> > > >
> > > > test logs: https://datawarehouse.cki-project.org/kcidb/tests/606167=
7
> > > > cki issue tracker: https://datawarehouse.cki-project.org/issue/1732
> > >
> > > Please just try and clone for-6.2/block from the block tree and bisec=
t
> > > it?
> > >
> >
> > Hi,
> > I've tried with commit 93c68cc46a070775cc6675e3543dd909eb9f6c9e (drbd:
> > use consistent license), but I was not able to hit the panic with it.
> >
> >
> > Bruno
> >
> > > --
> > > Jens Axboe
> > >
> > >
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


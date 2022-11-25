Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A0C4332F
	for <linux-block@archiver.kernel.org>; Fri, 25 Nov 2022 08:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKYIkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 03:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYIkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 03:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352C623E88
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 00:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669365553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZH7d7xco2tfttNyu2GXA90Mwx3oHrCLAQLrSmlA7bqc=;
        b=H5A91gzg6D68UpACJgx1wSLhvZvWUEiHWGTZYaYNscGkuJGWViGA3xmKv5uMr2f8D7715F
        haDOyJXnoK/IQ6bDpB5Xw5ABvKeknI8m0LAlVcsYBeb3sGG+mDItG24MNdEdkIOHYlBnF4
        +nFWS8z/V8QlTpvIq+/wzrVYNpUQ6BY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-FQgMMoOdNB6W67ktuYoQ4g-1; Fri, 25 Nov 2022 03:39:12 -0500
X-MC-Unique: FQgMMoOdNB6W67ktuYoQ4g-1
Received: by mail-pj1-f71.google.com with SMTP id mj8-20020a17090b368800b002137a506927so2325197pjb.1
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 00:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH7d7xco2tfttNyu2GXA90Mwx3oHrCLAQLrSmlA7bqc=;
        b=zfEkmjmTswT4Lx+UV5zgoGvJLZk2bq8xPFk5uKE5DfE/LoAwM/F1ObbolLZD2JL7d9
         k5DX3pCccNyKJPT7LuQ7lHj3AhvOlCSJQwcmUs0FwuO9asySv0kWboYn7ylbWTefzzPV
         9QMyx8KBQPkU5i/lqkZ1M+fj1Zz/1zLnsnSEXmVlqe6ygHgtTHcXHDh/EbgcE7dBHLp3
         teWYqwdFpyp/cKkg4C3kcR5t7hrzMPDDg2ccpXzsk2+7x/FuyigaAKv4gNmPZV5/mQ8Z
         c9EPQIABpvgMUW8NFOD/ToL8uU6H9ykZmDHzsVGU0a+euGU3e2a5jAz8POXrdDiMKdAj
         I7yg==
X-Gm-Message-State: ANoB5pkZGQdLGaf2wxSP+CML4xhbMtvTUALK6RU62VCyi/bE4Lemxn6i
        rhMfea9WgLOUND3R0k4DefZ0sC/zC0oYDCQD5ZrG+7YlUbsHsXkTZ9wRsdYdlf8TPfuMYA93C54
        AabG93ekh0sQsm5D5aXOmQmVRWtcwa8nNcx+XJxM=
X-Received: by 2002:a05:6a00:330e:b0:56c:d93a:ac5f with SMTP id cq14-20020a056a00330e00b0056cd93aac5fmr21403517pfb.48.1669365550701;
        Fri, 25 Nov 2022 00:39:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7oRu+UODEbDaFH6TOt+Gc86G2NGtRvurOnkkVFiiy+j2Fs0YcqM6ZM+xwP4/LxfDF9+QPesRKXj0Cf7hBUHYQ=
X-Received: by 2002:a05:6a00:330e:b0:56c:d93a:ac5f with SMTP id
 cq14-20020a056a00330e00b0056cd93aac5fmr21403504pfb.48.1669365550360; Fri, 25
 Nov 2022 00:39:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk> <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
In-Reply-To: <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 25 Nov 2022 16:38:58 +0800
Message-ID: <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
Subject: Re: kernel BUG at lib/list_debug.c:30! (list_add corruption.
 prev->next should be nex)
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I reproduced this issue even when system boot with the latest
linux-block/for-next, will try to bisect it later.

43f3ae1898c9 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.2/writeback' into for-next
d6798bc243fa writeback: Add asserts for adding freed inode to lists

[   24.183829] list_add corruption. prev->next should be next
(ffff9a1d9f337f68), but was ffff9a1a02119e70. (prev=3Dffff9a1a02119e70).
[   24.195478] ------------[ cut here ]------------
[   24.200088] kernel BUG at lib/list_debug.c:30!
[   24.204532] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   24.209751] CPU: 4 PID: 167 Comm: kworker/4:1 Not tainted 6.1.0-rc6+ #1
[   24.216365] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.8.5 08/18/2022
[   24.223930] Workqueue: cgwb_release cgwb_release_workfn
[   24.229157] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
[   24.234208] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 20 23 65 a8 e8 d2
a2 fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 c8 22 65 a8 e8 bb
a2 fe ff <0f> 0b 4c 89 c1 48 c7 c7 70 22 65 a8 e8 aa a2 fe ff 0f 0b 48
c7 c7
[   24.252953] RSP: 0018:ffffb035407e7da8 EFLAGS: 00010046
[   24.258172] RAX: 0000000000000075 RBX: ffff9a1a02119e68 RCX: 00000000000=
00000
[   24.265303] RDX: 0000000000000000 RSI: ffff9a1d9f31f840 RDI: ffff9a1d9f3=
1f840
[   24.272428] RBP: ffff9a1d9f337f00 R08: 0000000000000000 R09: 00000000fff=
f7fff
[   24.279560] R10: ffffb035407e7c50 R11: ffffffffa8be75e8 R12: ffff9a1d9f3=
37f68
[   24.286683] R13: ffff9a1a02119e70 R14: ffff9a1a02119e70 R15: ffff9a1d9f3=
30340
[   24.293808] FS:  0000000000000000(0000) GS:ffff9a1d9f300000(0000)
knlGS:0000000000000000
[   24.301894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.307641] CR2: 000055b5f1f28050 CR3: 0000000104e38000 CR4: 00000000003=
50ee0
[   24.314772] Call Trace:
[   24.314774]  <TASK>
[   24.314774]  insert_work+0x46/0xc0
[   24.314780]  __queue_work+0x1d5/0x380
[   24.326376]  queue_work_on+0x24/0x30
[   24.329955]  blkcg_unpin_online+0x1b5/0x1c0
[   24.334143]  cgwb_release_workfn+0x6a/0x200
[   24.338327]  process_one_work+0x1e5/0x3b0
[   24.342342]  ? rescuer_thread+0x390/0x390
[   24.346352]  worker_thread+0x50/0x3a0
[   24.350019]  ? rescuer_thread+0x390/0x390
[   24.354030]  kthread+0xd9/0x100
[   24.357177]  ? kthread_complete_and_exit+0x20/0x20
[   24.361970]  ret_from_fork+0x22/0x30
[   24.365550]  </TASK>
[   24.367742] Modules linked in: sunrpc intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd kvm
mgag200 ledtrig_audio rfkill video i2c_algo_bit drm_shmem_helper
dcdbas drm_kms_helper irqbypass dell_smbios rapl dell_wmi_descriptor
wmi_bmof pcspkr syscopyarea acpi_ipmi sysfillrect sysimgblt
fb_sys_fops ipmi_si ipmi_devintf ptdma i2c_piix4 k10temp
ipmi_msghandler acpi_power_meter vfat fat acpi_cpufreq drm fuse xfs
libcrc32c sd_mod sg ahci crct10dif_pclmul crc32_pclmul libahci
crc32c_intel ghash_clmulni_intel mpt3sas nvme tg3 libata nvme_core ccp
raid_class nvme_common t10_pi sp5100_tco scsi_transport_sas wmi
dm_mirror dm_region_hash dm_log dm_mod
[   24.426475] ---[ end trace 0000000000000000 ]---
[   24.505278] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
[   24.510331] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 20 23 65 a8 e8 d2
a2 fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 c8 22 65 a8 e8 bb
a2 fe ff <0f> 0b 4c 89 c1 48 c7 c7 70 22 65 a8 e8 aa a2 fe ff 0f 0b 48
c7 c7
[   24.510332] RSP: 0018:ffffb035407e7da8 EFLAGS: 00010046
[   24.510333] RAX: 0000000000000075 RBX: ffff9a1a02119e68 RCX: 00000000000=
00000
[   24.510334] RDX: 0000000000000000 RSI: ffff9a1d9f31f840 RDI: ffff9a1d9f3=
1f840
[   24.510335] RBP: ffff9a1d9f337f00 R08: 0000000000000000 R09: 00000000fff=
f7fff
[   24.510337] R10: ffffb035407e7c50 R11: ffffffffa8be75e8 R12: ffff9a1d9f3=
37f68
[   24.562805] R13: ffff9a1a02119e70 R14: ffff9a1a02119e70 R15: ffff9a1d9f3=
30340
[   24.569929] FS:  0000000000000000(0000) GS:ffff9a1d9f300000(0000)
knlGS:0000000000000000
[   24.578017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.578018] CR2: 000055b5f1f28050 CR3: 0000000104e38000 CR4: 00000000003=
50ee0
[   24.578019] Kernel panic - not syncing: Fatal exception
[   24.578653] Kernel Offset: 0x26200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.682013] ---[ end Kernel panic - not syncing: Fatal exception ]---
[   24.339396] r[-- MARK -- Fri Nov 25 06:25:00 2022]


On Thu, Nov 24, 2022 at 11:00 PM Bruno Goncalves <bgoncalv@redhat.com> wrot=
e:
>
> On Wed, 23 Nov 2022 at 14:46, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 11/23/22 1:48=E2=80=AFAM, Bruno Goncalves wrote:
> > > Hello,
> > >
> > > We recently started to hit the following panic when testing the block
> > > tree (for-next branch).
> > >
> > > [ 5076.172749] list_add corruption. prev->next should be next
> > > (ffff91cd6f7fa568), but was ffff91c991ca6670. (prev=3Dffff91c991ca667=
0).
> > > [ 5076.173863] ------------[ cut here ]------------
> > > [ 5076.174853] kernel BUG at lib/list_debug.c:30!
> > > [ 5076.175523] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > [ 5076.175853] CPU: 15 PID: 16415 Comm: kworker/15:13 Tainted: G
> > >    I        6.1.0-rc6 #1
> > > [ 5076.176799] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24=
/2019
> > > [ 5076.177198] Workqueue: cgwb_release cgwb_release_workfn
> > > [ 5076.177497] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > > [ 5076.177788] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> > > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> > > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 4=
8
> > > c7 c7
> > > [ 5076.179173] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > > [ 5076.179472] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 00000=
00000000000
> > > [ 5076.180241] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 00000=
000ffffffff
> > > [ 5076.181069] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa=
1c98a6afc60
> > > [ 5076.182209] R10: 0000000000000003 R11: ffff91cd7ff42fe8 R12: ffff9=
1cd6f7fa568
> > > [ 5076.183002] R13: ffff91c991ca6670 R14: ffff91c991ca6670 R15: ffff9=
1cd6f7f1440
> > > [ 5076.183902] FS:  0000000000000000(0000) GS:ffff91cd6f7c0000(0000)
> > > knlGS:0000000000000000
> > > [ 5076.184377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5076.185084] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 00000=
000000606e0
> > > [ 5076.185945] Call Trace:
> > > [ 5076.186110]  <TASK>
> > > [ 5076.186916]  insert_work+0x46/0xc0
> > > [ 5076.187533]  __queue_work+0x1d4/0x460
> > > [ 5076.187788]  queue_work_on+0x37/0x40
> > > [ 5076.187993]  blkcg_unpin_online+0x1ad/0x1b0
> > > [ 5076.188244]  cgwb_release_workfn+0x6a/0x200
> > > [ 5076.188464]  process_one_work+0x1c7/0x380
> > > [ 5076.188675]  worker_thread+0x4d/0x380
> > > [ 5076.188881]  ? rescuer_thread+0x380/0x380
> > > [ 5076.189089]  kthread+0xe9/0x110
> > > [ 5076.189716]  ? kthread_complete_and_exit+0x20/0x20
> > > [ 5076.190407]  ret_from_fork+0x22/0x30
> > > [ 5076.190677]  </TASK>
> > > [ 5076.190816] Modules linked in: nvme nvme_core nvme_common loop tls
> > > rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> > > intel_powerclamp coretemp sunrpc kvm_intel kvm iTCO_wdt iapl
> > > intel_cstate intel_uncore pcspkr lpc_ich ipmi_ssif hpilo tg3 acpi_ipm=
i
> > > ioatdma ipmi_si ipmi_devintf dca ipmi_msghandler acpi_power_meter fus=
e
> > > zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> > > polyval_generic ghash_clmulni_intel sha512_ssse3 serio_raw hpsa
> > > mgag200 scsi_transport_sas [last unloaded: scsi_debug]
> > > [ 5076.293315] ---[ end trace 0000000000000000 ]---
> > > [ 5076.295226] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> > > [ 5076.295587] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> > > 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> > > 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 4=
8
> > > c7 c7
> > > [ 5076.296921] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> > > [ 5076.297239] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 00000=
00000000000
> > > [ 5076.297983] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 00000=
000ffffffff
> > > [ 5076.298768] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa=
1c98a6afc60
> > > [ 5076.299525] R10: 0000S:  0000000000000000(0000)
> > > GS:ffff91cd6f7c0000(0000) knlGS:0000000000000000
> > > [ 5076.700351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5076.701046] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 00000=
000000606e0
> > > [ 5076ernel panic - not syncing: Fatal exception
> > > [ 5077.924713] Shutting down cpus with NMI
> > > [ 5077.924986] Kernel Offset: 0x2b000000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [ 5077.927946] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> > >
> > > It seems to happen often during different tests.
> > >
> > > full console.log:
> > > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/=
datawarehouse-public/2022/11/21/redhat:700955106/build_x86_64_redhat:700955=
106_x86_64/tests/1/results_0001/console.log/console.log
> > >
> > > kernel tarball:
> > > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artif=
acts/700955106/publish%20x86_64/3356091217/artifacts/kernel-block-redhat_70=
0955106_x86_64.tar.gz
> > >
> > > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifact=
s/trusted-artifacts/700955106/build%20x86_64/3356091207/artifacts/kernel-bl=
ock-redhat_700955106_x86_64.config
> > >
> > > test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> > >
> > > We didn't bisect, but the first commit we hit the problem was
> > > "f65d92c600fe6eecdbd6e7fab7893c9c094dfcbf
> > > (io_uring-6.1-2022-11-18-2180-gf65d92c600fe)" and the last one where
> > > we didn't hit the problem was
> > > "40fa774af7fd04d06014ac74947c351649b6f64f
> > > (io_uring-6.1-2022-11-11-1843-g40fa774af7fd)"
> > >
> > > test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> > > cki issue tracker: https://datawarehouse.cki-project.org/issue/1732
> >
> > Please just try and clone for-6.2/block from the block tree and bisect
> > it?
> >
>
> Hi,
> I've tried with commit 93c68cc46a070775cc6675e3543dd909eb9f6c9e (drbd:
> use consistent license), but I was not able to hit the panic with it.
>
>
> Bruno
>
> > --
> > Jens Axboe
> >
> >
>


--=20
Best Regards,
  Yi Zhang


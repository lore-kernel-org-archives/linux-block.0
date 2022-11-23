Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6636C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiKWNxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiKWNwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 08:52:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE1DF60
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:46:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 9so618377pfx.11
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEcQ4MEtjHmm0VrpzmFVYznuxVICvdgu7YVkFO3jvNM=;
        b=t37MsBR+f7VUdUt/tpIrfN4nXDz/Gi/Xc96F/a0NZSxqbi664DiOnQkrNXblgG6OfG
         YwnBy78eV95YiGzCpR18/VDofwwdT0dVrH3qIHT2sMarTgFDb51FNVL/MgKWSx4+Wh4W
         a0wwohWCmk5V2Su3e6bTBhczdbEuHi04vek2LnyR9onE0TdBWPYyVJeyKQ/3k5opnwUx
         fWy3b0ulSuOX3G08SYHm4CBNfAeEupzjJhGIxuCzFxO/wsXkBIR2XPXbKGv9ZZH69Edo
         198Or4OPBCEUhddo32WZAriUipp51kcSF2/59RI8ZXaRrlnU2ytRqh6b+ueDJy11lCLq
         FC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEcQ4MEtjHmm0VrpzmFVYznuxVICvdgu7YVkFO3jvNM=;
        b=ri2ROnU7mI0hvcLxuisC3pbmPbOGKTK5Dcf5S4PB2EorPy7XNWCw3qoFokzX3wUcLq
         x3RXBJ+/Qd+P8rNQMBJ5RExFf8wsYxZ+iEQ5efteEqF46NlLgrzeruMuVV/U6Fq5Xhtk
         PRbXu2SRXkoDEM977DEAB4U8nYHmkQnFysAVQ0Lh1lhmbgXSkn+fuXB56uqym/BeItC9
         xr+acCEjTJyoMjhtfKxLAX4c3XC1l6d/zO1Jf19OvCuKIjmoSsHRBsSryJhStWg2x6IZ
         yG27O9WbQxO0luHx5KF0lJJNTexIpIn0m2Xe+xS99ZWpalwgCNeH6Bstm3ObFUc3ynQI
         xcwQ==
X-Gm-Message-State: ANoB5pn9M7msft+LFqD/7xXztXVTOWhMUVZ56f1g/a9rRylS8Ao44U3H
        gcEHnDyeksZklu/nYfVgLb6t4oXt1X6BEVkL
X-Google-Smtp-Source: AA0mqf4unAZn4rW/xlMfWmEn/Bpeq18wk/HaUwnWJZS8zh4pyvi86h0FmpGgzzlZYeK0rTwhIk8rrw==
X-Received: by 2002:a63:e510:0:b0:470:60a5:146d with SMTP id r16-20020a63e510000000b0047060a5146dmr13185064pgh.156.1669211167393;
        Wed, 23 Nov 2022 05:46:07 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p188-20020a625bc5000000b0056e32a2b88esm12575562pfb.219.2022.11.23.05.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:46:06 -0800 (PST)
Message-ID: <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
Date:   Wed, 23 Nov 2022 06:46:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: kernel BUG at lib/list_debug.c:30! (list_add corruption.
 prev->next should be nex)
Content-Language: en-US
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/22 1:48 AM, Bruno Goncalves wrote:
> Hello,
> 
> We recently started to hit the following panic when testing the block
> tree (for-next branch).
> 
> [ 5076.172749] list_add corruption. prev->next should be next
> (ffff91cd6f7fa568), but was ffff91c991ca6670. (prev=ffff91c991ca6670).
> [ 5076.173863] ------------[ cut here ]------------
> [ 5076.174853] kernel BUG at lib/list_debug.c:30!
> [ 5076.175523] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [ 5076.175853] CPU: 15 PID: 16415 Comm: kworker/15:13 Tainted: G
>    I        6.1.0-rc6 #1
> [ 5076.176799] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24/2019
> [ 5076.177198] Workqueue: cgwb_release cgwb_release_workfn
> [ 5076.177497] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> [ 5076.177788] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 48
> c7 c7
> [ 5076.179173] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> [ 5076.179472] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 0000000000000000
> [ 5076.180241] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 00000000ffffffff
> [ 5076.181069] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa1c98a6afc60
> [ 5076.182209] R10: 0000000000000003 R11: ffff91cd7ff42fe8 R12: ffff91cd6f7fa568
> [ 5076.183002] R13: ffff91c991ca6670 R14: ffff91c991ca6670 R15: ffff91cd6f7f1440
> [ 5076.183902] FS:  0000000000000000(0000) GS:ffff91cd6f7c0000(0000)
> knlGS:0000000000000000
> [ 5076.184377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5076.185084] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 00000000000606e0
> [ 5076.185945] Call Trace:
> [ 5076.186110]  <TASK>
> [ 5076.186916]  insert_work+0x46/0xc0
> [ 5076.187533]  __queue_work+0x1d4/0x460
> [ 5076.187788]  queue_work_on+0x37/0x40
> [ 5076.187993]  blkcg_unpin_online+0x1ad/0x1b0
> [ 5076.188244]  cgwb_release_workfn+0x6a/0x200
> [ 5076.188464]  process_one_work+0x1c7/0x380
> [ 5076.188675]  worker_thread+0x4d/0x380
> [ 5076.188881]  ? rescuer_thread+0x380/0x380
> [ 5076.189089]  kthread+0xe9/0x110
> [ 5076.189716]  ? kthread_complete_and_exit+0x20/0x20
> [ 5076.190407]  ret_from_fork+0x22/0x30
> [ 5076.190677]  </TASK>
> [ 5076.190816] Modules linked in: nvme nvme_core nvme_common loop tls
> rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp sunrpc kvm_intel kvm iTCO_wdt iapl
> intel_cstate intel_uncore pcspkr lpc_ich ipmi_ssif hpilo tg3 acpi_ipmi
> ioatdma ipmi_si ipmi_devintf dca ipmi_msghandler acpi_power_meter fuse
> zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> polyval_generic ghash_clmulni_intel sha512_ssse3 serio_raw hpsa
> mgag200 scsi_transport_sas [last unloaded: scsi_debug]
> [ 5076.293315] ---[ end trace 0000000000000000 ]---
> [ 5076.295226] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> [ 5076.295587] Code: f2 48 89 c1 48 89 fe 48 c7 c7 48 d8 76 ad e8 5a
> 8f fd ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f0 d7 76 ad e8 43
> 8f fd ff <0f> 0b 48 89 c1 48 c7 c7 98 d7 76 ad e8 32 8f fd ff 0f 0b 48
> c7 c7
> [ 5076.296921] RSP: 0018:ffffa1c98a6afdb0 EFLAGS: 00010082
> [ 5076.297239] RAX: 0000000000000075 RBX: ffff91c991ca6668 RCX: 0000000000000000
> [ 5076.297983] RDX: 0000000000000002 RSI: ffffffffad752ad3 RDI: 00000000ffffffff
> [ 5076.298768] RBP: ffff91cd6f7fa500 R08: 0000000000000000 R09: ffffa1c98a6afc60
> [ 5076.299525] R10: 0000S:  0000000000000000(0000)
> GS:ffff91cd6f7c0000(0000) knlGS:0000000000000000
> [ 5076.700351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5076.701046] CR2: 0000560ff67e11b8 CR3: 000000020d010005 CR4: 00000000000606e0
> [ 5076ernel panic - not syncing: Fatal exception
> [ 5077.924713] Shutting down cpus with NMI
> [ 5077.924986] Kernel Offset: 0x2b000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 5077.927946] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> It seems to happen often during different tests.
> 
> full console.log:
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/11/21/redhat:700955106/build_x86_64_redhat:700955106_x86_64/tests/1/results_0001/console.log/console.log
> 
> kernel tarball:
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/700955106/publish%20x86_64/3356091217/artifacts/kernel-block-redhat_700955106_x86_64.tar.gz
> 
> kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/700955106/build%20x86_64/3356091207/artifacts/kernel-block-redhat_700955106_x86_64.config
> 
> test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> 
> We didn't bisect, but the first commit we hit the problem was
> "f65d92c600fe6eecdbd6e7fab7893c9c094dfcbf
> (io_uring-6.1-2022-11-18-2180-gf65d92c600fe)" and the last one where
> we didn't hit the problem was
> "40fa774af7fd04d06014ac74947c351649b6f64f
> (io_uring-6.1-2022-11-11-1843-g40fa774af7fd)"
> 
> test logs: https://datawarehouse.cki-project.org/kcidb/tests/6061677
> cki issue tracker: https://datawarehouse.cki-project.org/issue/1732

Please just try and clone for-6.2/block from the block tree and bisect
it?

-- 
Jens Axboe



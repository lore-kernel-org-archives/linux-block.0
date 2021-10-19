Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD91C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 02:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8A760F02
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 02:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhJSCyO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 22:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhJSCyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 22:54:13 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D2C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 19:52:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y17so16991913ilb.9
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 19:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BfDF92TeEHTQxP8bLh/wY0OUZohtrtucbaSeGErVLVk=;
        b=fMC4T404AW7PGwZmyTS+GDirNUFC+RzwBRdY0Y8L+KOJVhzpl227NJZKHyg9tgnexw
         Gmj7gSRCIpx7QAdmzfWNVcM9V261jMh68yvD773eGzXYoAEDuJeJZmkAPyY8gWR3Wd7c
         G9leyIl2fiI0mD8yjOQ1p0DX9C8NWVuju548csw/566zC+vIYJ+IRWeDn0nYz0OAHu15
         A6sWchujZZBMuCP+GnzcyDypRZolpYm2RkuDGvOVmNLCu0u580Q3fqs9QLK0Gb4D8+AO
         4YiYjHRsqlEtKnvW+ZpAkE19xaK8K0HU6PMD1qDcI9OSBPPAgi7l48Q2Y0vf57NokLF2
         +ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfDF92TeEHTQxP8bLh/wY0OUZohtrtucbaSeGErVLVk=;
        b=2qAJbRYpUTBQeuK/D4enRSdkihZzzoolb4VpXZSYlXVsaToVhH4o/rlNxX8L6dyS0y
         GxtphJ7IBoVPxtaQj36ZmFp06vpNXXTkEqR9gNfHba3hlPKDeYlzbAmwQmSRYJO4FjNy
         SY1R00hQ8qTBsdCyhXNL9B6z7wJmYr1JuKf4UExqG0mSBT/tr6Y993+mq/g6d1Pwsude
         ll26cnbBY59m2zk4g/RvxmnBbmcf2RjLETQpwI38a57+D9iJA0bTMxtCBSTSMEWI9IEg
         iRL4BakS7QLmZoBUpwCdxoggt7+uYPoGlrV6eI9xXO/U5mj/uKQnVtGXzRlOapFqgPFz
         TJ9g==
X-Gm-Message-State: AOAM531OtC1w+rUu1iK3gQVjtQf15aEpBga5wZK3sgo+4SkFDjC97OZE
        CAbEQeY/1V7M4Bnv+7BmaD03Ng==
X-Google-Smtp-Source: ABdhPJzHPrylDUZvb36mcwtMAOgJTM50sYq14uXZCtRLHrnLno2gBFmrakq+0o671I9Ek9ruzJKhlA==
X-Received: by 2002:a05:6e02:158c:: with SMTP id m12mr16671792ilu.64.1634611920795;
        Mon, 18 Oct 2021 19:52:00 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m2sm7920264ilg.72.2021.10.18.19.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 19:52:00 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Waiting_for_review=3a_Test?=
 =?UTF-8?Q?_report_for_kernel_5=2e15=2e0-rc6_=28block=2c_1983520d=29?=
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     skt-results-master@redhat.com,
        CKI Project <cki-project@redhat.com>,
        Changhui Zhong <czhong@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
References: <cki.1BB6AA01C6.FWO6ZHIQNG@redhat.com>
 <CAHj4cs_3MSAHXaxwwCreLhpL7c+Tak4+y-Hv_Ld7kDT0ZbCRtw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8543f0bf-66b8-8688-313a-0d9e21fce184@kernel.dk>
Date:   Mon, 18 Oct 2021 20:51:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_3MSAHXaxwwCreLhpL7c+Tak4+y-Hv_Ld7kDT0ZbCRtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 8:13 PM, Yi Zhang wrote:
> Hello
> 
> With this commit, the servers boots with NULL pointer[1], pls help check it.
> 
>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' into for-next
> [1]
> [    8.614036] Kernel attempted to read user page (f) - exploit
> attempt? (uid: 0)
> [    8.614071] BUG: Kernel NULL pointer dereference on read at 0x0000000f
> [    8.614099] Faulting instruction address: 0xc00000000093b5b4
> [    8.614118] Oops: Kernel access of bad area, sig: 11 [#1]
> [    8.614143] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [    8.614192] Modules linked in: zram ip_tables ast i2c_algo_bit
> drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto crc32c_vpmsum
> i2c_core drm_panel_orientation_quirks
> [    8.614285] CPU: 52 PID: 0 Comm: swapper/52 Not tainted 5.15.0-rc6+ #1
> [    8.614323] NIP:  c00000000093b5b4 LR: c00000000093b5a4 CTR: c000000000972c50
> [    8.614371] REGS: c000000018d3b430 TRAP: 0300   Not tainted  (5.15.0-rc6+)
> [    8.614409] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
> 44004284  XER: 00000000
> [    8.614464] CFAR: c000000000972cd0 DAR: 000000000000000f DSISR:
> 40000000 IRQMASK: 1
> [    8.614464] GPR00: c00000000093b5a4 c000000018d3b6d0
> c0000000028aa100 c000000044582a00
> [    8.614464] GPR04: 00000000ffff8e2c 0000000000000001
> 0000000000000004 c000000001212930
> [    8.614464] GPR08: 00000000000001d7 0000000000000007
> c000000044361f80 0000000000000000
> [    8.614464] GPR12: c000000000972c50 c000001ffffa7200
> 0000000000000000 0000000000000100
> [    8.614464] GPR16: 0000000000000004 0000000004200042
> 0000000000000000 0000000000000001
> [    8.614464] GPR20: c0000000028d3a00 c000000002167888
> 00000000ffff8e2d c000000002167888
> [    8.614464] GPR24: c0000000021f0580 0000000000000001
> c000000044582ae0 0000000000000801
> [    8.614464] GPR28: c000000044361f80 c000000044361f80
> c00000003b81f800 c000000044582a00
> [    8.614852] NIP [c00000000093b5b4] blk_mq_free_request+0x74/0x210
> [    8.614898] LR [c00000000093b5a4] blk_mq_free_request+0x64/0x210
> [    8.614942] Call Trace:
> [    8.614961] [c000000018d3b6d0] [c00000000093b8ec]
> __blk_mq_end_request+0x19c/0x1d0 (unreliable)
> [    8.615020] [c000000018d3b710] [c00000000092fdfc]
> blk_flush_complete_seq+0x1ac/0x3d0
> [    8.615077] [c000000018d3b770] [c0000000009302dc] flush_end_io+0x2bc/0x390
> [    8.615122] [c000000018d3b7d0] [c00000000093b7cc]
> __blk_mq_end_request+0x7c/0x1d0
> [    8.615174] [c000000018d3b810] [c000000000c20684]
> scsi_end_request+0x124/0x270
> [    8.615228] [c000000018d3b860] [c000000000c21458]
> scsi_io_completion+0x1f8/0x740
> [    8.615250] [c000000018d3b900] [c000000000c13e14]
> scsi_finish_command+0x134/0x190
> [    8.615292] [c000000018d3b990] [c000000000c21068] scsi_complete+0xa8/0x200
> [    8.615345] [c000000018d3ba10] [c000000000939870] blk_complete_reqs+0x80/0xa0
> [    8.615409] [c000000018d3ba40] [c00000000115dfe0] __do_softirq+0x170/0x3fc
> [    8.615475] [c000000018d3bb30] [c00000000015df38] __irq_exit_rcu+0x168/0x1a0
> [    8.615535] [c000000018d3bb60] [c00000000015e140] irq_exit+0x20/0x40
> [    8.615583] [c000000018d3bb80] [c000000000054670]
> doorbell_exception+0x120/0x300
> [    8.615616] [c000000018d3bbc0] [c000000000016cc4]
> replay_soft_interrupts+0x1e4/0x2c0
> [    8.615639] [c000000018d3bda0] [c000000000016ed8]
> arch_local_irq_restore+0x138/0x1a0
> [    8.615694] [c000000018d3bdd0] [c000000000de1714]
> cpuidle_enter_state+0x104/0x540
> [    8.615741] [c000000018d3be30] [c000000000de1bec] cpuidle_enter+0x4c/0x70
> [    8.615795] [c000000018d3be70] [c0000000001aef18] do_idle+0x2f8/0x3f0
> [    8.615839] [c000000018d3bf00] [c0000000001af238] cpu_startup_entry+0x38/0x40
> [    8.615901] [c000000018d3bf30] [c00000000005be6c] start_secondary+0x29c/0x2b0
> [    8.615969] [c000000018d3bf90] [c00000000000d254]
> start_secondary_prolog+0x10/0x14
> [    8.616025] Instruction dump:
> [    8.616074] 41820048 e93d0008 e9290000 e9890068 2c2c0000 41820010
> 7d8903a6 4e800421
> [    8.616136] e8410018 e93f00d8 2c290000 41820140 <e8690008> 4bff6b91
> 60000000 39400000
> [    8.616184] ---[ end trace cc3215be892e1be7 ]---
> [    8.644628] systemd-journald[1408]: Received client request to
> flush runtime journal.
> [  OK  ] Finished Create Static Device Nodes in /dev.
>          Starting Rule-based Manage…for Device Events and Files...
> [  OK  ] Finished Coldplug All udev Devices.
>          Starting Wait for udev To …plete Device Initialization...
> [    8.690954] fuse: init (API version 7.34)
> [  OK  ] Finished Load Kernel Module fuse.
> [    8.694411]
>          Mounting FUSE Control File System...
> [  OK  ] Mounted FUSE Control File System.
> [  OK  ] Started Rule-based Manager for Device Events and Files.
>          Starting Load Kernel Module configfs...
> [  OK  ] Finished Load Kernel Module configfs.
> [    8.950307] IPMI message handler: version 39.2
> [  OK  ] Found device /dev/zram0.
>          Starting Create swap on /dev/zram0...
> [    9.008355] zram0: detected capacity change from 0 to 16777216
> [    9.694430] Kernel panic - not syncing: Aiee, killing interrupt handler!
> [   11.080031] ---[ end Kernel panic - not syncing: Aiee, killing
> interrupt handler! ]---

Can you try this?


diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4201728bf3a5..e9c0b300a177 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -129,6 +129,9 @@ static void blk_flush_restore_request(struct request *rq)
 	/* make @rq a normal request */
 	rq->rq_flags &= ~RQF_FLUSH_SEQ;
 	rq->end_io = rq->flush.saved_end_io;
+	/* clear pointers overlapping with flush data */
+	rq->elv.icq = NULL;
+	rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 }
 
 static void blk_flush_queue_rq(struct request *rq, bool add_front)

-- 
Jens Axboe


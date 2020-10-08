Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F5C433DF
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B3521789
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJHTZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 15:25:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51821 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 15:25:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id d81so7595923wmc.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 12:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DdN4PjtKNt6aWEowxK9QF5zvOx52gUrfAYhXIfQtMCE=;
        b=YKTtcUMDATKEvPHoscvlKt9UYGl8tstTCHtKCzMWX7TjjL0PoDwhTpbL7nLuGfDKXi
         ryIDT5zKme3SHr4vQQLIZUjAYZe2BuH6AKrCmbcAaLOpspba5+GaGgCszxruAV4wlzU/
         9j3Mp1N97arCi0560Znx1PltdEFrCzARjeBAvarA8/hp4GnVCD1NywaDZVif7IvIYBZo
         SwqA74pu2pDrWDCFDZajOrAoUTqJJgKqhvErMVk7nsHiBSItuddViDtpFMrYKysCCLF1
         cULi0YMKUqYzhufQzEtvP90iSb/aFN4IEFKg6Afg6lYDFYBsdcPUz5xj/Btcpdpf/hhX
         e2lw==
X-Gm-Message-State: AOAM531lIPkvLSCq9qgOqhpEAYNmrETiuQW5L+cH295ZkwsbBLc3puQ3
        6UsgUg87CgMVcmJCzd0nMN0=
X-Google-Smtp-Source: ABdhPJwmzvw5nAXq/q4ZfIG0IZzMtE6vqJPGLNpx6BvBft08Vobt4SVADyBp34tk7N6MlI3ntHW46A==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr10660735wmc.107.1602185142222;
        Thu, 08 Oct 2020 12:25:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959? ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
        by smtp.gmail.com with ESMTPSA id w7sm8186809wmc.43.2020.10.08.12.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 12:25:41 -0700 (PDT)
Subject: Re: [bug report] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28
 refcount_warn_saturate+0xa6/0xf0
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Cc:     hch@lst.de
References: <1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <595779fc-0ae8-7c53-9bf3-619c14d74c74@grimberg.me>
Date:   Thu, 8 Oct 2020 12:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hello
> 
> I saw this failure[2] on both stable and block/for-next recently, seems it was introduced from[1], pls help check it, thanks.
> 
> 
> [1]
> commit 236187c4ed195161dfa4237c7beffbba0c5ae45b
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Tue Jul 28 13:16:36 2020 -0700
> 
>      nvme-tcp: fix timeout handler
> 

Thanks for reporting Yi,

I'm not able to reproduce it, but it appears that there is
a possible race with blk_mq_complete_request_remote.

Can you try this and report if this reproduces?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8f4f29f18b8c..ee996f32cb26 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,6 +2178,8 @@ static void nvme_tcp_complete_timed_out(struct 
request *rq)
         if (!blk_mq_request_completed(rq)) {
                 nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
                 blk_mq_complete_request(rq);
+               while (blk_mq_request_started(rq))
+                       msleep(10);
         }
         mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
  }
--

> 
> [2]
> #nvme_trtype=tcp ./check nvme/012
> 
> [ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
> [ 2152.799640] loop: module loaded
> [ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
> [ 2152.952085] nvme nvme0: creating 12 I/O queues.
> [ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
> [ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
> [ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
> [ 2154.942432] XFS (nvme0n1): Ending clean mount
> [ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
> [ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
> [ 2215.199331] nvme nvme0: starting error recovery
> [ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
> [ 2215.204483] block nvme0n1: no usable path - requeuing I/O
> [ 2215.214976] block nvme0n1: no usable path - requeuing I/O
> [ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
> [ 2215.215502] ------------[ cut here ]------------
> [ 2215.215505] refcount_t: underflow; use-after-free.
> [ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> [ 2215.215619] Modules linked in: loop nvme_tcp nvme_fabrics nvme_core nvmet_tcp nvmet rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep hp_wmi amd64_edac_mod edac_mce_amd kvm_amd ccp kvm irqbypass k10temp sparse_keymap rfkill pcspkr nv_tco wmi_bmof snd_pcm snd_timer snd soundcore i2c_nforce2 acpi_cpufreq ip_tables xfs nouveau video mxm_wmi i2c_algo_bit ata_generic drm_kms_helper cec mptsas ttm scsi_transport_sas firewire_ohci mptscsih pata_acpi drm serio_raw mptbase firewire_core forcedeth crc_itu_t sata_nv pata_amd wmi floppy
> [ 2215.215710] CPU: 6 PID: 45 Comm: kworker/6:0H Not tainted 5.9.0-rc8+ #1
> [ 2215.215713] Hardware name: Hewlett-Packard HP xw9400 Workstation/0A1Ch, BIOS 786D6 v04.02 04/21/2009
> [ 2215.215721] Workqueue: kblockd blk_mq_timeout_work
> [ 2215.215736] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
> [ 2215.215742] Code: 05 ca 98 22 01 01 e8 bf cf ad ff 0f 0b c3 80 3d b8 98 22 01 00 75 95 48 c7 c7 d8 53 3e a7 c6 05 a8 98 22 01 01 e8 a0 cf ad ff <0f> 0b c3 80 3d 97 98 22 01 00 0f 85 72 ff ff ff 48 c7 c7 30 54 3e
> [ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
> [ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
> [ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
> [ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
> [ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
> [ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
> [ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
> [ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
> [ 2215.215773] Call Trace:
> [ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
> [ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
> [ 2215.215801]  ? blk_poll+0x300/0x300
> [ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
> [ 2215.215814]  process_one_work+0x1b4/0x370
> [ 2215.215820]  worker_thread+0x53/0x3e0
> [ 2215.215825]  ? process_one_work+0x370/0x370
> [ 2215.215829]  kthread+0x11b/0x140
> [ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
> [ 2215.215841]  ret_from_fork+0x22/0x30
> [ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
> [ 2215.220371] block nvme0n1: no usable path - requeuing I/O
> [ 2215.220377] block nvme0n1: no usable path - requeuing I/O
> [ 2215.466666] block nvme0n1: no usable path - requeuing I/O
> [ 2215.472056] block nvme0n1: no usable path - requeuing I/O
> [ 2215.477444] block nvme0n1: no usable path - requeuing I/O
> [ 2215.482828] block nvme0n1: no usable path - requeuing I/O
> [ 2215.488219] block nvme0n1: no usable path - requeuing I/O
> [ 2215.493625] block nvme0n1: no usable path - requeuing I/O
> [ 2240.794172] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
> [ 2240.800189] nvmet: ctrl 2 fatal error occurred!
> [ 2245.402268] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [ 2245.408286] nvmet: ctrl 1 fatal error occurred!
> [ 2262.862528] nvmet: creating controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
> [ 2288.411172] nvme nvme0: queue 0: timeout request 0x0 type 4
> [ 2288.416794] nvme nvme0: Connect command failed, error wo/DNR bit: 881
> [ 2288.423254] nvme nvme0: failed to connect queue: 0 ret=881
> [ 2288.428773] nvme nvme0: Failed reconnect attempt 1
> [ 2288.433568] nvme nvme0: Reconnecting in 10 seconds...
> [ 2298.651953] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
> [ 2298.665918] nvme_ns_head_submit_bio: 30 callbacks suppressed
> [ 2298.665926] block nvme0n1: no usable path - requeuing I/O
> [ 2298.676993] block nvme0n1: no usable path - requeuing I/O
> [ 2298.682393] block nvme0n1: no usable path - requeuing I/O
> [ 2298.687791] block nvme0n1: no usable path - requeuing I/O
> [ 2298.693202] block nvme0n1: no usable path - requeuing I/O
> [ 2298.698593] block nvme0n1: no usable path - requeuing I/O
> [ 2298.703988] block nvme0n1: no usable path - requeuing I/O
> [ 2298.709375] block nvme0n1: no usable path - requeuing I/O
> [ 2298.714758] block nvme0n1: no usable path - requeuing I/O
> [ 2298.720152] block nvme0n1: no usable path - requeuing I/O
> [ 2298.725691] nvme nvme0: creating 12 I/O queues.
> [ 2298.737066] nvme nvme0: mapped 12/0/0 default/read/poll queues.
> [ 2298.745612] nvme nvme0: Successfully reconnected (2 attempt)
> 
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 

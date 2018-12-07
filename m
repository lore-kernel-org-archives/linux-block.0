Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF29C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 05:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6720838
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 05:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ADKP5zYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD6720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGFwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:52:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36486 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGFwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 00:52:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so1229414pgm.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 21:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n5nzNF/2QyZMAs2rXh7Oidf6VFJjE+8AAe3L1zoY1UI=;
        b=ADKP5zYFUJerYw4Hdtf6HZSVH0Qb6Myxr7+gY29RpKKl7pzsoFQYYZ4er8TCcpcAMF
         IJO2Lhp0YnZwA+Iq4Re7z1Y5QyyGk7hb9JOZKwEjXIwZvHxguVy5AjyoN6Ha+tip0lcb
         K1WIpnVp6XJdnZVjnk6s1sl+oKndZubtwUXP/s4QatvaHpUzqByrkutXBaeA2IPfpPSy
         tnie4bd7YhxR/+wTC/B9r+PmUluL2Qk/lEmzk7zcOhNus4/gaN+VXfJRszQnco03mIiN
         a3q2Mea9GNnx/adqX3XJXazaB7e4MLbSNq6fmXuDHQ1czRJ2ct3qI2ii0eodr95nHcla
         CQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5nzNF/2QyZMAs2rXh7Oidf6VFJjE+8AAe3L1zoY1UI=;
        b=dpU7TBX5dLktEnB1o34FJ8PZZTtzxYy9PzKdBFClROiRN0vZXgSc2mJKxAfeVp8ACg
         3AVE4lR9j0AGkbJaCR7UYbu4qWUtGuIWtTMfjJGwo2KN8oTqx7h8gjCPEQRhC8CJU6Gm
         fF/Tiiuyx7g8I+MUHJ/7+DfFtCt86oEq0eiIU1jnQAh2+gUL07WOCPLYW/zXgikKn6lF
         rS5/AVet5+ZszhRW60WrZjx/gNTPUlPrxVj4F/MA6cHc1C5caro6x5W3urCV36mrEqwB
         DvWNNLmsRMMKV6jG305MAhx6OJcaxe9auHwURU9KkGqQspLf79YNTR4rGTpAoD+y8uNW
         kpyQ==
X-Gm-Message-State: AA+aEWa6fJv2u8YRHbV9HOuehCMCBf3ElERZ0VzTNEBBfcyZQuii1E6A
        9t2M24AUt02cWA1OqAWQsmKWUg==
X-Google-Smtp-Source: AFSGD/W85B48QGTC83GsVhJYUIjov+7jRns2zqJnZsfgZJtL+a2L4d+KG19a6Lw3CJDwrEzoHReGyQ==
X-Received: by 2002:a63:b218:: with SMTP id x24mr777651pge.223.1544161935921;
        Thu, 06 Dec 2018 21:52:15 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t67sm3518995pfd.90.2018.12.06.21.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 21:52:14 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: re-build queue map in case of kdump kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, David Milburn <dmilburn@redhat.com>
References: <20181207030353.27575-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd0c4c59-fd9a-aebe-5f25-aa02878f66ad@kernel.dk>
Date:   Thu, 6 Dec 2018 22:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207030353.27575-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:03 PM, Ming Lei wrote:
> Now almost all .map_queues() implementation based on managed irq
> affinity doesn't update queue mapping and it just retrieves the
> old built mapping, so if nr_hw_queues is changed, the mapping talbe
> includes stale mapping. And only blk_mq_map_queues() may rebuild
> the mapping talbe.
> 
> One case is that we limit .nr_hw_queues as 1 in case of kdump kernel.
> However, drivers often builds queue mapping before allocating tagset
> via pci_alloc_irq_vectors_affinity(), but set->nr_hw_queues can be set
> as 1 in case of kdump kernel, so wrong queue mapping is used, and
> kernel panic[1] is observed during booting.
> 
> This patch fixes the kernel panic triggerd on nvme by rebulding the
> mapping table via blk_mq_map_queues().
> 
> [1] kernel panic log
> [    4.438371] nvme nvme0: 16/0/0 default/read/poll queues
> [    4.443277] BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
> [    4.444681] PGD 0 P4D 0
> [    4.445367] Oops: 0000 [#1] SMP NOPTI
> [    4.446342] CPU: 3 PID: 201 Comm: kworker/u33:10 Not tainted 4.20.0-rc5-00664-g5eb02f7ee1eb-dirty #459
> [    4.447630] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> [    4.448689] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [    4.449368] RIP: 0010:blk_mq_map_swqueue+0xfb/0x222
> [    4.450596] Code: 04 f5 20 28 ef 81 48 89 c6 39 55 30 76 93 89 d0 48 c1 e0 04 48 03 83 f8 05 00 00 48 8b 00 42 8b 3c 28 48 8b 43 58 48 8b 04 f8 <48> 8b b8 98 00 00 00 4c 0f a3 37 72 42 f0 4c 0f ab 37 66 8b b8 f6
> [    4.453132] RSP: 0018:ffffc900023b3cd8 EFLAGS: 00010286
> [    4.454061] RAX: 0000000000000000 RBX: ffff888174448000 RCX: 0000000000000001
> [    4.456480] RDX: 0000000000000001 RSI: ffffe8feffc506c0 RDI: 0000000000000001
> [    4.458750] RBP: ffff88810722d008 R08: ffff88817647a880 R09: 0000000000000002
> [    4.464580] R10: ffffc900023b3c10 R11: 0000000000000004 R12: ffff888174448538
> [    4.467803] R13: 0000000000000004 R14: 0000000000000001 R15: 0000000000000001
> [    4.469220] FS:  0000000000000000(0000) GS:ffff88817bac0000(0000) knlGS:0000000000000000
> [    4.471554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.472464] CR2: 0000000000000098 CR3: 0000000174e4e001 CR4: 0000000000760ee0
> [    4.474264] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    4.476007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    4.477061] PKRU: 55555554
> [    4.477464] Call Trace:
> [    4.478731]  blk_mq_init_allocated_queue+0x36a/0x3ad
> [    4.479595]  blk_mq_init_queue+0x32/0x4e
> [    4.480178]  nvme_validate_ns+0x98/0x623 [nvme_core]
> [    4.480963]  ? nvme_submit_sync_cmd+0x1b/0x20 [nvme_core]
> [    4.481685]  ? nvme_identify_ctrl.isra.8+0x70/0xa0 [nvme_core]
> [    4.482601]  nvme_scan_work+0x23a/0x29b [nvme_core]
> [    4.483269]  ? _raw_spin_unlock_irqrestore+0x25/0x38
> [    4.483930]  ? try_to_wake_up+0x38d/0x3b3
> [    4.484478]  ? process_one_work+0x179/0x2fc
> [    4.485118]  process_one_work+0x1d3/0x2fc
> [    4.485655]  ? rescuer_thread+0x2ae/0x2ae
> [    4.486196]  worker_thread+0x1e9/0x2be
> [    4.486841]  kthread+0x115/0x11d
> [    4.487294]  ? kthread_park+0x76/0x76
> [    4.487784]  ret_from_fork+0x3a/0x50
> [    4.488322] Modules linked in: nvme nvme_core qemu_fw_cfg virtio_scsi ip_tables
> [    4.489428] Dumping ftrace buffer:
> [    4.489939]    (ftrace buffer empty)
> [    4.490492] CR2: 0000000000000098
> [    4.491052] ---[ end trace 03cd268ad5a86ff7 ]---

Works for me, tested various configs and stubbed out the kdump check.
Thanks for fixing this, applied to 4.21.

-- 
Jens Axboe


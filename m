Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917D5C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5662921900
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVKY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbfCVKY5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 06:24:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0CECACBA;
        Fri, 22 Mar 2019 10:24:54 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
 <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
 <17f1ef65-5fcf-0cba-4d37-a43d5e5038b0@kernel.dk>
 <64dce739-128b-1770-4062-9ba566ceda63@suse.de>
 <beaecea2-13b2-e8ef-de18-b841f4fe82de@kernel.dk>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ca5b317d-23a3-ec14-c6b5-42c33b724267@suse.de>
Date:   Fri, 22 Mar 2019 11:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <beaecea2-13b2-e8ef-de18-b841f4fe82de@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/03/2019 15:25, Jens Axboe wrote:
> On 3/21/19 8:23 AM, Johannes Thumshirn wrote:
>> On 21/03/2019 15:21, Jens Axboe wrote:
>>> On 3/21/19 8:15 AM, Jens Axboe wrote:
>>>> You also haven't solved the issue of now having an extra bit, 2/2 uses
>>>> the last bit which the other patch already took...
>>>
>>> Here's one way - kill BIO_SEG_VALID. We should just use
>>> ->bi_phys_segments to tell if it's valid or not. This patch uses -1 to
>>> signify it's not.
>>>
>>> Totally untested...
>>
>>
>> That sounds like an idea, I'll trow some testing at it and report back.
> 
> That'd be great, thanks. If we can do that as a prep patch for you, then
> you can just use an enum and not worry about initializing since I'll just
> shove BIO_PAGE_NO_REF at the end.
> 
> And this is simpler than having to shift the masks around.
> 


OK it survived xfstests on BTRFS and XFS(on zram) but blktests block/002
runs into this:

[    7.730469] WARNING: CPU: 1 PID: 283 at drivers/scsi/scsi_lib.c:1018
scsi_init_io+0x132/0x160 [scsi_mod]
[    7.732062] Modules linked in: scsi_debug(E+) scsi_mod(E) zram(E)
[    7.733094] CPU: 1 PID: 283 Comm: modprobe Tainted: G            E
  5.1.0-rc1-default+ #943
[    7.735046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[    7.737504] RIP: 0010:scsi_init_io+0x132/0x160 [scsi_mod]
[    7.738408] Code: 39 c5 7c 47 48 8b 55 00 0f b7 92 78 04 00 00 39 d0
7f 36 4c 89 a3 10 01 00 00 41 89 44 24 08 31 c0 5b 5d 41 5c 41 5d 41 5e
c3 <0f> 0b b8 0a 00 00 00 eb 98 0f 0b b8 09 00 00 00 eb 8f 0f 0b 41 be
[    7.741442] RSP: 0018:ffffb35a402eb6d8 EFLAGS: 00010246
[    7.742296] RAX: 0000000000000002 RBX: ffff8d805f4d0118 RCX:
0000000000000024
[    7.743451] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff8d805f4d0118
[    7.744637] RBP: ffff8d805f4d0000 R08: 0000000000000000 R09:
ffff8d805f4d0150
[    7.745819] R10: 0000000000000024 R11: ffffb35a402eb7b8 R12:
ffff8d805f4d0000
[    7.746977] R13: ffff8d8052fbd000 R14: ffff8d805f4d0118 R15:
ffff8d805fbe4c00
[    7.748132] FS:  00007ffa8a26e700(0000) GS:ffff8d805cb00000(0000)
knlGS:0000000000000000
[    7.749438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.750366] CR2: 00007ffa899c39b2 CR3: 00000000137d6000 CR4:
00000000000006e0
[    7.751520] Call Trace:
[    7.751940]  scsi_queue_rq+0x72a/0x9a0 [scsi_mod]
[    7.753358]  blk_mq_dispatch_rq_list+0x80/0x4b0
[    7.754100]  ? dd_dispatch_request+0x21/0x220
[    7.754815]  blk_mq_do_dispatch_sched+0x64/0xd0
[    7.755575]  blk_mq_sched_dispatch_requests+0xe9/0x160
[    7.756417]  __blk_mq_run_hw_queue+0x5f/0xf0
[    7.757108]  __blk_mq_delay_run_hw_queue+0x106/0x150
[    7.757913]  blk_mq_run_hw_queue+0x51/0x100
[    7.758595]  blk_mq_sched_insert_request+0xa2/0x130
[    7.759383]  blk_execute_rq+0x3b/0x80
[    7.759981]  __scsi_execute+0xb5/0x1e0 [scsi_mod]
[    7.760754]  scsi_probe_and_add_lun+0x270/0xd60 [scsi_mod]
[    7.761641]  ? scsi_alloc_target+0x274/0x340 [scsi_mod]
[    7.762487]  __scsi_scan_target+0xcc/0x220 [scsi_mod]
[    7.763307]  scsi_scan_channel.part.14+0x52/0x70 [scsi_mod]
[    7.764210]  scsi_scan_host_selected+0xe3/0x190 [scsi_mod]
[    7.765098]  ? __pm_runtime_resume+0x48/0x60
[    7.765807]  scsi_scan_host+0x16a/0x1b0 [scsi_mod]
[    7.766580]  sdebug_driver_probe+0x159/0x2c0 [scsi_debug]
[    7.767442]  ? driver_sysfs_add+0x71/0xd0
[    7.768101]  ? driver_allows_async_probing+0x50/0x50
[    7.768893]  really_probe+0x229/0x420
[    7.769492]  ? driver_allows_async_probing+0x50/0x50
[    7.770287]  driver_probe_device+0x115/0x130
[    7.770976]  ? driver_allows_async_probing+0x50/0x50
[    7.771770]  bus_for_each_drv+0x54/0x80
[    7.772398]  __device_attach+0xb2/0x130
[    7.773016]  bus_probe_device+0x8a/0xa0
[    7.773639]  device_add+0x496/0x670
[    7.774209]  sdebug_add_adapter+0xf1/0x1b0 [scsi_debug]
[    7.775049]  scsi_debug_init+0x6e3/0x1000 [scsi_debug]
[    7.775888]  ? 0xffffffffc011a000
[    7.776430]  do_one_initcall+0x4e/0x1d4
[    7.777048]  do_init_module+0x5a/0x21d
[    7.777652]  load_module+0x1926/0x1f00
[    7.778255]  ? m_show+0x1c0/0x1c0
[    7.778794]  __do_sys_finit_module+0x83/0xc0
[    7.779482]  do_syscall_64+0x5b/0x180
[    7.780079]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    7.780882] RIP: 0033:0x7ffa89959969
[    7.781459] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 64 2b 00 f7 d8 64 89 01 48
[    7.784402] RSP: 002b:00007ffca3d05938 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    7.785602] RAX: ffffffffffffffda RBX: 00000000010e6400 RCX:
00007ffa89959969
[    7.786740] RDX: 0000000000000000 RSI: 000000000042ac19 RDI:
0000000000000004
[    7.787858] RBP: 000000000042ac19 R08: 0000000000000000 R09:
00000000010e6310
[    7.788985] R10: 0000000000000004 R11: 0000000000000246 R12:
0000000000040000
[    7.790107] R13: 0000000000000000 R14: 00000000010e6530 R15:
0000000000000000


1013 blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
1014 {
1015         struct request *rq = cmd->request;
1016         blk_status_t ret;
1017
1018         if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
1019                 return BLK_STS_IOERR;


Looking into it now.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

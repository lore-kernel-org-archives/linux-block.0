Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66AC43460
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB9360FD9
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDACFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhDACF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 22:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617242728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FAhoIqigBZ/82IURJIPE2tNAHFV2QV0PJ7JAv7Zjaw=;
        b=HGZNZggyYfmKepFbPy6X35gd/+LhKOPk4JuN1LX7ydNR3NKIuSgUN2TQ5LTH0lH0mOfuXO
        ZUyIiU2OjWQsUAul6Q/ZNsZqCbT5BqNg2VZjrHRKaiQshFQPkRCKXTm/SbxXAvYNMKJAH4
        j8wCgICQrnTZwlfWW0VX3reR3XLc8FY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-4yI5mHtrNnCOkZwo4DmHfw-1; Wed, 31 Mar 2021 22:05:25 -0400
X-MC-Unique: 4yI5mHtrNnCOkZwo4DmHfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8648801817;
        Thu,  1 Apr 2021 02:05:24 +0000 (UTC)
Received: from [10.72.12.75] (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7A15D9CC;
        Thu,  1 Apr 2021 02:05:20 +0000 (UTC)
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <DM6PR04MB4972E4D2857500F644758516867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <11b824c1-f2d2-db35-c072-d81ef348ede7@redhat.com>
Date:   Thu, 1 Apr 2021 10:05:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB4972E4D2857500F644758516867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/1/21 9:55 AM, Chaitanya Kulkarni wrote:
> Yi,
>
> On 3/31/21 18:28, Yi Zhang wrote:
>> Hi
>> We reproduced this bfq regression[3] on ppc64le with blktests[2] on the latest linux-block/for-next branch, seems it was introduced with [1] from my bisecting, pls help check it. Let me know if you need any testing for it, thanks.
>>
>> [1]
>> commit 430a67f9d6169a7b3e328bceb2ef9542e4153c7c (HEAD, refs/bisect/bad)
>> Author: Paolo Valente <paolo.valente@linaro.org>
>> Date:   Thu Mar 4 18:46:27 2021 +0100
>>
>>      block, bfq: merge bursts of newly-created queues
>>
>> [2] blktests: nvme_trtype=tcp ./check nvme/011
>>
>>
> + linux-nvme
>
> Please add linux-nvme mailing list from next time for blktests
> nvmecategory to
> get better response.
>
Thanks for reminder, here is another log from x86_64:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/03/31/627938/build_x86_64_redhat%3A1135726/tests/9788884_x86_64_2_console.log

[18786.566141] run blktests nvme/011 at 2021-03-31 05:14:49
[18786.628130] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[18786.665543] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[18786.699230] nvmet: creating controller 1 for subsystem 
blktests-subsystem-1 for NQN 
nqn.2014-08.org.nvmexpress:uuid:efb6b8a520d74d6c8193b4cdfcf4ed27.
[18786.768196] nvme nvme0: creating 32 I/O queues.
[18786.794890] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[18786.838099] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 
127.0.0.1:4420
[-- MARK -- Wed Mar 31 09:15:00 2021]
[18805.461676] ------------[ cut here ]------------
[18805.486313] kernel BUG at mm/slub.c:314!
[18805.506044] invalid opcode: 0000 [#1] SMP PTI
[18805.528104] CPU: 31 PID: 322 Comm: kworker/31:1H Tainted: G          
I       5.12.0-rc5 #1
[18805.570307] Hardware name: HP ProLiant DL380e Gen8, BIOS P73 08/20/2012
[18805.604735] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[18805.635671] RIP: 0010:kmem_cache_free+0x40d/0x440
[18805.660905] Code: 00 00 00 e9 1c ff ff ff 4c 8b 0c 24 48 8b 4c 24 08 
48 89 da 48 89 ee 41 b8 01 00 00 00 4c 89 f7 e8 98 c5 ff ff e9 c0 fd ff 
ff <0f> 0b 48 c7 c6 78 c4 3c 90 4c 89 ff e8 a2 68 fa ff 0f 0b 48 8b 05
[18805.755735] RSP: 0018:ffffae10023eba68 EFLAGS: 00010046
[18805.783155] RAX: ffff909991c4e760 RBX: ffff909991c4e760 RCX: 
ffff909991c4e878
[18805.819016] RDX: 00000000000008c4 RSI: 0000000000000000 RDI: 
ffff909991c4e760
[18805.855858] RBP: fffff7dd49471300 R08: ffff90998688ba48 R09: 
ffffae10023ebabb
[18805.891750] R10: ffff909991c4e760 R11: 0000000000001000 R12: 
ffff909991c4e760
[18805.930721] R13: 0000000000000000 R14: ffff909844eb9300 R15: 
fffff7dd49471300
[18805.969903] FS:  0000000000000000(0000) GS:ffff909b777c0000(0000) 
knlGS:0000000000000000
[18806.011278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18806.041018] CR2: 000055883d2eb018 CR3: 0000000255b7c001 CR4: 
00000000000606e0
[18806.077143] Call Trace:
[18806.090748]  ? bfq_put_queue+0x156/0x280
[18806.110302]  bfq_put_queue+0x156/0x280
[18806.129147]  bfq_insert_requests+0x182/0x1610
[18806.153478]  ? iomap_apply+0xf1/0x2b0
[18806.171562]  blk_mq_sched_insert_requests+0x5d/0xe0
[18806.195976]  blk_mq_flush_plug_list+0xf0/0x170
[18806.219609]  blk_finish_plug+0x36/0x50
[18806.238186]  __iomap_dio_rw+0x3ff/0x4c0
[18806.257607]  iomap_dio_rw+0xa/0x30
[18806.275661]  xfs_file_dio_write_aligned+0x86/0x110 [xfs]
[18806.302402]  ? xfs_file_buffered_write+0x280/0x280 [xfs]
[18806.329803]  xfs_file_write_iter+0xc8/0x110 [xfs]
[18806.354426]  nvmet_file_submit_bvec+0xc3/0x100 [nvmet]
[18806.380201]  nvmet_file_execute_io+0x1f8/0x240 [nvmet]
[18806.407312]  nvmet_tcp_io_work+0xbd3/0xc15 [nvmet_tcp]
[18806.434505]  ? switch_mm_irqs_off+0x58/0x430
[18806.456485]  ? __switch_to_asm+0x42/0x70
[18806.476908]  ? __switch_to+0x7b/0x450
[18806.494909]  process_one_work+0x1ec/0x380
[18806.516534]  worker_thread+0x53/0x3e0
[18806.535986]  ? process_one_work+0x380/0x380
[18806.556696]  kthread+0x11b/0x140
[18806.573191]  ? __kthread_bind_mask+0x60/0x60
[18806.596048]  ret_from_fork+0x22/0x30
[18806.613788] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp nvmet 
nvme nvme_core md4 cmac nls_utf8 cifs libarc4 libdes loop 
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache nfsd auth_rpcgss nfs_acl 
lockd grace nfs_ssc dm_log_writes dm_flakey rfkill sunrpc iTCO_wdt 
intel_rapl_msr intel_pmc_bxt iTCO_vendor_support intel_rapl_common 
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm 
irqbypass rapl intel_cstate intel_uncore pcspkr ipmi_ssif lpc_ich 
acpi_ipmi hpilo ipmi_si hpwdt ipmi_devintf ioatdma igb ipmi_msghandler 
acpi_power_meter dca fuse zram ip_tables xfs crct10dif_pclmul 
crc32_pclmul mgag200 crc32c_intel drm_kms_helper ghash_clmulni_intel cec 
serio_raw drm i2c_algo_bit [last unloaded: nvmet]
[18806.937291] ---[ end trace e1409caee7927af8 ]---
>
>


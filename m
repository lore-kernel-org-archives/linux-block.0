Return-Path: <SRS0=5nn9=DR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51FC433DF
	for <linux-block@archiver.kernel.org>; Sat, 10 Oct 2020 06:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A8A20731
	for <linux-block@archiver.kernel.org>; Sat, 10 Oct 2020 06:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHvKFqPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJJGIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Oct 2020 02:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgJJGIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Oct 2020 02:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602310127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lCjwDSk1P9+fcHZpndTzgRCiVFoyIUf+RDCNbMBmKY=;
        b=LHvKFqPmJfxSUwBL2xNLW5GufUVixw7SrDFTqhz27Vil10f81yIUoUD5uTjYvPUa0Y3Jon
        8FODHzsXMrI8uKUDb3YqQkv+/1FqxOMSlKEnx1KZ5DOdE5TO0LKNvhmYxbGNNvXmlZzY9N
        1h2AIZoyiEq++ARLCHvHeemlFdCdmdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-xEaTkORNPjmQR14kWwlojA-1; Sat, 10 Oct 2020 02:08:43 -0400
X-MC-Unique: xEaTkORNPjmQR14kWwlojA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4951005513;
        Sat, 10 Oct 2020 06:08:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A66FD7665A;
        Sat, 10 Oct 2020 06:08:35 +0000 (UTC)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
Date:   Sat, 10 Oct 2020 14:08:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/10/20 2:29 AM, Sagi Grimberg wrote:
>
>
> On 10/9/20 6:55 AM, Yi Zhang wrote:
>> Hi Sagi
>>
>> On 10/9/20 4:09 PM, Sagi Grimberg wrote:
>>>> Hi Sagi
>>>>
>>>> I applied this patch on block origin/for-next and still can 
>>>> reproduce it.
>>>
>>> That's unexpected, can you try this patch?
>>> -- 
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 629b025685d1..46428ff0b0fc 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct 
>>> request *rq)
>>>         /* fence other contexts that may complete the command */
>>>         mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>         nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>> -       if (!blk_mq_request_completed(rq)) {
>>> +       if (blk_mq_request_started(rq) && 
>>> !blk_mq_request_completed(rq)) {
>>>                 nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>>>                 blk_mq_complete_request_sync(rq);
>>>         }
>> No WARNING with this patch, but the test still will be hang and never 
>> finished, here is the kernel log:
>
> Thanks Yi,
>
> Good to know no warning, that confirms the issue analysis.
>
Cool, feel fee to add Tested-by: Yi Zhang <yi.zhang@redhat.com>

> As for the test, I'm able to successfuly pass this on my VM, and
> this test is not designed to generate errors, just fio to
> a file backed namespace. I'm wandering what is causing these
> delays in I/O that cause timeouts...
>
I just found all the failure occurred on AMD with 4G memory, not sure 
whether it's related to the low memory.
Let me know if you need any test for further investigation . :)
>>
>> [ 3327.011067] run blktests nvme/012 at 2020-10-09 06:21:59
>> [ 3327.278169] loop: module loaded
>> [ 3327.314287] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [ 3327.346276] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [ 3327.396746] nvmet: creating controller 1 for subsystem 
>> blktests-subsystem-1 for NQN 
>> nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>> [ 3327.411000] nvme nvme0: creating 12 I/O queues.
>> [ 3327.416963] nvme nvme0: mapped 12/0/0 default/read/poll queues.
>> [ 3327.428836] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 
>> 127.0.0.1:4420
>> [ 3329.403658] XFS (nvme0n1): Mounting V5 Filesystem
>> [ 3329.417213] XFS (nvme0n1): Ending clean mount
>> [ 3329.423044] xfs filesystem being mounted at /mnt/blktests supports 
>> timestamps until 2038 (0x7fffffff)
>> [ 3390.069126] nvme nvme0: queue 6: timeout request 0x21 type 4
>> [ 3390.074797] nvme nvme0: starting error recovery
>> [ 3390.079362] nvme nvme0: queue 6: timeout request 0x22 type 4
>> [ 3390.079932] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.081999] nvme nvme0: Reconnecting in 10 seconds...
>> [ 3390.095467] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.100879] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.106279] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.111691] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.117098] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.122507] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.127920] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.133333] block nvme0n1: no usable path - requeuing I/O
>> [ 3390.138734] block nvme0n1: no usable path - requeuing I/O
>> [ 3415.669659] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
>> [ 3415.675682] nvmet: ctrl 2 fatal error occurred!
>> [ 3419.765738] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
>> [ 3419.771762] nvmet: ctrl 1 fatal error occurred!
>> [ 3440.000352] nvmet: creating controller 2 for subsystem 
>> blktests-subsystem-1 for NQN 
>> nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>> [ 3463.286700] nvme nvme0: queue 0: timeout request 0x0 type 4
>> [ 3463.292357] nvme nvme0: Connect command failed, error wo/DNR bit: 881
>> [ 3463.298830] nvme nvme0: failed to connect queue: 0 ret=881
>> [ 3463.304352] nvme nvme0: Failed reconnect attempt 1
>> [ 3463.309156] nvme nvme0: Reconnecting in 10 seconds...
>> [ 3473.527574] nvmet: creating controller 1 for subsystem 
>> blktests-subsystem-1 for NQN 
>> nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>> [ 3473.541438] nvme_ns_head_submit_bio: 47 callbacks suppressed
>> [ 3473.541445] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.552521] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.557923] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.563319] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.568739] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.574678] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.580068] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.585461] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.590861] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.596249] block nvme0n1: no usable path - requeuing I/O
>> [ 3473.601880] nvme nvme0: creating 12 I/O queues.
>> [ 3473.613955] nvme nvme0: mapped 12/0/0 default/read/poll queues.
>> [ 3473.622106] nvme nvme0: Successfully reconnected (2 attempt)
>> [ 3531.384170] nvme nvme0: queue 1: timeout request 0x62 type 4
>> [ 3531.389837] nvme nvme0: starting error recovery
>> [ 3531.394396] nvme nvme0: queue 7: timeout request 0x61 type 4
>> [ 3531.394954] nvme_ns_head_submit_bio: 14 callbacks suppressed
>> [ 3531.394964] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.411147] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.416548] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.421954] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.427361] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.432763] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.438287] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.443701] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.449103] block nvme0n1: no usable path - requeuing I/O
>> [ 3531.454497] block nvme0n1: no usable path - requeuing I/O
>> [ 3560.568832] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
>> [ 3560.574839] nvmet: ctrl 1 fatal error occurred!
>>
>>
>>> -- 
>>>
>>>>
>>>> [  724.267865] run blktests nvme/012 at 2020-10-09 00:48:52
>>>> [  724.518498] loop: module loaded
>>>> [  724.552880] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>> [  724.586609] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>> [  724.648898] nvmet: creating controller 1 for subsystem 
>>>> blktests-subsystem-1 for NQN 
>>>> nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>>>> [  724.663300] nvme nvme0: creating 12 I/O queues.
>>>> [  724.669826] nvme nvme0: mapped 12/0/0 default/read/poll queues.
>>>> [  724.681350] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", 
>>>> addr 127.0.0.1:4420
>>>> [  726.641605] XFS (nvme0n1): Mounting V5 Filesystem
>>>> [  726.654637] XFS (nvme0n1): Ending clean mount
>>>> [  726.660302] xfs filesystem being mounted at /mnt/blktests 
>>>> supports timestamps until 2038 (0x7fffffff)
>>>> [  787.042066] nvme nvme0: queue 2: timeout request 0xe type 4
>>>> [  787.047649] nvme nvme0: starting error recovery
>>>> [  787.052211] nvme nvme0: queue 4: timeout request 0x61 type 4
>>>> [  787.053407] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.054543] nvme nvme0: Reconnecting in 10 seconds...
>>>> [  787.057877] ------------[ cut here ]------------
>>>> [  787.063274] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.068313] refcount_t: underflow; use-after-free.
>>>> [  787.068370] WARNING: CPU: 3 PID: 30 at lib/refcount.c:28 
>>>> refcount_warn_saturate+0xa6/0xf0
>>>> [  787.072941] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.072945] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.078333] Modules linked in: loop nvme_tcp nvme_fabrics 
>>>> nvme_core nvmet_tcp nvmet rpcsec_gss_krb5 auth_rpcgss nfsv4 
>>>> dns_resolver nfs lockd grace fscache sunrpc snd_hda_codec_realtek 
>>>> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg 
>>>> snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer 
>>>> amd64_edac_mod snd edac_mce_amd soundcore kvm_amd ccp kvm pcspkr 
>>>> irqbypass hp_wmi sparse_keymap rfkill k10temp wmi_bmof nv_tco 
>>>> i2c_nforce2 acpi_cpufreq ip_tables xfs nouveau video mxm_wmi 
>>>> i2c_algo_bit drm_kms_helper mptsas cec scsi_transport_sas ttm 
>>>> mptscsih ata_generic firewire_ohci pata_acpi firewire_core drm 
>>>> serio_raw mptbase forcedeth crc_itu_t sata_nv pata_amd wmi floppy
>>>> [  787.083142] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.091304] CPU: 3 PID: 30 Comm: kworker/3:0H Not tainted 
>>>> 5.9.0-rc8.update+ #3
>>>> [  787.096673] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.096674] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.096680] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.096681] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.096683] block nvme0n1: no usable path - requeuing I/O
>>>> [  787.201242] Hardware name: Hewlett-Packard HP xw9400 
>>>> Workstation/0A1Ch, BIOS 786D6 v04.02 04/21/2009
>>>> [  787.210366] Workqueue: kblockd blk_mq_timeout_work
>>>> [  787.215161] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
>>>> [  787.220295] Code: 05 aa 98 22 01 01 e8 9f cf ad ff 0f 0b c3 80 
>>>> 3d 98 98 22 01 00 75 95 48 c7 c7 48 54 3e a2 c6 05 88 98 22 01 01 
>>>> e8 80 cf ad ff <0f> 0b c3 80 3d 77 98 22 01 00 0f 85 72 ff ff ff 48 
>>>> c7 c7 a0 54 3e
>>>> [  787.239021] RSP: 0018:ffffb860407b3dc8 EFLAGS: 00010292
>>>> [  787.244240] RAX: 0000000000000026 RBX: 0000000000000000 RCX: 
>>>> ffff9d93ddc58d08
>>>> [  787.251361] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: 
>>>> ffff9d93ddc58d00
>>>> [  787.258480] RBP: ffff9d93dbd6c200 R08: 000000b740ed60e8 R09: 
>>>> ffffffffa2fffbc4
>>>> [  787.265612] R10: 0000000000000477 R11: 0000000000028320 R12: 
>>>> ffff9d93dbd6c2e8
>>>> [  787.272741] R13: ffff9d93dbea0000 R14: ffffb860407b3e70 R15: 
>>>> ffff9d93dbea0000
>>>> [  787.279864] FS:  0000000000000000(0000) 
>>>> GS:ffff9d93ddc40000(0000) knlGS:0000000000000000
>>>> [  787.287948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  787.293695] CR2: 00007f45fd8fa024 CR3: 00000000792dc000 CR4: 
>>>> 00000000000006e0
>>>> [  787.300820] Call Trace:
>>>> [  787.303277]  blk_mq_check_expired+0x109/0x1b0
>>>> [  787.307638]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
>>>> [  787.312524]  ? blk_poll+0x300/0x300
>>>> [  787.316022]  blk_mq_timeout_work+0x44/0xe0
>>>> [  787.320128]  process_one_work+0x1b4/0x370
>>>> [  787.324137]  worker_thread+0x53/0x3e0
>>>> [  787.327809]  ? process_one_work+0x370/0x370
>>>> [  787.332015]  kthread+0x11b/0x140
>>>> [  787.335245]  ? __kthread_bind_mask+0x60/0x60
>>>> [  787.339515]  ret_from_fork+0x22/0x30
>>>> [  787.343094] ---[ end trace 606cf9189379fcfc ]---
>>>>
>>>>
>>>> Best Regards,
>>>>    Yi Zhang
>>>>
>>>>
>>>> ----- Original Message -----
>>>> From: "Ming Lei" <ming.lei@redhat.com>
>>>> To: "Sagi Grimberg" <sagi@grimberg.me>
>>>> Cc: "Jens Axboe" <axboe@kernel.dk>, "Yi Zhang" 
>>>> <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org, 
>>>> linux-block@vger.kernel.org, "Keith Busch" <kbusch@kernel.org>, 
>>>> "Christoph Hellwig" <hch@lst.de>
>>>> Sent: Friday, October 9, 2020 12:39:38 PM
>>>> Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
>>>>
>>>> On Thu, Oct 08, 2020 at 02:37:50PM -0700, Sagi Grimberg wrote:
>>>>> In nvme-tcp and nvme-rdma, the timeout handler in certain conditions
>>>>> needs to complete an aborted request. The timeout handler serializes
>>>>> against an error recovery sequence that iterates over the inflight
>>>>> requests and cancels them.
>>>>>
>>>>> However, the fact that blk_mq_complete_request may defer to a 
>>>>> different
>>>>> core that serialization breaks.
>>>>>
>>>>> Hence re-introduce blk_mq_complete_request_sync and use that in the
>>>>> timeout handler to make sure that we don't get a use-after-free
>>>>> condition.
>>>>>
>>>>> This was uncovered by the blktests:
>>>>> -- 
>>>>> $ nvme_trtype=tcp ./check nvme/012
>>>>>
>>>>> [ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
>>>>> [ 2152.799640] loop: module loaded
>>>>> [ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>> [ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>> [ 2152.937889] nvmet: creating controller 1 for subsystem 
>>>>> blktests-subsystem-1 for NQN 
>>>>> nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>>>>> [ 2152.952085] nvme nvme0: creating 12 I/O queues.
>>>>> [ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
>>>>> [ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", 
>>>>> addr 127.0.0.1:4420
>>>>> [ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
>>>>> [ 2154.942432] XFS (nvme0n1): Ending clean mount
>>>>> [ 2154.948183] xfs filesystem being mounted at /mnt/blktests 
>>>>> supports timestamps until 2038 (0x7fffffff)
>>>>> [ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
>>>>> [ 2215.199331] nvme nvme0: starting error recovery
>>>>> [ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
>>>>> [ 2215.204483] block nvme0n1: no usable path - requeuing I/O
>>>>> [ 2215.214976] block nvme0n1: no usable path - requeuing I/O
>>>>> [ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
>>>>> [ 2215.215502] ------------[ cut here ]------------
>>>>> [ 2215.215505] refcount_t: underflow; use-after-free.
>>>>> [ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 
>>>>> refcount_warn_saturate+0xa6/0xf0
>>>>> [ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
>>>>> [ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: 
>>>>> ffff93f37dcd8d08
>>>>> [ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: 
>>>>> ffff93f37dcd8d00
>>>>> [ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: 
>>>>> ffffffffa7fffbc4
>>>>> [ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: 
>>>>> ffff93f37a8124e8
>>>>> [ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: 
>>>>> ffff93f37a2b0000
>>>>> [ 2215.215765] FS:  0000000000000000(0000) 
>>>>> GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
>>>>> [ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 
>>>>> 00000000000006e0
>>>>> [ 2215.215773] Call Trace:
>>>>> [ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
>>>>> [ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
>>>>> [ 2215.215801]  ? blk_poll+0x300/0x300
>>>>> [ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
>>>>> [ 2215.215814]  process_one_work+0x1b4/0x370
>>>>> [ 2215.215820]  worker_thread+0x53/0x3e0
>>>>> [ 2215.215825]  ? process_one_work+0x370/0x370
>>>>> [ 2215.215829]  kthread+0x11b/0x140
>>>>> [ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
>>>>> [ 2215.215841]  ret_from_fork+0x22/0x30
>>>>> [ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
>>>>> -- 
>>>>>
>>>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>>>> Fixes: 236187c4ed19 ("nvme-tcp: fix timeout handler")
>>>>> Fixes: 0475a8dcbcee ("nvme-rdma: fix timeout handler")
>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>> ---
>>>>> Yi, would appreciate your Tested-by tag
>>>>>
>>>>>   block/blk-mq.c           | 7 +++++++
>>>>>   drivers/nvme/host/rdma.c | 2 +-
>>>>>   drivers/nvme/host/tcp.c  | 2 +-
>>>>>   include/linux/blk-mq.h   | 1 +
>>>>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index f8e1e759c905..2d154722ef39 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -729,6 +729,13 @@ bool blk_mq_complete_request_remote(struct 
>>>>> request *rq)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
>>>>>   +void blk_mq_complete_request_sync(struct request *rq)
>>>>> +{
>>>>> +    WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>>>>> +    rq->q->mq_ops->complete(rq);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
>>>>> +
>>>>>   /**
>>>>>    * blk_mq_complete_request - end I/O on a request
>>>>>    * @rq:        the request being processed
>>>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>>>> index 9e378d0a0c01..45fc605349da 100644
>>>>> --- a/drivers/nvme/host/rdma.c
>>>>> +++ b/drivers/nvme/host/rdma.c
>>>>> @@ -1975,7 +1975,7 @@ static void 
>>>>> nvme_rdma_complete_timed_out(struct request *rq)
>>>>>       nvme_rdma_stop_queue(queue);
>>>>>       if (!blk_mq_request_completed(rq)) {
>>>>>           nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>>>>> -        blk_mq_complete_request(rq);
>>>>> +        blk_mq_complete_request_sync(rq);
>>>>>       }
>>>>>       mutex_unlock(&ctrl->teardown_lock);
>>>>>   }
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index 8f4f29f18b8c..629b025685d1 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -2177,7 +2177,7 @@ static void 
>>>>> nvme_tcp_complete_timed_out(struct request *rq)
>>>>>       nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>>>>       if (!blk_mq_request_completed(rq)) {
>>>>>           nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>>>>> -        blk_mq_complete_request(rq);
>>>>> +        blk_mq_complete_request_sync(rq);
>>>>
>>>> Or complete the request in the following way? Then one block layer API
>>>> can be saved:
>>>>
>>>>     blk_mq_complete_request_remote(rq);
>>>>     nvme_complete_rq(rq);
>>>>
>>>>
>>>> thanks,
>>>> Ming
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>>>
>>>
>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


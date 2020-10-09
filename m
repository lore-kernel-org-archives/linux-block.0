Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D11C433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC7122227
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgJIIJV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 04:09:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbgJIIJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 04:09:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id u24so6589887pgi.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 01:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRNshmp99wOst7DVAEz4V3og+DEzXVLX33i9Vg5313A=;
        b=HU6KTIRyGwbmvr7bo2Vf+4drUJjcqa71FgBmsjsr9BOU9626/i5BcVbf5K1azmMcLJ
         cOtvRGY+dtoX7Y5N+aqukRMe6XBelpTJKyBY0pd5p0MevAZQShKTBX1QmmGEzOGkcT9s
         zrpx1+vr+D0gjHdY+Ya5ebO38awDXai4N7FO2/AALsr0DNXZp18Z7fsktYfbK4NzlI5g
         my/6QwGBG/evL59eusYAp7E3LgJC67pKhrlyG/qsWlpfMEqPap+PB3gpjARl91rC7J9/
         8FSvh30aD2kzc+icmPE/mj0AQyy7pVuwSu8L4A2mXrUOTenoVN8IIPvcJjkP/usCTKD+
         jTtQ==
X-Gm-Message-State: AOAM533OTtN4+Q/n551ca7h7k+V8L9Y44WC2r3AP3FMOptul3vx4hxDN
        rHjFN5yGG711woVpOUGHSIc=
X-Google-Smtp-Source: ABdhPJzPD2wZ4tiZZ/0c5qEMFY26IzrVSUO/zv4aHdnSPzoD4/Nlomb/wV92JhQwQYU9PzZ7LEiiMg==
X-Received: by 2002:a62:1c96:0:b029:142:4bf7:15f3 with SMTP id c144-20020a621c960000b02901424bf715f3mr11073485pfc.75.1602230958813;
        Fri, 09 Oct 2020 01:09:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e430:c9cb:46e0:d242? ([2601:647:4802:9070:e430:c9cb:46e0:d242])
        by smtp.gmail.com with ESMTPSA id o23sm10382236pjw.32.2020.10.09.01.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 01:09:17 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
Date:   Fri, 9 Oct 2020 01:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hi Sagi
> 
> I applied this patch on block origin/for-next and still can reproduce it.

That's unexpected, can you try this patch?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 629b025685d1..46428ff0b0fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct 
request *rq)
         /* fence other contexts that may complete the command */
         mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
         nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-       if (!blk_mq_request_completed(rq)) {
+       if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
                 nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
                 blk_mq_complete_request_sync(rq);
         }
--

> 
> [  724.267865] run blktests nvme/012 at 2020-10-09 00:48:52
> [  724.518498] loop: module loaded
> [  724.552880] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  724.586609] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  724.648898] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
> [  724.663300] nvme nvme0: creating 12 I/O queues.
> [  724.669826] nvme nvme0: mapped 12/0/0 default/read/poll queues.
> [  724.681350] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
> [  726.641605] XFS (nvme0n1): Mounting V5 Filesystem
> [  726.654637] XFS (nvme0n1): Ending clean mount
> [  726.660302] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
> [  787.042066] nvme nvme0: queue 2: timeout request 0xe type 4
> [  787.047649] nvme nvme0: starting error recovery
> [  787.052211] nvme nvme0: queue 4: timeout request 0x61 type 4
> [  787.053407] block nvme0n1: no usable path - requeuing I/O
> [  787.054543] nvme nvme0: Reconnecting in 10 seconds...
> [  787.057877] ------------[ cut here ]------------
> [  787.063274] block nvme0n1: no usable path - requeuing I/O
> [  787.068313] refcount_t: underflow; use-after-free.
> [  787.068370] WARNING: CPU: 3 PID: 30 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> [  787.072941] block nvme0n1: no usable path - requeuing I/O
> [  787.072945] block nvme0n1: no usable path - requeuing I/O
> [  787.078333] Modules linked in: loop nvme_tcp nvme_fabrics nvme_core nvmet_tcp nvmet rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer amd64_edac_mod snd edac_mce_amd soundcore kvm_amd ccp kvm pcspkr irqbypass hp_wmi sparse_keymap rfkill k10temp wmi_bmof nv_tco i2c_nforce2 acpi_cpufreq ip_tables xfs nouveau video mxm_wmi i2c_algo_bit drm_kms_helper mptsas cec scsi_transport_sas ttm mptscsih ata_generic firewire_ohci pata_acpi firewire_core drm serio_raw mptbase forcedeth crc_itu_t sata_nv pata_amd wmi floppy
> [  787.083142] block nvme0n1: no usable path - requeuing I/O
> [  787.091304] CPU: 3 PID: 30 Comm: kworker/3:0H Not tainted 5.9.0-rc8.update+ #3
> [  787.096673] block nvme0n1: no usable path - requeuing I/O
> [  787.096674] block nvme0n1: no usable path - requeuing I/O
> [  787.096680] block nvme0n1: no usable path - requeuing I/O
> [  787.096681] block nvme0n1: no usable path - requeuing I/O
> [  787.096683] block nvme0n1: no usable path - requeuing I/O
> [  787.201242] Hardware name: Hewlett-Packard HP xw9400 Workstation/0A1Ch, BIOS 786D6 v04.02 04/21/2009
> [  787.210366] Workqueue: kblockd blk_mq_timeout_work
> [  787.215161] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
> [  787.220295] Code: 05 aa 98 22 01 01 e8 9f cf ad ff 0f 0b c3 80 3d 98 98 22 01 00 75 95 48 c7 c7 48 54 3e a2 c6 05 88 98 22 01 01 e8 80 cf ad ff <0f> 0b c3 80 3d 77 98 22 01 00 0f 85 72 ff ff ff 48 c7 c7 a0 54 3e
> [  787.239021] RSP: 0018:ffffb860407b3dc8 EFLAGS: 00010292
> [  787.244240] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff9d93ddc58d08
> [  787.251361] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d93ddc58d00
> [  787.258480] RBP: ffff9d93dbd6c200 R08: 000000b740ed60e8 R09: ffffffffa2fffbc4
> [  787.265612] R10: 0000000000000477 R11: 0000000000028320 R12: ffff9d93dbd6c2e8
> [  787.272741] R13: ffff9d93dbea0000 R14: ffffb860407b3e70 R15: ffff9d93dbea0000
> [  787.279864] FS:  0000000000000000(0000) GS:ffff9d93ddc40000(0000) knlGS:0000000000000000
> [  787.287948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  787.293695] CR2: 00007f45fd8fa024 CR3: 00000000792dc000 CR4: 00000000000006e0
> [  787.300820] Call Trace:
> [  787.303277]  blk_mq_check_expired+0x109/0x1b0
> [  787.307638]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
> [  787.312524]  ? blk_poll+0x300/0x300
> [  787.316022]  blk_mq_timeout_work+0x44/0xe0
> [  787.320128]  process_one_work+0x1b4/0x370
> [  787.324137]  worker_thread+0x53/0x3e0
> [  787.327809]  ? process_one_work+0x370/0x370
> [  787.332015]  kthread+0x11b/0x140
> [  787.335245]  ? __kthread_bind_mask+0x60/0x60
> [  787.339515]  ret_from_fork+0x22/0x30
> [  787.343094] ---[ end trace 606cf9189379fcfc ]---
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 
> ----- Original Message -----
> From: "Ming Lei" <ming.lei@redhat.com>
> To: "Sagi Grimberg" <sagi@grimberg.me>
> Cc: "Jens Axboe" <axboe@kernel.dk>, "Yi Zhang" <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
> Sent: Friday, October 9, 2020 12:39:38 PM
> Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
> 
> On Thu, Oct 08, 2020 at 02:37:50PM -0700, Sagi Grimberg wrote:
>> In nvme-tcp and nvme-rdma, the timeout handler in certain conditions
>> needs to complete an aborted request. The timeout handler serializes
>> against an error recovery sequence that iterates over the inflight
>> requests and cancels them.
>>
>> However, the fact that blk_mq_complete_request may defer to a different
>> core that serialization breaks.
>>
>> Hence re-introduce blk_mq_complete_request_sync and use that in the
>> timeout handler to make sure that we don't get a use-after-free
>> condition.
>>
>> This was uncovered by the blktests:
>> --
>> $ nvme_trtype=tcp ./check nvme/012
>>
>> [ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
>> [ 2152.799640] loop: module loaded
>> [ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
>> [ 2152.952085] nvme nvme0: creating 12 I/O queues.
>> [ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
>> [ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
>> [ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
>> [ 2154.942432] XFS (nvme0n1): Ending clean mount
>> [ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
>> [ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
>> [ 2215.199331] nvme nvme0: starting error recovery
>> [ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
>> [ 2215.204483] block nvme0n1: no usable path - requeuing I/O
>> [ 2215.214976] block nvme0n1: no usable path - requeuing I/O
>> [ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
>> [ 2215.215502] ------------[ cut here ]------------
>> [ 2215.215505] refcount_t: underflow; use-after-free.
>> [ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
>> [ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
>> [ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
>> [ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
>> [ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
>> [ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
>> [ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
>> [ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
>> [ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
>> [ 2215.215773] Call Trace:
>> [ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
>> [ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
>> [ 2215.215801]  ? blk_poll+0x300/0x300
>> [ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
>> [ 2215.215814]  process_one_work+0x1b4/0x370
>> [ 2215.215820]  worker_thread+0x53/0x3e0
>> [ 2215.215825]  ? process_one_work+0x370/0x370
>> [ 2215.215829]  kthread+0x11b/0x140
>> [ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
>> [ 2215.215841]  ret_from_fork+0x22/0x30
>> [ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
>> --
>>
>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>> Fixes: 236187c4ed19 ("nvme-tcp: fix timeout handler")
>> Fixes: 0475a8dcbcee ("nvme-rdma: fix timeout handler")
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Yi, would appreciate your Tested-by tag
>>
>>   block/blk-mq.c           | 7 +++++++
>>   drivers/nvme/host/rdma.c | 2 +-
>>   drivers/nvme/host/tcp.c  | 2 +-
>>   include/linux/blk-mq.h   | 1 +
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index f8e1e759c905..2d154722ef39 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -729,6 +729,13 @@ bool blk_mq_complete_request_remote(struct request *rq)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
>>   
>> +void blk_mq_complete_request_sync(struct request *rq)
>> +{
>> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>> +	rq->q->mq_ops->complete(rq);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
>> +
>>   /**
>>    * blk_mq_complete_request - end I/O on a request
>>    * @rq:		the request being processed
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 9e378d0a0c01..45fc605349da 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1975,7 +1975,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
>>   	nvme_rdma_stop_queue(queue);
>>   	if (!blk_mq_request_completed(rq)) {
>>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>> -		blk_mq_complete_request(rq);
>> +		blk_mq_complete_request_sync(rq);
>>   	}
>>   	mutex_unlock(&ctrl->teardown_lock);
>>   }
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 8f4f29f18b8c..629b025685d1 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>   	if (!blk_mq_request_completed(rq)) {
>>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>> -		blk_mq_complete_request(rq);
>> +		blk_mq_complete_request_sync(rq);
> 
> Or complete the request in the following way? Then one block layer API
> can be saved:
> 
> 	blk_mq_complete_request_remote(rq);
> 	nvme_complete_rq(rq);
> 
> 
> thanks,
> Ming
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

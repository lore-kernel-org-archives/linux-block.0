Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE229C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CA0611CC
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353390AbhDGPP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232221AbhDGPP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 11:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617808516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viyfCZI+lo0LCEnPQkp+XBR+RbGzEk6fDVCxdTNBSDA=;
        b=VRVlv8uB0AUnb0xhPd5Xn+9b6q02FGTO9JvupSz6Uyh25ZghX4Z/ozUJizvMVMcPIH1CMo
        0EVLw1q00WWd0eI8CfrEX912Gy5WUJAoCt///N4j8zwfteINMoHeSTLRb8Rnp27FOUJwx2
        mqxp03sYLlosp0uH+OJEYxVEMuVuYN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-a4J_c-7CNv6gatn8VE2vYg-1; Wed, 07 Apr 2021 11:15:12 -0400
X-MC-Unique: a4J_c-7CNv6gatn8VE2vYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF296D582;
        Wed,  7 Apr 2021 15:15:11 +0000 (UTC)
Received: from [10.72.12.82] (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5795B2BFE7;
        Wed,  7 Apr 2021 15:15:10 +0000 (UTC)
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <c7d23258-0890-f79f-cc6a-9cb24bbaa437@redhat.com>
Date:   Wed, 7 Apr 2021 23:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/2/21 9:39 PM, Paolo Valente wrote:
>
>> Il giorno 1 apr 2021, alle ore 03:27, Yi Zhang <yi.zhang@redhat.com> ha scritto:
>>
>> Hi
> Hi
>
>> We reproduced this bfq regression[3] on ppc64le with blktests[2] on the latest linux-block/for-next branch, seems it was introduced with [1] from my bisecting, pls help check it. Let me know if you need any testing for it, thanks.
>>
> Thanks for reporting this bug and finding the candidate offending commit. Could you try this test with my dev kernel, which might provide more information? The kernel is here:
> https://github.com/Algodev-github/bfq-mq
>
> Alternatively, I could try to provide you with patches to instrument your kernel.
HI Paolo
I tried your dev kernel, but with no luck to reproduce it, could you 
provide the debug patch based on latest linux-block/for-next?

> The first option may be quicker.
>
> In both cases, having KASAN active could be rather helpful too.
>
> Looking forward to your feedback,
> Paolo
>
>> [1]
>> commit 430a67f9d6169a7b3e328bceb2ef9542e4153c7c (HEAD, refs/bisect/bad)
>> Author: Paolo Valente <paolo.valente@linaro.org>
>> Date:   Thu Mar 4 18:46:27 2021 +0100
>>
>>     block, bfq: merge bursts of newly-created queues
>>
>> [2] blktests: nvme_trtype=tcp ./check nvme/011
>>
>> [3]
>> [  109.342525] run blktests nvme/011 at 2021-03-31 20:58:58
>> [  109.497429] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [  109.512868] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [  109.584932] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:9b73e8531afa4320963cc96571e0acb1.
>> [  109.585809] nvme nvme0: creating 128 I/O queues.
>> [  109.596570] nvme nvme0: mapped 128/0/0 default/read/poll queues.
>> [  109.654170] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
>> [  155.366535] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
>> [  155.366568] nvmet: ctrl 1 fatal error occurred!
>> [  155.366608] nvme nvme0: starting error recovery
>> [  155.374861] block nvme0n1: no usable path - requeuing I/O
>> [  155.374891] block nvme0n1: no usable path - requeuing I/O
>> [  155.374911] block nvme0n1: no usable path - requeuing I/O
>> [  155.374923] block nvme0n1: no usable path - requeuing I/O
>> [  155.374934] block nvme0n1: no usable path - requeuing I/O
>> [  155.374954] block nvme0n1: no usable path - requeuing I/O
>> [  155.374973] block nvme0n1: no usable path - requeuing I/O
>> [  155.374984] block nvme0n1: no usable path - requeuing I/O
>> [  155.375004] block nvme0n1: no usable path - requeuing I/O
>> [  155.375024] block nvme0n1: no usable path - requeuing I/O
>> [  155.375674] nvme nvme0: Reconnecting in 10 seconds...
>> [  180.967462] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
>> [  180.967486] nvmet: ctrl 2 fatal error occurred!
>> [  193.427906] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  193.427934] rcu: 	40-...0: (1 GPs behind) idle=f3e/1/0x4000000000000000 softirq=535/535 fqs=2839
>> [  193.427966] rcu: 	42-...0: (1 GPs behind) idle=792/1/0x4000000000000000 softirq=160/160 fqs=2839
>> [  193.427995] 	(detected by 5, t=6002 jiffies, g=7961, q=7219)
>> [  193.428030] Sending NMI from CPU 5 to CPUs 40:
>> [  199.235530] CPU 40 didn't respond to backtrace IPI, inspecting paca.
>> [  199.235551] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 217 (kworker/40:0H)
>> [  199.235579] Back trace of paca->saved_r1 (0xc000000012973380) (possibly stale):
>> [  199.235594] Call Trace:
>> [  199.235601] [c000000012973380] [c0000000129733e0] 0xc0000000129733e0 (unreliable)
>> [  199.235633] [c000000012973420] [c000000000933008] bfq_allow_bio_merge+0x78/0x110
>> [  199.235673] [c000000012973460] [c0000000008d7470] elv_bio_merge_ok+0x90/0xb0
>> [  199.235711] [c000000012973490] [c0000000008d811c] elv_merge+0x6c/0x1b0
>> [  199.235747] [c0000000129734e0] [c0000000008ea1d8] blk_mq_sched_try_merge+0x48/0x250
>> [  199.235785] [c000000012973540] [c00000000092d29c] bfq_bio_merge+0xfc/0x230
>> [  199.235820] [c0000000129735c0] [c0000000008f9e24] __blk_mq_sched_bio_merge+0xa4/0x210
>> [  199.235848] [c000000012973620] [c0000000008f288c] blk_mq_submit_bio+0xec/0x710
>> [  199.235877] [c0000000129736c0] [c0000000008dfad4] submit_bio_noacct+0x534/0x680
>> [  199.235915] [c000000012973760] [c0000000005e0308] iomap_dio_submit_bio+0xd8/0x100
>> [  199.235953] [c000000012973790] [c0000000005e0ed4] iomap_dio_bio_actor+0x3c4/0x570
>> [  199.235991] [c000000012973830] [c0000000005db284] iomap_apply+0x1f4/0x3e0
>> [  199.236017] [c000000012973920] [c0000000005e06e4] __iomap_dio_rw+0x204/0x5b0
>> [  199.236054] [c0000000129739f0] [c0000000005e0ab0] iomap_dio_rw+0x20/0x80
>> [  199.236090] [c000000012973a10] [c00800000e4ea660] xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
>> [  199.236230] [c000000012973a60] [c00800000e4eabfc] xfs_file_write_iter+0x104/0x190 [xfs]
>> [  199.236368] [c000000012973a90] [c008000010440724] nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
>> [  199.236412] [c000000012973b10] [c008000010440b54] nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
>> [  199.236455] [c000000012973b90] [c00800000fa142d8] nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
>> [  199.236493] [c000000012973c70] [c000000000179534] process_one_work+0x294/0x580
>> [  199.236533] [c000000012973d10] [c0000000001798c8] worker_thread+0xa8/0x650
>> [  199.236568] [c000000012973da0] [c000000000184180] kthread+0x190/0x1a0
>> [  199.236595] [c000000012973e10] [c00000000000d4ec] ret_from_kernel_thread+0x5c/0x70
>> [  199.236710] Sending NMI from CPU 5 to CPUs 42:
>> [  205.044364] CPU 42 didn't respond to backtrace IPI, inspecting paca.
>> [  205.044381] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 3004 (kworker/42:2H)
>> [  205.044408] Back trace of paca->saved_r1 (0xc00000085194b520) (possibly stale):
>> [  205.044423] Call Trace:
>> [  205.044440] [c00000085194b520] [c00000079ac7f700] 0xc00000079ac7f700 (unreliable)
>> [  205.044468] [c00000085194b540] [c00000000092d248] bfq_bio_merge+0xa8/0x230
>> [  205.044494] [c00000085194b5c0] [c0000000008f9e24] __blk_mq_sched_bio_merge+0xa4/0x210
>> [  205.044531] [c00000085194b620] [c0000000008f288c] blk_mq_submit_bio+0xec/0x710
>> [  205.044569] [c00000085194b6c0] [c0000000008dfad4] submit_bio_noacct+0x534/0x680
>> [  205.044607] [c00000085194b760] [c0000000005e0308] iomap_dio_submit_bio+0xd8/0x100
>> [  205.044645] [c00000085194b790] [c0000000005e0ed4] iomap_dio_bio_actor+0x3c4/0x570
>> [  205.044672] [c00000085194b830] [c0000000005db284] iomap_apply+0x1f4/0x3e0
>> [  205.044698] [c00000085194b920] [c0000000005e06e4] __iomap_dio_rw+0x204/0x5b0
>> [  205.044735] [c00000085194b9f0] [c0000000005e0ab0] iomap_dio_rw+0x20/0x80
>> [  205.044771] [c00000085194ba10] [c00800000e4ea660] xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
>> [  205.044897] [c00000085194ba60] [c00800000e4eabfc] xfs_file_write_iter+0x104/0x190 [xfs]
>> [  205.045021] [c00000085194ba90] [c008000010440724] nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
>> [  205.045064] [c00000085194bb10] [c008000010440b54] nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
>> [  205.045106] [c00000085194bb90] [c00800000fa142d8] nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
>> [  205.045144] [c00000085194bc70] [c000000000179534] process_one_work+0x294/0x580
>> [  205.045181] [c00000085194bd10] [c0000000001798c8] worker_thread+0xa8/0x650
>> [  205.045216] [c00000085194bda0] [c000000000184180] kthread+0x190/0x1a0
>> [  205.045242] [c00000085194be10] [c00000000000d4ec] ret_from_kernel_thread+0x5c/0x70
>>
>>
>>
>>
>> Best Regards,
>>   Yi Zhang
>>
>>


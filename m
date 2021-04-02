Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31CC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA03761105
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 13:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDBNjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDBNjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 09:39:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973CC0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 06:39:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso4348687wmq.1
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xDJi4kjuahKXHK0XhGkeAsa48GtPTbIzJggRxmJ/Wpo=;
        b=DuTeJ/TK70iEtnmexOKuVT4Bv5A3zXvQLJ7r3iM//nElUu1s9cvVMuwMXYGE3/bcJj
         HYgGJQOcwKI2Vjva3NbI/gJdZEa1cYZ1SlmzgONwZadbS9N/m0HSLT/ADASo32IgT3a1
         ZEcB2lIT0wJGsppwR+Dz54kUJPuWmKnwm5wxEaUwH0Z31rIgW/rZ4OGiFa4Ftn9XT7Ee
         HVPo4fxEp/5BS7kuIW/vxHOuNWQr64U1V1hk3UcpCNwotSufzfUGPNYt/peIjb9/y8dh
         eEvjmgH6SjvzUBP5x9t9VBX/3ygImRZ7IMUyPp1KX0LahIc0rlLhxoCtlizxGRl+BQ2d
         CxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xDJi4kjuahKXHK0XhGkeAsa48GtPTbIzJggRxmJ/Wpo=;
        b=CaivnDZN6UBVVZqSF8EJlyULufhMQZpEwQErnvriuEeOvnmL/M5SuKEQ7xeltllBZy
         z5ENAwaWX0/GZw3WXpwlmsd2Z7/S/Jgh7wqKq0sp+DiZLhMH1zY9/dGvGJIy4C24hhIB
         qjoDNmJJxQaOHuwVB+NentU+/JoXBzf+Nt9nabpk//5ihl9C/GCXovr2NqbMFOXteD35
         qxSkI6T1NYSOkGTqv8EMS2BWlPPIWUXo1ROTJfYGfmOCIBvS9CVRwgikt0wWX5XXaSgz
         8Ay0qXmzTGdBU4haM6Fn2p/NldSLIyMQHmeynK7ffxgmPdRQFGUCZ4Peg63aS15zYYKg
         Oblw==
X-Gm-Message-State: AOAM531TroLnUYDF3fEfIP0VI88d+2poCxoc72YTTQgYWT+pmfdOaIUd
        tXgPOP684Hfq9UNAYEJo8iCNJh2H+RpgjdUT
X-Google-Smtp-Source: ABdhPJx/yFAgN6sNmHU8itFQc21GfN2IK6CZ/OYToQ4HrTulkTTaMzk8yWx5iA315bxUmlE0+7tWWQ==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr12744133wmh.153.1617370786235;
        Fri, 02 Apr 2021 06:39:46 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y10sm14577715wrl.19.2021.04.02.06.39.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 06:39:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
Date:   Fri, 2 Apr 2021 15:39:51 +0200
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 1 apr 2021, alle ore 03:27, Yi Zhang <yi.zhang@redhat.com> =
ha scritto:
>=20
> Hi

Hi

> We reproduced this bfq regression[3] on ppc64le with blktests[2] on =
the latest linux-block/for-next branch, seems it was introduced with [1] =
from my bisecting, pls help check it. Let me know if you need any =
testing for it, thanks.
>=20

Thanks for reporting this bug and finding the candidate offending =
commit. Could you try this test with my dev kernel, which might provide =
more information? The kernel is here:
https://github.com/Algodev-github/bfq-mq

Alternatively, I could try to provide you with patches to instrument =
your kernel.

The first option may be quicker.

In both cases, having KASAN active could be rather helpful too.

Looking forward to your feedback,
Paolo

> [1]
> commit 430a67f9d6169a7b3e328bceb2ef9542e4153c7c (HEAD, =
refs/bisect/bad)
> Author: Paolo Valente <paolo.valente@linaro.org>
> Date:   Thu Mar 4 18:46:27 2021 +0100
>=20
>    block, bfq: merge bursts of newly-created queues
>=20
> [2] blktests: nvme_trtype=3Dtcp ./check nvme/011
>=20
> [3]
> [  109.342525] run blktests nvme/011 at 2021-03-31 20:58:58
> [  109.497429] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  109.512868] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  109.584932] nvmet: creating controller 1 for subsystem =
blktests-subsystem-1 for NQN =
nqn.2014-08.org.nvmexpress:uuid:9b73e8531afa4320963cc96571e0acb1.
> [  109.585809] nvme nvme0: creating 128 I/O queues.
> [  109.596570] nvme nvme0: mapped 128/0/0 default/read/poll queues.
> [  109.654170] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr =
127.0.0.1:4420
> [  155.366535] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [  155.366568] nvmet: ctrl 1 fatal error occurred!
> [  155.366608] nvme nvme0: starting error recovery
> [  155.374861] block nvme0n1: no usable path - requeuing I/O
> [  155.374891] block nvme0n1: no usable path - requeuing I/O
> [  155.374911] block nvme0n1: no usable path - requeuing I/O
> [  155.374923] block nvme0n1: no usable path - requeuing I/O
> [  155.374934] block nvme0n1: no usable path - requeuing I/O
> [  155.374954] block nvme0n1: no usable path - requeuing I/O
> [  155.374973] block nvme0n1: no usable path - requeuing I/O
> [  155.374984] block nvme0n1: no usable path - requeuing I/O
> [  155.375004] block nvme0n1: no usable path - requeuing I/O
> [  155.375024] block nvme0n1: no usable path - requeuing I/O
> [  155.375674] nvme nvme0: Reconnecting in 10 seconds...
> [  180.967462] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
> [  180.967486] nvmet: ctrl 2 fatal error occurred!
> [  193.427906] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  193.427934] rcu: 	40-...0: (1 GPs behind) =
idle=3Df3e/1/0x4000000000000000 softirq=3D535/535 fqs=3D2839=20
> [  193.427966] rcu: 	42-...0: (1 GPs behind) =
idle=3D792/1/0x4000000000000000 softirq=3D160/160 fqs=3D2839=20
> [  193.427995] 	(detected by 5, t=3D6002 jiffies, g=3D7961, =
q=3D7219)
> [  193.428030] Sending NMI from CPU 5 to CPUs 40:
> [  199.235530] CPU 40 didn't respond to backtrace IPI, inspecting =
paca.
> [  199.235551] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 217 =
(kworker/40:0H)
> [  199.235579] Back trace of paca->saved_r1 (0xc000000012973380) =
(possibly stale):
> [  199.235594] Call Trace:
> [  199.235601] [c000000012973380] [c0000000129733e0] =
0xc0000000129733e0 (unreliable)
> [  199.235633] [c000000012973420] [c000000000933008] =
bfq_allow_bio_merge+0x78/0x110
> [  199.235673] [c000000012973460] [c0000000008d7470] =
elv_bio_merge_ok+0x90/0xb0
> [  199.235711] [c000000012973490] [c0000000008d811c] =
elv_merge+0x6c/0x1b0
> [  199.235747] [c0000000129734e0] [c0000000008ea1d8] =
blk_mq_sched_try_merge+0x48/0x250
> [  199.235785] [c000000012973540] [c00000000092d29c] =
bfq_bio_merge+0xfc/0x230
> [  199.235820] [c0000000129735c0] [c0000000008f9e24] =
__blk_mq_sched_bio_merge+0xa4/0x210
> [  199.235848] [c000000012973620] [c0000000008f288c] =
blk_mq_submit_bio+0xec/0x710
> [  199.235877] [c0000000129736c0] [c0000000008dfad4] =
submit_bio_noacct+0x534/0x680
> [  199.235915] [c000000012973760] [c0000000005e0308] =
iomap_dio_submit_bio+0xd8/0x100
> [  199.235953] [c000000012973790] [c0000000005e0ed4] =
iomap_dio_bio_actor+0x3c4/0x570
> [  199.235991] [c000000012973830] [c0000000005db284] =
iomap_apply+0x1f4/0x3e0
> [  199.236017] [c000000012973920] [c0000000005e06e4] =
__iomap_dio_rw+0x204/0x5b0
> [  199.236054] [c0000000129739f0] [c0000000005e0ab0] =
iomap_dio_rw+0x20/0x80
> [  199.236090] [c000000012973a10] [c00800000e4ea660] =
xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
> [  199.236230] [c000000012973a60] [c00800000e4eabfc] =
xfs_file_write_iter+0x104/0x190 [xfs]
> [  199.236368] [c000000012973a90] [c008000010440724] =
nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
> [  199.236412] [c000000012973b10] [c008000010440b54] =
nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
> [  199.236455] [c000000012973b90] [c00800000fa142d8] =
nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
> [  199.236493] [c000000012973c70] [c000000000179534] =
process_one_work+0x294/0x580
> [  199.236533] [c000000012973d10] [c0000000001798c8] =
worker_thread+0xa8/0x650
> [  199.236568] [c000000012973da0] [c000000000184180] =
kthread+0x190/0x1a0
> [  199.236595] [c000000012973e10] [c00000000000d4ec] =
ret_from_kernel_thread+0x5c/0x70
> [  199.236710] Sending NMI from CPU 5 to CPUs 42:
> [  205.044364] CPU 42 didn't respond to backtrace IPI, inspecting =
paca.
> [  205.044381] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 3004 =
(kworker/42:2H)
> [  205.044408] Back trace of paca->saved_r1 (0xc00000085194b520) =
(possibly stale):
> [  205.044423] Call Trace:
> [  205.044440] [c00000085194b520] [c00000079ac7f700] =
0xc00000079ac7f700 (unreliable)
> [  205.044468] [c00000085194b540] [c00000000092d248] =
bfq_bio_merge+0xa8/0x230
> [  205.044494] [c00000085194b5c0] [c0000000008f9e24] =
__blk_mq_sched_bio_merge+0xa4/0x210
> [  205.044531] [c00000085194b620] [c0000000008f288c] =
blk_mq_submit_bio+0xec/0x710
> [  205.044569] [c00000085194b6c0] [c0000000008dfad4] =
submit_bio_noacct+0x534/0x680
> [  205.044607] [c00000085194b760] [c0000000005e0308] =
iomap_dio_submit_bio+0xd8/0x100
> [  205.044645] [c00000085194b790] [c0000000005e0ed4] =
iomap_dio_bio_actor+0x3c4/0x570
> [  205.044672] [c00000085194b830] [c0000000005db284] =
iomap_apply+0x1f4/0x3e0
> [  205.044698] [c00000085194b920] [c0000000005e06e4] =
__iomap_dio_rw+0x204/0x5b0
> [  205.044735] [c00000085194b9f0] [c0000000005e0ab0] =
iomap_dio_rw+0x20/0x80
> [  205.044771] [c00000085194ba10] [c00800000e4ea660] =
xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
> [  205.044897] [c00000085194ba60] [c00800000e4eabfc] =
xfs_file_write_iter+0x104/0x190 [xfs]
> [  205.045021] [c00000085194ba90] [c008000010440724] =
nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
> [  205.045064] [c00000085194bb10] [c008000010440b54] =
nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
> [  205.045106] [c00000085194bb90] [c00800000fa142d8] =
nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
> [  205.045144] [c00000085194bc70] [c000000000179534] =
process_one_work+0x294/0x580
> [  205.045181] [c00000085194bd10] [c0000000001798c8] =
worker_thread+0xa8/0x650
> [  205.045216] [c00000085194bda0] [c000000000184180] =
kthread+0x190/0x1a0
> [  205.045242] [c00000085194be10] [c00000000000d4ec] =
ret_from_kernel_thread+0x5c/0x70
>=20
>=20
>=20
>=20
> Best Regards,
>  Yi Zhang
>=20
>=20


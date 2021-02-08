Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69617C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 06:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DD64E6E
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 06:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhBHGtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 01:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhBHGtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 01:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612766904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5CaU1MyH5H8Hj9CUshwG5TX0YIuttmYfvo+2Lb4+Fo=;
        b=hmZKOY6lFtQ7OFztrCsJiWS0CG55tlaiXTZOCvvID59oyeOXGwgP32DSE1OUTihpxpLrbL
        s6tLYHa+1Ru4JeN3ipqcq1xD9a+A2vnT4A12q2hLWu9R+VYvHuvdIXaSps4+GaILck11dU
        RolkVLmv07td9pVSyN3at6ulQG7/Njc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-RXMfEEjLNq-28-idzwEEEw-1; Mon, 08 Feb 2021 01:48:21 -0500
X-MC-Unique: RXMfEEjLNq-28-idzwEEEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B1C803648;
        Mon,  8 Feb 2021 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.71.19.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2BC7722F9;
        Mon,  8 Feb 2021 06:48:13 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
 <BYAPR04MB49654E940FACB778A787B68E86B09@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <79af2e42-f1f1-bb51-2e6c-b0d8a7294bcc@redhat.com>
Date:   Mon, 8 Feb 2021 14:48:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654E940FACB778A787B68E86B09@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/7/21 1:25 PM, Chaitanya Kulkarni wrote:
> Yi,
>
> On 2/6/21 20:51, Yi Zhang wrote:
>> The issue was introduced after merge the NVMe updates
>>
>> commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)
>> Merge: 44d10e4b2f2c 0d7389718c32
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Tue Feb 2 07:12:06 2021 -0700
>>
>>       Merge branch 'for-5.12/drivers' into for-next
>>
>>       * for-5.12/drivers: (22 commits)
>>         nvme-tcp: use cancel tagset helper for tear down
>>         nvme-rdma: use cancel tagset helper for tear down
>>         nvme-tcp: add clean action for failed reconnection
>>         nvme-rdma: add clean action for failed reconnection
>>         nvme-core: add cancel tagset helpers
>>         nvme-core: get rid of the extra space
>>         nvme: add tracing of zns commands
>>         nvme: parse format nvm command details when tracing
>>         nvme: update enumerations for status codes
>>         nvmet: add lba to sect conversion helpers
>>         nvmet: remove extra variable in identify ns
>>         nvmet: remove extra variable in id-desclist
>>         nvmet: remove extra variable in smart log nsid
>>         nvme: refactor ns->ctrl by request
>>         nvme-tcp: pass multipage bvec to request iov_iter
>>         nvme-tcp: get rid of unused helper function
>>         nvme-tcp: fix wrong setting of request iov_iter
>>         nvme: support command retry delay for admin command
>>         nvme: constify static attribute_group structs
>>         nvmet-fc: use RCU proctection for assoc_list
>>
>>
>> On 2/6/21 11:08 AM, Yi Zhang wrote:
>>> blktests nvme-tcp/012
> Thanks for reporting, you can further bisect this using following
> NVMe tree if is from NVMEe tree :- http://git.infradead.org/nvme.git
> Branch :- 5.12
I've tried that branch, but encountered another NULL pointer.

[  224.290720] run blktests nvme/012 at 2021-02-08 01:46:25
[  224.515479] BUG: kernel NULL pointer dereference, address: 
0000000000000368
[  224.522442] #PF: supervisor read access in kernel mode
[  224.527590] #PF: error_code(0x0000) - not-present page
[  224.532737] PGD 0 P4D 0
[  224.535276] Oops: 0000 [#1] SMP PTI
[  224.538770] CPU: 0 PID: 2403 Comm: multipath Tainted: G S I       
5.11.0-rc5+ #1
[  224.546776] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS 
2.10.0 11/12/2020
[  224.554340] RIP: 0010:bio_associate_blkg_from_css+0xbd/0x2c0
[  224.560009] Code: 03 75 79 65 48 ff 00 e8 b1 94 cc ff e8 ac 94 cc ff 
49 89 5c 24 48 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 49 8b 44 24 
08 <48> 8b 808
[  224.578761] RSP: 0018:ffffad748ec5bd78 EFLAGS: 00010246
[  224.583988] RAX: 0000000000000000 RBX: ffffa0e96452b3c0 RCX: 
0000000000000000
[  224.591120] RDX: ffffa11077088000 RSI: ffffffffa06edb20 RDI: 
ffffa0e96452b3c0
[  224.598253] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000002
[  224.605385] R10: 0000000000000022 R11: 0000000000000c10 R12: 
ffffa0e96452b3c0
[  224.612516] R13: ffffffffa06edb20 R14: 0000000000001000 R15: 
0000000000000000
[  224.619649] FS:  00007fb6647feb00(0000) GS:ffffa107f0000000(0000) 
knlGS:0000000000000000
[  224.627734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.633479] CR2: 0000000000000368 CR3: 0000002884b54002 CR4: 
00000000007706f0
[  224.640611] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  224.647751] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  224.654884] PKRU: 55555554
[  224.657595] Call Trace:
[  224.660043]  bio_associate_blkg+0x20/0x70
[  224.664055]  nvme_submit_user_cmd+0xd7/0x340 [nvme_core]
[  224.669375]  nvme_user_cmd.isra.82+0x120/0x190 [nvme_core]
[  224.674859]  nvme_dev_ioctl+0x13b/0x150 [nvme_core]
[  224.679738]  __x64_sys_ioctl+0x84/0xc0
[  224.683500]  do_syscall_64+0x33/0x40
[  224.687088]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  224.692149] RIP: 0033:0x7fb66338161b
[  224.695726] Code: 0f 1e fa 48 8b 05 6d b8 2c 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 
05 <48> 3d 018
[  224.714469] RSP: 002b:00007ffeae59aba8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  224.722036] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fb66338161b
[  224.729168] RDX: 00007ffeae59abb0 RSI: 00000000c0484e41 RDI: 
0000000000000003
[  224.736300] RBP: 00007ffeae59ac10 R08: 0000559af0bb3d20 R09: 
00007fb66340e580
[  224.743431] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007ffeae59bcb0
[  224.750563] R13: 0000559af0bb3d20 R14: 0000000000000003 R15: 
0000000000000000
[  224.757697] Modules linked in: loop nvme_tcp nvme_fabrics nvme_core 
nvmet_tcp nvmet rfkill sunrpc dm_multipath intel_rapl_msr 
intel_rapl_common isst_if_cod
[  224.833264] CR2: 0000000000000368
[  224.836604] ---[ end trace fa77e7cc26f8cfc1 ]---
[  224.883915] RIP: 0010:bio_associate_blkg_from_css+0xbd/0x2c0
[  224.889584] Code: 03 75 79 65 48 ff 00 e8 b1 94 cc ff e8 ac 94 cc ff 
49 89 5c 24 48 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 49 8b 44 24 
08 <48> 8b 808
[  224.908329] RSP: 0018:ffffad748ec5bd78 EFLAGS: 00010246
[  224.913554] RAX: 0000000000000000 RBX: ffffa0e96452b3c0 RCX: 
0000000000000000
[  224.920686] RDX: ffffa11077088000 RSI: ffffffffa06edb20 RDI: 
ffffa0e96452b3c0
[  224.927818] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000002
[  224.934948] R10: 0000000000000022 R11: 0000000000000c10 R12: 
ffffa0e96452b3c0
[  224.942082] R13: ffffffffa06edb20 R14: 0000000000001000 R15: 
0000000000000000
[  224.949213] FS:  00007fb6647feb00(0000) GS:ffffa107f0000000(0000) 
knlGS:0000000000000000
[  224.957301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.963044] CR2: 0000000000000368 CR3: 0000002884b54002 CR4: 
00000000007706f0
[  224.970177] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  224.977309] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  224.984441] PKRU: 55555554
[  224.987155] Kernel panic - not syncing: Fatal exception
[  225.425279] Kernel Offset: 0x1d400000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  225.478268] ---[ end Kernel panic - not syncing: Fatal exception ]---

> Looking at the commit log it seems like nvme-tcp commits might be
> the issue given that you got the problem in nvme_tcp_init_iter()
> and just eliminating by the looking at the code
> commit 9f99a29e5307 can lead to this behavior.
>
> *I may be completely wrong as I'm not expert in the nvme-tcp host.*
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


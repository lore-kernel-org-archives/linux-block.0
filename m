Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A4C3B187
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4620842
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B7/JOcod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBKTpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:45:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38447 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgBKTpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 14:45:08 -0500
Received: by mail-io1-f68.google.com with SMTP id s24so13169765iog.5
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdngiGIc56ND3G8IVZNUfQiKVaT600fcPIGIo+38OV8=;
        b=B7/JOcodZff7WaqRdg4ptMJaOmcU0wm4AzxWtfktmEra3n49Im63SzosGbvUVNMhCC
         rvf0fG6ESwmUrGiiLAKKXjA+DJVenHrG3wvrETiAYMDIqegPbZGIelCoxAZl060WZXe6
         0dCrjz1TYN26DZ2xD82oWVjmucp8xIlBikE0DhmmJdfDbePuJRjGe0hlhzcFhouRFtYW
         loYLKkmdmV9DMyIiG7DJC3Mnqhl2d3/AeT63L04ZfwcNbnQ5g8TV8U1Co6mhpoOOUerD
         PShQIaBycLaZXP/6Bs5qxlhcO1SnIF0sbG6cctgG8g/JxGQ/lx8URJMBqe3YfNOAu+4N
         d0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdngiGIc56ND3G8IVZNUfQiKVaT600fcPIGIo+38OV8=;
        b=gH43kde0Ewnt1/L/q5orOMGwAd6skJ9NMPYkhOsqYFufD8spxjF7wxm7GlD19Xv8R2
         4dldqD1Poh3235Sc8UDo6kb2kFhluWfr3cv3U2lOHpgGG3b7c4BNCwYYj9910PSlQmvJ
         GnZTEBOuZol9WiC0GQfjXPEP49O6EgIQg+KCH7aJWIQBhMy612TCrAjtm0SbJBfBJizo
         ruldoququclTk9uZQd2f/8OoTZlZEK9Jk7vyBn6KZ6GARIvJr14Fjny0c3229BbxCEfg
         M2ospIxnlzufumSbiezlVTYQnXsUwaTm5jKqGVYgbqH6pu0kpMyy5NGFv6EspofAhD0L
         IrTw==
X-Gm-Message-State: APjAAAXHpzewdR3SBP+dB+YqGA4BTXE26qRhxd8wRHgM1NkJdtj++D5x
        Zyg1g00K2t4hfAzeHtnVYO03Rg==
X-Google-Smtp-Source: APXvYqzMv4BSTsh9kXNBgt5cpoTv5x6xdBnqtlJYYx6wnOHbpSHnaiLJ0tUDAeH/ro4QIhfaywQy8A==
X-Received: by 2002:a6b:c703:: with SMTP id x3mr14942220iof.118.1581450307422;
        Tue, 11 Feb 2020 11:45:07 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm1598265iln.81.2020.02.11.11.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:45:07 -0800 (PST)
Subject: Re: Fault seen with io_uring and nvmf/tcp
To:     "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>
References: <CY4PR11MB13515FF9DCEFD14FF68FC65CE5180@CY4PR11MB1351.namprd11.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7334a739-78b4-d3dc-be00-668aab2e2522@kernel.dk>
Date:   Tue, 11 Feb 2020 12:45:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB13515FF9DCEFD14FF68FC65CE5180@CY4PR11MB1351.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/20 12:30 PM, Wunderlich, Mark wrote:
> Posting to this mail list in hopes someone has already seen this fault before I start digging.  Using the nvme-5.5-rc branch of  git.infradead.org repo.
> Pulled this branch and running un-modified.
> Performing FIO (io_uring) test: (initiating on 8 host cores, TIME=30, RWMIX=100, BLOCK_SIZE=4k, DEPTH=32, BATCH=8), using latest version of fio.
> cmd="fio --filename=/dev/nvme0n1 --time_based --runtime=$TIME --ramp_time=10 --thread --rw=randrw --rwmixread=$RWMIX --refill_buffers --direct=1 --ioengine=io_uring --hipri --fixedbufs --bs=$BLOCK_SIZE --iodepth=$DEPTH --iodepth_batch_complete_min=1 --iodepth_batch_complete_max=$DEPTH --iodepth_batch=$BATCH --numjobs=1 --group_reporting --gtod_reduce=0 --disable_lat=0 --name=cpu3 --cpus_allowed=3 --name=cpu5 --cpus_allowed=5 --name=cpu7 --cpus_allowed=7 --name=cpu9 --cpus_allowed=9 --name=cpu11 --cpus_allowed11 --name=cpu13 --cpus_allowed=13 --name=cpu15 --cpus_allowed=15 --name=cpu17 --cpus_allowed=17
> 
> NVMf TCP queue configuration is 1 default queue and 101 poll queues.  Connected to a single remote NVMe ram disk device.
> I/O performs normally up to 30 second run, but faults just at the end. Very repeatable.
> 
> Thanks for your time --- Mark
> 
> [64592.841944] nvme nvme0: mapped 1/0/101 default/read/poll queues.
> [64592.867003] nvme nvme0: new ctrl: NQN "testrd", addr 192.168.0.1:4420
> [64646.940588] list_add corruption. prev->next should be next (ffff9c1feb2bc7c8), but was ffff9c1ff7ee5368. (prev=ffff9c1ff7ee5468).
> [64646.941149] ------------[ cut here ]------------
> [64646.941150] kernel BUG at lib/list_debug.c:28!
> [64646.941360] invalid opcode: 0000 [#1] SMP PTI
> [64646.941561] CPU: 82 PID: 7886 Comm: io_wqe_worker-0 Tainted: G           O      5.5.0-rc2stable+ #32
> [64646.941994] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
> [64646.942349] RIP: 0010:__list_add_valid+0x64/0x70
> [64646.942562] Code: 48 89 fe 31 c0 48 c7 c7 40 21 17 89 e8 f9 5c c6 ff 0f 0b 48 89 d1 48 c7 c7 e8 20 17 89 48 89 f2 48 89 c6 31 c0 e8 e0 5c c6 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 48 8b 07 48 b9 00 01 00 00 00
> [64646.943442] RSP: 0018:ffffa78a49137d90 EFLAGS: 00010246
> [64646.943687] RAX: 0000000000000075 RBX: ffff9c1ff7ee5a00 RCX: 0000000000000000
> [64646.944021] RDX: 0000000000000000 RSI: ffff9c0fffe59d28 RDI: ffff9c0fffe59d28
> [64646.944356] RBP: ffffa78a49137df8 R08: 00000000000006ad R09: ffffffff88ec3be0
> [64646.944691] R10: 000000000000000f R11: 0000000007070707 R12: ffff9c1feb2bc600
> [64646.945025] R13: ffff9c1feb2bc7c8 R14: ffff9c1ff7ee5468 R15: ffff9c1ff7ee5a68
> [64646.945360] FS:  0000000000000000(0000) GS:ffff9c0fffe40000(0000) knlGS:0000000000000000
> [64646.945739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [64646.946008] CR2: 00007f4423eb7004 CR3: 000000169940a005 CR4: 00000000007606e0
> [64646.946343] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [64646.946677] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [64646.947012] PKRU: 55555554
> [64646.947138] Call Trace:
> [64646.947260]  io_issue_sqe+0x115/0xa30
> [64646.947429]  io_wq_submit_work+0xb5/0x1d0
> [64646.947615]  io_worker_handle_work+0x19d/0x4c0
> [64646.947823]  io_wqe_worker+0xdc/0x390
> [64646.947998]  kthread+0xf8/0x130
> [64646.948141]  ? io_wq_for_each_worker+0xb0/0xb0
> [64646.948349]  ? kthread_bind+0x10/0x10
> [64646.948522]  ret_from_fork+0x35/0x40

I think you want to check that you have these in your tree:


commit 11ba820bf163e224bf5dd44e545a66a44a5b1d7a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Jan 15 21:51:17 2020 -0700

    io_uring: ensure workqueue offload grabs ring mutex for poll list

and

commit 797f3f535d59f05ad12c629338beef6cb801d19e
Author: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Date:   Wed Jan 15 18:37:45 2020 -0800

    io_uring: clear req->result always before issuing a read/write request

-- 
Jens Axboe


Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92DC432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974EF22303
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 23:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKRX1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:27:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44248 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfKRX1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 18:27:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id e6so2395671pgi.11
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 15:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZAOxZezC0Se3HOZ1M/F89wjImttKpPlG2OtXS0MLqg=;
        b=hyngTjFkg+kzz5csxkdHO8Sy9wT+PLfBrWtwE5qXTLHNemgBavHMIcQcE6Nk9ok3jS
         RYWmt0UURlnzemnxaum8UfG6NAmaG2XqMydfEnjxVD8Hnixhmasst5nP2bgYHPSv3J9L
         1SuIeHqsXtPkX1jjAmHTpX5H+OBrGqVhQbplQj5RVtmk1MSa0zPJCX9YQIVVcZmbJUS0
         XLdx3YiylowVmPwirJf7018YrDiYnPFG5c0o/WDM6/rY9EGlUQu9Mf8KBW6DiQqwIgmT
         1LsRWhIvzI53Z+7FjnAMBVEgsbyrUxh21cn6GuhlmRp49aTqC4CrGj1AKNb2RUzCpT0F
         7czg==
X-Gm-Message-State: APjAAAUrJCxr0tGDWYhJIeXpoZwsbqWQE7gKwJD2psX0fHVvDyOFBfKu
        8WEkmM7mLur5CTxqFjOsj00=
X-Google-Smtp-Source: APXvYqzq9aW7dMG2jzpHke1fqawVm0qK2Pv9iaebUHY1Ye/BdsfX35lPWWyHGVlJBtjCCKTzqTdKEw==
X-Received: by 2002:a62:4e03:: with SMTP id c3mr2107086pfb.114.1574119639771;
        Mon, 18 Nov 2019 15:27:19 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v24sm22008752pfn.53.2019.11.18.15.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 15:27:18 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
 <20191117041233.GA30615@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <922fd489-04f1-fe0b-7e5a-5f2def5cf211@acm.org>
Date:   Mon, 18 Nov 2019 15:27:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191117041233.GA30615@ming.t460p>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/19 8:12 PM, Ming Lei wrote:
> On Sat, Nov 16, 2019 at 05:24:05PM -0800, Bart Van Assche wrote:
>> On 2019-11-15 23:17, Ming Lei wrote:
>>> Now blk-mq takes a static queue mapping between CPU and hw queues, given
>>> CPU hotplug may happen any time, so the specified hw queue may become
>>> inactive any time.
>>
>> I can trigger a race between blk_mq_alloc_request_hctx() and
>> CPU-hotplugging by running blktests. The patch below fixes that race
>> on my setup. Does this patch also fix the race(s) that you ran into?
> 
> The following problem has been triggered in my regular test for years,
> is it same with yours?
> 
> [ 2248.751675] nvme nvme1: creating 2 I/O queues.
> [ 2248.752351] BUG: unable to handle page fault for address: 0000607d064434a8
> [ 2248.753348] #PF: supervisor write access in kernel mode
> [ 2248.754106] #PF: error_code(0x0002) - not-present page
> [ 2248.754846] PGD 0 P4D 0
> [ 2248.755230] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 2248.755838] CPU: 7 PID: 16293 Comm: kworker/u18:3 Not tainted 5.4.0-rc7_96b95eff4a59_master+ #1
> [ 2248.757089] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> [ 2248.758863] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
> [ 2248.759857] RIP: 0010:blk_mq_get_request+0x2a8/0x31c
> [ 2248.760654] Code: c7 83 08 01 00 00 00 00 00 00 48 c7 83 10 01 00 00 00 00 00 00 48 8b 55 18 45 84 ed 74 0c 31 c0 41 81 e5 00 08 06 00 0f 95 c0 <48> ff 44 c2 68 c7 83 d4 00 00 00 01 00 00 00 f7 45 10 00 00 06 00
> [ 2248.763375] RSP: 0018:ffffc900012dbc80 EFLAGS: 00010246
> [ 2248.764130] RAX: 0000000000000000 RBX: ffff888170d70000 RCX: 0000000000000017
> [ 2248.765156] RDX: 0000607d06443440 RSI: 0000020bb36c554e RDI: 0000020bb3837c3f
> [ 2248.766034] RBP: ffffc900012dbcc0 R08: 00000000f461df07 R09: 00000000000000a8
> [ 2248.767084] R10: ffffc900012dbe50 R11: 0000000000000002 R12: 0000000000000000
> [ 2248.768109] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 2248.769134] FS:  0000000000000000(0000) GS:ffff88827bd80000(0000) knlGS:0000000000000000
> [ 2248.770294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2248.771125] CR2: 0000607d064434a8 CR3: 0000000272866001 CR4: 0000000000760ee0
> [ 2248.772152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2248.773179] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2248.774204] PKRU: 55555554
> [ 2248.774603] Call Trace:
> [ 2248.774983]  blk_mq_alloc_request_hctx+0xc5/0x10e
> [ 2248.775674]  nvme_alloc_request+0x42/0x71
> [ 2248.776263]  __nvme_submit_sync_cmd+0x49/0x1b2
> [ 2248.776910]  nvmf_connect_io_queue+0x12c/0x195 [nvme_fabrics]
> [ 2248.777663]  ? nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
> [ 2248.778481]  nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
> [ 2248.779325]  nvme_loop_reset_ctrl_work+0x62/0xd4 [nvme_loop]
> [ 2248.780144]  process_one_work+0x1a8/0x2a1
> [ 2248.780727]  ? process_scheduled_works+0x2c/0x2c
> [ 2248.781398]  process_scheduled_works+0x27/0x2c
> [ 2248.782046]  worker_thread+0x1b1/0x23f
> [ 2248.782594]  kthread+0xf5/0xfa
> [ 2248.783048]  ? kthread_unpark+0x62/0x62
> [ 2248.783608]  ret_from_fork+0x35/0x40

Hi Ming,

Thanks for having shared this call stack. What made me look at 
blk_mq_alloc_request_hctx() is a different issue, namely the following 
kernel warnings, reported from inside blk_mq_run_hw_queue():

WARNING: CPU: 0 PID: 6123 at include/linux/cpumask.h:137 
cpumask_next_and+0x16/0x30
WARNING: CPU: 0 PID: 323 at include/linux/cpumask.h:137 
__blk_mq_run_hw_queue+0x152/0x1b0

Bart.

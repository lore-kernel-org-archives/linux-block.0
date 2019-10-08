Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D74C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C420673
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJHRQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:16:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfJHRQD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 13:16:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DEECE8E04DDFE1C673B;
        Wed,  9 Oct 2019 01:16:00 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 01:15:57 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Message-ID: <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com>
Date:   Tue, 8 Oct 2019 18:15:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/10/2019 10:06, John Garry wrote:
> On 08/10/2019 05:18, Ming Lei wrote:
>> Hi,
>>
>> Thomas mentioned:
>>     "
>>      That was the constraint of managed interrupts from the very
>> beginning:
>>
>>       The driver/subsystem has to quiesce the interrupt line and the
>> associated
>>       queue _before_ it gets shutdown in CPU unplug and not fiddle
>> with it
>>       until it's restarted by the core when the CPU is plugged in again.
>>     "
>>
>> But no drivers or blk-mq do that before one hctx becomes dead(all
>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>
>> This patchset tries to address the issue by two stages:
>>
>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>
>> - mark the hctx as internal stopped, and drain all in-flight requests
>> if the hctx is going to be dead.
>>
>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx
>> becomes dead
>>
>> - steal bios from the request, and resubmit them via
>> generic_make_request(),
>> then these IO will be mapped to other live hctx for dispatch
>>
>> Please comment & review, thanks!
>>
>> John, I don't add your tested-by tag since V3 have some changes,
>> and I appreciate if you may run your test on V3.
>>
>
> Will do, Thanks

Hi Ming,

I got this warning once:

[  162.558185] CPU10: shutdown
[  162.560994] psci: CPU10 killed.
[  162.593939] CPU9: shutdown
[  162.596645] psci: CPU9 killed.
[  162.625838] CPU8: shutdown
[  162.628550] psci: CPU8 killed.
[  162.685790] CPU7: shutdown
[  162.688496] psci: CPU7 killed.
[  162.725771] CPU6: shutdown
[  162.728486] psci: CPU6 killed.
[  162.753884] CPU5: shutdown
[  162.756591] psci: CPU5 killed.
[  162.785584] irq_shutdown
[  162.788277] IRQ 800: no longer affine to CPU4
[  162.793267] CPU4: shutdown
[  162.795975] psci: CPU4 killed.
[  162.849680] run queue from wrong CPU 13, hctx active
[  162.849692] CPU3: shutdown
[  162.854649] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  162.854653] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  162.857362] psci: CPU3 killed.
[  162.866039] Workqueue: kblockd blk_mq_run_work_fn
[  162.882281] Call trace:
[  162.884716]  dump_backtrace+0x0/0x150
[  162.888365]  show_stack+0x14/0x20
[  162.891668]  dump_stack+0xb0/0xf8
[  162.894970]  __blk_mq_run_hw_queue+0x11c/0x128
[  162.899400]  blk_mq_run_work_fn+0x1c/0x28
[  162.903397]  process_one_work+0x1e0/0x358
[  162.907393]  worker_thread+0x40/0x488
[  162.911042]  kthread+0x118/0x120
[  162.914257]  ret_from_fork+0x10/0x18
[  162.917834] run queue from wrong CPU 13, hctx active
[  162.922789] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  162.931472] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  162.939983] Workqueue: kblockd blk_mq_run_work_fn
[  162.944674] Call trace:
[  162.947107]  dump_backtrace+0x0/0x150
[  162.950755]  show_stack+0x14/0x20
[  162.954057]  dump_stack+0xb0/0xf8
[  162.957359]  __blk_mq_run_hw_queue+0x11c/0x128
[  162.961788]  blk_mq_run_work_fn+0x1c/0x28
[  162.965784]  process_one_work+0x1e0/0x358
[  162.969780]  worker_thread+0x40/0x488
[  162.973429]  kthread+0x118/0x120
[  162.976644]  ret_from_fork+0x10/0x18
[  162.980214] run queue from wrong CPU 13, hctx active
[  162.985171] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  162.993853] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.002366] Workqueue: kblockd blk_mq_run_work_fn
[  163.007057] Call trace:
[  163.009490]  dump_backtrace+0x0/0x150
[  163.013138]  show_stack+0x14/0x20
[  163.016440]  dump_stack+0xb0/0xf8
[  163.019742]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.024172]  blk_mq_run_work_fn+0x1c/0x28
[  163.028167]  process_one_work+0x1e0/0x358
[  163.032163]  worker_thread+0x238/0x488
[  163.035899]  kthread+0x118/0x120
[  163.039113]  ret_from_fork+0x10/0x18
[  163.042736] run queue from wrong CPU 13, hctx active
[  163.047692] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.056374] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.064885] Workqueue: kblockd blk_mq_run_work_fn
[  163.069575] Call trace:
[  163.072008]  dump_backtrace+0x0/0x150
[  163.075656]  show_stack+0x14/0x20
[  163.078958]  dump_stack+0xb0/0xf8
[  163.082260]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.086690]  blk_mq_run_work_fn+0x1c/0x28
[  163.090686]  process_one_work+0x1e0/0x358
[  163.094681]  worker_thread+0x238/0x488
[  163.098417]  kthread+0x118/0x120
[  163.101631]  ret_from_fork+0x10/0x18
[  163.105200] run queue from wrong CPU 13, hctx active
[  163.110534] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.111852] CPU2: shutdown
[  163.119218] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.119222] Workqueue: kblockd blk_mq_run_work_fn
[  163.119223] Call trace:
[  163.119224]  dump_backtrace+0x0/0x150
[  163.119226]  show_stack+0x14/0x20
[  163.119228]  dump_stack+0xb0/0xf8
[  163.119230]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.119234]  blk_mq_run_work_fn+0x1c/0x28
[  163.121943] psci: CPU2 killed.
[  163.130439]  process_one_work+0x1e0/0x358
[  163.130441]  worker_thread+0x238/0x488
[  163.130443]  kthread+0x118/0x120
[  163.130447]  ret_from_fork+0x10/0x18
[  163.173789] run queue from wrong CPU 13, hctx active
[  163.178743] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.187425] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.195937] Workqueue: kblockd blk_mq_run_work_fn
[  163.200627] Call trace:
[  163.203061]  dump_backtrace+0x0/0x150
[  163.206709]  show_stack+0x14/0x20
[  163.210011]  dump_stack+0xb0/0xf8
[  163.213312]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.217742]  blk_mq_run_work_fn+0x1c/0x28
[  163.221738]  process_one_work+0x1e0/0x358
[  163.225733]  worker_thread+0x238/0x488
[  163.229469]  kthread+0x118/0x120
[  163.232684]  ret_from_fork+0x10/0x18
[  163.236253] run queue from wrong CPU 13, hctx active
[  163.241597] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.241691] CPU1: shutdown
[  163.250281] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.250285] Workqueue: kblockd blk_mq_run_work_fn
[  163.250287] Call trace:
[  163.250291]  dump_backtrace+0x0/0x150
[  163.252998] psci: CPU1 killed.
[  163.261496]  show_stack+0x14/0x20
[  163.261499]  dump_stack+0xb0/0xf8
[  163.261503]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.279008] process 870 (fio) no longer affine to cpu0
[  163.291463]  blk_mq_run_work_fn+0x1c/0x28
[  163.295458]  process_one_work+0x1e0/0x358
[  163.299454]  worker_thread+0x238/0x488
[  163.303189]  kthread+0x118/0x120
[  163.306404]  ret_from_fork+0x10/0x18
[  163.309975] run queue from wrong CPU 13, hctx active
[  163.314929] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.323611] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.332122] Workqueue: kblockd blk_mq_run_work_fn
[  163.336812] Call trace:
[  163.339245]  dump_backtrace+0x0/0x150
[  163.342894]  show_stack+0x14/0x20
[  163.346195]  dump_stack+0xb0/0xf8
[  163.349497]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.353927]  blk_mq_run_work_fn+0x1c/0x28
[  163.357923]  process_one_work+0x1e0/0x358
[  163.361918]  worker_thread+0x238/0x488
[  163.365654]  kthread+0x118/0x120
[  163.368868]  ret_from_fork+0x10/0x18
[  163.372437] run queue from wrong CPU 13, hctx active
[  163.377391] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.386073] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.394583] Workqueue: kblockd blk_mq_run_work_fn
[  163.399273] Call trace:
[  163.401706]  dump_backtrace+0x0/0x150
[  163.405354]  show_stack+0x14/0x20
[  163.408656]  dump_stack+0xb0/0xf8
[  163.411958]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.416388]  blk_mq_run_work_fn+0x1c/0x28
[  163.420384]  process_one_work+0x1e0/0x358
[  163.424379]  worker_thread+0x238/0x488
[  163.428115]  kthread+0x118/0x120
[  163.431329]  ret_from_fork+0x10/0x18
[  163.434934] run queue from wrong CPU 13, hctx active
[  163.439887] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.448570] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.457080] Workqueue: kblockd blk_mq_run_work_fn
[  163.461770] Call trace:
[  163.464203]  dump_backtrace+0x0/0x150
[  163.467851]  show_stack+0x14/0x20
[  163.471153]  dump_stack+0xb0/0xf8
[  163.474455]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.478885]  blk_mq_run_work_fn+0x1c/0x28
[  163.482881]  process_one_work+0x1e0/0x358
[  163.486877]  worker_thread+0x238/0x488
[  163.490613]  kthread+0x118/0x120
[  163.493828]  ret_from_fork+0x10/0x18
[  163.497424] run queue from wrong CPU 13, hctx active
[  163.502378] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.511061] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.519572] Workqueue: kblockd blk_mq_run_work_fn
[  163.524262] Call trace:
[  163.526696]  dump_backtrace+0x0/0x150
[  163.530344]  show_stack+0x14/0x20
[  163.533646]  dump_stack+0xb0/0xf8
[  163.536948]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.541378]  blk_mq_run_work_fn+0x1c/0x28
[  163.545375]  process_one_work+0x1e0/0x358
[  163.549370]  worker_thread+0x238/0x488
[  163.553107]  kthread+0x118/0x120
[  163.556321]  ret_from_fork+0x10/0x18
[  163.559908] run queue from wrong CPU 24, hctx active
[  163.564871] CPU: 24 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.573554] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.582072] Workqueue: kblockd blk_mq_run_work_fn
[  163.586764] Call trace:
[  163.589199]  dump_backtrace+0x0/0x150
[  163.592848]  show_stack+0x14/0x20
[  163.596153]  dump_stack+0xb0/0xf8
[  163.599455]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.603885]  blk_mq_run_work_fn+0x1c/0x28
[  163.607882]  process_one_work+0x1e0/0x358
[  163.611877]  worker_thread+0x238/0x488
[  163.615613]  kthread+0x118/0x120
[  163.618828]  ret_from_fork+0x10/0x18
[  163.622404] run queue from wrong CPU 24, hctx active
[  163.627358] CPU: 24 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.636041] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.644552] Workqueue: kblockd blk_mq_run_work_fn
[  163.649242] Call trace:
[  163.651674]  dump_backtrace+0x0/0x150
[  163.655322]  show_stack+0x14/0x20
[  163.658623]  dump_stack+0xb0/0xf8
[  163.661924]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.666354]  blk_mq_run_work_fn+0x1c/0x28
[  163.670349]  process_one_work+0x1e0/0x358
[  163.674345]  worker_thread+0x238/0x488
[  163.678081]  kthread+0x118/0x120
[  163.681295]  ret_from_fork+0x10/0x18
[  163.684864] run queue from wrong CPU 24, hctx active
[  163.689819] CPU: 24 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.698501] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.707011] Workqueue: kblockd blk_mq_run_work_fn
[  163.711701] Call trace:
[  163.714133]  dump_backtrace+0x0/0x150
[  163.717781]  show_stack+0x14/0x20
[  163.721082]  dump_stack+0xb0/0xf8
[  163.724383]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.728813]  blk_mq_run_work_fn+0x1c/0x28
[  163.732808]  process_one_work+0x1e0/0x358
[  163.736803]  worker_thread+0x238/0x488
[  163.740539]  kthread+0x118/0x120
[  163.743753]  ret_from_fork+0x10/0x18
[  163.747342] run queue from wrong CPU 48, hctx active
[  163.752311] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.760995] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.769516] Workqueue: kblockd blk_mq_run_work_fn
[  163.774208] Call trace:
[  163.776644]  dump_backtrace+0x0/0x150
[  163.780294]  show_stack+0x14/0x20
[  163.783600]  dump_stack+0xb0/0xf8
[  163.786902]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.791332]  blk_mq_run_work_fn+0x1c/0x28
[  163.795330]  process_one_work+0x1e0/0x358
[  163.799327]  worker_thread+0x238/0x488
[  163.803064]  kthread+0x118/0x120
[  163.806279]  ret_from_fork+0x10/0x18
[  163.809855] run queue from wrong CPU 48, hctx active
[  163.814811] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.823496] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.832008] Workqueue: kblockd blk_mq_run_work_fn
[  163.836698] Call trace:
[  163.839132]  dump_backtrace+0x0/0x150
[  163.842782]  show_stack+0x14/0x20
[  163.846084]  dump_stack+0xb0/0xf8
[  163.849386]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.853817]  blk_mq_run_work_fn+0x1c/0x28
[  163.857813]  process_one_work+0x1e0/0x358
[  163.861810]  worker_thread+0x238/0x488
[  163.865546]  kthread+0x118/0x120
[  163.868762]  ret_from_fork+0x10/0x18
[  163.872454] run queue from wrong CPU 48, hctx active
[  163.877411] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.886095] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.894606] Workqueue: kblockd blk_mq_run_work_fn
[  163.899297] Call trace:
[  163.901731]  dump_backtrace+0x0/0x150
[  163.905379]  show_stack+0x14/0x20
[  163.908681]  dump_stack+0xb0/0xf8
[  163.911983]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.916414]  blk_mq_run_work_fn+0x1c/0x28
[  163.920411]  process_one_work+0x1e0/0x358
[  163.924407]  worker_thread+0x238/0x488
[  163.928143]  kthread+0x118/0x120
[  163.931359]  ret_from_fork+0x10/0x18
[  163.934932] run queue from wrong CPU 48, hctx active
[  163.939888] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  163.948571] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  163.957082] Workqueue: kblockd blk_mq_run_work_fn
[  163.961773] Call trace:
[  163.964207]  dump_backtrace+0x0/0x150
[  163.967855]  show_stack+0x14/0x20
[  163.971157]  dump_stack+0xb0/0xf8
[  163.974459]  __blk_mq_run_hw_queue+0x11c/0x128
[  163.978890]  blk_mq_run_work_fn+0x1c/0x28
[  163.982886]  process_one_work+0x1e0/0x358
[  163.986882]  worker_thread+0x238/0x488
[  163.990618]  kthread+0x118/0x120
[  163.993833]  ret_from_fork+0x10/0x18
[  163.997406] run queue from wrong CPU 48, hctx active
[  164.002361] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  164.011045] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  164.019556] Workqueue: kblockd blk_mq_run_work_fn
[  164.024247] Call trace:
[  164.026681]  dump_backtrace+0x0/0x150
[  164.030329]  show_stack+0x14/0x20
[  164.033631]  dump_stack+0xb0/0xf8
[  164.036934]  __blk_mq_run_hw_queue+0x11c/0x128
[  164.041364]  blk_mq_run_work_fn+0x1c/0x28
[  164.045360]  process_one_work+0x1e0/0x358
[  164.049357]  worker_thread+0x238/0x488
[  164.053093]  kthread+0x118/0x120
[  164.056308]  ret_from_fork+0x10/0x18
[  164.059885] run queue from wrong CPU 48, hctx active
[  164.064841] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  164.073525] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  164.082036] Workqueue: kblockd blk_mq_run_work_fn
[  164.086726] Call trace:
[  164.089160]  dump_backtrace+0x0/0x150
[  164.092809]  show_stack+0x14/0x20
[  164.096111]  dump_stack+0xb0/0xf8
[  164.099413]  __blk_mq_run_hw_queue+0x11c/0x128
[  164.103844]  blk_mq_run_work_fn+0x1c/0x28
[  164.107840]  process_one_work+0x1e0/0x358
[  164.111836]  worker_thread+0x238/0x488
[  164.115573]  kthread+0x118/0x120
[  164.118788]  ret_from_fork+0x10/0x18
[  164.122361] run queue from wrong CPU 48, hctx active
[  164.127317] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  164.136000] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  164.144512] Workqueue: kblockd blk_mq_run_work_fn
[  164.149203] Call trace:
[  164.151636]  dump_backtrace+0x0/0x150
[  164.155285]  show_stack+0x14/0x20
[  164.158587]  dump_stack+0xb0/0xf8
[  164.161889]  __blk_mq_run_hw_queue+0x11c/0x128
[  164.166319]  blk_mq_run_work_fn+0x1c/0x28
[  164.170315]  process_one_work+0x1e0/0x358
[  164.174312]  worker_thread+0x238/0x488
[  164.178048]  kthread+0x118/0x120
[  164.181263]  ret_from_fork+0x10/0x18
[  164.184839] run queue from wrong CPU 48, hctx active
[  164.189794] CPU: 48 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  164.198478] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  164.206989] Workqueue: kblockd blk_mq_run_work_fn
[  164.211680] Call trace:
[  164.214114]  dump_backtrace+0x0/0x150
[  164.217762]  show_stack+0x14/0x20
[  164.221064]  dump_stack+0xb0/0xf8
[  164.224367]  __blk_mq_run_hw_queue+0x11c/0x128
[  164.228797]  blk_mq_run_work_fn+0x1c/0x28
[  164.232793]  process_one_work+0x1e0/0x358
[  164.236789]  worker_thread+0x238/0x488
[  164.240525]  kthread+0x118/0x120
[  164.243740]  ret_from_fork+0x10/0x18
[  164.247348] run queue from wrong CPU 11, hctx active
[  164.252324] CPU: 11 PID: 874 Comm: kworker/3:2H Not tainted 
5.4.0-rc1-00012-gad025dd3d001 #1098
[  164.261008] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  164.269524] Workqueue: kblockd blk_mq_run_work_fn
[  164.274215] Call trace:
[  164.276649]  dump_backtrace+0x0/0x150
[  164.280299]  show_stack+0x14/0x20
[  164.283603]  dump_stack+0xb0/0xf8
[  164.286904]  __blk_mq_run_hw_queue+0x11c/0x128
[  164.291335]  blk_mq_run_work_fn+0x1c/0x28
[  164.295332]  process_one_work+0x1e0/0x358
[  164.299328]  worker_thread+0x238/0x488
[  164.303065]  kthread+0x118/0x120
[  164.306279]  ret_from_fork+0x10/0x18
[  164.857365] irq_shutdown
[  164.859957] irq_shutdown
[  164.862676] IRQ 799: no longer affine to CPU0
[  164.867332] CPU0: shutdown
[  164.870048] psci: CPU0 killed.
root@(none)$

[I manually added the irq_shutdown print]

 From looking at 7df938fbc4ee641, appearantly it's harmless...

I'll continue to test.

John

>
>> V3:
>>     - re-organize patch 2 & 3 a bit for addressing Hannes's comment
>>     - fix patch 4 for avoiding potential deadlock, as found by Hannes
>>
>> V2:
>>     - patch4 & patch 5 in V1 have been merged to block tree, so remove
>>       them
>>     - addres
>
>
>
> .
>



Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeDEQfe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Apr 2018 12:35:34 -0400
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
Date: Fri, 6 Apr 2018 00:35:24 +0800
MIME-Version: 1.0
In-Reply-To: <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/04/2018 09:22 PM, Sagi Grimberg wrote:
>
>
> On 03/30/2018 12:32 PM, Yi Zhang wrote:
>> Hello
>> I got this kernel BUG on 4.16.0-rc7, here is the reproducer and log, 
>> let me know if you need more info, thanks.
>>
>> Reproducer:
>> 1. setup target
>> #nvmetcli restore /etc/rdma.json
>> 2. connect target on host
>> #nvme connect-all -t rdma -a $IP -s 4420during my NVMeoF RDMA testing
>> 3. do fio background on host
>> #fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite 
>> -ioengine=psync 
>> -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 
>> -bs_unaligned -runtime=180 -size=-group_reporting -name=mytest 
>> -numjobs=60 &
>> 4. offline cpu on host
>> #echo 0 > /sys/devices/system/cpu/cpu1/online
>> #echo 0 > /sys/devices/system/cpu/cpu2/online
>> #echo 0 > /sys/devices/system/cpu/cpu3/online
>> 5. clear target
>> #nvmetcli clear
>> 6. restore target
>> #nvmetcli restore /etc/rdma.json
>> 7. check console log on host
>
> Hi Yi,
>
> Does this happen with this applied?
> -- 
> diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
> index 996167f1de18..b89da55e8aaa 100644
> --- a/block/blk-mq-rdma.c
> +++ b/block/blk-mq-rdma.c
> @@ -35,6 +35,8 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>         const struct cpumask *mask;
>         unsigned int queue, cpu;
>
> +       goto fallback;
> +
>         for (queue = 0; queue < set->nr_hw_queues; queue++) {
>                 mask = ib_get_vector_affinity(dev, first_vec + queue);
>                 if (!mask)
> -- 
>

Hi Sagi

Still can reproduce this issue with the change:

[  133.469908] nvme nvme0: new ctrl: NQN 
"nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
[  133.554025] nvme nvme0: creating 40 I/O queues.
[  133.947648] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
[  138.740870] smpboot: CPU 1 is now offline
[  138.778382] IRQ 37: no longer affine to CPU2
[  138.783153] IRQ 54: no longer affine to CPU2
[  138.787919] IRQ 70: no longer affine to CPU2
[  138.792687] IRQ 98: no longer affine to CPU2
[  138.797458] IRQ 140: no longer affine to CPU2
[  138.802319] IRQ 141: no longer affine to CPU2
[  138.807189] IRQ 166: no longer affine to CPU2
[  138.813622] smpboot: CPU 2 is now offline
[  139.043610] smpboot: CPU 3 is now offline
[  141.587283] print_req_error: operation not supported error, dev 
nvme0n1, sector 494622136
[  141.587303] print_req_error: operation not supported error, dev 
nvme0n1, sector 219643648
[  141.587304] print_req_error: operation not supported error, dev 
nvme0n1, sector 279256456
[  141.587306] print_req_error: operation not supported error, dev 
nvme0n1, sector 1208024
[  141.587322] print_req_error: operation not supported error, dev 
nvme0n1, sector 100575248
[  141.587335] print_req_error: operation not supported error, dev 
nvme0n1, sector 111717456
[  141.587346] print_req_error: operation not supported error, dev 
nvme0n1, sector 171939296
[  141.587348] print_req_error: operation not supported error, dev 
nvme0n1, sector 476420528
[  141.587353] print_req_error: operation not supported error, dev 
nvme0n1, sector 371566696
[  141.587356] print_req_error: operation not supported error, dev 
nvme0n1, sector 161758408
[  141.587463] Buffer I/O error on dev nvme0n1, logical block 54193430, 
lost async page write
[  141.587472] Buffer I/O error on dev nvme0n1, logical block 54193431, 
lost async page write
[  141.587478] Buffer I/O error on dev nvme0n1, logical block 54193432, 
lost async page write
[  141.587483] Buffer I/O error on dev nvme0n1, logical block 54193433, 
lost async page write
[  141.587532] Buffer I/O error on dev nvme0n1, logical block 54193476, 
lost async page write
[  141.587534] Buffer I/O error on dev nvme0n1, logical block 54193477, 
lost async page write
[  141.587536] Buffer I/O error on dev nvme0n1, logical block 54193478, 
lost async page write
[  141.587538] Buffer I/O error on dev nvme0n1, logical block 54193479, 
lost async page write
[  141.587540] Buffer I/O error on dev nvme0n1, logical block 54193480, 
lost async page write
[  141.587542] Buffer I/O error on dev nvme0n1, logical block 54193481, 
lost async page write
[  142.573522] nvme nvme0: Reconnecting in 10 seconds...
[  146.587532] buffer_io_error: 3743628 callbacks suppressed
[  146.587534] Buffer I/O error on dev nvme0n1, logical block 64832757, 
lost async page write
[  146.602837] Buffer I/O error on dev nvme0n1, logical block 64832758, 
lost async page write
[  146.612091] Buffer I/O error on dev nvme0n1, logical block 64832759, 
lost async page write
[  146.621346] Buffer I/O error on dev nvme0n1, logical block 64832760, 
lost async page write
[  146.630615] print_req_error: 556822 callbacks suppressed
[  146.630616] print_req_error: I/O error, dev nvme0n1, sector 518662176
[  146.643776] Buffer I/O error on dev nvme0n1, logical block 64832772, 
lost async page write
[  146.653030] Buffer I/O error on dev nvme0n1, logical block 64832773, 
lost async page write
[  146.662282] Buffer I/O error on dev nvme0n1, logical block 64832774, 
lost async page write
[  146.671542] print_req_error: I/O error, dev nvme0n1, sector 518662568
[  146.678754] Buffer I/O error on dev nvme0n1, logical block 64832821, 
lost async page write
[  146.688003] Buffer I/O error on dev nvme0n1, logical block 64832822, 
lost async page write
[  146.697784] print_req_error: I/O error, dev nvme0n1, sector 518662928
[  146.705450] Buffer I/O error on dev nvme0n1, logical block 64832866, 
lost async page write
[  146.715176] print_req_error: I/O error, dev nvme0n1, sector 518665376
[  146.722920] print_req_error: I/O error, dev nvme0n1, sector 518666136
[  146.730602] print_req_error: I/O error, dev nvme0n1, sector 518666920
[  146.738275] print_req_error: I/O error, dev nvme0n1, sector 518667880
[  146.745944] print_req_error: I/O error, dev nvme0n1, sector 518668096
[  146.753605] print_req_error: I/O error, dev nvme0n1, sector 518668960
[  146.761249] print_req_error: I/O error, dev nvme0n1, sector 518669616
[  149.010303] nvme nvme0: Identify namespace failed
[  149.016171] Dev nvme0n1: unable to read RDB block 0
[  149.022017]  nvme0n1: unable to read partition table
[  149.032192] nvme nvme0: Identify namespace failed
[  149.037857] Dev nvme0n1: unable to read RDB block 0
[  149.043695]  nvme0n1: unable to read partition table
[  153.081673] nvme nvme0: creating 37 I/O queues.
[  153.384977] BUG: unable to handle kernel paging request at 
00003a9ed053bd48
[  153.393197] IP: blk_mq_get_request+0x23e/0x390
[  153.398585] PGD 0 P4D 0
[  153.401841] Oops: 0002 [#1] SMP PTI
[  153.406168] Modules linked in: nvme_rdma nvme_fabrics nvme_core 
nvmet_rdma nvmet sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tabt
[  153.489688]  drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops ttm drm mlx4_core ahci libahci crc32c_intel libata tg3 
i2c_core dd
[  153.509370] CPU: 32 PID: 689 Comm: kworker/u369:6 Not tainted 
4.16.0-rc7.sagi+ #4
[  153.518417] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 
1.6.2 01/08/2016
[  153.527486] Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
[  153.535695] RIP: 0010:blk_mq_get_request+0x23e/0x390
[  153.541973] RSP: 0018:ffffb8cc0853fca8 EFLAGS: 00010246
[  153.548530] RAX: 00003a9ed053bd00 RBX: ffff9e2cbbf30000 RCX: 
000000000000001f
[  153.557230] RDX: 0000000000000000 RSI: ffffffe19b5ba5d2 RDI: 
ffff9e2c90219000
[  153.565923] RBP: ffffb8cc0853fce8 R08: ffffffffffffffff R09: 
0000000000000002
[  153.574628] R10: ffff9e1cbea27160 R11: fffff20780005c00 R12: 
0000000000000023
[  153.583340] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[  153.592062] FS:  0000000000000000(0000) GS:ffff9e1cbea00000(0000) 
knlGS:0000000000000000
[  153.601846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.609013] CR2: 00003a9ed053bd48 CR3: 00000014b560a003 CR4: 
00000000001606e0
[  153.617732] Call Trace:
[  153.621221]  blk_mq_alloc_request_hctx+0xf2/0x140
[  153.627244]  nvme_alloc_request+0x36/0x60 [nvme_core]
[  153.633647]  __nvme_submit_sync_cmd+0x2b/0xd0 [nvme_core]
[  153.640429]  nvmf_connect_io_queue+0x10e/0x170 [nvme_fabrics]
[  153.647613]  nvme_rdma_start_queue+0x21/0x80 [nvme_rdma]
[  153.654300]  nvme_rdma_configure_io_queues+0x196/0x280 [nvme_rdma]
[  153.661947]  nvme_rdma_reconnect_ctrl_work+0x39/0xd0 [nvme_rdma]
[  153.669394]  process_one_work+0x158/0x360
[  153.674618]  worker_thread+0x47/0x3e0
[  153.679458]  kthread+0xf8/0x130
[  153.683717]  ? max_active_store+0x80/0x80
[  153.688952]  ? kthread_bind+0x10/0x10
[  153.693809]  ret_from_fork+0x35/0x40
[  153.698569] Code: 89 83 40 01 00 00 45 84 e4 48 c7 83 48 01 00 00 00 
00 00 00 ba 01 00 00 00 48 8b 45 10 74 0c 31 d2 41 f7 c4 00 08 06 00 0
[  153.721261] RIP: blk_mq_get_request+0x23e/0x390 RSP: ffffb8cc0853fca8
[  153.729264] CR2: 00003a9ed053bd48
[  153.733833] ---[ end trace f77c1388aba74f1c ]---

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <pgwipeout@gmail.com>
Return-Path: <pgwipeout@gmail.com>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
 <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
 <20180728133654.GA8047@ming.t460p>
From: Peter Geis <pgwipeout@gmail.com>
Message-ID: <4284a9b0-2d90-3ffa-0172-9ec5d8f6f8af@gmail.com>
Date: Mon, 30 Jul 2018 14:55:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180728133654.GA8047@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 07/28/2018 09:37 AM, Ming Lei wrote:
> On Wed, Jul 25, 2018 at 02:29:30PM -0400, Peter Geis wrote:
>> On 07/25/2018 02:17 PM, Jens Axboe wrote:
>>> On 7/25/18 10:28 AM, Peter Geis wrote:
>>>> Good Afternoon,
>>>>
>>>> I have encountered an issue on both Tegra 2 and Tegra 3 devices
>>>> accessing emmc following the 25 July 2018 remote tracking merge.
>>>>
>>>> The offending commit is:
>>>> 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
>>>> blk-mq: issue directly if hw queue isn't busy in case of 'none'.
>>>
>>> Can you try my current for-next? This should fix it:
>>>
>>> commit 8824f62246bef288173a6624a363352f0d4d3b09
>>> Author: Ming Lei <ming.lei@redhat.com>
>>> Date:   Sun Jul 22 14:10:15 2018 +0800
>>>
>>>       blk-mq: fail the request in case issue failure
>>>
>>
>> That commit made the current merge window, it must be reverted before
>> reverting the offending commit.
>>
>> With that patch, the bug triggers then the kernel waits for the mmc to
>> recover. It seems however that the bug leaves the mmc in a zombie state,
>> where it is processing the previous command but the kernel has no control
>> over it.
>>
>> [    4.233073] mmc0: Got command interrupt 0x00000001 even though no command
>> operation was in progress.
>> [    4.242189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [    4.248616] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
>> [    4.255041] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>> [    4.261465] mmc0: sdhci: Argument:  0x002e3b10 | Trn mode: 0x00000033
>> [    4.267890] mmc0: sdhci: Present:   0x1ff70000 | Host ctl: 0x00000031
>> [    4.274314] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [    4.280737] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>> [    4.287162] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000002
>> [    4.293586] mmc0: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02fc000b
>> [    4.300010] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
>> [    4.306433] mmc0: sdhci: Caps:      0xe7ffd080 | Caps_1:   0x00000074
>> [    4.312857] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00969696
>> [    4.319281] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x04800e92
>> [    4.325705] mmc0: sdhci: Resp[2]:   0x074b8000 | Resp[3]:  0x00000240
>> [    4.332128] mmc0: sdhci: Host ctl2: 0x00000000
>> [    4.336560] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xae2f9220
>> [    4.342981] mmc0: sdhci: ============================================
> 
> Not found issue in the two merged patches, and it might be one mmc
> internal issue, could you apply the following debug patch and post
> the console log?
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index cf9c66c6d35a..6573684b07e5 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -415,6 +415,8 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
>   			blk_mq_try_issue_list_directly(hctx, list);
>   			if (list_empty(list))
>   				return;
> +			if (blk_queue_debug(q))
> +				trace_printk("issue direct: partial done\n");
>   		}
>   		blk_mq_insert_requests(hctx, ctx, list);
>   	}
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e13bdc2707ce..efb898323e2d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -488,6 +488,9 @@ void blk_mq_free_request(struct request *rq)
>   	struct blk_mq_ctx *ctx = rq->mq_ctx;
>   	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>   
> +	if (blk_queue_debug(q))
> +		trace_printk("complete: rq %d\n", rq->internal_tag);
> +
>   	if (rq->rq_flags & RQF_ELVPRIV) {
>   		if (e && e->type->ops.mq.finish_request)
>   			e->type->ops.mq.finish_request(rq);
> @@ -1793,6 +1796,9 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>   
>   		list_del_init(&rq->queuelist);
>   		ret = blk_mq_request_issue_directly(rq);
> +		if (blk_queue_debug(rq->q))
> +			trace_printk("issue direct: rq %d, ret %d\n",
> +					rq->internal_tag, (int)ret);
>   		if (ret != BLK_STS_OK) {
>   			if (ret == BLK_STS_RESOURCE ||
>   					ret == BLK_STS_DEV_RESOURCE) {
> @@ -1841,6 +1847,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>   		return BLK_QC_T_NONE;
>   	}
>   
> +	 if (blk_queue_debug(q))
> +		 trace_printk("make rq %d\n", rq->internal_tag);
>   	rq_qos_track(q, rq, bio);
>   
>   	cookie = request_to_qc_t(data.hctx, rq);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 648eb6743ed5..90745829cf9a 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -257,6 +257,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>   
>   	if (mmc_card_removed(mq->card)) {
>   		req->rq_flags |= RQF_QUIET;
> +
> +		if (blk_queue_debug(q))
> +			trace_printk("queue rq %d, %s\n", req->internal_tag, "io err");
>   		return BLK_STS_IOERR;
>   	}
>   
> @@ -266,6 +269,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>   
>   	if (mq->recovery_needed) {
>   		spin_unlock_irq(q->queue_lock);
> +		if (blk_queue_debug(q))
> +			trace_printk("queue rq %d, %s\n", req->internal_tag,
> +					"resource");
>   		return BLK_STS_RESOURCE;
>   	}
>   
> @@ -274,6 +280,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		if (mmc_cqe_dcmd_busy(mq)) {
>   			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
>   			spin_unlock_irq(q->queue_lock);
> +			if (blk_queue_debug(q))
> +				trace_printk("queue rq %d, %s\n", req->internal_tag,
> +					"resource");
>   			return BLK_STS_RESOURCE;
>   		}
>   		break;
> @@ -326,6 +335,8 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		break;
>   	}
>   
> +	if (blk_queue_debug(q))
> +		trace_printk("queue rq %d, %d\n", req->internal_tag, (int)ret);
>   	if (issued != MMC_REQ_STARTED) {
>   		bool put_card = false;
>   
> @@ -404,6 +415,8 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
>   	mq->queue->queue_lock = lock;
>   	mq->queue->queuedata = mq;
>   
> +	blk_queue_flag_set(31, mq->queue);
> +
>   	return 0;
>   
>   free_tag_set:
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0e9905..b2b471c2f5f6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2640,6 +2640,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
>   			return;
>   		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
>   		       mmc_hostname(host->mmc), (unsigned)intmask);
> +		ftrace_dump(DUMP_ALL);
>   		sdhci_dumpregs(host);
>   		return;
>   	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 050d599f5ea9..29be3a6d5903 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -741,6 +741,7 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
>   #define blk_queue_preempt_only(q)				\
>   	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
>   #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> +#define blk_queue_debug(q)	test_bit(31, &(q)->queue_flags)
>   
>   extern int blk_set_preempt_only(struct request_queue *q);
>   extern void blk_clear_preempt_only(struct request_queue *q);
> 
> Thanks,
> Ming
> 


Apologies for the long message, but that was a heck of a long log.

[    1.129076] mmc3: new high speed MMC card at address 0001
[    1.130103] mmcblk3: mmc3:0001 SEM32G 29.7 GiB
[    1.130737] mmcblk3boot0: mmc3:0001 SEM32G partition 1 1.00 MiB
[    1.131381] mmcblk3boot1: mmc3:0001 SEM32G partition 2 1.00 MiB
[    1.132976] tegra-dc 54240000.dc: Linked as a consumer to 54200000.dc
[    1.133050] tegra-dc 54240000.dc: coupled to 54200000.dc
[    1.138845] Primary GPT is invalid, using alternate GPT.
[    1.138973]  mmcblk3: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
[    1.142447] usb 1-1: New USB device found, idVendor=22b8, 
idProduct=2a70, bcdDevice= 0.00
[    1.142530] usb 1-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.142587] usb 1-1: Product: Flash MZ600
[    1.142630] usb 1-1: Manufacturer: Motorola, Incorporated
[    1.144277] drm drm: Linked as a consumer to panel
[    1.144679] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.144735] [drm] No driver support for vblank timestamp query.
[    1.260904] Console: switching to colour frame buffer device 160x50
[    1.281076] drm drm: fb0:  frame buffer device
[    1.281265] [drm] Initialized tegra 0.0.0 20120330 for drm on minor 0
[    1.282801] input: gpio-keys as /devices/soc0/gpio-keys/input/input1
[    1.284768] cpcap-rtc 7000d600.spi:pmic@0:rtc: setting system clock 
to 2018-07-30 18:30:24 UTC (1532975424)
[    1.293027] EXT4-fs (mmcblk3p10): INFO: recovery required on readonly 
filesystem
[    1.293230] EXT4-fs (mmcblk3p10): write access will be enabled during 
recovery
[    1.516755] EXT4-fs (mmcblk3p10): recovery complete
[    1.520397] EXT4-fs (mmcblk3p10): mounted filesystem with ordered 
data mode. Opts: (null)
[    1.520678] VFS: Mounted root (ext4 filesystem) readonly on device 
179:26.
[    1.533204] devtmpfs: mounted
[    1.539896] Freeing unused kernel memory: 1024K
[    1.541164] Checked W+X mappings: passed, no W+X pages found
[    2.313488] systemd[1]: systemd 237 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN 
-PCRE2 default-hierarchy=hybrid)
[    2.314953] systemd[1]: Detected architecture arm.
[    2.334923] systemd[1]: Set hostname to <MotoXoom>.
[    2.415408] ------------[ cut here ]------------
[    2.419130] WARNING: CPU: 1 PID: 111 at drivers/mmc/host/sdhci.c:1203 
sdhci_send_command+0x44/0xda4
[    2.422877] Modules linked in:
[    2.426573] CPU: 1 PID: 111 Comm: (direxec) Not tainted 
4.18.0-rc6-next-20180725-00003-g8fb10381dd8a-dirty #112
[    2.430394] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    2.434204] [<c0113174>] (unwind_backtrace) from [<c010dc74>] 
(show_stack+0x20/0x24)
[    2.438038] [<c010dc74>] (show_stack) from [<c08756d8>] 
(dump_stack+0xa8/0xdc)
[    2.441895] [<c08756d8>] (dump_stack) from [<c012bc94>] 
(__warn+0xfc/0x118)
[    2.445752] [<c012bc94>] (__warn) from [<c012bde4>] 
(warn_slowpath_null+0x4c/0x58)
[    2.449662] [<c012bde4>] (warn_slowpath_null) from [<c073257c>] 
(sdhci_send_command+0x44/0xda4)
[    2.453581] [<c073257c>] (sdhci_send_command) from [<c0733724>] 
(sdhci_request+0x13c/0x148)
[    2.457498] [<c0733724>] (sdhci_request) from [<c07185f8>] 
(__mmc_start_request+0x138/0x1b8)
[    2.461422] [<c07185f8>] (__mmc_start_request) from [<c0718718>] 
(mmc_start_request+0xa0/0xb4)
[    2.465380] [<c0718718>] (mmc_start_request) from [<c072c644>] 
(mmc_blk_mq_issue_rq+0x61c/0x788)
[    2.469357] [<c072c644>] (mmc_blk_mq_issue_rq) from [<c072cc70>] 
(mmc_mq_queue_rq+0x1ac/0x2a0)
[    2.473365] [<c072cc70>] (mmc_mq_queue_rq) from [<c0490b24>] 
(__blk_mq_try_issue_directly+0xe8/0x1ac)
[    2.477419] [<c0490b24>] (__blk_mq_try_issue_directly) from 
[<c0491e8c>] (blk_mq_request_issue_directly+0x64/0x98)
[    2.481587] [<c0491e8c>] (blk_mq_request_issue_directly) from 
[<c0491f10>] (blk_mq_try_issue_list_directly+0x50/0xb8)
[    2.485809] [<c0491f10>] (blk_mq_try_issue_list_directly) from 
[<c0495b84>] (blk_mq_sched_insert_requests+0xa8/0xec)
[    2.490089] [<c0495b84>] (blk_mq_sched_insert_requests) from 
[<c0491d80>] (blk_mq_flush_plug_list+0x228/0x2d0)
[    2.494408] [<c0491d80>] (blk_mq_flush_plug_list) from [<c0485a90>] 
(blk_flush_plug_list+0x74/0x208)
[    2.498759] [<c0485a90>] (blk_flush_plug_list) from [<c0486188>] 
(blk_finish_plug+0x38/0x54)
[    2.503108] [<c0486188>] (blk_finish_plug) from [<c0271fec>] 
(read_pages+0x78/0x164)
[    2.507441] [<c0271fec>] (read_pages) from [<c02721c0>] 
(__do_page_cache_readahead+0xe8/0x1d0)
[    2.511786] [<c02721c0>] (__do_page_cache_readahead) from 
[<c0272430>] (ondemand_readahead+0x188/0x278)
[    2.516171] [<c0272430>] (ondemand_readahead) from [<c02727c8>] 
(page_cache_sync_readahead+0xd8/0xdc)
[    2.520591] [<c02727c8>] (page_cache_sync_readahead) from 
[<c0262878>] (generic_file_read_iter+0x294/0xa54)
[    2.525070] [<c0262878>] (generic_file_read_iter) from [<c039112c>] 
(ext4_file_read_iter+0x40/0x54)
[    2.529565] [<c039112c>] (ext4_file_read_iter) from [<c02d29e0>] 
(__vfs_read+0x134/0x164)
[    2.534077] [<c02d29e0>] (__vfs_read) from [<c02d2ab0>] 
(vfs_read+0xa0/0x158)
[    2.538589] [<c02d2ab0>] (vfs_read) from [<c02d2b98>] 
(kernel_read+0x30/0x44)
[    2.543107] [<c02d2b98>] (kernel_read) from [<c02d98d8>] 
(prepare_binprm+0x170/0x194)
[    2.547647] [<c02d98d8>] (prepare_binprm) from [<c02dacfc>] 
(__do_execve_file+0x328/0x76c)
[    2.552202] [<c02dacfc>] (__do_execve_file) from [<c02db1b8>] 
(do_execve+0x38/0x40)
[    2.556710] [<c02db1b8>] (do_execve) from [<c02db3f0>] 
(sys_execve+0x2c/0x30)
[    2.561171] [<c02db3f0>] (sys_execve) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[    2.565652] Exception stack(0xedbb1fa8 to 0xedbb1ff0)
[    2.570123] 1fa0:                   b6f764e0 ffffffff 01e2e8d8 
beaa8b60 beaa8f0c b6f3cb94
[    2.574663] 1fc0: b6f764e0 ffffffff 00000000 0000000b 01e2e744 
01e2e8d8 00000000 ffffffff
[    2.579190] 1fe0: b6e43b08 beaa8ae4 b6d77313 b6ebaba8
[    2.583679] ---[ end trace ade625438f6a48ce ]---
[    2.589234] mmc3: Got command interrupt 0x00000001 even though no 
command operation was in progress.
[    2.594158] Dumping ftrace buffer:
[    2.599091] ---------------------------------
[    2.599139] kworker/-5       0.n.1 808954us : blk_mq_make_request: 
make rq -1
[    2.599160] kworker/-5       0.... 809247us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599183] kworker/-6       0.n.1 824140us : blk_mq_free_request: 
complete: rq -1
[    2.599198] kworker/-5       0.n.1 824386us : blk_mq_make_request: 
make rq -1
[    2.599213] kworker/-5       0.... 824685us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599229] kworker/-98      0.n.1 825920us : blk_mq_free_request: 
complete: rq -1
[    2.599243] kworker/-5       0...1 1132313us : blk_mq_make_request: 
make rq -1
[    2.599258] kworker/-5       0.... 1132491us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599274] kworker/-98      0...1 1134626us : blk_mq_free_request: 
complete: rq -1
[    2.599289] kworker/-5       0...1 1134748us : blk_mq_make_request: 
make rq -1
[    2.599304] kworker/-5       0.... 1134858us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599320] kworker/-98      0...1 1135728us : blk_mq_free_request: 
complete: rq -1
[    2.599334] kworker/-5       0...1 1135813us : blk_mq_make_request: 
make rq -1
[    2.599349] kworker/-5       0.... 1135916us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599364] kworker/-98      0...1 1136952us : blk_mq_free_request: 
complete: rq -1
[    2.599379] kworker/-5       0...1 1137042us : blk_mq_make_request: 
make rq -1
[    2.599393] kworker/-5       0.... 1137148us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599409] kworker/-98      0...1 1137872us : blk_mq_free_request: 
complete: rq -1
[    2.599423] kworker/-5       0...1 1137967us : blk_mq_make_request: 
make rq -1
[    2.599437] kworker/-5       0.... 1138070us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599463] kworker/-98      0...1 1138758us : blk_mq_free_request: 
complete: rq -1
[    2.599491]  systemd-1       1...1 1288178us : blk_mq_make_request: 
make rq -1
[    2.599507]  systemd-1       1.... 1288272us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599524]   <idle>-0       1dnh1 1288745us : blk_mq_free_request: 
complete: rq -1
[    2.599538]  systemd-1       1...1 1289027us : blk_mq_make_request: 
make rq -1
[    2.599553]  systemd-1       1.... 1289080us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599568]   <idle>-0       1dnh1 1289526us : blk_mq_free_request: 
complete: rq -1
[    2.599583]  systemd-1       1...1 1289621us : blk_mq_make_request: 
make rq -1
[    2.599597]  systemd-1       1.... 1289686us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599613]   <idle>-0       1dnh1 1290209us : blk_mq_free_request: 
complete: rq -1
[    2.599627]  systemd-1       1...1 1290282us : blk_mq_make_request: 
make rq -1
[    2.599642]  systemd-1       1.... 1290334us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599656]  systemd-1       1...1 1290367us : blk_mq_make_request: 
make rq -1
[    2.599671]  systemd-1       1...1 1290856us : blk_mq_free_request: 
complete: rq -1
[    2.599685]  systemd-1       1.... 1290864us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599699]  systemd-1       1...1 1290896us : blk_mq_make_request: 
make rq -1
[    2.599714]  systemd-1       1...1 1291438us : blk_mq_free_request: 
complete: rq -1
[    2.599728]  systemd-1       1.... 1291445us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599742]  systemd-1       1...1 1291477us : blk_mq_make_request: 
make rq -1
[    2.599758]  systemd-1       1...1 1291928us : blk_mq_free_request: 
complete: rq -1
[    2.599772]  systemd-1       1.... 1291935us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599787]   <idle>-0       1dnh1 1292516us : blk_mq_free_request: 
complete: rq -1
[    2.599801]  systemd-1       1...1 1293496us : blk_mq_make_request: 
make rq -1
[    2.599816]  systemd-1       1.... 1293564us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599830]  systemd-1       1...1 1293599us : blk_mq_make_request: 
make rq -1
[    2.599845]  systemd-1       1...1 1294206us : blk_mq_free_request: 
complete: rq -1
[    2.599860]  systemd-1       1.... 1294214us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599874]  systemd-1       1...1 1294248us : blk_mq_make_request: 
make rq -1
[    2.599889]  systemd-1       1...1 1294818us : blk_mq_free_request: 
complete: rq -1
[    2.599903]  systemd-1       1.... 1294825us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599917]  systemd-1       1...1 1294858us : blk_mq_make_request: 
make rq -1
[    2.599932]  systemd-1       1...1 1295404us : blk_mq_free_request: 
complete: rq -1
[    2.599947]  systemd-1       1.... 1295411us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.599962]  systemd-1       1...1 1295443us : blk_mq_make_request: 
make rq -1
[    2.599998]  systemd-1       1...1 1295990us : blk_mq_free_request: 
complete: rq -1
[    2.600019]  systemd-1       1.... 1295997us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600053]  systemd-1       1...1 1296029us : blk_mq_make_request: 
make rq -1
[    2.600075]  systemd-1       1...1 1296572us : blk_mq_free_request: 
complete: rq -1
[    2.600091]  systemd-1       1.... 1296579us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600105]  systemd-1       1...1 1296612us : blk_mq_make_request: 
make rq -1
[    2.600121]  systemd-1       1...1 1297162us : blk_mq_free_request: 
complete: rq -1
[    2.600135]  systemd-1       1.... 1297169us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600149]  systemd-1       1...1 1297202us : blk_mq_make_request: 
make rq -1
[    2.600165]  systemd-1       1...1 1297769us : blk_mq_free_request: 
complete: rq -1
[    2.600179]  systemd-1       1.... 1297776us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600194]  systemd-1       1...1 1297822us : blk_mq_make_request: 
make rq -1
[    2.600209]  systemd-1       1...1 1298387us : blk_mq_free_request: 
complete: rq -1
[    2.600224]  systemd-1       1.... 1298395us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600238]  systemd-1       1...1 1298430us : blk_mq_make_request: 
make rq -1
[    2.600253]  systemd-1       1...1 1298992us : blk_mq_free_request: 
complete: rq -1
[    2.600267]  systemd-1       1.... 1298999us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600281]  systemd-1       1...1 1299032us : blk_mq_make_request: 
make rq -1
[    2.600296]  systemd-1       1...1 1299605us : blk_mq_free_request: 
complete: rq -1
[    2.600311]  systemd-1       1.... 1299612us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600325]  systemd-1       1...1 1299644us : blk_mq_make_request: 
make rq -1
[    2.600342]  systemd-1       1...1 1300189us : blk_mq_free_request: 
complete: rq -1
[    2.600356]  systemd-1       1.... 1300196us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600370]  systemd-1       1...1 1300228us : blk_mq_make_request: 
make rq -1
[    2.600385]  systemd-1       1...1 1300773us : blk_mq_free_request: 
complete: rq -1
[    2.600400]  systemd-1       1.... 1300780us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600414]  systemd-1       1...1 1300812us : blk_mq_make_request: 
make rq -1
[    2.600429]  systemd-1       1...1 1301359us : blk_mq_free_request: 
complete: rq -1
[    2.600444]  systemd-1       1.... 1301366us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600457]  systemd-1       1...1 1301397us : blk_mq_make_request: 
make rq -1
[    2.600472]  systemd-1       1...1 1301947us : blk_mq_free_request: 
complete: rq -1
[    2.600487]  systemd-1       1.... 1301954us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600500]  systemd-1       1...1 1301986us : blk_mq_make_request: 
make rq -1
[    2.600516]  systemd-1       1...1 1302605us : blk_mq_free_request: 
complete: rq -1
[    2.600530]  systemd-1       1.... 1302612us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600543]  systemd-1       1...1 1302645us : blk_mq_make_request: 
make rq -1
[    2.600559]  systemd-1       1...1 1303214us : blk_mq_free_request: 
complete: rq -1
[    2.600573]  systemd-1       1.... 1303221us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600586]  systemd-1       1...1 1303253us : blk_mq_make_request: 
make rq -1
[    2.600601]  systemd-1       1...1 1303837us : blk_mq_free_request: 
complete: rq -1
[    2.600615]  systemd-1       1.... 1303844us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600629]  systemd-1       1...1 1303876us : blk_mq_make_request: 
make rq -1
[    2.600644]  systemd-1       1...1 1304449us : blk_mq_free_request: 
complete: rq -1
[    2.600658]  systemd-1       1.... 1304456us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600672]  systemd-1       1...1 1304489us : blk_mq_make_request: 
make rq -1
[    2.600687]  systemd-1       1...1 1305033us : blk_mq_free_request: 
complete: rq -1
[    2.600702]  systemd-1       1.... 1305040us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600715]  systemd-1       1...1 1305072us : blk_mq_make_request: 
make rq -1
[    2.600730]  systemd-1       1...1 1305619us : blk_mq_free_request: 
complete: rq -1
[    2.600744]  systemd-1       1.... 1305626us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600758]  systemd-1       1...1 1305658us : blk_mq_make_request: 
make rq -1
[    2.600773]  systemd-1       1...1 1306202us : blk_mq_free_request: 
complete: rq -1
[    2.600788]  systemd-1       1.... 1306210us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600801]  systemd-1       1...1 1306242us : blk_mq_make_request: 
make rq -1
[    2.600816]  systemd-1       1...1 1306792us : blk_mq_free_request: 
complete: rq -1
[    2.600831]  systemd-1       1.... 1306799us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600845]  systemd-1       1...1 1306845us : blk_mq_make_request: 
make rq -1
[    2.600859]  systemd-1       1...1 1307408us : blk_mq_free_request: 
complete: rq -1
[    2.600874]  systemd-1       1.... 1307415us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600887]  systemd-1       1...1 1307448us : blk_mq_make_request: 
make rq -1
[    2.600902]  systemd-1       1...1 1308020us : blk_mq_free_request: 
complete: rq -1
[    2.600917]  systemd-1       1.... 1308026us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600930]  systemd-1       1...1 1308059us : blk_mq_make_request: 
make rq -1
[    2.600946]  systemd-1       1...1 1308633us : blk_mq_free_request: 
complete: rq -1
[    2.600960]  systemd-1       1.... 1308641us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.600974]  systemd-1       1...1 1308675us : blk_mq_make_request: 
make rq -1
[    2.600989]  systemd-1       1...1 1309244us : blk_mq_free_request: 
complete: rq -1
[    2.601004]  systemd-1       1.... 1309251us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601018]  systemd-1       1...1 1309283us : blk_mq_make_request: 
make rq -1
[    2.601033]  systemd-1       1...1 1309830us : blk_mq_free_request: 
complete: rq -1
[    2.601048]  systemd-1       1.... 1309837us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601062]  systemd-1       1...1 1309870us : blk_mq_make_request: 
make rq -1
[    2.601077]  systemd-1       1...1 1310415us : blk_mq_free_request: 
complete: rq -1
[    2.601091]  systemd-1       1.... 1310422us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601105]  systemd-1       1...1 1310455us : blk_mq_make_request: 
make rq -1
[    2.601120]  systemd-1       1...1 1311001us : blk_mq_free_request: 
complete: rq -1
[    2.601134]  systemd-1       1.... 1311008us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601148]  systemd-1       1...1 1311040us : blk_mq_make_request: 
make rq -1
[    2.601163]  systemd-1       1...1 1311588us : blk_mq_free_request: 
complete: rq -1
[    2.601177]  systemd-1       1.... 1311594us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601191]  systemd-1       1...1 1311627us : blk_mq_make_request: 
make rq -1
[    2.601207]  systemd-1       1...1 1312196us : blk_mq_free_request: 
complete: rq -1
[    2.601221]  systemd-1       1.... 1312203us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601235]  systemd-1       1...1 1312218us : blk_mq_make_request: 
make rq -1
[    2.601250]  systemd-1       1...1 1312804us : blk_mq_free_request: 
complete: rq -1
[    2.601264]  systemd-1       1.... 1312811us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601280]   <idle>-0       1dnh1 1313298us : blk_mq_free_request: 
complete: rq -1
[    2.601294]  systemd-1       1...1 1313448us : blk_mq_make_request: 
make rq -1
[    2.601308]  systemd-1       1.... 1313502us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601323]   <idle>-0       1dnh1 1314221us : blk_mq_free_request: 
complete: rq -1
[    2.601338]  systemd-1       1...1 1314432us : blk_mq_make_request: 
make rq -1
[    2.601352]  systemd-1       1.... 1314494us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601366]  systemd-1       1...1 1314511us : blk_mq_make_request: 
make rq -1
[    2.601381]  systemd-1       1...1 1315019us : blk_mq_free_request: 
complete: rq -1
[    2.601395]  systemd-1       1.... 1315026us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601409]  systemd-1       1...1 1315041us : blk_mq_make_request: 
make rq -1
[    2.601424]  systemd-1       1...1 1315514us : blk_mq_free_request: 
complete: rq -1
[    2.601438]  systemd-1       1.... 1315521us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601452]  systemd-1       1...1 1315536us : blk_mq_make_request: 
make rq -1
[    2.601467]  systemd-1       1...1 1316008us : blk_mq_free_request: 
complete: rq -1
[    2.601481]  systemd-1       1.... 1316014us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601495]  systemd-1       1...1 1316029us : blk_mq_make_request: 
make rq -1
[    2.601510]  systemd-1       1...1 1316590us : blk_mq_free_request: 
complete: rq -1
[    2.601524]  systemd-1       1.... 1316597us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601538]  systemd-1       1...1 1316612us : blk_mq_make_request: 
make rq -1
[    2.601553]  systemd-1       1...1 1317176us : blk_mq_free_request: 
complete: rq -1
[    2.601567]  systemd-1       1.... 1317182us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601581]  systemd-1       1...1 1317197us : blk_mq_make_request: 
make rq -1
[    2.601596]  systemd-1       1...1 1317758us : blk_mq_free_request: 
complete: rq -1
[    2.601610]  systemd-1       1.... 1317765us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601624]  systemd-1       1...1 1317780us : blk_mq_make_request: 
make rq -1
[    2.601639]  systemd-1       1...1 1318353us : blk_mq_free_request: 
complete: rq -1
[    2.601654]  systemd-1       1.... 1318361us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601668]  systemd-1       1...1 1318511us : blk_mq_make_request: 
make rq -1
[    2.601683]  systemd-1       1...1 1318937us : blk_mq_free_request: 
complete: rq -1
[    2.601697]  systemd-1       1.... 1318944us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601711]  systemd-1       1...1 1318959us : blk_mq_make_request: 
make rq -1
[    2.601726]  systemd-1       1...1 1319523us : blk_mq_free_request: 
complete: rq -1
[    2.601740]  systemd-1       1.... 1319530us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601754]  systemd-1       1...1 1319544us : blk_mq_make_request: 
make rq -1
[    2.601769]  systemd-1       1...1 1320105us : blk_mq_free_request: 
complete: rq -1
[    2.601784]  systemd-1       1.... 1320112us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601797]  systemd-1       1...1 1320127us : blk_mq_make_request: 
make rq -1
[    2.601813]  systemd-1       1...1 1320694us : blk_mq_free_request: 
complete: rq -1
[    2.601827]  systemd-1       1.... 1320701us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601841]  systemd-1       1...1 1320716us : blk_mq_make_request: 
make rq -1
[    2.601856]  systemd-1       1...1 1321302us : blk_mq_free_request: 
complete: rq -1
[    2.601871]  systemd-1       1.... 1321312us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601885]  systemd-1       1...1 1321327us : blk_mq_make_request: 
make rq -1
[    2.601901]  systemd-1       1...1 1321910us : blk_mq_free_request: 
complete: rq -1
[    2.601915]  systemd-1       1.... 1321917us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601929]  systemd-1       1...1 1321932us : blk_mq_make_request: 
make rq -1
[    2.601944]  systemd-1       1...1 1322519us : blk_mq_free_request: 
complete: rq -1
[    2.601959]  systemd-1       1.... 1322526us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.601973]  systemd-1       1...1 1322541us : blk_mq_make_request: 
make rq -1
[    2.601988]  systemd-1       1...1 1323130us : blk_mq_free_request: 
complete: rq -1
[    2.602002]  systemd-1       1.... 1323136us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602016]  systemd-1       1...1 1323316us : blk_mq_make_request: 
make rq -1
[    2.602032]  systemd-1       1...1 1324064us : blk_mq_free_request: 
complete: rq -1
[    2.602046]  systemd-1       1.... 1324076us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602060]  systemd-1       1...1 1324103us : blk_mq_make_request: 
make rq -1
[    2.602075]  systemd-1       1...1 1324678us : blk_mq_free_request: 
complete: rq -1
[    2.602090]  systemd-1       1.... 1324689us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602104]  systemd-1       1...1 1324714us : blk_mq_make_request: 
make rq -1
[    2.602120]  systemd-1       1...1 1325291us : blk_mq_free_request: 
complete: rq -1
[    2.602134]  systemd-1       1.... 1325302us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602148]  systemd-1       1...1 1325327us : blk_mq_make_request: 
make rq -1
[    2.602190]  systemd-1       1...1 1325911us : blk_mq_free_request: 
complete: rq -1
[    2.602226]  systemd-1       1.... 1325922us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602244]  systemd-1       1...1 1325947us : blk_mq_make_request: 
make rq -1
[    2.602261]  systemd-1       1...1 1326550us : blk_mq_free_request: 
complete: rq -1
[    2.602284]  systemd-1       1.... 1326561us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602318]  systemd-1       1...1 1326586us : blk_mq_make_request: 
make rq -1
[    2.602349]  systemd-1       1...1 1327186us : blk_mq_free_request: 
complete: rq -1
[    2.602371]  systemd-1       1.... 1327197us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602404]  systemd-1       1...1 1327222us : blk_mq_make_request: 
make rq -1
[    2.602422]  systemd-1       1...1 1327827us : blk_mq_free_request: 
complete: rq -1
[    2.602437]  systemd-1       1.... 1327838us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602452]  systemd-1       1...1 1327863us : blk_mq_make_request: 
make rq -1
[    2.602467]  systemd-1       1...1 1328479us : blk_mq_free_request: 
complete: rq -1
[    2.602481]  systemd-1       1.... 1328491us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602496]  systemd-1       1...1 1328776us : blk_mq_make_request: 
make rq -1
[    2.602511]  systemd-1       1...1 1329096us : blk_mq_free_request: 
complete: rq -1
[    2.602526]  systemd-1       1.... 1329108us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602540]  systemd-1       1...1 1329133us : blk_mq_make_request: 
make rq -1
[    2.602561]  systemd-1       1...1 1329710us : blk_mq_free_request: 
complete: rq -1
[    2.602593]  systemd-1       1.... 1329722us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602628]  systemd-1       1...1 1329747us : blk_mq_make_request: 
make rq -1
[    2.602657]  systemd-1       1...1 1330324us : blk_mq_free_request: 
complete: rq -1
[    2.602682]  systemd-1       1.... 1330336us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602710]  systemd-1       1...1 1330359us : blk_mq_make_request: 
make rq -1
[    2.602727]  systemd-1       1...1 1330943us : blk_mq_free_request: 
complete: rq -1
[    2.602742]  systemd-1       1.... 1330954us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602756]  systemd-1       1...1 1330979us : blk_mq_make_request: 
make rq -1
[    2.602772]  systemd-1       1...1 1331579us : blk_mq_free_request: 
complete: rq -1
[    2.602786]  systemd-1       1.... 1331591us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602800]  systemd-1       1...1 1331616us : blk_mq_make_request: 
make rq -1
[    2.602816]  systemd-1       1...1 1332219us : blk_mq_free_request: 
complete: rq -1
[    2.602830]  systemd-1       1.... 1332231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602844]  systemd-1       1...1 1332255us : blk_mq_make_request: 
make rq -1
[    2.602860]  systemd-1       1...1 1332860us : blk_mq_free_request: 
complete: rq -1
[    2.602897]  systemd-1       1.... 1332871us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.602915]  systemd-1       1...1 1332895us : blk_mq_make_request: 
make rq -1
[    2.602940]  systemd-1       1...1 1333499us : blk_mq_free_request: 
complete: rq -1
[    2.602975]  systemd-1       1.... 1333511us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603011]  systemd-1       1d.h. 1334109us : blk_mq_free_request: 
complete: rq -1
[    2.603044]  systemd-1       1...1 1334149us : blk_mq_make_request: 
make rq -1
[    2.603081]  systemd-1       1.... 1334237us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603099]  systemd-1       1...1 1334263us : blk_mq_make_request: 
make rq -1
[    2.603116]  systemd-1       1...1 1334904us : blk_mq_free_request: 
complete: rq -1
[    2.603134]  systemd-1       1.... 1334916us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603166]  systemd-1       1...1 1334941us : blk_mq_make_request: 
make rq -1
[    2.603185]  systemd-1       1...1 1335543us : blk_mq_free_request: 
complete: rq -1
[    2.603200]  systemd-1       1.... 1335555us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603214]  systemd-1       1...1 1335580us : blk_mq_make_request: 
make rq -1
[    2.603231]  systemd-1       1...1 1336192us : blk_mq_free_request: 
complete: rq -1
[    2.603265]  systemd-1       1.... 1336203us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603301]  systemd-1       1...1 1336227us : blk_mq_make_request: 
make rq -1
[    2.603321]  systemd-1       1...1 1336831us : blk_mq_free_request: 
complete: rq -1
[    2.603341]  systemd-1       1.... 1336843us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603374]  systemd-1       1...1 1336868us : blk_mq_make_request: 
make rq -1
[    2.603392]  systemd-1       1...1 1337476us : blk_mq_free_request: 
complete: rq -1
[    2.603408]  systemd-1       1.... 1337487us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603422]  systemd-1       1...1 1337512us : blk_mq_make_request: 
make rq -1
[    2.603438]  systemd-1       1.n.1 1338203us : blk_mq_free_request: 
complete: rq -1
[    2.603453]  systemd-1       1.... 1338366us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603467]  systemd-1       1...1 1338395us : blk_mq_make_request: 
make rq -1
[    2.603482]  systemd-1       1...1 1338717us : blk_mq_free_request: 
complete: rq -1
[    2.603497]  systemd-1       1.... 1338729us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603511]  systemd-1       1...1 1338985us : blk_mq_make_request: 
make rq -1
[    2.603526]  systemd-1       1...1 1339337us : blk_mq_free_request: 
complete: rq -1
[    2.603541]  systemd-1       1.... 1339349us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603555]  systemd-1       1...1 1339374us : blk_mq_make_request: 
make rq -1
[    2.603570]  systemd-1       1...1 1339953us : blk_mq_free_request: 
complete: rq -1
[    2.603584]  systemd-1       1.... 1339964us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603599]  systemd-1       1...1 1339989us : blk_mq_make_request: 
make rq -1
[    2.603614]  systemd-1       1...1 1340593us : blk_mq_free_request: 
complete: rq -1
[    2.603628]  systemd-1       1.... 1340604us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603642]  systemd-1       1...1 1340629us : blk_mq_make_request: 
make rq -1
[    2.603657]  systemd-1       1...1 1341232us : blk_mq_free_request: 
complete: rq -1
[    2.603672]  systemd-1       1.... 1341244us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603686]  systemd-1       1...1 1341267us : blk_mq_make_request: 
make rq -1
[    2.603719]  systemd-1       1...1 1341869us : blk_mq_free_request: 
complete: rq -1
[    2.603746]  systemd-1       1.... 1341880us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603775]  systemd-1       1...1 1341904us : blk_mq_make_request: 
make rq -1
[    2.603801]  systemd-1       1...1 1342511us : blk_mq_free_request: 
complete: rq -1
[    2.603830]  systemd-1       1.... 1342523us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603852]  systemd-1       1...1 1342547us : blk_mq_make_request: 
make rq -1
[    2.603888]  systemd-1       1...1 1343124us : blk_mq_free_request: 
complete: rq -1
[    2.603906]  systemd-1       1.... 1343136us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603921]  systemd-1       1...1 1343160us : blk_mq_make_request: 
make rq -1
[    2.603938]  systemd-1       1...1 1344330us : blk_mq_free_request: 
complete: rq -1
[    2.603974]  systemd-1       1.... 1344339us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.603992]  systemd-1       1...1 1344551us : blk_mq_make_request: 
make rq -1
[    2.604008]  systemd-1       1...1 1344927us : blk_mq_free_request: 
complete: rq -1
[    2.604023]  systemd-1       1.... 1344937us : mmc_mq_queue_rq: queue 
rq -1, 0
[    2.604049]  systemd-1       1...1 1344955us : blk_mq_make_request: 
make rq -1
[    2.604068]  systemd-1       1...1 1345526us : blk_mq_free_request: 
complete: rq -1
[    2.604088]  systemd-1       1.... 1345535us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.322137]  systemd-1       1...1 1345553us : blk_mq_make_request: 
make rq -1
[    3.324380]  systemd-1       1...1 1346143us : blk_mq_free_request: 
complete: rq -1
[    3.326617]  systemd-1       1.... 1346152us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.328863]  systemd-1       1...1 1346170us : blk_mq_make_request: 
make rq -1
[    3.331106]  systemd-1       1...1 1346763us : blk_mq_free_request: 
complete: rq -1
[    3.333344]  systemd-1       1.... 1346772us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.335592]  systemd-1       1...1 1346790us : blk_mq_make_request: 
make rq -1
[    3.337837]  systemd-1       1...1 1347384us : blk_mq_free_request: 
complete: rq -1
[    3.340079]  systemd-1       1.... 1347392us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.342332]  systemd-1       1...1 1347410us : blk_mq_make_request: 
make rq -1
[    3.344585]  systemd-1       1...1 1348005us : blk_mq_free_request: 
complete: rq -1
[    3.346840]  systemd-1       1.... 1348014us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.349105]  systemd-1       1...1 1348032us : blk_mq_make_request: 
make rq -1
[    3.351370]  systemd-1       1...1 1348610us : blk_mq_free_request: 
complete: rq -1
[    3.353629]  systemd-1       1.... 1348619us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.355896]  systemd-1       1...1 1348638us : blk_mq_make_request: 
make rq -1
[    3.358159]  systemd-1       1...1 1349206us : blk_mq_free_request: 
complete: rq -1
[    3.360421]  systemd-1       1.... 1349215us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.362693]  systemd-1       1...1 1349405us : blk_mq_make_request: 
make rq -1
[    3.364964]  systemd-1       1...1 1349803us : blk_mq_free_request: 
complete: rq -1
[    3.367231]  systemd-1       1.... 1349812us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.369503]  systemd-1       1...1 1349831us : blk_mq_make_request: 
make rq -1
[    3.371777]  systemd-1       1...1 1350400us : blk_mq_free_request: 
complete: rq -1
[    3.374048]  systemd-1       1.... 1350409us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.376329]  systemd-1       1...1 1350427us : blk_mq_make_request: 
make rq -1
[    3.378611]  systemd-1       1...1 1351021us : blk_mq_free_request: 
complete: rq -1
[    3.380885]  systemd-1       1.... 1351030us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.383177]  systemd-1       1...1 1351048us : blk_mq_make_request: 
make rq -1
[    3.385464]  systemd-1       1...1 1351639us : blk_mq_free_request: 
complete: rq -1
[    3.387748]  systemd-1       1.... 1351648us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.390041]  systemd-1       1...1 1351666us : blk_mq_make_request: 
make rq -1
[    3.392336]  systemd-1       1...1 1352259us : blk_mq_free_request: 
complete: rq -1
[    3.394627]  systemd-1       1.... 1352267us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.396922]  systemd-1       1...1 1352286us : blk_mq_make_request: 
make rq -1
[    3.399219]  systemd-1       1...1 1352884us : blk_mq_free_request: 
complete: rq -1
[    3.401514]  systemd-1       1.... 1352892us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.403824]  systemd-1       1...1 1352911us : blk_mq_make_request: 
make rq -1
[    3.406128]  systemd-1       1...1 1353478us : blk_mq_free_request: 
complete: rq -1
[    3.408433]  systemd-1       1.... 1353486us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.410746]  systemd-1       1...1 1353504us : blk_mq_make_request: 
make rq -1
[    3.413047]  systemd-1       1...1 1354076us : blk_mq_free_request: 
complete: rq -1
[    3.415353]  systemd-1       1.... 1354084us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.417674]  systemd-1       1...1 1354572us : blk_mq_make_request: 
make rq -1
[    3.419996]  systemd-1       1...1 1354668us : blk_mq_free_request: 
complete: rq -1
[    3.422314]  systemd-1       1.... 1354678us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.424641]  systemd-1       1...1 1354696us : blk_mq_make_request: 
make rq -1
[    3.426966]  systemd-1       1...1 1355274us : blk_mq_free_request: 
complete: rq -1
[    3.429284]  systemd-1       1.... 1355282us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.431617]  systemd-1       1...1 1355301us : blk_mq_make_request: 
make rq -1
[    3.433953]  systemd-1       1...1 1355900us : blk_mq_free_request: 
complete: rq -1
[    3.436280]  systemd-1       1.... 1355908us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.438610]  systemd-1       1...1 1355927us : blk_mq_make_request: 
make rq -1
[    3.440939]  systemd-1       1...1 1356516us : blk_mq_free_request: 
complete: rq -1
[    3.443265]  systemd-1       1.... 1356525us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.445595]  systemd-1       1...1 1356544us : blk_mq_make_request: 
make rq -1
[    3.447927]  systemd-1       1...1 1357137us : blk_mq_free_request: 
complete: rq -1
[    3.450252]  systemd-1       1.... 1357145us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.452586]  systemd-1       1...1 1357164us : blk_mq_make_request: 
make rq -1
[    3.454915]  systemd-1       1...1 1357758us : blk_mq_free_request: 
complete: rq -1
[    3.457238]  systemd-1       1.... 1357767us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.459565]  systemd-1       1...1 1357785us : blk_mq_make_request: 
make rq -1
[    3.461888]  systemd-1       1...1 1358363us : blk_mq_free_request: 
complete: rq -1
[    3.464213]  systemd-1       1.... 1358372us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.466545]  systemd-1       1...1 1358392us : blk_mq_make_request: 
make rq -1
[    3.468872]  systemd-1       1...1 1358959us : blk_mq_free_request: 
complete: rq -1
[    3.471197]  systemd-1       1.... 1358967us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.473525]  systemd-1       1...1 1359160us : blk_mq_make_request: 
make rq -1
[    3.475857]  systemd-1       1...1 1359556us : blk_mq_free_request: 
complete: rq -1
[    3.478183]  systemd-1       1.... 1359565us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.480512]  systemd-1       1...1 1359584us : blk_mq_make_request: 
make rq -1
[    3.482839]  systemd-1       1...1 1360157us : blk_mq_free_request: 
complete: rq -1
[    3.485163]  systemd-1       1.... 1360166us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.487498]  systemd-1       1...1 1360185us : blk_mq_make_request: 
make rq -1
[    3.489829]  systemd-1       1...1 1360775us : blk_mq_free_request: 
complete: rq -1
[    3.492154]  systemd-1       1.... 1360783us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.494485]  systemd-1       1...1 1360801us : blk_mq_make_request: 
make rq -1
[    3.496811]  systemd-1       1...1 1361396us : blk_mq_free_request: 
complete: rq -1
[    3.499133]  systemd-1       1.... 1361405us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.501470]  systemd-1       1...1 1361423us : blk_mq_make_request: 
make rq -1
[    3.503804]  systemd-1       1...1 1362014us : blk_mq_free_request: 
complete: rq -1
[    3.506134]  systemd-1       1.... 1362023us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.508469]  systemd-1       1...1 1362041us : blk_mq_make_request: 
make rq -1
[    3.510802]  systemd-1       1...1 1362637us : blk_mq_free_request: 
complete: rq -1
[    3.513131]  systemd-1       1.... 1362646us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.515473]  systemd-1       1...1 1362664us : blk_mq_make_request: 
make rq -1
[    3.517809]  systemd-1       1...1 1363234us : blk_mq_free_request: 
complete: rq -1
[    3.520138]  systemd-1       1.... 1363242us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.522471]  systemd-1       1...1 1363261us : blk_mq_make_request: 
make rq -1
[    3.524800]  systemd-1       1...1 1363828us : blk_mq_free_request: 
complete: rq -1
[    3.527126]  systemd-1       1.... 1363836us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.529460]  systemd-1       1...1 1364060us : blk_mq_make_request: 
make rq -1
[    3.531794]  systemd-1       1...1 1364465us : blk_mq_free_request: 
complete: rq -1
[    3.534118]  systemd-1       1.... 1364474us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.536454]  systemd-1       1...1 1364494us : blk_mq_make_request: 
make rq -1
[    3.538782]  systemd-1       1...1 1365062us : blk_mq_free_request: 
complete: rq -1
[    3.541104]  systemd-1       1.... 1365070us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.543440]  systemd-1       1...1 1365088us : blk_mq_make_request: 
make rq -1
[    3.545772]  systemd-1       1...1 1365680us : blk_mq_free_request: 
complete: rq -1
[    3.548098]  systemd-1       1.... 1365689us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.550433]  systemd-1       1...1 1365708us : blk_mq_make_request: 
make rq -1
[    3.552769]  systemd-1       1...1 1366308us : blk_mq_free_request: 
complete: rq -1
[    3.555099]  systemd-1       1.... 1366317us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.557433]  systemd-1       1...1 1366335us : blk_mq_make_request: 
make rq -1
[    3.559759]  systemd-1       1...1 1366928us : blk_mq_free_request: 
complete: rq -1
[    3.562085]  systemd-1       1.... 1366937us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.564418]  systemd-1       1...1 1366956us : blk_mq_make_request: 
make rq -1
[    3.566748]  systemd-1       1...1 1367551us : blk_mq_free_request: 
complete: rq -1
[    3.569071]  systemd-1       1.... 1367560us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.571401]  systemd-1       1...1 1367578us : blk_mq_make_request: 
make rq -1
[    3.573721]  systemd-1       0.... 1368242us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.576055] rcu_pree-10      1d.h1 1368254us : blk_mq_free_request: 
complete: rq -1
[    3.578420]  systemd-1       0...1 1368269us : blk_mq_make_request: 
make rq -1
[    3.580774]  systemd-1       0.... 1368838us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.583141]   <idle>-0       1d.h1 1368849us : blk_mq_free_request: 
complete: rq -1
[    3.585538]  systemd-1       0...1 1369053us : blk_mq_make_request: 
make rq -1
[    3.587934]  systemd-1       0...1 1369449us : blk_mq_free_request: 
complete: rq -1
[    3.590318]  systemd-1       0.... 1369458us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.592714]  systemd-1       0...1 1369477us : blk_mq_make_request: 
make rq -1
[    3.595107]  systemd-1       0...1 1370048us : blk_mq_free_request: 
complete: rq -1
[    3.597495]  systemd-1       0.... 1370057us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.599884]  systemd-1       0...1 1370075us : blk_mq_make_request: 
make rq -1
[    3.602277]  systemd-1       0...1 1370674us : blk_mq_free_request: 
complete: rq -1
[    3.604663]  systemd-1       0.... 1370682us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.607056]  systemd-1       0...1 1370701us : blk_mq_make_request: 
make rq -1
[    3.609454]  systemd-1       0...1 1371296us : blk_mq_free_request: 
complete: rq -1
[    3.611842]  systemd-1       0.... 1371305us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.614241]  systemd-1       0...1 1371323us : blk_mq_make_request: 
make rq -1
[    3.616630]  systemd-1       0...1 1371922us : blk_mq_free_request: 
complete: rq -1
[    3.619015]  systemd-1       0.... 1371931us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.621408]  systemd-1       0...1 1371949us : blk_mq_make_request: 
make rq -1
[    3.623799]  systemd-1       0...1 1372548us : blk_mq_free_request: 
complete: rq -1
[    3.626188]  systemd-1       0.... 1372556us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.628585]  systemd-1       0...1 1372575us : blk_mq_make_request: 
make rq -1
[    3.630974]  systemd-1       0...1 1373147us : blk_mq_free_request: 
complete: rq -1
[    3.633362]  systemd-1       0.... 1373155us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.635753]  systemd-1       0...1 1373174us : blk_mq_make_request: 
make rq -1
[    3.638138]  systemd-1       0...1 1373748us : blk_mq_free_request: 
complete: rq -1
[    3.640525]  systemd-1       0.... 1373756us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.642926] kworker/-98      0...1 1374337us : blk_mq_free_request: 
complete: rq -1
[    3.645338]  systemd-1       0...1 1374612us : blk_mq_make_request: 
make rq -1
[    3.647750]  systemd-1       0.... 1374698us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.650171]  systemd-1       0...1 1374717us : blk_mq_make_request: 
make rq -1
[    3.652585]  systemd-1       0...1 1375345us : blk_mq_free_request: 
complete: rq -1
[    3.655000]  systemd-1       0.... 1375354us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.657423]  systemd-1       0...1 1375373us : blk_mq_make_request: 
make rq -1
[    3.659843]  systemd-1       0...1 1375972us : blk_mq_free_request: 
complete: rq -1
[    3.662257]  systemd-1       0.... 1375980us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.664678]  systemd-1       0...1 1375999us : blk_mq_make_request: 
make rq -1
[    3.667099]  systemd-1       0...1 1376594us : blk_mq_free_request: 
complete: rq -1
[    3.669510]  systemd-1       0.... 1376602us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.671934]  systemd-1       0...1 1376621us : blk_mq_make_request: 
make rq -1
[    3.674359]  systemd-1       0...1 1377222us : blk_mq_free_request: 
complete: rq -1
[    3.676779]  systemd-1       0.... 1377231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.679207]  systemd-1       0...1 1377249us : blk_mq_make_request: 
make rq -1
[    3.681629]  systemd-1       0...1 1377821us : blk_mq_free_request: 
complete: rq -1
[    3.684046]  systemd-1       0.... 1377829us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.686467]  systemd-1       0...1 1377848us : blk_mq_make_request: 
make rq -1
[    3.688892]  systemd-1       0...1 1378422us : blk_mq_free_request: 
complete: rq -1
[    3.691310]  systemd-1       0.... 1378430us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.693724]  systemd-1       0...1 1378450us : blk_mq_make_request: 
make rq -1
[    3.696118]  systemd-1       0...1 1379021us : blk_mq_free_request: 
complete: rq -1
[    3.698497]  systemd-1       0.... 1379030us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.700881]  systemd-1       0...1 1379219us : blk_mq_make_request: 
make rq -1
[    3.703243]  systemd-1       0...1 1379626us : blk_mq_free_request: 
complete: rq -1
[    3.705600]  systemd-1       0.... 1379634us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.707958]  systemd-1       0...1 1379653us : blk_mq_make_request: 
make rq -1
[    3.710317]  systemd-1       0...1 1380250us : blk_mq_free_request: 
complete: rq -1
[    3.712677]  systemd-1       0.... 1380259us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.715038]  systemd-1       0...1 1380277us : blk_mq_make_request: 
make rq -1
[    3.717396]  systemd-1       0...1 1380889us : blk_mq_free_request: 
complete: rq -1
[    3.719749]  systemd-1       0.... 1380898us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.722109]  systemd-1       0...1 1380916us : blk_mq_make_request: 
make rq -1
[    3.724466]  systemd-1       0...1 1381524us : blk_mq_free_request: 
complete: rq -1
[    3.726819]  systemd-1       0.... 1381532us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.729175]  systemd-1       0...1 1381551us : blk_mq_make_request: 
make rq -1
[    3.731531]  systemd-1       0...1 1382153us : blk_mq_free_request: 
complete: rq -1
[    3.733879]  systemd-1       0.... 1382162us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.736240]  systemd-1       0...1 1382180us : blk_mq_make_request: 
make rq -1
[    3.738599]  systemd-1       0...1 1382762us : blk_mq_free_request: 
complete: rq -1
[    3.740951]  systemd-1       0.... 1382771us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.743311]  systemd-1       0...1 1382789us : blk_mq_make_request: 
make rq -1
[    3.745662]  systemd-1       0...1 1383371us : blk_mq_free_request: 
complete: rq -1
[    3.748014]  systemd-1       0.... 1383379us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.750373]  systemd-1       0...1 1383398us : blk_mq_make_request: 
make rq -1
[    3.752729]  systemd-1       0...1 1383973us : blk_mq_free_request: 
complete: rq -1
[    3.755077]  systemd-1       0.... 1383982us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.757437]  systemd-1       0...1 1384185us : blk_mq_make_request: 
make rq -1
[    3.759792]  systemd-1       0...1 1384592us : blk_mq_free_request: 
complete: rq -1
[    3.762125]  systemd-1       0.... 1384601us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.764449]  systemd-1       0...1 1384620us : blk_mq_make_request: 
make rq -1
[    3.766780]  systemd-1       0...1 1385203us : blk_mq_free_request: 
complete: rq -1
[    3.769099]  systemd-1       0.... 1385212us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.771426]  systemd-1       0...1 1385230us : blk_mq_make_request: 
make rq -1
[    3.773754]  systemd-1       0...1 1386060us : blk_mq_free_request: 
complete: rq -1
[    3.776080]  systemd-1       0.... 1386073us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.778417]  systemd-1       0...1 1386099us : blk_mq_make_request: 
make rq -1
[    3.780749]  systemd-1       0...1 1386701us : blk_mq_free_request: 
complete: rq -1
[    3.783069]  systemd-1       0.... 1386713us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.785397]  systemd-1       0...1 1386738us : blk_mq_make_request: 
make rq -1
[    3.787720]  systemd-1       0...1 1387343us : blk_mq_free_request: 
complete: rq -1
[    3.790043]  systemd-1       0.... 1387354us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.792376]  systemd-1       0...1 1387379us : blk_mq_make_request: 
make rq -1
[    3.794704]  systemd-1       0...1 1388002us : blk_mq_free_request: 
complete: rq -1
[    3.797029]  systemd-1       0.... 1388013us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.799356]  systemd-1       0...1 1388037us : blk_mq_make_request: 
make rq -1
[    3.801685]  systemd-1       0...1 1388667us : blk_mq_free_request: 
complete: rq -1
[    3.804007]  systemd-1       0.... 1388679us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.806341]  systemd-1       0...1 1388704us : blk_mq_make_request: 
make rq -1
[    3.808671]  systemd-1       0...1 1389323us : blk_mq_free_request: 
complete: rq -1
[    3.810999]  systemd-1       0.... 1389335us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.813336]  systemd-1       0...1 1389588us : blk_mq_make_request: 
make rq -1
[    3.815665]  systemd-1       0...1 1389987us : blk_mq_free_request: 
complete: rq -1
[    3.817985]  systemd-1       0.... 1389999us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.820318]  systemd-1       0...1 1390023us : blk_mq_make_request: 
make rq -1
[    3.822651]  systemd-1       0...1 1390630us : blk_mq_free_request: 
complete: rq -1
[    3.824978]  systemd-1       0.... 1390641us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.827312]  systemd-1       0...1 1390665us : blk_mq_make_request: 
make rq -1
[    3.829641]  systemd-1       0...1 1391269us : blk_mq_free_request: 
complete: rq -1
[    3.831970]  systemd-1       0.... 1391280us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.834308]  systemd-1       0...1 1391305us : blk_mq_make_request: 
make rq -1
[    3.836645]  systemd-1       0...1 1391911us : blk_mq_free_request: 
complete: rq -1
[    3.838974]  systemd-1       0.... 1391922us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.841309]  systemd-1       0...1 1391947us : blk_mq_make_request: 
make rq -1
[    3.843643]  systemd-1       0...1 1392554us : blk_mq_free_request: 
complete: rq -1
[    3.845971]  systemd-1       0.... 1392565us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.848304]  systemd-1       0...1 1392589us : blk_mq_make_request: 
make rq -1
[    3.850633]  systemd-1       0...1 1393212us : blk_mq_free_request: 
complete: rq -1
[    3.852958]  systemd-1       0.... 1393223us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.855298]  systemd-1       0...1 1393248us : blk_mq_make_request: 
make rq -1
[    3.857626]  systemd-1       0...1 1393874us : blk_mq_free_request: 
complete: rq -1
[    3.859953]  systemd-1       0.... 1393885us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.862289]  systemd-1       0...1 1393909us : blk_mq_make_request: 
make rq -1
[    3.864626]  systemd-1       0...1 1394533us : blk_mq_free_request: 
complete: rq -1
[    3.866956]  systemd-1       0.... 1394545us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.869295]  systemd-1       0...1 1394962us : blk_mq_make_request: 
make rq -1
[    3.871633]  systemd-1       0...1 1395203us : blk_mq_free_request: 
complete: rq -1
[    3.873961]  systemd-1       0.... 1395215us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.876298]  systemd-1       0...1 1395240us : blk_mq_make_request: 
make rq -1
[    3.878634]  systemd-1       0...1 1395725us : blk_mq_free_request: 
complete: rq -1
[    3.880966]  systemd-1       0.... 1395736us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.883305]  systemd-1       0...1 1395761us : blk_mq_make_request: 
make rq -1
[    3.885640]  systemd-1       0...1 1396249us : blk_mq_free_request: 
complete: rq -1
[    3.887971]  systemd-1       0.... 1396260us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.890311]  systemd-1       0...1 1396285us : blk_mq_make_request: 
make rq -1
[    3.892648]  systemd-1       0...1 1396780us : blk_mq_free_request: 
complete: rq -1
[    3.894980]  systemd-1       0.... 1396791us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.897318]  systemd-1       0...1 1396816us : blk_mq_make_request: 
make rq -1
[    3.899655]  systemd-1       0...1 1397304us : blk_mq_free_request: 
complete: rq -1
[    3.901988]  systemd-1       0.... 1397315us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.904326]  systemd-1       0...1 1397340us : blk_mq_make_request: 
make rq -1
[    3.906664]  systemd-1       0...1 1397829us : blk_mq_free_request: 
complete: rq -1
[    3.908994]  systemd-1       0.... 1397840us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.911334]  systemd-1       0...1 1397865us : blk_mq_make_request: 
make rq -1
[    3.913670]  systemd-1       0...1 1398355us : blk_mq_free_request: 
complete: rq -1
[    3.916001]  systemd-1       0.... 1398366us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.918334]  systemd-1       0...1 1398392us : blk_mq_make_request: 
make rq -1
[    3.920665]  systemd-1       0...1 1398875us : blk_mq_free_request: 
complete: rq -1
[    3.922994]  systemd-1       0.... 1398887us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.925329]  systemd-1       0...1 1399139us : blk_mq_make_request: 
make rq -1
[    3.927665]  systemd-1       0...1 1399401us : blk_mq_free_request: 
complete: rq -1
[    3.929995]  systemd-1       0.... 1399413us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.932334]  systemd-1       0...1 1399437us : blk_mq_make_request: 
make rq -1
[    3.934670]  systemd-1       0...1 1399925us : blk_mq_free_request: 
complete: rq -1
[    3.936996]  systemd-1       0.... 1399936us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.939327]  systemd-1       0...1 1399960us : blk_mq_make_request: 
make rq -1
[    3.941659]  systemd-1       0...1 1400452us : blk_mq_free_request: 
complete: rq -1
[    3.943979]  systemd-1       0.... 1400463us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.946311]  systemd-1       0...1 1400488us : blk_mq_make_request: 
make rq -1
[    3.948644]  systemd-1       0...1 1400973us : blk_mq_free_request: 
complete: rq -1
[    3.950971]  systemd-1       0.... 1400985us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.953304]  systemd-1       0...1 1401010us : blk_mq_make_request: 
make rq -1
[    3.955637]  systemd-1       0...1 1401498us : blk_mq_free_request: 
complete: rq -1
[    3.957966]  systemd-1       0.... 1401510us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.960297]  systemd-1       0...1 1401535us : blk_mq_make_request: 
make rq -1
[    3.962632]  systemd-1       0...1 1402022us : blk_mq_free_request: 
complete: rq -1
[    3.964965]  systemd-1       0.... 1402034us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.967305]  systemd-1       0...1 1402058us : blk_mq_make_request: 
make rq -1
[    3.969641]  systemd-1       0...1 1402547us : blk_mq_free_request: 
complete: rq -1
[    3.971974]  systemd-1       0.... 1402558us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.974308]  systemd-1       0...1 1402582us : blk_mq_make_request: 
make rq -1
[    3.976636]  systemd-1       0...1 1403069us : blk_mq_free_request: 
complete: rq -1
[    3.978967]  systemd-1       0.... 1403081us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.981307]  systemd-1       0...1 1403386us : blk_mq_make_request: 
make rq -1
[    3.983645]  systemd-1       0...1 1403606us : blk_mq_free_request: 
complete: rq -1
[    3.985974]  systemd-1       0.... 1403618us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.988307]  systemd-1       0...1 1403642us : blk_mq_make_request: 
make rq -1
[    3.990633]  systemd-1       0...1 1404130us : blk_mq_free_request: 
complete: rq -1
[    3.992955]  systemd-1       0.... 1404141us : mmc_mq_queue_rq: queue 
rq -1, 0
[    3.995292]  systemd-1       0...1 1404166us : blk_mq_make_request: 
make rq -1
[    3.997620]  systemd-1       0...1 1404654us : blk_mq_free_request: 
complete: rq -1
[    3.999946]  systemd-1       0.... 1404666us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.002280]  systemd-1       0...1 1404690us : blk_mq_make_request: 
make rq -1
[    4.004614]  systemd-1       0...1 1405178us : blk_mq_free_request: 
complete: rq -1
[    4.006944]  systemd-1       0.... 1405190us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.009285]  systemd-1       0...1 1405213us : blk_mq_make_request: 
make rq -1
[    4.011622]  systemd-1       0...1 1405702us : blk_mq_free_request: 
complete: rq -1
[    4.013949]  systemd-1       0.... 1405714us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.016289]  systemd-1       0...1 1405737us : blk_mq_make_request: 
make rq -1
[    4.018621]  systemd-1       0...1 1406881us : blk_mq_free_request: 
complete: rq -1
[    4.020950]  systemd-1       0.... 1406888us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.023288]  systemd-1       0...1 1406904us : blk_mq_make_request: 
make rq -1
[    4.025623]  systemd-1       0...1 1407472us : blk_mq_free_request: 
complete: rq -1
[    4.027949]  systemd-1       0.... 1407479us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.030285]  systemd-1       0...1 1407494us : blk_mq_make_request: 
make rq -1
[    4.032617]  systemd-1       0...1 1408064us : blk_mq_free_request: 
complete: rq -1
[    4.034948]  systemd-1       0.... 1408071us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.037286]  systemd-1       0...1 1408274us : blk_mq_make_request: 
make rq -1
[    4.039621]  systemd-1       0...1 1408683us : blk_mq_free_request: 
complete: rq -1
[    4.041952]  systemd-1       0.... 1408690us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.044289]  systemd-1       0...1 1408706us : blk_mq_make_request: 
make rq -1
[    4.046626]  systemd-1       0...1 1409296us : blk_mq_free_request: 
complete: rq -1
[    4.048955]  systemd-1       0.... 1409302us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.051294]  systemd-1       0...1 1409317us : blk_mq_make_request: 
make rq -1
[    4.053631]  systemd-1       0...1 1409909us : blk_mq_free_request: 
complete: rq -1
[    4.055959]  systemd-1       0.... 1409916us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.058294]  systemd-1       0...1 1409931us : blk_mq_make_request: 
make rq -1
[    4.060627]  systemd-1       0...1 1410543us : blk_mq_free_request: 
complete: rq -1
[    4.062958]  systemd-1       0.... 1410550us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.065298]  systemd-1       0...1 1410564us : blk_mq_make_request: 
make rq -1
[    4.067635]  systemd-1       0...1 1411131us : blk_mq_free_request: 
complete: rq -1
[    4.069966]  systemd-1       0.... 1411138us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.072303]  systemd-1       0...1 1411152us : blk_mq_make_request: 
make rq -1
[    4.074638]  systemd-1       0...1 1411720us : blk_mq_free_request: 
complete: rq -1
[    4.076963]  systemd-1       0.... 1411727us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.079294]  systemd-1       0...1 1411742us : blk_mq_make_request: 
make rq -1
[    4.081625]  systemd-1       0...1 1412309us : blk_mq_free_request: 
complete: rq -1
[    4.083952]  systemd-1       0.... 1412316us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.086288]  systemd-1       0...1 1412330us : blk_mq_make_request: 
make rq -1
[    4.088619]  systemd-1       0...1 1412901us : blk_mq_free_request: 
complete: rq -1
[    4.090944]  systemd-1       0.... 1412908us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.093281] kworker/-98      0...1 1413509us : blk_mq_free_request: 
complete: rq -1
[    4.095638]  systemd-1       0...1 1415983us : blk_mq_make_request: 
make rq -1
[    4.097988]  systemd-1       0.... 1416065us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.100350]  systemd-1       0...1 1416080us : blk_mq_make_request: 
make rq -1
[    4.102715]  systemd-1       0...1 1416682us : blk_mq_free_request: 
complete: rq -1
[    4.105063]  systemd-1       0.... 1416691us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.107425] kworker/-98      0...1 1417267us : blk_mq_free_request: 
complete: rq -1
[    4.109809]  systemd-1       0...1 1420198us : blk_mq_make_request: 
make rq -1
[    4.112189]  systemd-1       0.... 1420290us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.114585] kworker/-98      0...1 1420908us : blk_mq_free_request: 
complete: rq -1
[    4.116995]  systemd-1       0...1 1422850us : blk_mq_make_request: 
make rq -1
[    4.119397]  systemd-1       0.... 1422936us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.121812] kworker/-98      0...1 1423459us : blk_mq_free_request: 
complete: rq -1
[    4.124246]  systemd-1       0...1 1424226us : blk_mq_make_request: 
make rq -1
[    4.126674]  systemd-1       0...1 1424267us : blk_mq_make_request: 
make rq -1
[    4.129083]  systemd-1       0...1 1424287us : blk_mq_make_request: 
make rq -1
[    4.131447]  systemd-1       0...1 1424307us : blk_mq_make_request: 
make rq -1
[    4.133787]  systemd-1       0...1 1424325us : blk_mq_make_request: 
make rq -1
[    4.136096]  systemd-1       0...1 1424369us : blk_mq_make_request: 
make rq -1
[    4.138370]  systemd-1       0...1 1424402us : blk_mq_make_request: 
make rq -1
[    4.140612]  systemd-1       0...1 1424422us : blk_mq_make_request: 
make rq -1
[    4.142826]  systemd-1       0...1 1424442us : blk_mq_make_request: 
make rq -1
[    4.145007]  systemd-1       0...1 1424527us : blk_mq_make_request: 
make rq -1
[    4.147153]  systemd-1       0...1 1424549us : blk_mq_make_request: 
make rq -1
[    4.149279]  systemd-1       0...1 1424570us : blk_mq_make_request: 
make rq -1
[    4.151365]  systemd-1       0...1 1424602us : blk_mq_make_request: 
make rq -1
[    4.153413]  systemd-1       0...1 1424624us : blk_mq_make_request: 
make rq -1
[    4.155447]  systemd-1       0...1 1424644us : blk_mq_make_request: 
make rq -1
[    4.157435]  systemd-1       0...1 1424676us : blk_mq_make_request: 
make rq -1
[    4.159393] kworker/-98      0.... 1424839us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.161375] kworker/-98      0...1 1425799us : blk_mq_free_request: 
complete: rq -1
[    4.163368] kworker/-98      0.... 1425807us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.165354] kworker/-98      0...1 1427203us : blk_mq_free_request: 
complete: rq -1
[    4.167366] kworker/-98      0.... 1427211us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.169368] kworker/-98      0...1 1427996us : blk_mq_free_request: 
complete: rq -1
[    4.171384] kworker/-98      0.... 1428003us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.173410] kworker/-98      0...1 1428799us : blk_mq_free_request: 
complete: rq -1
[    4.175442] kworker/-98      0.... 1428806us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.177478] kworker/-98      0...1 1430252us : blk_mq_free_request: 
complete: rq -1
[    4.179532] kworker/-98      0.... 1430258us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.181581] kworker/-98      0...1 1431160us : blk_mq_free_request: 
complete: rq -1
[    4.183643] kworker/-98      0.... 1431166us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.185712] kworker/-98      0...1 1431961us : blk_mq_free_request: 
complete: rq -1
[    4.187794] kworker/-98      0.... 1431968us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.189871] kworker/-98      0...1 1432766us : blk_mq_free_request: 
complete: rq -1
[    4.191971] kworker/-98      0.... 1432772us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.194059] kworker/-98      0...1 1434912us : blk_mq_free_request: 
complete: rq -1
[    4.196163] kworker/-98      0.... 1434918us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.198275] kworker/-98      0...1 1435699us : blk_mq_free_request: 
complete: rq -1
[    4.200395] kworker/-98      0.... 1435718us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.202497]  systemd-1       0...1 1435793us : blk_mq_make_request: 
make rq -1
[    4.204609]  systemd-1       0...1 1435823us : blk_mq_make_request: 
make rq -1
[    4.206685]  systemd-1       0...1 1435843us : blk_mq_make_request: 
make rq -1
[    4.208724]  systemd-1       0...1 1435862us : blk_mq_make_request: 
make rq -1
[    4.210735]  systemd-1       0...1 1435881us : blk_mq_make_request: 
make rq -1
[    4.212712]  systemd-1       0...1 1435912us : blk_mq_make_request: 
make rq -1
[    4.214640]  systemd-1       0...1 1435930us : blk_mq_make_request: 
make rq -1
[    4.216529]  systemd-1       0...1 1435961us : blk_mq_make_request: 
make rq -1
[    4.218385]  systemd-1       0...1 1435979us : blk_mq_make_request: 
make rq -1
[    4.220193]  systemd-1       0...1 1435998us : blk_mq_make_request: 
make rq -1
[    4.221967] kworker/-98      0...1 1436513us : blk_mq_free_request: 
complete: rq -1
[    4.223746] kworker/-98      0.... 1436521us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.225508] kworker/-98      0...1 1437425us : blk_mq_free_request: 
complete: rq -1
[    4.227278] kworker/-98      0.... 1437432us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.229084] kworker/-98      0...1 1438261us : blk_mq_free_request: 
complete: rq -1
[    4.230932] kworker/-98      0.... 1438268us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.232816] kworker/-98      0...1 1439065us : blk_mq_free_request: 
complete: rq -1
[    4.234745] kworker/-98      0.... 1439072us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.236706] kworker/-98      0...1 1439982us : blk_mq_free_request: 
complete: rq -1
[    4.238708] kworker/-98      0.... 1439989us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.240742] kworker/-98      0...1 1440778us : blk_mq_free_request: 
complete: rq -1
[    4.242821] kworker/-98      0.... 1440785us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.244934] kworker/-98      0...1 1441582us : blk_mq_free_request: 
complete: rq -1
[    4.247088] kworker/-98      0.... 1441589us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.249278] kworker/-98      0...1 1442385us : blk_mq_free_request: 
complete: rq -1
[    4.251509] kworker/-98      0.... 1442391us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.253775] kworker/-98      0...1 1443190us : blk_mq_free_request: 
complete: rq -1
[    4.256082] kworker/-98      0.... 1443197us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.258426] kworker/-98      0...1 1444527us : blk_mq_free_request: 
complete: rq -1
[    4.260766] kworker/-98      0.... 1444544us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.263100]  systemd-1       0...1 1444593us : blk_mq_make_request: 
make rq -1
[    4.265438]  systemd-1       0...1 1444624us : blk_mq_make_request: 
make rq -1
[    4.267735]  systemd-1       0...1 1444644us : blk_mq_make_request: 
make rq -1
[    4.269996]  systemd-1       0...1 1444662us : blk_mq_make_request: 
make rq -1
[    4.272220]  systemd-1       0...1 1444701us : blk_mq_make_request: 
make rq -1
[    4.274407]  systemd-1       0...1 1444720us : blk_mq_make_request: 
make rq -1
[    4.276548]  systemd-1       0...1 1444739us : blk_mq_make_request: 
make rq -1
[    4.278653]  systemd-1       0...1 1444765us : blk_mq_make_request: 
make rq -1
[    4.280713]  systemd-1       0...1 1444815us : blk_mq_make_request: 
make rq -1
[    4.282740]  systemd-1       0...1 1444846us : blk_mq_make_request: 
make rq -1
[    4.284725] kworker/-98      0...1 1445870us : blk_mq_free_request: 
complete: rq -1
[    4.286715] kworker/-98      0.... 1445877us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.288703] kworker/-98      0...1 1490816us : blk_mq_free_request: 
complete: rq -1
[    4.290692] kworker/-98      0.... 1490844us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.292681] kworker/-98      0...1 1493028us : blk_mq_free_request: 
complete: rq -1
[    4.294676] kworker/-98      0.... 1493052us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.296665] kworker/-98      0...1 1494082us : blk_mq_free_request: 
complete: rq -1
[    4.298655] kworker/-98      0.... 1494106us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.300640] kworker/-98      0...1 1495057us : blk_mq_free_request: 
complete: rq -1
[    4.302630] kworker/-98      0.... 1495081us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.304609] kworker/-98      0...1 1496034us : blk_mq_free_request: 
complete: rq -1
[    4.306630] kworker/-98      0.... 1496058us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.308691] kworker/-98      0...1 1497007us : blk_mq_free_request: 
complete: rq -1
[    4.310796] kworker/-98      0.... 1497032us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.312936] kworker/-98      0...1 1498022us : blk_mq_free_request: 
complete: rq -1
[    4.315112] kworker/-98      0.... 1498048us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.317325] kworker/-98      0...1 1499010us : blk_mq_free_request: 
complete: rq -1
[    4.319584] kworker/-98      0.... 1499035us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.321873] kworker/-98      0...1 1500494us : blk_mq_free_request: 
complete: rq -1
[    4.324212] kworker/-98      0.... 1500564us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.326546]  systemd-1       0...1 1500743us : blk_mq_make_request: 
make rq -1
[    4.328887]  systemd-1       0...1 1500843us : blk_mq_make_request: 
make rq -1
[    4.331181]  systemd-1       0...1 1500946us : blk_mq_make_request: 
make rq -1
[    4.333444]  systemd-1       0...1 1501016us : blk_mq_make_request: 
make rq -1
[    4.335670]  systemd-1       0...1 1501084us : blk_mq_make_request: 
make rq -1
[    4.337861] kworker/-98      0...1 1501436us : blk_mq_free_request: 
complete: rq -1
[    4.340047] kworker/-98      0.... 1501461us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.342227]  systemd-1       0...1 1501764us : blk_mq_make_request: 
make rq -1
[    4.344421] kworker/-98      0...1 1502978us : blk_mq_free_request: 
complete: rq -1
[    4.346612] kworker/-98      0.... 1503004us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.348805] kworker/-98      0...1 1503972us : blk_mq_free_request: 
complete: rq -1
[    4.351001] kworker/-98      0.... 1503998us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.353192] kworker/-98      0...1 1505356us : blk_mq_free_request: 
complete: rq -1
[    4.355391] kworker/-98      0.... 1505381us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.357586] kworker/-98      0...1 1506420us : blk_mq_free_request: 
complete: rq -1
[    4.359782] kworker/-98      0.... 1506445us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.361975]  systemd-1       0...1 1508760us : blk_mq_free_request: 
complete: rq -1
[    4.364185]  systemd-1       0.... 1508786us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.366387]  systemd-1       0.... 1508799us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.368651]  systemd-1       0...1 1509623us : blk_mq_free_request: 
complete: rq -1
[    4.370899]  systemd-1       0.... 1509648us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.373175]  systemd-1       0.... 1509660us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.375546]  systemd-1       0...1 1511013us : blk_mq_free_request: 
complete: rq -1
[    4.377955]  systemd-1       0.... 1511021us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.380394]  systemd-1       0.... 1511024us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.382920]  systemd-1       0...1 1511828us : blk_mq_free_request: 
complete: rq -1
[    4.385475]  systemd-1       0.... 1511836us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.388067]  systemd-1       0.... 1511839us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.390751]  systemd-1       0...1 1512645us : blk_mq_free_request: 
complete: rq -1
[    4.393468]  systemd-1       0.... 1512652us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.396183]  systemd-1       0.... 1512656us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.398954]  systemd-1       0...1 1513575us : blk_mq_free_request: 
complete: rq -1
[    4.401715]  systemd-1       0.... 1513582us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.404471]  systemd-1       0.... 1513586us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    4.407279] kworker/-98      0...1 1514374us : blk_mq_free_request: 
complete: rq -1
[    4.410088]  systemd-1       0...1 1514413us : blk_mq_make_request: 
make rq -1
[    4.412896] kworker/-98      0d..1 1514466us : blk_mq_free_request: 
complete: rq -1
[    4.415704] kworker/-98      0.... 1514473us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.418504]  systemd-1       0...1 1516943us : blk_mq_make_request: 
make rq -1
[    4.421306] kworker/-98      0.... 1517065us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.424121] kworker/-98      0...1 1518790us : blk_mq_free_request: 
complete: rq -1
[    4.426944]  systemd-1       0...1 1518858us : blk_mq_make_request: 
make rq -1
[    4.429757] kworker/-98      0.... 1518948us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.432580] kworker/-98      0...1 1520361us : blk_mq_free_request: 
complete: rq -1
[    4.435415]  systemd-1       0...1 1520929us : blk_mq_make_request: 
make rq -1
[    4.438233]  systemd-1       0.... 1521003us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.441054] kworker/-98      0...1 1522663us : blk_mq_free_request: 
complete: rq -1
[    4.443888]  systemd-1       0...1 1522783us : blk_mq_make_request: 
make rq -1
[    4.446707]  systemd-1       0.... 1522854us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.449521]  systemd-1       0...1 1522892us : blk_mq_make_request: 
make rq -1
[    4.452329]  systemd-1       0...1 1523558us : blk_mq_free_request: 
complete: rq -1
[    4.455169]  systemd-1       0.... 1523565us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.458036]  systemd-1       0...1 1523599us : blk_mq_make_request: 
make rq -1
[    4.460939]  systemd-1       0...1 1524057us : blk_mq_free_request: 
complete: rq -1
[    4.463864]  systemd-1       0.... 1524065us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.466794]  systemd-1       0...1 1524097us : blk_mq_make_request: 
make rq -1
[    4.469709]  systemd-1       0...1 1524558us : blk_mq_free_request: 
complete: rq -1
[    4.472612]  systemd-1       0.... 1524565us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.475499]  systemd-1       0...1 1524597us : blk_mq_make_request: 
make rq -1
[    4.478395]  systemd-1       0...1 1525059us : blk_mq_free_request: 
complete: rq -1
[    4.481280]  systemd-1       0.... 1525066us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.484151]  systemd-1       0...1 1525099us : blk_mq_make_request: 
make rq -1
[    4.487018]  systemd-1       0...1 1525581us : blk_mq_free_request: 
complete: rq -1
[    4.489881]  systemd-1       0.... 1525587us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.492731]  systemd-1       0...1 1525620us : blk_mq_make_request: 
make rq -1
[    4.495580]  systemd-1       0...1 1526105us : blk_mq_free_request: 
complete: rq -1
[    4.498399]  systemd-1       0.... 1526112us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.501219]  systemd-1       0...1 1526145us : blk_mq_make_request: 
make rq -1
[    4.504014]  systemd-1       0...1 1526640us : blk_mq_free_request: 
complete: rq -1
[    4.506778]  systemd-1       0.... 1526647us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.509530]  systemd-1       0...1 1526680us : blk_mq_make_request: 
make rq -1
[    4.512260]  systemd-1       0...1 1527143us : blk_mq_free_request: 
complete: rq -1
[    4.514955]  systemd-1       0.... 1527150us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.517645]  systemd-1       0...1 1527186us : blk_mq_make_request: 
make rq -1
[    4.520309]  systemd-1       0...1 1527643us : blk_mq_free_request: 
complete: rq -1
[    4.522943]  systemd-1       0.... 1527650us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.525570]  systemd-1       0...1 1527683us : blk_mq_make_request: 
make rq -1
[    4.528175]  systemd-1       0...1 1528228us : blk_mq_free_request: 
complete: rq -1
[    4.530749]  systemd-1       0.... 1528235us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.533310]  systemd-1       0...1 1528270us : blk_mq_make_request: 
make rq -1
[    4.535856]  systemd-1       0...1 1528728us : blk_mq_free_request: 
complete: rq -1
[    4.538369]  systemd-1       0.... 1528736us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.540872]  systemd-1       0...1 1528796us : blk_mq_make_request: 
make rq -1
[    4.543346]  systemd-1       0...1 1529226us : blk_mq_free_request: 
complete: rq -1
[    4.545781]  systemd-1       0.... 1529233us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.548210]  systemd-1       0...1 1529272us : blk_mq_make_request: 
make rq -1
[    4.550636]  systemd-1       0...1 1529727us : blk_mq_free_request: 
complete: rq -1
[    4.553054]  systemd-1       0.... 1529734us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.555457]  systemd-1       0...1 1529767us : blk_mq_make_request: 
make rq -1
[    4.557850]  systemd-1       0...1 1530321us : blk_mq_free_request: 
complete: rq -1
[    4.560230]  systemd-1       0.... 1530328us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.562606]  systemd-1       0...1 1530361us : blk_mq_make_request: 
make rq -1
[    4.564973]  systemd-1       0...1 1530824us : blk_mq_free_request: 
complete: rq -1
[    4.567325]  systemd-1       0.... 1530831us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.569668]  systemd-1       0...1 1530863us : blk_mq_make_request: 
make rq -1
[    4.572008]  systemd-1       0...1 1531947us : blk_mq_free_request: 
complete: rq -1
[    4.574329]  systemd-1       0.... 1531956us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.576647]  systemd-1       0...1 1532003us : blk_mq_make_request: 
make rq -1
[    4.578968]  systemd-1       0...1 1532463us : blk_mq_free_request: 
complete: rq -1
[    4.581285]  systemd-1       0.... 1532472us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.583614] kworker/-98      0...1 1533079us : blk_mq_free_request: 
complete: rq -1
[    4.585959]  systemd-1       0...1 1541526us : blk_mq_make_request: 
make rq -1
[    4.588296]  systemd-1       0.... 1541653us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.590648]  systemd-1       0...1 1541697us : blk_mq_make_request: 
make rq -1
[    4.592998]  systemd-1       0...1 1542385us : blk_mq_free_request: 
complete: rq -1
[    4.595344]  systemd-1       0.... 1542397us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.597700]  systemd-1       0...1 1542441us : blk_mq_make_request: 
make rq -1
[    4.600051]  systemd-1       0...1 1542883us : blk_mq_free_request: 
complete: rq -1
[    4.602403]  systemd-1       0.... 1542891us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.604758]  systemd-1       0...1 1542933us : blk_mq_make_request: 
make rq -1
[    4.607112]  systemd-1       0...1 1543390us : blk_mq_free_request: 
complete: rq -1
[    4.609461]  systemd-1       0.... 1543398us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.611814]  systemd-1       0...1 1543439us : blk_mq_make_request: 
make rq -1
[    4.614166]  systemd-1       0...1 1543901us : blk_mq_free_request: 
complete: rq -1
[    4.616516]  systemd-1       0.... 1543910us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.618875]  systemd-1       0...1 1543950us : blk_mq_make_request: 
make rq -1
[    4.621223]  systemd-1       0...1 1544416us : blk_mq_free_request: 
complete: rq -1
[    4.623569]  systemd-1       0.... 1544425us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.625927]  systemd-1       0...1 1544465us : blk_mq_make_request: 
make rq -1
[    4.628282]  systemd-1       0...1 1544927us : blk_mq_free_request: 
complete: rq -1
[    4.630633]  systemd-1       0.... 1544935us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.632988]  systemd-1       0...1 1544975us : blk_mq_make_request: 
make rq -1
[    4.635341]  systemd-1       0...1 1545436us : blk_mq_free_request: 
complete: rq -1
[    4.637694]  systemd-1       0.... 1545445us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.640050]  systemd-1       0...1 1545486us : blk_mq_make_request: 
make rq -1
[    4.642402]  systemd-1       0...1 1545946us : blk_mq_free_request: 
complete: rq -1
[    4.644748]  systemd-1       0.... 1545954us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.647105]  systemd-1       0...1 1546015us : blk_mq_make_request: 
make rq -1
[    4.649456]  systemd-1       0...1 1546460us : blk_mq_free_request: 
complete: rq -1
[    4.651808]  systemd-1       0.... 1546469us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.654165]  systemd-1       0...1 1546509us : blk_mq_make_request: 
make rq -1
[    4.656518]  systemd-1       0...1 1547100us : blk_mq_free_request: 
complete: rq -1
[    4.658869]  systemd-1       0.... 1547108us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.661229]  systemd-1       0...1 1547149us : blk_mq_make_request: 
make rq -1
[    4.663582]  systemd-1       0...1 1547736us : blk_mq_free_request: 
complete: rq -1
[    4.665930]  systemd-1       0.... 1547745us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.668282]  systemd-1       0...1 1547785us : blk_mq_make_request: 
make rq -1
[    4.670635]  systemd-1       0...1 1548350us : blk_mq_free_request: 
complete: rq -1
[    4.672981]  systemd-1       0.... 1548359us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.675335]  systemd-1       0...1 1548402us : blk_mq_make_request: 
make rq -1
[    4.677686]  systemd-1       0...1 1548963us : blk_mq_free_request: 
complete: rq -1
[    4.680038]  systemd-1       0.... 1548972us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.682398]  systemd-1       0...1 1549013us : blk_mq_make_request: 
make rq -1
[    4.684750]  systemd-1       0...1 1549581us : blk_mq_free_request: 
complete: rq -1
[    4.687100]  systemd-1       0.... 1549590us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.689454]  systemd-1       0...1 1549631us : blk_mq_make_request: 
make rq -1
[    4.691805]  systemd-1       0...1 1550198us : blk_mq_free_request: 
complete: rq -1
[    4.694153]  systemd-1       0.... 1550207us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.696515]  systemd-1       0...1 1550248us : blk_mq_make_request: 
make rq -1
[    4.698871]  systemd-1       0...1 1550711us : blk_mq_free_request: 
complete: rq -1
[    4.701196]  systemd-1       0.... 1550720us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.703521]  systemd-1       0...1 1550760us : blk_mq_make_request: 
make rq -1
[    4.705849]  systemd-1       0...1 1551223us : blk_mq_free_request: 
complete: rq -1
[    4.708174]  systemd-1       0.... 1551231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.710505]  systemd-1       0...1 1551272us : blk_mq_make_request: 
make rq -1
[    4.712836]  systemd-1       0...1 1551731us : blk_mq_free_request: 
complete: rq -1
[    4.715160]  systemd-1       0.... 1551740us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.717490]  systemd-1       0...1 1551780us : blk_mq_make_request: 
make rq -1
[    4.719813]  systemd-1       0...1 1552860us : blk_mq_free_request: 
complete: rq -1
[    4.722133]  systemd-1       0.... 1552867us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.724452]  systemd-1       0...1 1552901us : blk_mq_make_request: 
make rq -1
[    4.726777]  systemd-1       0...1 1553457us : blk_mq_free_request: 
complete: rq -1
[    4.729090]  systemd-1       0.... 1553464us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.731412]  systemd-1       0...1 1553496us : blk_mq_make_request: 
make rq -1
[    4.733737]  systemd-1       0...1 1554056us : blk_mq_free_request: 
complete: rq -1
[    4.736054]  systemd-1       0.... 1554062us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.738380]  systemd-1       0...1 1554093us : blk_mq_make_request: 
make rq -1
[    4.740700]  systemd-1       0...1 1554651us : blk_mq_free_request: 
complete: rq -1
[    4.743019]  systemd-1       0.... 1554658us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.745340]  systemd-1       0...1 1554688us : blk_mq_make_request: 
make rq -1
[    4.747662]  systemd-1       0...1 1555254us : blk_mq_free_request: 
complete: rq -1
[    4.749980]  systemd-1       0.... 1555260us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.752304]  systemd-1       0...1 1555302us : blk_mq_make_request: 
make rq -1
[    4.754624]  systemd-1       0...1 1555874us : blk_mq_free_request: 
complete: rq -1
[    4.756941]  systemd-1       0.... 1555880us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.759263]  systemd-1       0...1 1555910us : blk_mq_make_request: 
make rq -1
[    4.761584]  systemd-1       0...1 1556496us : blk_mq_free_request: 
complete: rq -1
[    4.763898]  systemd-1       0.... 1556503us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.766225]  systemd-1       0...1 1556533us : blk_mq_make_request: 
make rq -1
[    4.768551]  systemd-1       0...1 1556990us : blk_mq_free_request: 
complete: rq -1
[    4.770869]  systemd-1       0.... 1556997us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.773196]  systemd-1       0...1 1557027us : blk_mq_make_request: 
make rq -1
[    4.775521]  systemd-1       0...1 1557486us : blk_mq_free_request: 
complete: rq -1
[    4.777836]  systemd-1       0.... 1557492us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.780163]  systemd-1       0...1 1557523us : blk_mq_make_request: 
make rq -1
[    4.782490]  systemd-1       0...1 1557980us : blk_mq_free_request: 
complete: rq -1
[    4.784814]  systemd-1       0.... 1557986us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.787141]  systemd-1       0...1 1558016us : blk_mq_make_request: 
make rq -1
[    4.789464]  systemd-1       0...1 1558581us : blk_mq_free_request: 
complete: rq -1
[    4.791785]  systemd-1       0.... 1558588us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.794114]  systemd-1       0...1 1558619us : blk_mq_make_request: 
make rq -1
[    4.796436]  systemd-1       0...1 1559176us : blk_mq_free_request: 
complete: rq -1
[    4.798752]  systemd-1       0.... 1559182us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.801081]  systemd-1       0...1 1559214us : blk_mq_make_request: 
make rq -1
[    4.803410]  systemd-1       0...1 1559705us : blk_mq_free_request: 
complete: rq -1
[    4.805731]  systemd-1       0.... 1559712us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.808057]  systemd-1       0...1 1559727us : blk_mq_make_request: 
make rq -1
[    4.810381]  systemd-1       0...1 1560325us : blk_mq_free_request: 
complete: rq -1
[    4.812701]  systemd-1       0.... 1560332us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.815033] kworker/-98      0...1 1560811us : blk_mq_free_request: 
complete: rq -1
[    4.817380]  systemd-1       0...1 1560918us : blk_mq_make_request: 
make rq -1
[    4.819726]  systemd-1       0.... 1560982us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.822081] kworker/-98      0...1 1561816us : blk_mq_free_request: 
complete: rq -1
[    4.824459]  systemd-1       0...1 1561884us : blk_mq_make_request: 
make rq -1
[    4.826830]  systemd-1       0.... 1561946us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.829211] kworker/-98      0...1 1562453us : blk_mq_free_request: 
complete: rq -1
[    4.831607]  systemd-1       0...1 1562627us : blk_mq_make_request: 
make rq -1
[    4.834006]  systemd-1       0.... 1562692us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.836419] kworker/-98      0...1 1563497us : blk_mq_free_request: 
complete: rq -1
[    4.838852]  systemd-1       0...1 1563618us : blk_mq_make_request: 
make rq -1
[    4.841278]  systemd-1       0.... 1563690us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.843712] kworker/-98      0...1 1564308us : blk_mq_free_request: 
complete: rq -1
[    4.846166]  systemd-1       0...1 1564370us : blk_mq_make_request: 
make rq -1
[    4.848611]  systemd-1       0.... 1564416us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.851076] kworker/-98      0...1 1565048us : blk_mq_free_request: 
complete: rq -1
[    4.853557]  systemd-1       0...1 1565151us : blk_mq_make_request: 
make rq -1
[    4.856039]  systemd-1       0.... 1565212us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.858532]  systemd-1       0...1 1565256us : blk_mq_make_request: 
make rq -1
[    4.861026]  systemd-1       0...1 1565734us : blk_mq_free_request: 
complete: rq -1
[    4.863515]  systemd-1       0.... 1565741us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.866011]  systemd-1       0...1 1565772us : blk_mq_make_request: 
make rq -1
[    4.868504]  systemd-1       0...1 1566350us : blk_mq_free_request: 
complete: rq -1
[    4.870984]  systemd-1       0.... 1566357us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.873471]  systemd-1       0...1 1566387us : blk_mq_make_request: 
make rq -1
[    4.875957]  systemd-1       0...1 1566968us : blk_mq_free_request: 
complete: rq -1
[    4.878435]  systemd-1       0.... 1566974us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.880927]  systemd-1       0...1 1567004us : blk_mq_make_request: 
make rq -1
[    4.883416]  systemd-1       0...1 1567585us : blk_mq_free_request: 
complete: rq -1
[    4.885899]  systemd-1       0.... 1567591us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.888385]  systemd-1       0...1 1567621us : blk_mq_make_request: 
make rq -1
[    4.890873]  systemd-1       0...1 1568125us : blk_mq_free_request: 
complete: rq -1
[    4.893359]  systemd-1       0.... 1568133us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.895847]  systemd-1       0...1 1568168us : blk_mq_make_request: 
make rq -1
[    4.898339]  systemd-1       0...1 1568682us : blk_mq_free_request: 
complete: rq -1
[    4.900824]  systemd-1       0.... 1568689us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.903314]  systemd-1       0...1 1568726us : blk_mq_make_request: 
make rq -1
[    4.905803]  systemd-1       0...1 1569186us : blk_mq_free_request: 
complete: rq -1
[    4.908281]  systemd-1       0.... 1569193us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.910770]  systemd-1       0...1 1569223us : blk_mq_make_request: 
make rq -1
[    4.913262]  systemd-1       0...1 1569804us : blk_mq_free_request: 
complete: rq -1
[    4.915744]  systemd-1       0.... 1569810us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.918228]  systemd-1       0...1 1569841us : blk_mq_make_request: 
make rq -1
[    4.920711]  systemd-1       0...1 1570423us : blk_mq_free_request: 
complete: rq -1
[    4.923191]  systemd-1       0.... 1570429us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.925678]  systemd-1       0...1 1570460us : blk_mq_make_request: 
make rq -1
[    4.928161]  systemd-1       0...1 1571016us : blk_mq_free_request: 
complete: rq -1
[    4.930642]  systemd-1       0.... 1571022us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.933133]  systemd-1       0...1 1571052us : blk_mq_make_request: 
make rq -1
[    4.935615]  systemd-1       0...1 1571608us : blk_mq_free_request: 
complete: rq -1
[    4.938073]  systemd-1       0.... 1571615us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.940527]  systemd-1       0...1 1571645us : blk_mq_make_request: 
make rq -1
[    4.942987]  systemd-1       0...1 1572114us : blk_mq_free_request: 
complete: rq -1
[    4.945413]  systemd-1       0.... 1572121us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.947841]  systemd-1       0...1 1572151us : blk_mq_make_request: 
make rq -1
[    4.950269]  systemd-1       0...1 1572710us : blk_mq_free_request: 
complete: rq -1
[    4.952669]  systemd-1       0.... 1572716us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.955060]  systemd-1       0...1 1572746us : blk_mq_make_request: 
make rq -1
[    4.957453]  systemd-1       0...1 1573961us : blk_mq_free_request: 
complete: rq -1
[    4.959821]  systemd-1       0.... 1573974us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.962187]  systemd-1       0...1 1574031us : blk_mq_make_request: 
make rq -1
[    4.964557]  systemd-1       0...1 1574606us : blk_mq_free_request: 
complete: rq -1
[    4.966901]  systemd-1       0.... 1574617us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.969245]  systemd-1       0...1 1574694us : blk_mq_make_request: 
make rq -1
[    4.971587]  systemd-1       0...1 1575256us : blk_mq_free_request: 
complete: rq -1
[    4.973911]  systemd-1       0.... 1575268us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.976227]  systemd-1       0...1 1575323us : blk_mq_make_request: 
make rq -1
[    4.978545]  systemd-1       0...1 1575905us : blk_mq_free_request: 
complete: rq -1
[    4.980863]  systemd-1       0.... 1575916us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.983185]  systemd-1       0...1 1575971us : blk_mq_make_request: 
make rq -1
[    4.985509]  systemd-1       0...1 1576546us : blk_mq_free_request: 
complete: rq -1
[    4.987825]  systemd-1       0.... 1576558us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.990144]  systemd-1       0...1 1576613us : blk_mq_make_request: 
make rq -1
[    4.992471]  systemd-1       0...1 1577168us : blk_mq_free_request: 
complete: rq -1
[    4.994793]  systemd-1       0.... 1577180us : mmc_mq_queue_rq: queue 
rq -1, 0
[    4.997125]  systemd-1       0...1 1577235us : blk_mq_make_request: 
make rq -1
[    4.999454]  systemd-1       0...1 1577808us : blk_mq_free_request: 
complete: rq -1
[    5.001769]  systemd-1       0.... 1577819us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.004102]  systemd-1       0...1 1577874us : blk_mq_make_request: 
make rq -1
[    5.006432]  systemd-1       0...1 1578423us : blk_mq_free_request: 
complete: rq -1
[    5.008752]  systemd-1       0.... 1578435us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.011082]  systemd-1       0...1 1578491us : blk_mq_make_request: 
make rq -1
[    5.013406]  systemd-1       0...1 1579064us : blk_mq_free_request: 
complete: rq -1
[    5.015726]  systemd-1       0.... 1579075us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.018051]  systemd-1       0...1 1579130us : blk_mq_make_request: 
make rq -1
[    5.020378]  systemd-1       0...1 1579710us : blk_mq_free_request: 
complete: rq -1
[    5.022691]  systemd-1       0.... 1579721us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.025019]  systemd-1       0...1 1579776us : blk_mq_make_request: 
make rq -1
[    5.027345]  systemd-1       0...1 1580359us : blk_mq_free_request: 
complete: rq -1
[    5.029663]  systemd-1       0.... 1580370us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.031989]  systemd-1       0...1 1580424us : blk_mq_make_request: 
make rq -1
[    5.034319]  systemd-1       0...1 1581019us : blk_mq_free_request: 
complete: rq -1
[    5.036640]  systemd-1       0.... 1581031us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.038965]  systemd-1       0...1 1581088us : blk_mq_make_request: 
make rq -1
[    5.041297]  systemd-1       0...1 1581642us : blk_mq_free_request: 
complete: rq -1
[    5.043619]  systemd-1       0.... 1581654us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.045950]  systemd-1       0...1 1581708us : blk_mq_make_request: 
make rq -1
[    5.048279]  systemd-1       0...1 1582266us : blk_mq_free_request: 
complete: rq -1
[    5.050607]  systemd-1       0.... 1582277us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.052941]  systemd-1       0...1 1582332us : blk_mq_make_request: 
make rq -1
[    5.055268]  systemd-1       0...1 1582888us : blk_mq_free_request: 
complete: rq -1
[    5.057594]  systemd-1       0.... 1582899us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.059931]  systemd-1       0...1 1582954us : blk_mq_make_request: 
make rq -1
[    5.062265]  systemd-1       0...1 1583516us : blk_mq_free_request: 
complete: rq -1
[    5.064600]  systemd-1       0.... 1583528us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.066943]  systemd-1       0...1 1583554us : blk_mq_make_request: 
make rq -1
[    5.069279]  systemd-1       0...1 1584162us : blk_mq_free_request: 
complete: rq -1
[    5.071617]  systemd-1       0.... 1584174us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.073967] kworker/-98      0...1 1584773us : blk_mq_free_request: 
complete: rq -1
[    5.076329]  systemd-1       0...1 1585064us : blk_mq_make_request: 
make rq -1
[    5.078688]  systemd-1       0.... 1585231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.081060]  systemd-1       0.... 1585239us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.083488] kworker/-98      0...1 1586473us : blk_mq_free_request: 
complete: rq -1
[    5.085927]  systemd-1       0...1 1586886us : blk_mq_make_request: 
make rq -1
[    5.088364]  systemd-1       0.... 1587002us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.090805] kworker/-98      0...1 1587879us : blk_mq_free_request: 
complete: rq -1
[    5.093270]  systemd-1       0...1 1587992us : blk_mq_make_request: 
make rq -1
[    5.095735]  systemd-1       0.... 1588197us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.098201] kworker/-98      0...1 1588790us : blk_mq_free_request: 
complete: rq -1
[    5.100688]  systemd-1       0...1 1588982us : blk_mq_make_request: 
make rq -1
[    5.103180]  systemd-1       0.... 1589093us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.105668]  systemd-1       0...1 1589149us : blk_mq_make_request: 
make rq -1
[    5.108156]  systemd-1       0...1 1589659us : blk_mq_free_request: 
complete: rq -1
[    5.110653]  systemd-1       0.... 1589671us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.113140]  systemd-1       0...1 1589734us : blk_mq_make_request: 
make rq -1
[    5.115632]  systemd-1       0...1 1590189us : blk_mq_free_request: 
complete: rq -1
[    5.118126]  systemd-1       0.... 1590201us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.120615]  systemd-1       0...1 1590255us : blk_mq_make_request: 
make rq -1
[    5.123107]  systemd-1       0...1 1590725us : blk_mq_free_request: 
complete: rq -1
[    5.125605]  systemd-1       0.... 1590736us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.128096]  systemd-1       0...1 1590790us : blk_mq_make_request: 
make rq -1
[    5.130587]  systemd-1       0...1 1591345us : blk_mq_free_request: 
complete: rq -1
[    5.133084]  systemd-1       0.... 1591356us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.135568]  systemd-1       0...1 1591411us : blk_mq_make_request: 
make rq -1
[    5.138058]  systemd-1       0...1 1591887us : blk_mq_free_request: 
complete: rq -1
[    5.140555]  systemd-1       0.... 1591898us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.143042]  systemd-1       0...1 1591953us : blk_mq_make_request: 
make rq -1
[    5.145540]  systemd-1       0...1 1592525us : blk_mq_free_request: 
complete: rq -1
[    5.148036]  systemd-1       0.... 1592536us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.150529]  systemd-1       0...1 1592591us : blk_mq_make_request: 
make rq -1
[    5.153020]  systemd-1       0...1 1593171us : blk_mq_free_request: 
complete: rq -1
[    5.155519]  systemd-1       0.... 1593183us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.158005]  systemd-1       0...1 1593264us : blk_mq_make_request: 
make rq -1
[    5.160499]  systemd-1       0...1 1593816us : blk_mq_free_request: 
complete: rq -1
[    5.162995]  systemd-1       0.... 1593827us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.165486]  systemd-1       0...1 1593904us : blk_mq_make_request: 
make rq -1
[    5.167971]  systemd-1       0...1 1594670us : blk_mq_free_request: 
complete: rq -1
[    5.170469]  systemd-1       0.... 1594680us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.172957]  systemd-1       0...1 1594725us : blk_mq_make_request: 
make rq -1
[    5.175447]  systemd-1       0...1 1595192us : blk_mq_free_request: 
complete: rq -1
[    5.177938]  systemd-1       0.... 1595201us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.180429]  systemd-1       0...1 1595242us : blk_mq_make_request: 
make rq -1
[    5.182921]  systemd-1       0...1 1595798us : blk_mq_free_request: 
complete: rq -1
[    5.185415]  systemd-1       0.... 1595807us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.187902]  systemd-1       0...1 1595849us : blk_mq_make_request: 
make rq -1
[    5.190392]  systemd-1       0...1 1596410us : blk_mq_free_request: 
complete: rq -1
[    5.192890]  systemd-1       0.... 1596419us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.195371]  systemd-1       0...1 1596460us : blk_mq_make_request: 
make rq -1
[    5.197842]  systemd-1       0...1 1596929us : blk_mq_free_request: 
complete: rq -1
[    5.200297]  systemd-1       0.... 1596937us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.202754]  systemd-1       0...1 1596978us : blk_mq_make_request: 
make rq -1
[    5.205189]  systemd-1       0...1 1597560us : blk_mq_free_request: 
complete: rq -1
[    5.207586]  systemd-1       0.... 1597568us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.209970]  systemd-1       0...1 1597613us : blk_mq_make_request: 
make rq -1
[    5.212359]  systemd-1       0...1 1598079us : blk_mq_free_request: 
complete: rq -1
[    5.214725]  systemd-1       0.... 1598203us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.217082]  systemd-1       0...1 1598246us : blk_mq_make_request: 
make rq -1
[    5.219446]  systemd-1       0...1 1598690us : blk_mq_free_request: 
complete: rq -1
[    5.221783]  systemd-1       0.... 1598699us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.224113]  systemd-1       0...1 1598740us : blk_mq_make_request: 
make rq -1
[    5.226447]  systemd-1       0...1 1599217us : blk_mq_free_request: 
complete: rq -1
[    5.228779]  systemd-1       0.... 1599225us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.231120]  systemd-1       0...1 1599270us : blk_mq_make_request: 
make rq -1
[    5.233458]  systemd-1       0...1 1599824us : blk_mq_free_request: 
complete: rq -1
[    5.235784]  systemd-1       0.... 1599833us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.238116]  systemd-1       0...1 1599873us : blk_mq_make_request: 
make rq -1
[    5.240448]  systemd-1       0...1 1600457us : blk_mq_free_request: 
complete: rq -1
[    5.242779]  systemd-1       0.... 1600466us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.245116]  systemd-1       0...1 1600506us : blk_mq_make_request: 
make rq -1
[    5.247452]  systemd-1       0...1 1601103us : blk_mq_free_request: 
complete: rq -1
[    5.249783]  systemd-1       0.... 1601112us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.252120]  systemd-1       0...1 1601152us : blk_mq_make_request: 
make rq -1
[    5.254454]  systemd-1       0...1 1601733us : blk_mq_free_request: 
complete: rq -1
[    5.256781]  systemd-1       0.... 1601741us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.259118]  systemd-1       0...1 1601782us : blk_mq_make_request: 
make rq -1
[    5.261447]  systemd-1       0...1 1602369us : blk_mq_free_request: 
complete: rq -1
[    5.263776]  systemd-1       0.... 1602378us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.266109]  systemd-1       0...1 1602434us : blk_mq_make_request: 
make rq -1
[    5.268445]  systemd-1       0...1 1603025us : blk_mq_free_request: 
complete: rq -1
[    5.270776]  systemd-1       0.... 1603033us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.273115]  systemd-1       0...1 1603074us : blk_mq_make_request: 
make rq -1
[    5.275454]  systemd-1       0...1 1603683us : blk_mq_free_request: 
complete: rq -1
[    5.277781]  systemd-1       0.... 1603691us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.280118]  systemd-1       0...1 1603732us : blk_mq_make_request: 
make rq -1
[    5.282452]  systemd-1       0...1 1604337us : blk_mq_free_request: 
complete: rq -1
[    5.284783]  systemd-1       0.... 1604346us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.287116]  systemd-1       0...1 1604370us : blk_mq_make_request: 
make rq -1
[    5.289448]  systemd-1       0...1 1604999us : blk_mq_free_request: 
complete: rq -1
[    5.291776]  systemd-1       0.... 1605007us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.294121] kworker/-98      0...1 1605504us : blk_mq_free_request: 
complete: rq -1
[    5.296472]  systemd-1       0...1 1605630us : blk_mq_make_request: 
make rq -1
[    5.298825]  systemd-1       0.... 1605749us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.301194]  systemd-1       0.... 1605755us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.303618] kworker/-98      0...1 1606989us : blk_mq_free_request: 
complete: rq -1
[    5.306053]  systemd-1       0...1 1607349us : blk_mq_make_request: 
make rq -1
[    5.308492]  systemd-1       0.... 1607616us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.310929]  systemd-1       0.... 1607622us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.313427] kworker/-98      0...1 1611464us : blk_mq_free_request: 
complete: rq -1
[    5.315941]  systemd-1       0...1 1611749us : blk_mq_make_request: 
make rq -1
[    5.318448]  systemd-1       0.... 1612025us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.320958]  systemd-1       0.... 1612031us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.323540] kworker/-98      0...1 1614862us : blk_mq_free_request: 
complete: rq -1
[    5.326127]  systemd-1       0...1 1615778us : blk_mq_make_request: 
make rq -1
[    5.328705]  systemd-1       0.... 1615951us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.331298]  systemd-1       0.... 1615959us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.333941] kworker/-98      0...1 1617202us : blk_mq_free_request: 
complete: rq -1
[    5.336598]  systemd-1       0...1 1617631us : blk_mq_make_request: 
make rq -1
[    5.339262]  systemd-1       0.... 1617748us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.341920]  systemd-1       0...1 1617804us : blk_mq_make_request: 
make rq -1
[    5.344583]  systemd-1       0...1 1618621us : blk_mq_free_request: 
complete: rq -1
[    5.347253]  systemd-1       0.... 1618634us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.349916]  systemd-1       0...1 1618713us : blk_mq_make_request: 
make rq -1
[    5.352578]  systemd-1       0...1 1619260us : blk_mq_free_request: 
complete: rq -1
[    5.355247]  systemd-1       0.... 1619272us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.357912]  systemd-1       0...1 1619328us : blk_mq_make_request: 
make rq -1
[    5.360576]  systemd-1       0...1 1619904us : blk_mq_free_request: 
complete: rq -1
[    5.363247]  systemd-1       0.... 1619917us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.365909]  systemd-1       0...1 1619972us : blk_mq_make_request: 
make rq -1
[    5.368575]  systemd-1       0...1 1620523us : blk_mq_free_request: 
complete: rq -1
[    5.371244]  systemd-1       0.... 1620534us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.373903]  systemd-1       0...1 1620588us : blk_mq_make_request: 
make rq -1
[    5.376571]  systemd-1       0...1 1621139us : blk_mq_free_request: 
complete: rq -1
[    5.379240]  systemd-1       0.... 1621151us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.381907]  systemd-1       0...1 1621206us : blk_mq_make_request: 
make rq -1
[    5.384571]  systemd-1       0...1 1621664us : blk_mq_free_request: 
complete: rq -1
[    5.387243]  systemd-1       0.... 1621675us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.389910]  systemd-1       0...1 1621729us : blk_mq_make_request: 
make rq -1
[    5.392581]  systemd-1       0...1 1622289us : blk_mq_free_request: 
complete: rq -1
[    5.395255]  systemd-1       0.... 1622300us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.397921]  systemd-1       0...1 1622355us : blk_mq_make_request: 
make rq -1
[    5.400583]  systemd-1       0...1 1622928us : blk_mq_free_request: 
complete: rq -1
[    5.403252]  systemd-1       0.... 1622940us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.405924]  systemd-1       0...1 1622994us : blk_mq_make_request: 
make rq -1
[    5.408592]  systemd-1       0...1 1623573us : blk_mq_free_request: 
complete: rq -1
[    5.411260]  systemd-1       0.... 1623585us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.413923]  systemd-1       0...1 1623639us : blk_mq_make_request: 
make rq -1
[    5.416594]  systemd-1       0...1 1624099us : blk_mq_free_request: 
complete: rq -1
[    5.419271]  systemd-1       0.... 1624110us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.421933]  systemd-1       0...1 1624164us : blk_mq_make_request: 
make rq -1
[    5.424585]  systemd-1       0...1 1624627us : blk_mq_free_request: 
complete: rq -1
[    5.427228]  systemd-1       0.... 1624639us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.429872]  systemd-1       0...1 1624694us : blk_mq_make_request: 
make rq -1
[    5.432482]  systemd-1       0...1 1625242us : blk_mq_free_request: 
complete: rq -1
[    5.435055]  systemd-1       0.... 1625256us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.437624]  systemd-1       0...1 1625311us : blk_mq_make_request: 
make rq -1
[    5.440189]  systemd-1       0...1 1625856us : blk_mq_free_request: 
complete: rq -1
[    5.442727]  systemd-1       0.... 1625867us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.445222]  systemd-1       0...1 1625921us : blk_mq_make_request: 
make rq -1
[    5.447718]  systemd-1       0...1 1626470us : blk_mq_free_request: 
complete: rq -1
[    5.450204]  systemd-1       0.... 1626482us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.452667]  systemd-1       0...1 1626537us : blk_mq_make_request: 
make rq -1
[    5.455098]  systemd-1       0...1 1627087us : blk_mq_free_request: 
complete: rq -1
[    5.457514]  systemd-1       0.... 1627098us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.459926]  systemd-1       0...1 1627153us : blk_mq_make_request: 
make rq -1
[    5.462321]  systemd-1       0...1 1627711us : blk_mq_free_request: 
complete: rq -1
[    5.464666]  systemd-1       0.... 1627722us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.467013]  systemd-1       0...1 1627798us : blk_mq_make_request: 
make rq -1
[    5.469359]  systemd-1       0...1 1628329us : blk_mq_free_request: 
complete: rq -1
[    5.471699]  systemd-1       0.... 1628341us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.474049]  systemd-1       0...1 1628397us : blk_mq_make_request: 
make rq -1
[    5.476390]  systemd-1       0...1 1628941us : blk_mq_free_request: 
complete: rq -1
[    5.478727]  systemd-1       0.... 1628952us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.481074]  systemd-1       0...1 1629007us : blk_mq_make_request: 
make rq -1
[    5.483413]  systemd-1       0...1 1629560us : blk_mq_free_request: 
complete: rq -1
[    5.485751]  systemd-1       0.... 1629571us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.488093]  systemd-1       0...1 1629625us : blk_mq_make_request: 
make rq -1
[    5.490435]  systemd-1       0...1 1630198us : blk_mq_free_request: 
complete: rq -1
[    5.492771]  systemd-1       0.... 1630209us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.495115]  systemd-1       0...1 1630264us : blk_mq_make_request: 
make rq -1
[    5.497462]  systemd-1       0...1 1630839us : blk_mq_free_request: 
complete: rq -1
[    5.499801]  systemd-1       0.... 1630851us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.502146]  systemd-1       0...1 1630905us : blk_mq_make_request: 
make rq -1
[    5.504492]  systemd-1       0...1 1631477us : blk_mq_free_request: 
complete: rq -1
[    5.506835]  systemd-1       0.... 1631489us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.509180]  systemd-1       0...1 1631543us : blk_mq_make_request: 
make rq -1
[    5.511526]  systemd-1       0...1 1632120us : blk_mq_free_request: 
complete: rq -1
[    5.513864]  systemd-1       0.... 1632131us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.516213]  systemd-1       0...1 1632186us : blk_mq_make_request: 
make rq -1
[    5.518553]  systemd-1       0...1 1632737us : blk_mq_free_request: 
complete: rq -1
[    5.520891]  systemd-1       0.... 1632748us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.523234]  systemd-1       0...1 1632803us : blk_mq_make_request: 
make rq -1
[    5.525578]  systemd-1       0...1 1633263us : blk_mq_free_request: 
complete: rq -1
[    5.527916]  systemd-1       0.... 1633275us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.530263]  systemd-1       0...1 1633328us : blk_mq_make_request: 
make rq -1
[    5.532610]  systemd-1       0...1 1633882us : blk_mq_free_request: 
complete: rq -1
[    5.534945]  systemd-1       0.... 1633893us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.537291]  systemd-1       0...1 1633947us : blk_mq_make_request: 
make rq -1
[    5.539637]  systemd-1       0...1 1634501us : blk_mq_free_request: 
complete: rq -1
[    5.541974]  systemd-1       0.... 1634512us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.544321]  systemd-1       0...1 1634566us : blk_mq_make_request: 
make rq -1
[    5.546665]  systemd-1       0...1 1635727us : blk_mq_free_request: 
complete: rq -1
[    5.549004]  systemd-1       0.... 1635736us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.551350]  systemd-1       0...1 1635780us : blk_mq_make_request: 
make rq -1
[    5.553696]  systemd-1       0...1 1636353us : blk_mq_free_request: 
complete: rq -1
[    5.556038]  systemd-1       0.... 1636362us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.558388]  systemd-1       0...1 1636404us : blk_mq_make_request: 
make rq -1
[    5.560731]  systemd-1       0...1 1636981us : blk_mq_free_request: 
complete: rq -1
[    5.563072]  systemd-1       0.... 1636990us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.565420]  systemd-1       0...1 1637032us : blk_mq_make_request: 
make rq -1
[    5.567766]  systemd-1       0...1 1637609us : blk_mq_free_request: 
complete: rq -1
[    5.570099]  systemd-1       0.... 1637617us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.572447]  systemd-1       0...1 1637637us : blk_mq_make_request: 
make rq -1
[    5.574792]  systemd-1       0...1 1638275us : blk_mq_free_request: 
complete: rq -1
[    5.577133]  systemd-1       0.... 1638284us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.579482] kworker/-98      0...1 1638773us : blk_mq_free_request: 
complete: rq -1
[    5.581844]  systemd-1       0...1 1638905us : blk_mq_make_request: 
make rq -1
[    5.584203]  systemd-1       0.... 1638988us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.586572] kworker/-98      0...1 1640152us : blk_mq_free_request: 
complete: rq -1
[    5.588967]  systemd-1       0...1 1640237us : blk_mq_make_request: 
make rq -1
[    5.591357]  systemd-1       0.... 1640319us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.593762] kworker/-98      0...1 1640836us : blk_mq_free_request: 
complete: rq -1
[    5.596183]  systemd-1       0...1 1641183us : blk_mq_make_request: 
make rq -1
[    5.598599]  systemd-1       0.... 1641557us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.601030]  systemd-1       0.... 1641563us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.603512] kworker/-98      0...1 1645780us : blk_mq_free_request: 
complete: rq -1
[    5.606008]  systemd-1       0...1 1646080us : blk_mq_make_request: 
make rq -1
[    5.608506]  systemd-1       0.... 1646163us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.610998] kworker/-98      0...1 1646991us : blk_mq_free_request: 
complete: rq -1
[    5.613517]  systemd-1       0...1 1647414us : blk_mq_make_request: 
make rq -1
[    5.616041]  systemd-1       0.... 1647501us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.618556]  systemd-1       0...1 1647543us : blk_mq_make_request: 
make rq -1
[    5.621077]  systemd-1       0...1 1648319us : blk_mq_free_request: 
complete: rq -1
[    5.623597]  systemd-1       0.... 1648328us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.626113]  systemd-1       0...1 1648371us : blk_mq_make_request: 
make rq -1
[    5.628629]  systemd-1       0...1 1648918us : blk_mq_free_request: 
complete: rq -1
[    5.631149]  systemd-1       0.... 1648927us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.633664]  systemd-1       0...1 1648968us : blk_mq_make_request: 
make rq -1
[    5.636181]  systemd-1       0...1 1649526us : blk_mq_free_request: 
complete: rq -1
[    5.638704]  systemd-1       0.... 1649534us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.641221]  systemd-1       0...1 1649576us : blk_mq_make_request: 
make rq -1
[    5.643734]  systemd-1       0...1 1650134us : blk_mq_free_request: 
complete: rq -1
[    5.646256]  systemd-1       0.... 1650142us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.648774]  systemd-1       0...1 1650183us : blk_mq_make_request: 
make rq -1
[    5.651290]  systemd-1       0...1 1650762us : blk_mq_free_request: 
complete: rq -1
[    5.653813]  systemd-1       0.... 1650771us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.656327]  systemd-1       0...1 1650812us : blk_mq_make_request: 
make rq -1
[    5.658845]  systemd-1       0...1 1651390us : blk_mq_free_request: 
complete: rq -1
[    5.661369]  systemd-1       0.... 1651398us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.663885]  systemd-1       0...1 1651439us : blk_mq_make_request: 
make rq -1
[    5.666398]  systemd-1       0...1 1652019us : blk_mq_free_request: 
complete: rq -1
[    5.668914]  systemd-1       0.... 1652027us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.671422]  systemd-1       0...1 1652068us : blk_mq_make_request: 
make rq -1
[    5.673937]  systemd-1       0...1 1652652us : blk_mq_free_request: 
complete: rq -1
[    5.676457]  systemd-1       0.... 1652660us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.678964]  systemd-1       0...1 1652702us : blk_mq_make_request: 
make rq -1
[    5.681473]  systemd-1       0...1 1653300us : blk_mq_free_request: 
complete: rq -1
[    5.683994]  systemd-1       0.... 1653309us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.686509]  systemd-1       0...1 1653349us : blk_mq_make_request: 
make rq -1
[    5.689015]  systemd-1       0...1 1653951us : blk_mq_free_request: 
complete: rq -1
[    5.691526]  systemd-1       0.... 1653960us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.694034]  systemd-1       0...1 1654001us : blk_mq_make_request: 
make rq -1
[    5.696547]  systemd-1       0...1 1654600us : blk_mq_free_request: 
complete: rq -1
[    5.699057]  systemd-1       0.... 1654609us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.701568]  systemd-1       0...1 1654665us : blk_mq_make_request: 
make rq -1
[    5.704065]  systemd-1       0...1 1655252us : blk_mq_free_request: 
complete: rq -1
[    5.706548]  systemd-1       0.... 1655261us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.709033]  systemd-1       0...1 1655302us : blk_mq_make_request: 
make rq -1
[    5.711501]  systemd-1       0...1 1655922us : blk_mq_free_request: 
complete: rq -1
[    5.713963]  systemd-1       0.... 1655931us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.716419]  systemd-1       0...1 1655973us : blk_mq_make_request: 
make rq -1
[    5.718854]  systemd-1       0...1 1656552us : blk_mq_free_request: 
complete: rq -1
[    5.721286]  systemd-1       0.... 1656561us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.723718]  systemd-1       0...1 1656602us : blk_mq_make_request: 
make rq -1
[    5.726121]  systemd-1       0...1 1657184us : blk_mq_free_request: 
complete: rq -1
[    5.728486]  systemd-1       0.... 1657193us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.730841]  systemd-1       0...1 1657234us : blk_mq_make_request: 
make rq -1
[    5.733199]  systemd-1       0...1 1657817us : blk_mq_free_request: 
complete: rq -1
[    5.735538]  systemd-1       0.... 1657826us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.737865]  systemd-1       0...1 1657867us : blk_mq_make_request: 
make rq -1
[    5.740199]  systemd-1       0...1 1658450us : blk_mq_free_request: 
complete: rq -1
[    5.742529]  systemd-1       0.... 1658459us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.744860]  systemd-1       0...1 1658502us : blk_mq_make_request: 
make rq -1
[    5.747188]  systemd-1       0...1 1659081us : blk_mq_free_request: 
complete: rq -1
[    5.749516]  systemd-1       0.... 1659090us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.751854]  systemd-1       0...1 1659131us : blk_mq_make_request: 
make rq -1
[    5.754193]  systemd-1       0...1 1659706us : blk_mq_free_request: 
complete: rq -1
[    5.756524]  systemd-1       0.... 1659715us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.758865]  systemd-1       0...1 1659756us : blk_mq_make_request: 
make rq -1
[    5.761200]  systemd-1       0...1 1660342us : blk_mq_free_request: 
complete: rq -1
[    5.763522]  systemd-1       0.... 1660350us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.765860]  systemd-1       0...1 1660391us : blk_mq_make_request: 
make rq -1
[    5.768196]  systemd-1       0...1 1660950us : blk_mq_free_request: 
complete: rq -1
[    5.770524]  systemd-1       0.... 1660958us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.772857]  systemd-1       0...1 1661000us : blk_mq_make_request: 
make rq -1
[    5.775195]  systemd-1       0...1 1661555us : blk_mq_free_request: 
complete: rq -1
[    5.777524]  systemd-1       0.... 1661563us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.779857]  systemd-1       0...1 1661605us : blk_mq_make_request: 
make rq -1
[    5.782193]  systemd-1       0...1 1662161us : blk_mq_free_request: 
complete: rq -1
[    5.784520]  systemd-1       0.... 1662170us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.786855]  systemd-1       0...1 1662211us : blk_mq_make_request: 
make rq -1
[    5.789192]  systemd-1       0...1 1662770us : blk_mq_free_request: 
complete: rq -1
[    5.791520]  systemd-1       0.... 1662778us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.793859]  systemd-1       0...1 1662820us : blk_mq_make_request: 
make rq -1
[    5.796198]  systemd-1       0...1 1663401us : blk_mq_free_request: 
complete: rq -1
[    5.798532]  systemd-1       0.... 1663409us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.800867]  systemd-1       0...1 1663450us : blk_mq_make_request: 
make rq -1
[    5.803207]  systemd-1       0...1 1663915us : blk_mq_free_request: 
complete: rq -1
[    5.805538]  systemd-1       0.... 1663924us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.807881]  systemd-1       0...1 1663980us : blk_mq_make_request: 
make rq -1
[    5.810215]  systemd-1       0...1 1664433us : blk_mq_free_request: 
complete: rq -1
[    5.812549]  systemd-1       0.... 1664442us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.814891]  systemd-1       0...1 1664496us : blk_mq_make_request: 
make rq -1
[    5.817229]  systemd-1       0...1 1664948us : blk_mq_free_request: 
complete: rq -1
[    5.819562]  systemd-1       0.... 1664957us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.821900]  systemd-1       0...1 1665003us : blk_mq_make_request: 
make rq -1
[    5.824240]  systemd-1       0...1 1665464us : blk_mq_free_request: 
complete: rq -1
[    5.826571]  systemd-1       0.... 1665473us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.828913]  systemd-1       0...1 1665514us : blk_mq_make_request: 
make rq -1
[    5.831254]  systemd-1       0...1 1665979us : blk_mq_free_request: 
complete: rq -1
[    5.833586]  systemd-1       0.... 1665988us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.835930]  systemd-1       0...1 1666028us : blk_mq_make_request: 
make rq -1
[    5.838266]  systemd-1       0...1 1666491us : blk_mq_free_request: 
complete: rq -1
[    5.840595]  systemd-1       0.... 1666500us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.842935]  systemd-1       0...1 1666519us : blk_mq_make_request: 
make rq -1
[    5.845274]  systemd-1       0...1 1667122us : blk_mq_free_request: 
complete: rq -1
[    5.847605]  systemd-1       0.... 1667131us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.849948] kworker/-98      0...1 1667630us : blk_mq_free_request: 
complete: rq -1
[    5.852308]  systemd-1       0...1 1667904us : blk_mq_make_request: 
make rq -1
[    5.854666]  systemd-1       0.... 1668299us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.857033]  systemd-1       0.... 1668306us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.859454] kworker/-98      0...1 1672272us : blk_mq_free_request: 
complete: rq -1
[    5.861890]  systemd-1       0...1 1672585us : blk_mq_make_request: 
make rq -1
[    5.864332]  systemd-1       0.... 1672706us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.866772]  systemd-1       0.... 1672712us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.869269] kworker/-98      0...1 1673683us : blk_mq_free_request: 
complete: rq -1
[    5.871782]  systemd-1       0...1 1673835us : blk_mq_make_request: 
make rq -1
[    5.874285]  systemd-1       0.... 1673933us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.876792]  systemd-1       0.... 1673939us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.879367] kworker/-98      0...1 1674876us : blk_mq_free_request: 
complete: rq -1
[    5.881947]  systemd-1       0...1 1674977us : blk_mq_make_request: 
make rq -1
[    5.884520]  systemd-1       0.... 1675065us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.887108]  systemd-1       0.... 1675071us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.889749] kworker/-98      0...1 1675699us : blk_mq_free_request: 
complete: rq -1
[    5.892393]  systemd-1       0...1 1676055us : blk_mq_make_request: 
make rq -1
[    5.895052]  systemd-1       0.... 1676322us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.897709]  systemd-1       0.... 1676328us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.900417]  systemd-1       0...1 1676366us : blk_mq_make_request: 
make rq -1
[    5.903129]  systemd-1       0...1 1679091us : blk_mq_free_request: 
complete: rq -1
[    5.905833]  systemd-1       0.... 1679104us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.908533]  systemd-1       0.... 1679110us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.911309] kworker/-98      0...1 1679468us : blk_mq_free_request: 
complete: rq -1
[    5.914095]  systemd-1       0...1 1679672us : blk_mq_make_request: 
make rq -1
[    5.916866]  systemd-1       0.... 1680194us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.919650]  systemd-1       0.... 1680203us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.922490] kworker/-98      0...1 1684599us : blk_mq_free_request: 
complete: rq -1
[    5.925346]  systemd-1       0...1 1684945us : blk_mq_make_request: 
make rq -1
[    5.928203]  systemd-1       0.... 1685102us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.931063]  systemd-1       0.... 1685110us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.933979] kworker/-98      0...1 1686368us : blk_mq_free_request: 
complete: rq -1
[    5.936919]  systemd-1       0...1 1686494us : blk_mq_make_request: 
make rq -1
[    5.939846]  systemd-1       0.... 1686624us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.942774]  systemd-1       0.... 1686631us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.945776] kworker/-98      0...1 1687414us : blk_mq_free_request: 
complete: rq -1
[    5.948779]  systemd-1       0...1 1687896us : blk_mq_make_request: 
make rq -1
[    5.951773]  systemd-1       0.... 1688369us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.954781]  systemd-1       0.... 1688377us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.957844] kworker/-98      0...1 1691146us : blk_mq_free_request: 
complete: rq -1
[    5.960917]  systemd-1       0...1 1691602us : blk_mq_make_request: 
make rq -1
[    5.964000]  systemd-1       0.... 1692177us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.967077]  systemd-1       0.... 1692185us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.970207] kworker/-98      0...1 1696855us : blk_mq_free_request: 
complete: rq -1
[    5.973357]  systemd-1       0...1 1697252us : blk_mq_make_request: 
make rq -1
[    5.976496]  systemd-1       0.... 1697367us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.979643] kworker/-98      0...1 1698369us : blk_mq_free_request: 
complete: rq -1
[    5.982826]  systemd-1       0...1 1698791us : blk_mq_make_request: 
make rq -1
[    5.986002]  systemd-1       0.... 1698911us : mmc_mq_queue_rq: queue 
rq -1, 0
[    5.989148]  systemd-1       0.... 1698917us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    5.992364] kworker/-98      0...1 1700207us : blk_mq_free_request: 
complete: rq -1
[    5.995585]  systemd-1       0...1 1700296us : blk_mq_make_request: 
make rq -1
[    5.998777]  systemd-1       0.... 1700384us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.001921]  systemd-1       0.... 1700390us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.005121] kworker/-98      0...1 1701019us : blk_mq_free_request: 
complete: rq -1
[    6.008334]  systemd-1       0...1 1701250us : blk_mq_make_request: 
make rq -1
[    6.011524]  systemd-1       0.... 1701339us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.014679]  systemd-1       0.... 1701345us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.017887] kworker/-98      0...1 1702003us : blk_mq_free_request: 
complete: rq -1
[    6.021100]  systemd-1       0...1 1702391us : blk_mq_make_request: 
make rq -1
[    6.024291]  systemd-1       0.... 1702528us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.027445]  systemd-1       0.... 1702534us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.030659] kworker/-98      0...1 1703734us : blk_mq_free_request: 
complete: rq -1
[    6.033879]  systemd-1       0...1 1703823us : blk_mq_make_request: 
make rq -1
[    6.037065]  systemd-1       0.... 1703910us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.040218]  systemd-1       0.... 1703916us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.043428] kworker/-98      0...1 1704577us : blk_mq_free_request: 
complete: rq -1
[    6.046644]  systemd-1       0...1 1704892us : blk_mq_make_request: 
make rq -1
[    6.049834]  systemd-1       0.... 1705153us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.053000]  systemd-1       0.... 1705159us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.056227] kworker/-98      0...1 1707853us : blk_mq_free_request: 
complete: rq -1
[    6.059456]  systemd-1       0...1 1708309us : blk_mq_make_request: 
make rq -1
[    6.062663]  systemd-1       0.... 1708435us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.065841]  systemd-1       0.... 1708441us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.069076] kworker/-98      0...1 1709442us : blk_mq_free_request: 
complete: rq -1
[    6.072312]  systemd-1       0...1 1709529us : blk_mq_make_request: 
make rq -1
[    6.075522]  systemd-1       0.... 1709616us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.078684]  systemd-1       0.... 1709622us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.081913] kworker/-98      0...1 1710448us : blk_mq_free_request: 
complete: rq -1
[    6.085149]  systemd-1       0...1 1710805us : blk_mq_make_request: 
make rq -1
[    6.088351]  systemd-1       0.... 1711070us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.091523]  systemd-1       0.... 1711076us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.094748] kworker/-98      0...1 1713730us : blk_mq_free_request: 
complete: rq -1
[    6.097987]  systemd-1       0...1 1714169us : blk_mq_make_request: 
make rq -1
[    6.101196]  systemd-1       0.... 1714294us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.104371]  systemd-1       0.... 1714300us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.107611] kworker/-98      0...1 1715507us : blk_mq_free_request: 
complete: rq -1
[    6.110860]  systemd-1       0...1 1715597us : blk_mq_make_request: 
make rq -1
[    6.114074]  systemd-1       0.... 1715683us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.117249]  systemd-1       0.... 1715689us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.120481] kworker/-98      0...1 1716249us : blk_mq_free_request: 
complete: rq -1
[    6.123722]  systemd-1       0...1 1716630us : blk_mq_make_request: 
make rq -1
[    6.126931]  systemd-1       0.... 1716897us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.130104]  systemd-1       0.... 1716903us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.133339] kworker/-98      0...1 1719439us : blk_mq_free_request: 
complete: rq -1
[    6.136582]  systemd-1       0...1 1719766us : blk_mq_make_request: 
make rq -1
[    6.139807]  systemd-1       0.... 1720144us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.143023]  systemd-1       0.... 1720150us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.146308] kworker/-98      0...1 1724172us : blk_mq_free_request: 
complete: rq -1
[    6.149569]  systemd-1       0...1 1724507us : blk_mq_make_request: 
make rq -1
[    6.152795]  systemd-1       0.... 1724627us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.156013]  systemd-1       0.... 1724634us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.159297] kworker/-98      0...1 1725646us : blk_mq_free_request: 
complete: rq -1
[    6.162553]  systemd-1       0...1 1725734us : blk_mq_make_request: 
make rq -1
[    6.165764]  systemd-1       0.... 1725821us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.168980]  systemd-1       0.... 1725827us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.172261] kworker/-98      0...1 1726460us : blk_mq_free_request: 
complete: rq -1
[    6.175527]  systemd-1       0...1 1726814us : blk_mq_make_request: 
make rq -1
[    6.178754]  systemd-1       0.... 1727078us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.181969]  systemd-1       0.... 1727084us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.185249] kworker/-98      0...1 1729768us : blk_mq_free_request: 
complete: rq -1
[    6.188514]  systemd-1       0...1 1730139us : blk_mq_make_request: 
make rq -1
[    6.191738]  systemd-1       0.... 1730261us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.194966]  systemd-1       0.... 1730267us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.198245] kworker/-98      0...1 1731569us : blk_mq_free_request: 
complete: rq -1
[    6.201514]  systemd-1       0...1 1731657us : blk_mq_make_request: 
make rq -1
[    6.204743]  systemd-1       0.... 1731748us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.207975]  systemd-1       0.... 1731755us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.211265] kworker/-98      0...1 1732427us : blk_mq_free_request: 
complete: rq -1
[    6.214531]  systemd-1       0...1 1732679us : blk_mq_make_request: 
make rq -1
[    6.217757]  systemd-1       0.... 1732799us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.220983]  systemd-1       0.... 1732805us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.224267] kworker/-98      0...1 1733897us : blk_mq_free_request: 
complete: rq -1
[    6.227543]  systemd-1       0...1 1734271us : blk_mq_make_request: 
make rq -1
[    6.230775]  systemd-1       0.... 1734393us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.234002]  systemd-1       0.... 1734400us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.237290] kworker/-98      0...1 1735381us : blk_mq_free_request: 
complete: rq -1
[    6.240568]  systemd-1       0...1 1735469us : blk_mq_make_request: 
make rq -1
[    6.243802]  systemd-1       0.... 1735555us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.247033]  systemd-1       0.... 1735562us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.250324] kworker/-98      0...1 1736118us : blk_mq_free_request: 
complete: rq -1
[    6.253605]  systemd-1       0...1 1736493us : blk_mq_make_request: 
make rq -1
[    6.256833]  systemd-1       0.... 1736759us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.260068]  systemd-1       0.... 1736764us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.263360] kworker/-98      0...1 1739373us : blk_mq_free_request: 
complete: rq -1
[    6.266631]  systemd-1       0...1 1739686us : blk_mq_make_request: 
make rq -1
[    6.269862]  systemd-1       0.... 1739847us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.273093]  systemd-1       0.... 1739855us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.276383]  systemd-1       0...1 1740210us : blk_mq_make_request: 
make rq -1
[    6.279647]  systemd-1       0...1 1740929us : blk_mq_free_request: 
complete: rq -1
[    6.282867]  systemd-1       0.... 1740942us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.286083]  systemd-1       0.... 1740948us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.289350] kworker/-98      0...1 1742188us : blk_mq_free_request: 
complete: rq -1
[    6.292597]  systemd-1       0...1 1742303us : blk_mq_make_request: 
make rq -1
[    6.295803]  systemd-1       0.... 1742419us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.299008]  systemd-1       0.... 1742427us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.302276] kworker/-98      0...1 1743108us : blk_mq_free_request: 
complete: rq -1
[    6.305529]  systemd-1       0...1 1743478us : blk_mq_make_request: 
make rq -1
[    6.308738]  systemd-1       0.... 1743730us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.311950]  systemd-1       0.... 1743738us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.315219] kworker/-98      0...1 1745618us : blk_mq_free_request: 
complete: rq -1
[    6.318464]  systemd-1       0...1 1746228us : blk_mq_make_request: 
make rq -1
[    6.321665]  systemd-1       0.... 1746389us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.324868]  systemd-1       0.... 1746397us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.328135] kworker/-98      0...1 1747420us : blk_mq_free_request: 
complete: rq -1
[    6.331387]  systemd-1       0...1 1747539us : blk_mq_make_request: 
make rq -1
[    6.334595]  systemd-1       0.... 1747653us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.337803]  systemd-1       0.... 1747662us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.341069] kworker/-98      0...1 1748369us : blk_mq_free_request: 
complete: rq -1
[    6.344314]  systemd-1       0...1 1748757us : blk_mq_make_request: 
make rq -1
[    6.347516]  systemd-1       0.... 1748954us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.350719]  systemd-1       0.... 1748962us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.353983] kworker/-98      0...1 1750373us : blk_mq_free_request: 
complete: rq -1
[    6.357234]  systemd-1       0...1 1750926us : blk_mq_make_request: 
make rq -1
[    6.360443]  systemd-1       0.... 1751088us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.363644]  systemd-1       0.... 1751096us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.366910] kworker/-98      0...1 1752433us : blk_mq_free_request: 
complete: rq -1
[    6.370162]  systemd-1       0...1 1752549us : blk_mq_make_request: 
make rq -1
[    6.373371]  systemd-1       0.... 1752665us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.376578]  systemd-1       0.... 1752673us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.379846] kworker/-98      0...1 1753360us : blk_mq_free_request: 
complete: rq -1
[    6.383095]  systemd-1       0...1 1753667us : blk_mq_make_request: 
make rq -1
[    6.386297]  systemd-1       0.... 1753786us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.389506]  systemd-1       0.... 1753794us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.392763] kworker/-98      0...1 1754489us : blk_mq_free_request: 
complete: rq -1
[    6.396016]  systemd-1       0...1 1755012us : blk_mq_make_request: 
make rq -1
[    6.399216]  systemd-1       0.... 1755172us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.402416]  systemd-1       0.... 1755180us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.405677] kworker/-98      0...1 1756414us : blk_mq_free_request: 
complete: rq -1
[    6.408921]  systemd-1       0...1 1756541us : blk_mq_make_request: 
make rq -1
[    6.412121]  systemd-1       0.... 1756668us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.415323]  systemd-1       0.... 1756676us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.418575] kworker/-98      0...1 1757376us : blk_mq_free_request: 
complete: rq -1
[    6.421813]  systemd-1       0...1 1757809us : blk_mq_make_request: 
make rq -1
[    6.425009]  systemd-1       0.... 1758241us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.428207]  systemd-1       0.... 1758251us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.431463] kworker/-98      0...1 1760807us : blk_mq_free_request: 
complete: rq -1
[    6.434709]  systemd-1       0...1 1761105us : blk_mq_make_request: 
make rq -1
[    6.437913]  systemd-1       0.... 1761203us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.441138]  systemd-1       0.... 1761209us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.444418] kworker/-98      0...1 1762152us : blk_mq_free_request: 
complete: rq -1
[    6.447679]  systemd-1       0...1 1762560us : blk_mq_make_request: 
make rq -1
[    6.450897]  systemd-1       0.... 1762659us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.454109]  systemd-1       0.... 1762664us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.457387] kworker/-98      0...1 1763857us : blk_mq_free_request: 
complete: rq -1
[    6.460647]  systemd-1       0...1 1763935us : blk_mq_make_request: 
make rq -1
[    6.463864]  systemd-1       0.... 1764013us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.467083]  systemd-1       0.... 1764018us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.470361] kworker/-98      0...1 1764784us : blk_mq_free_request: 
complete: rq -1
[    6.473625]  systemd-1       0...1 1765060us : blk_mq_make_request: 
make rq -1
[    6.476845]  systemd-1       0.... 1765298us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.480058]  systemd-1       0.... 1765303us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    6.483341] kworker/-98      0...1 1768394us : blk_mq_free_request: 
complete: rq -1
[    6.486603]  systemd-1       0...1 1768615us : blk_mq_make_request: 
make rq -1
[    6.489818]  systemd-1       0.... 1768688us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.493028]  systemd-1       0...1 1768722us : blk_mq_make_request: 
make rq -1
[    6.496248]  systemd-1       0...1 1769396us : blk_mq_free_request: 
complete: rq -1
[    6.499430]  systemd-1       0.... 1769403us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.502571]  systemd-1       0...1 1769438us : blk_mq_make_request: 
make rq -1
[    6.505715]  systemd-1       0...1 1769899us : blk_mq_free_request: 
complete: rq -1
[    6.508862]  systemd-1       0.... 1769906us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.511979]  systemd-1       0...1 1769939us : blk_mq_make_request: 
make rq -1
[    6.515052]  systemd-1       0...1 1770506us : blk_mq_free_request: 
complete: rq -1
[    6.518127]  systemd-1       0.... 1770513us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.521199]  systemd-1       0...1 1770546us : blk_mq_make_request: 
make rq -1
[    6.524245]  systemd-1       0...1 1771114us : blk_mq_free_request: 
complete: rq -1
[    6.527243]  systemd-1       0.... 1771121us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.530240]  systemd-1       0...1 1771155us : blk_mq_make_request: 
make rq -1
[    6.533236]  systemd-1       0...1 1771721us : blk_mq_free_request: 
complete: rq -1
[    6.536192]  systemd-1       0.... 1771728us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.539109]  systemd-1       0...1 1771775us : blk_mq_make_request: 
make rq -1
[    6.542029]  systemd-1       0...1 1772329us : blk_mq_free_request: 
complete: rq -1
[    6.544946]  systemd-1       0.... 1772336us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.547835]  systemd-1       0...1 1772368us : blk_mq_make_request: 
make rq -1
[    6.550687]  systemd-1       0...1 1772934us : blk_mq_free_request: 
complete: rq -1
[    6.553534]  systemd-1       0.... 1772941us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.556377]  systemd-1       0...1 1772975us : blk_mq_make_request: 
make rq -1
[    6.559197]  systemd-1       0...1 1773545us : blk_mq_free_request: 
complete: rq -1
[    6.561969]  systemd-1       0.... 1773552us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.564740]  systemd-1       0...1 1773585us : blk_mq_make_request: 
make rq -1
[    6.567513]  systemd-1       0...1 1774175us : blk_mq_free_request: 
complete: rq -1
[    6.570254]  systemd-1       0.... 1774182us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.572958]  systemd-1       0...1 1774215us : blk_mq_make_request: 
make rq -1
[    6.575663]  systemd-1       0...1 1774804us : blk_mq_free_request: 
complete: rq -1
[    6.578357]  systemd-1       0.... 1774811us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.581022]  systemd-1       0...1 1774844us : blk_mq_make_request: 
make rq -1
[    6.583658]  systemd-1       0...1 1775440us : blk_mq_free_request: 
complete: rq -1
[    6.586284]  systemd-1       0.... 1775447us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.588905]  systemd-1       0...1 1775480us : blk_mq_make_request: 
make rq -1
[    6.591500]  systemd-1       0...1 1776045us : blk_mq_free_request: 
complete: rq -1
[    6.594054]  systemd-1       0.... 1776052us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.596608]  systemd-1       0...1 1776084us : blk_mq_make_request: 
make rq -1
[    6.599158]  systemd-1       0...1 1776654us : blk_mq_free_request: 
complete: rq -1
[    6.601674]  systemd-1       0.... 1776661us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.604152]  systemd-1       0...1 1776693us : blk_mq_make_request: 
make rq -1
[    6.606631]  systemd-1       0...1 1777260us : blk_mq_free_request: 
complete: rq -1
[    6.609104]  systemd-1       0.... 1777267us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.611548]  systemd-1       0...1 1777301us : blk_mq_make_request: 
make rq -1
[    6.613953]  systemd-1       0...1 1777870us : blk_mq_free_request: 
complete: rq -1
[    6.616353]  systemd-1       0.... 1777877us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.618748]  systemd-1       0...1 1777910us : blk_mq_make_request: 
make rq -1
[    6.621121]  systemd-1       0...1 1779136us : blk_mq_free_request: 
complete: rq -1
[    6.623449]  systemd-1       0.... 1779148us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.625769]  systemd-1       0...1 1779209us : blk_mq_make_request: 
make rq -1
[    6.628097]  systemd-1       0...1 1779794us : blk_mq_free_request: 
complete: rq -1
[    6.630416]  systemd-1       0.... 1779805us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.632736]  systemd-1       0...1 1779861us : blk_mq_make_request: 
make rq -1
[    6.635057]  systemd-1       0...1 1780451us : blk_mq_free_request: 
complete: rq -1
[    6.637378]  systemd-1       0.... 1780462us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.639707]  systemd-1       0...1 1780517us : blk_mq_make_request: 
make rq -1
[    6.642026]  systemd-1       0...1 1781111us : blk_mq_free_request: 
complete: rq -1
[    6.644348]  systemd-1       0.... 1781122us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.646674]  systemd-1       0...1 1781178us : blk_mq_make_request: 
make rq -1
[    6.648989]  systemd-1       0...1 1781752us : blk_mq_free_request: 
complete: rq -1
[    6.651309]  systemd-1       0.... 1781763us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.653632]  systemd-1       0...1 1781840us : blk_mq_make_request: 
make rq -1
[    6.655954]  systemd-1       0...1 1782386us : blk_mq_free_request: 
complete: rq -1
[    6.658274]  systemd-1       0.... 1782398us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.660600]  systemd-1       0...1 1782453us : blk_mq_make_request: 
make rq -1
[    6.662929]  systemd-1       0...1 1783021us : blk_mq_free_request: 
complete: rq -1
[    6.665249]  systemd-1       0.... 1783033us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.667579]  systemd-1       0...1 1783087us : blk_mq_make_request: 
make rq -1
[    6.669900]  systemd-1       0...1 1783658us : blk_mq_free_request: 
complete: rq -1
[    6.672222]  systemd-1       0.... 1783669us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.674551]  systemd-1       0...1 1783724us : blk_mq_make_request: 
make rq -1
[    6.676877]  systemd-1       0...1 1784313us : blk_mq_free_request: 
complete: rq -1
[    6.679197]  systemd-1       0.... 1784325us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.681528]  systemd-1       0...1 1784380us : blk_mq_make_request: 
make rq -1
[    6.683856]  systemd-1       0...1 1784974us : blk_mq_free_request: 
complete: rq -1
[    6.686176]  systemd-1       0.... 1784986us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.688507]  systemd-1       0...1 1785040us : blk_mq_make_request: 
make rq -1
[    6.690833]  systemd-1       0...1 1785629us : blk_mq_free_request: 
complete: rq -1
[    6.693157]  systemd-1       0.... 1785641us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.695493]  systemd-1       0...1 1785695us : blk_mq_make_request: 
make rq -1
[    6.697821]  systemd-1       0...1 1786290us : blk_mq_free_request: 
complete: rq -1
[    6.700141]  systemd-1       0.... 1786301us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.702474]  systemd-1       0...1 1786355us : blk_mq_make_request: 
make rq -1
[    6.704801]  systemd-1       0...1 1786925us : blk_mq_free_request: 
complete: rq -1
[    6.707126]  systemd-1       0.... 1786937us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.709457]  systemd-1       0...1 1786991us : blk_mq_make_request: 
make rq -1
[    6.711784]  systemd-1       0...1 1787557us : blk_mq_free_request: 
complete: rq -1
[    6.714109]  systemd-1       0.... 1787569us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.716444]  systemd-1       0...1 1787624us : blk_mq_make_request: 
make rq -1
[    6.718776]  systemd-1       0...1 1788384us : blk_mq_free_request: 
complete: rq -1
[    6.721102]  systemd-1       0.... 1788396us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.723437]  systemd-1       0...1 1788454us : blk_mq_make_request: 
make rq -1
[    6.725770]  systemd-1       0...1 1789021us : blk_mq_free_request: 
complete: rq -1
[    6.728099]  systemd-1       0.... 1789033us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.730438]  systemd-1       0...1 1789058us : blk_mq_make_request: 
make rq -1
[    6.732776]  systemd-1       0...1 1789675us : blk_mq_free_request: 
complete: rq -1
[    6.735108]  systemd-1       0.... 1789686us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.737446] kworker/-98      0...1 1790321us : blk_mq_free_request: 
complete: rq -1
[    6.739808]  systemd-1       0...1 1790470us : blk_mq_make_request: 
make rq -1
[    6.742164]  systemd-1       0.... 1790581us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.744531] kworker/-98      0...1 1791265us : blk_mq_free_request: 
complete: rq -1
[    6.746917]  systemd-1       0...1 1791450us : blk_mq_make_request: 
make rq -1
[    6.749296]  systemd-1       0.... 1791559us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.751685]  systemd-1       0...1 1791615us : blk_mq_make_request: 
make rq -1
[    6.754078]  systemd-1       0...1 1792232us : blk_mq_free_request: 
complete: rq -1
[    6.756465]  systemd-1       0.... 1792244us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.758860]  systemd-1       0...1 1792320us : blk_mq_make_request: 
make rq -1
[    6.761250]  systemd-1       0...1 1792868us : blk_mq_free_request: 
complete: rq -1
[    6.763637]  systemd-1       0.... 1792880us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.766033]  systemd-1       0...1 1792934us : blk_mq_make_request: 
make rq -1
[    6.768425]  systemd-1       0...1 1793508us : blk_mq_free_request: 
complete: rq -1
[    6.770810]  systemd-1       0.... 1793520us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.773207]  systemd-1       0...1 1793574us : blk_mq_make_request: 
make rq -1
[    6.775601]  systemd-1       0...1 1794167us : blk_mq_free_request: 
complete: rq -1
[    6.777977]  systemd-1       0.... 1794179us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.780370]  systemd-1       0...1 1794234us : blk_mq_make_request: 
make rq -1
[    6.782759]  systemd-1       0...1 1794828us : blk_mq_free_request: 
complete: rq -1
[    6.785143]  systemd-1       0.... 1794840us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.787543]  systemd-1       0...1 1794895us : blk_mq_make_request: 
make rq -1
[    6.789935]  systemd-1       0...1 1795489us : blk_mq_free_request: 
complete: rq -1
[    6.792316]  systemd-1       0.... 1795501us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.794710]  systemd-1       0...1 1795555us : blk_mq_make_request: 
make rq -1
[    6.797099]  systemd-1       0...1 1796159us : blk_mq_free_request: 
complete: rq -1
[    6.799484]  systemd-1       0.... 1796171us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.801874]  systemd-1       0...1 1796226us : blk_mq_make_request: 
make rq -1
[    6.804271]  systemd-1       0...1 1796794us : blk_mq_free_request: 
complete: rq -1
[    6.806658]  systemd-1       0.... 1796806us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.809055]  systemd-1       0...1 1796860us : blk_mq_make_request: 
make rq -1
[    6.811447]  systemd-1       0...1 1797433us : blk_mq_free_request: 
complete: rq -1
[    6.813836]  systemd-1       0.... 1797444us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.816231]  systemd-1       0...1 1797498us : blk_mq_make_request: 
make rq -1
[    6.818626]  systemd-1       0...1 1798068us : blk_mq_free_request: 
complete: rq -1
[    6.821011]  systemd-1       0.... 1798079us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.823404]  systemd-1       0...1 1798204us : blk_mq_make_request: 
make rq -1
[    6.825798]  systemd-1       0...1 1799287us : blk_mq_free_request: 
complete: rq -1
[    6.828187]  systemd-1       0.... 1799296us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.830585]  systemd-1       0...1 1799340us : blk_mq_make_request: 
make rq -1
[    6.832979]  systemd-1       0...1 1799927us : blk_mq_free_request: 
complete: rq -1
[    6.835369]  systemd-1       0.... 1799936us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.837765]  systemd-1       0...1 1799978us : blk_mq_make_request: 
make rq -1
[    6.840152]  systemd-1       0...1 1800590us : blk_mq_free_request: 
complete: rq -1
[    6.842541]  systemd-1       0.... 1800599us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.844931]  systemd-1       0...1 1800640us : blk_mq_make_request: 
make rq -1
[    6.847323]  systemd-1       0...1 1801236us : blk_mq_free_request: 
complete: rq -1
[    6.849705]  systemd-1       0.... 1801245us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.852095]  systemd-1       0...1 1801285us : blk_mq_make_request: 
make rq -1
[    6.854490]  systemd-1       0...1 1801887us : blk_mq_free_request: 
complete: rq -1
[    6.856854]  systemd-1       0.... 1801895us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.859215]  systemd-1       0...1 1801936us : blk_mq_make_request: 
make rq -1
[    6.861572]  systemd-1       0...1 1802508us : blk_mq_free_request: 
complete: rq -1
[    6.863909]  systemd-1       0.... 1802517us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.866244]  systemd-1       0...1 1802575us : blk_mq_make_request: 
make rq -1
[    6.868576]  systemd-1       0...1 1803129us : blk_mq_free_request: 
complete: rq -1
[    6.870905]  systemd-1       0.... 1803138us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.873241]  systemd-1       0...1 1803195us : blk_mq_make_request: 
make rq -1
[    6.875574]  systemd-1       0...1 1803755us : blk_mq_free_request: 
complete: rq -1
[    6.877902]  systemd-1       0.... 1803763us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.880238]  systemd-1       0...1 1803804us : blk_mq_make_request: 
make rq -1
[    6.882572]  systemd-1       0...1 1804379us : blk_mq_free_request: 
complete: rq -1
[    6.884901]  systemd-1       0.... 1804388us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.887240]  systemd-1       0...1 1804429us : blk_mq_make_request: 
make rq -1
[    6.889570]  systemd-1       0...1 1805026us : blk_mq_free_request: 
complete: rq -1
[    6.891896]  systemd-1       0.... 1805035us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.894234]  systemd-1       0...1 1805076us : blk_mq_make_request: 
make rq -1
[    6.896567]  systemd-1       0...1 1805672us : blk_mq_free_request: 
complete: rq -1
[    6.898892]  systemd-1       0.... 1805680us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.901226]  systemd-1       0...1 1805721us : blk_mq_make_request: 
make rq -1
[    6.903555]  systemd-1       0...1 1806318us : blk_mq_free_request: 
complete: rq -1
[    6.905889]  systemd-1       0.... 1806326us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.908223]  systemd-1       0...1 1806368us : blk_mq_make_request: 
make rq -1
[    6.910557]  systemd-1       0...1 1806968us : blk_mq_free_request: 
complete: rq -1
[    6.912885]  systemd-1       0.... 1806977us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.915219]  systemd-1       0...1 1807033us : blk_mq_make_request: 
make rq -1
[    6.917552]  systemd-1       0...1 1807591us : blk_mq_free_request: 
complete: rq -1
[    6.919876]  systemd-1       0.... 1807600us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.922215]  systemd-1       0...1 1807642us : blk_mq_make_request: 
make rq -1
[    6.924551]  systemd-1       0...1 1808270us : blk_mq_free_request: 
complete: rq -1
[    6.926878]  systemd-1       0.... 1808280us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.929215]  systemd-1       0...1 1808322us : blk_mq_make_request: 
make rq -1
[    6.931548]  systemd-1       0...1 1808891us : blk_mq_free_request: 
complete: rq -1
[    6.933876]  systemd-1       0.... 1808899us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.936208]  systemd-1       0...1 1808941us : blk_mq_make_request: 
make rq -1
[    6.938541]  systemd-1       0...1 1809515us : blk_mq_free_request: 
complete: rq -1
[    6.940870]  systemd-1       0.... 1809524us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.943206]  systemd-1       0...1 1809565us : blk_mq_make_request: 
make rq -1
[    6.945538]  systemd-1       0...1 1810167us : blk_mq_free_request: 
complete: rq -1
[    6.947867]  systemd-1       0.... 1810176us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.950206]  systemd-1       0...1 1810217us : blk_mq_make_request: 
make rq -1
[    6.952542]  systemd-1       0...1 1810812us : blk_mq_free_request: 
complete: rq -1
[    6.954868]  systemd-1       0.... 1810821us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.957204]  systemd-1       0...1 1810862us : blk_mq_make_request: 
make rq -1
[    6.959540]  systemd-1       0...1 1811458us : blk_mq_free_request: 
complete: rq -1
[    6.961869]  systemd-1       0.... 1811467us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.964210]  systemd-1       0...1 1811509us : blk_mq_make_request: 
make rq -1
[    6.966548]  systemd-1       0...1 1812110us : blk_mq_free_request: 
complete: rq -1
[    6.968883]  systemd-1       0.... 1812119us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.971215]  systemd-1       0...1 1812138us : blk_mq_make_request: 
make rq -1
[    6.973555]  systemd-1       0...1 1812730us : blk_mq_free_request: 
complete: rq -1
[    6.975886]  systemd-1       0.... 1812738us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.978225] kworker/-98      0...1 1813236us : blk_mq_free_request: 
complete: rq -1
[    6.980581]  systemd-1       0...1 1813358us : blk_mq_make_request: 
make rq -1
[    6.982938]  systemd-1       0.... 1813442us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.985305] kworker/-98      0...1 1814099us : blk_mq_free_request: 
complete: rq -1
[    6.987692]  systemd-1       0...1 1814259us : blk_mq_make_request: 
make rq -1
[    6.990071]  systemd-1       0.... 1814343us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.992465] kworker/-98      0...1 1815107us : blk_mq_free_request: 
complete: rq -1
[    6.994875]  systemd-1       0...1 1815252us : blk_mq_make_request: 
make rq -1
[    6.997281]  systemd-1       0.... 1815336us : mmc_mq_queue_rq: queue 
rq -1, 0
[    6.999694] kworker/-98      0...1 1815970us : blk_mq_free_request: 
complete: rq -1
[    7.002127]  systemd-1       0...1 1816049us : blk_mq_make_request: 
make rq -1
[    7.004565]  systemd-1       0.... 1816130us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.007019] kworker/-98      0...1 1816765us : blk_mq_free_request: 
complete: rq -1
[    7.009485]  systemd-1       0...1 1816945us : blk_mq_make_request: 
make rq -1
[    7.011949]  systemd-1       0.... 1817030us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.014419]  systemd-1       0...1 1817072us : blk_mq_make_request: 
make rq -1
[    7.016894]  systemd-1       0...1 1817699us : blk_mq_free_request: 
complete: rq -1
[    7.019350]  systemd-1       0.... 1817709us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.021815]  systemd-1       0...1 1817751us : blk_mq_make_request: 
make rq -1
[    7.024283]  systemd-1       0...1 1818341us : blk_mq_free_request: 
complete: rq -1
[    7.026746]  systemd-1       0.... 1818350us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.029215]  systemd-1       0...1 1818393us : blk_mq_make_request: 
make rq -1
[    7.031686]  systemd-1       0...1 1818985us : blk_mq_free_request: 
complete: rq -1
[    7.034148]  systemd-1       0.... 1818994us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.036622]  systemd-1       0...1 1819035us : blk_mq_make_request: 
make rq -1
[    7.039094]  systemd-1       0...1 1819641us : blk_mq_free_request: 
complete: rq -1
[    7.041558]  systemd-1       0.... 1819650us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.044032]  systemd-1       0...1 1819691us : blk_mq_make_request: 
make rq -1
[    7.046502]  systemd-1       0...1 1820260us : blk_mq_free_request: 
complete: rq -1
[    7.048962]  systemd-1       0.... 1820269us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.051423]  systemd-1       0...1 1820310us : blk_mq_make_request: 
make rq -1
[    7.053893]  systemd-1       0...1 1820879us : blk_mq_free_request: 
complete: rq -1
[    7.056357]  systemd-1       0.... 1820888us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.058824]  systemd-1       0...1 1820928us : blk_mq_make_request: 
make rq -1
[    7.061289]  systemd-1       0...1 1821504us : blk_mq_free_request: 
complete: rq -1
[    7.063753]  systemd-1       0.... 1821513us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.066224]  systemd-1       0...1 1821554us : blk_mq_make_request: 
make rq -1
[    7.068684]  systemd-1       0...1 1822147us : blk_mq_free_request: 
complete: rq -1
[    7.071144]  systemd-1       0.... 1822156us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.073610]  systemd-1       0...1 1822196us : blk_mq_make_request: 
make rq -1
[    7.076072]  systemd-1       0...1 1822793us : blk_mq_free_request: 
complete: rq -1
[    7.078523]  systemd-1       0.... 1822801us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.080989]  systemd-1       0...1 1822859us : blk_mq_make_request: 
make rq -1
[    7.083448]  systemd-1       0...1 1823435us : blk_mq_free_request: 
complete: rq -1
[    7.085906]  systemd-1       0.... 1823444us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.088371]  systemd-1       0...1 1823484us : blk_mq_make_request: 
make rq -1
[    7.090833]  systemd-1       0...1 1824082us : blk_mq_free_request: 
complete: rq -1
[    7.093288]  systemd-1       0.... 1824091us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.095757]  systemd-1       0...1 1824132us : blk_mq_make_request: 
make rq -1
[    7.098222]  systemd-1       0...1 1824707us : blk_mq_free_request: 
complete: rq -1
[    7.100660]  systemd-1       0.... 1824716us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.103098]  systemd-1       0...1 1824757us : blk_mq_make_request: 
make rq -1
[    7.105538]  systemd-1       0...1 1825327us : blk_mq_free_request: 
complete: rq -1
[    7.107947]  systemd-1       0.... 1825336us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.110352]  systemd-1       0...1 1825377us : blk_mq_make_request: 
make rq -1
[    7.112762]  systemd-1       0...1 1825947us : blk_mq_free_request: 
complete: rq -1
[    7.115147]  systemd-1       0.... 1825956us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.117527]  systemd-1       0...1 1825997us : blk_mq_make_request: 
make rq -1
[    7.119907]  systemd-1       0...1 1826570us : blk_mq_free_request: 
complete: rq -1
[    7.122266]  systemd-1       0.... 1826579us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.124613]  systemd-1       0...1 1826620us : blk_mq_make_request: 
make rq -1
[    7.126964]  systemd-1       0...1 1827215us : blk_mq_free_request: 
complete: rq -1
[    7.129289]  systemd-1       0.... 1827223us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.131615]  systemd-1       0...1 1827264us : blk_mq_make_request: 
make rq -1
[    7.133940]  systemd-1       0...1 1827858us : blk_mq_free_request: 
complete: rq -1
[    7.136260]  systemd-1       0.... 1827867us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.138588]  systemd-1       0...1 1827908us : blk_mq_make_request: 
make rq -1
[    7.140912]  systemd-1       0...1 1828505us : blk_mq_free_request: 
complete: rq -1
[    7.143230]  systemd-1       0.... 1828515us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.145559]  systemd-1       0...1 1828557us : blk_mq_make_request: 
make rq -1
[    7.147879]  systemd-1       0...1 1829151us : blk_mq_free_request: 
complete: rq -1
[    7.150195]  systemd-1       0.... 1829161us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.152521]  systemd-1       0...1 1829201us : blk_mq_make_request: 
make rq -1
[    7.154839]  systemd-1       0...1 1829769us : blk_mq_free_request: 
complete: rq -1
[    7.157155]  systemd-1       0.... 1829778us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.159479]  systemd-1       0...1 1829818us : blk_mq_make_request: 
make rq -1
[    7.161799]  systemd-1       0...1 1830388us : blk_mq_free_request: 
complete: rq -1
[    7.164106]  systemd-1       0.... 1830397us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.166427]  systemd-1       0...1 1830441us : blk_mq_make_request: 
make rq -1
[    7.168745]  systemd-1       0...1 1831010us : blk_mq_free_request: 
complete: rq -1
[    7.171063]  systemd-1       0.... 1831019us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.173384]  systemd-1       0...1 1831060us : blk_mq_make_request: 
make rq -1
[    7.175703]  systemd-1       0...1 1831653us : blk_mq_free_request: 
complete: rq -1
[    7.178019]  systemd-1       0.... 1831662us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.180334]  systemd-1       0...1 1831702us : blk_mq_make_request: 
make rq -1
[    7.182655]  systemd-1       0...1 1832298us : blk_mq_free_request: 
complete: rq -1
[    7.184972]  systemd-1       0.... 1832307us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.187301]  systemd-1       0...1 1832363us : blk_mq_make_request: 
make rq -1
[    7.189619]  systemd-1       0...1 1832943us : blk_mq_free_request: 
complete: rq -1
[    7.191934]  systemd-1       0.... 1832951us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.194263]  systemd-1       0...1 1832992us : blk_mq_make_request: 
make rq -1
[    7.196577]  systemd-1       0...1 1833587us : blk_mq_free_request: 
complete: rq -1
[    7.198896]  systemd-1       0.... 1833596us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.201223]  systemd-1       0...1 1833636us : blk_mq_make_request: 
make rq -1
[    7.203548]  systemd-1       0...1 1834208us : blk_mq_free_request: 
complete: rq -1
[    7.205872]  systemd-1       0.... 1834217us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.208199]  systemd-1       0...1 1834257us : blk_mq_make_request: 
make rq -1
[    7.210523]  systemd-1       0...1 1834825us : blk_mq_free_request: 
complete: rq -1
[    7.212839]  systemd-1       0.... 1834834us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.215162]  systemd-1       0...1 1834874us : blk_mq_make_request: 
make rq -1
[    7.217483]  systemd-1       0...1 1835460us : blk_mq_free_request: 
complete: rq -1
[    7.219799]  systemd-1       0.... 1835469us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.222124]  systemd-1       0...1 1835509us : blk_mq_make_request: 
make rq -1
[    7.224444]  systemd-1       0...1 1836081us : blk_mq_free_request: 
complete: rq -1
[    7.226758]  systemd-1       0.... 1836090us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.229081]  systemd-1       0...1 1836109us : blk_mq_make_request: 
make rq -1
[    7.231407]  systemd-1       0...1 1836724us : blk_mq_free_request: 
complete: rq -1
[    7.233728]  systemd-1       0.... 1836733us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.236059] kworker/-98      0...1 1837337us : blk_mq_free_request: 
complete: rq -1
[    7.238408]  systemd-1       0...1 1837446us : blk_mq_make_request: 
make rq -1
[    7.240749]  systemd-1       0.... 1837529us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.243110] kworker/-98      0...1 1838220us : blk_mq_free_request: 
complete: rq -1
[    7.245487]  systemd-1       0...1 1838409us : blk_mq_make_request: 
make rq -1
[    7.247860]  systemd-1       0.... 1838532us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.250245]  systemd-1       0.... 1838539us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.252685] kworker/-98      0...1 1839607us : blk_mq_free_request: 
complete: rq -1
[    7.255129]  systemd-1       0...1 1840294us : blk_mq_make_request: 
make rq -1
[    7.257581]  systemd-1       0.... 1840412us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.260031]  systemd-1       0.... 1840420us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.262545] kworker/-98      0...1 1841046us : blk_mq_free_request: 
complete: rq -1
[    7.265081]  systemd-1       0...1 1841759us : blk_mq_make_request: 
make rq -1
[    7.267605]  systemd-1       0.... 1841926us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.270128]  systemd-1       0.... 1841934us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.272729] kworker/-98      0...1 1842962us : blk_mq_free_request: 
complete: rq -1
[    7.275335]  systemd-1       0...1 1843081us : blk_mq_make_request: 
make rq -1
[    7.277932]  systemd-1       0.... 1843196us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.280542]  systemd-1       0.... 1843204us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.283214] kworker/-98      0...1 1844091us : blk_mq_free_request: 
complete: rq -1
[    7.285892]  systemd-1       0...1 1844514us : blk_mq_make_request: 
make rq -1
[    7.288569]  systemd-1       0.... 1844869us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.291243]  systemd-1       0.... 1844877us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.293987] kworker/-98      0...1 1847657us : blk_mq_free_request: 
complete: rq -1
[    7.296746]  systemd-1       0...1 1848238us : blk_mq_make_request: 
make rq -1
[    7.299499]  systemd-1       0.... 1848713us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.302255]  systemd-1       0.... 1848721us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.305077]  systemd-1       0...1 1849013us : blk_mq_make_request: 
make rq -1
[    7.307889]  systemd-1       0...1 1852677us : blk_mq_free_request: 
complete: rq -1
[    7.310698]  systemd-1       0.... 1852689us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.313519]  systemd-1       0.... 1852696us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.316395] kworker/-98      0...1 1853556us : blk_mq_free_request: 
complete: rq -1
[    7.319279]  systemd-1       0...1 1853680us : blk_mq_make_request: 
make rq -1
[    7.322168]  systemd-1       0.... 1853794us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.325049]  systemd-1       0.... 1853802us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.327990] kworker/-98      0...1 1854466us : blk_mq_free_request: 
complete: rq -1
[    7.330958]  systemd-1       0...1 1854892us : blk_mq_make_request: 
make rq -1
[    7.333916]  systemd-1       0.... 1855242us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.336875]  systemd-1       0.... 1855250us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.339910] kworker/-98      0...1 1858063us : blk_mq_free_request: 
complete: rq -1
[    7.342940]  systemd-1       0...1 1858462us : blk_mq_make_request: 
make rq -1
[    7.345972]  systemd-1       0.... 1858622us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.349011]  systemd-1       0.... 1858631us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.352106]  systemd-1       0...1 1858848us : blk_mq_make_request: 
make rq -1
[    7.355200]  systemd-1       0...1 1859655us : blk_mq_free_request: 
complete: rq -1
[    7.358299]  systemd-1       0.... 1859667us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.361393] kworker/-98      0...1 1860286us : blk_mq_free_request: 
complete: rq -1
[    7.364508]  systemd-1       0...1 1861059us : blk_mq_make_request: 
make rq -1
[    7.367632]  systemd-1       0.... 1861182us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.370748]  systemd-1       0.... 1861188us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.373907] kworker/-98      0...1 1862386us : blk_mq_free_request: 
complete: rq -1
[    7.377071]  systemd-1       0...1 1862474us : blk_mq_make_request: 
make rq -1
[    7.380233]  systemd-1       0.... 1862562us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.383377]  systemd-1       0.... 1862568us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.386574] kworker/-98      0...1 1863215us : blk_mq_free_request: 
complete: rq -1
[    7.389771]  systemd-1       0...1 1863531us : blk_mq_make_request: 
make rq -1
[    7.392949]  systemd-1       0.... 1863751us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.396086]  systemd-1       0.... 1863757us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.399284] kworker/-98      0...1 1866043us : blk_mq_free_request: 
complete: rq -1
[    7.402485]  systemd-1       0...1 1866467us : blk_mq_make_request: 
make rq -1
[    7.405650]  systemd-1       0.... 1866588us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.408795]  systemd-1       0.... 1866594us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.411990] kworker/-98      0...1 1867612us : blk_mq_free_request: 
complete: rq -1
[    7.415198]  systemd-1       0...1 1867702us : blk_mq_make_request: 
make rq -1
[    7.418368]  systemd-1       0.... 1867791us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.421505]  systemd-1       0.... 1867797us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.424704] kworker/-98      0...1 1868650us : blk_mq_free_request: 
complete: rq -1
[    7.427909]  systemd-1       0...1 1868744us : blk_mq_make_request: 
make rq -1
[    7.431075]  systemd-1       0.... 1868831us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.434205]  systemd-1       0.... 1868837us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.437398] kworker/-98      0...1 1869473us : blk_mq_free_request: 
complete: rq -1
[    7.440604]  systemd-1       0...1 1869797us : blk_mq_make_request: 
make rq -1
[    7.443777]  systemd-1       0.... 1870013us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.446913]  systemd-1       0.... 1870019us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.450102]  systemd-1       0...1 1870105us : blk_mq_make_request: 
make rq -1
[    7.453288]  systemd-1       0...1 1872305us : blk_mq_free_request: 
complete: rq -1
[    7.456438]  systemd-1       0.... 1872315us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.459561]  systemd-1       0.... 1872320us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.462749]  systemd-1       0...1 1872709us : blk_mq_make_request: 
make rq -1
[    7.465921]  systemd-1       0...1 1873745us : blk_mq_free_request: 
complete: rq -1
[    7.469067]  systemd-1       0.... 1873754us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.472178]  systemd-1       0.... 1873759us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.475343] kworker/-98      0...1 1874653us : blk_mq_free_request: 
complete: rq -1
[    7.478510]  systemd-1       0...1 1874743us : blk_mq_make_request: 
make rq -1
[    7.481643]  systemd-1       0.... 1874837us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.484740]  systemd-1       0.... 1874843us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.487903] kworker/-98      0...1 1875450us : blk_mq_free_request: 
complete: rq -1
[    7.491073]  systemd-1       0...1 1875781us : blk_mq_make_request: 
make rq -1
[    7.494213]  systemd-1       0.... 1876045us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.497319]  systemd-1       0.... 1876051us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.500483] kworker/-98      0...1 1878744us : blk_mq_free_request: 
complete: rq -1
[    7.503652]  systemd-1       0...1 1879080us : blk_mq_make_request: 
make rq -1
[    7.506797]  systemd-1       0.... 1879192us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.509917]  systemd-1       0.... 1879198us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.513100] kworker/-98      0...1 1880407us : blk_mq_free_request: 
complete: rq -1
[    7.516292]  systemd-1       0...1 1880993us : blk_mq_make_request: 
make rq -1
[    7.519458]  systemd-1       0.... 1881120us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.522628]  systemd-1       0.... 1881126us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.525857] kworker/-98      0...1 1882427us : blk_mq_free_request: 
complete: rq -1
[    7.529070]  systemd-1       0...1 1882515us : blk_mq_make_request: 
make rq -1
[    7.532243]  systemd-1       0.... 1882604us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.535413]  systemd-1       0.... 1882609us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.538640] kworker/-98      0...1 1883247us : blk_mq_free_request: 
complete: rq -1
[    7.541856]  systemd-1       0...1 1883498us : blk_mq_make_request: 
make rq -1
[    7.545021]  systemd-1       0.... 1883589us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.548186]  systemd-1       0.... 1883595us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.551410] kworker/-98      0...1 1884228us : blk_mq_free_request: 
complete: rq -1
[    7.554630]  systemd-1       0...1 1884592us : blk_mq_make_request: 
make rq -1
[    7.557801]  systemd-1       0.... 1884714us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.560973]  systemd-1       0.... 1884721us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.564205] kworker/-98      0...1 1885813us : blk_mq_free_request: 
complete: rq -1
[    7.567425]  systemd-1       0...1 1886338us : blk_mq_make_request: 
make rq -1
[    7.570590]  systemd-1       0.... 1886462us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.573768]  systemd-1       0.... 1886469us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.576996] kworker/-98      0...1 1887694us : blk_mq_free_request: 
complete: rq -1
[    7.580212]  systemd-1       0...1 1888283us : blk_mq_make_request: 
make rq -1
[    7.583389]  systemd-1       0.... 1888407us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.586560]  systemd-1       0.... 1888414us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.589791] kworker/-98      0...1 1889613us : blk_mq_free_request: 
complete: rq -1
[    7.593013]  systemd-1       0...1 1889711us : blk_mq_make_request: 
make rq -1
[    7.596191]  systemd-1       0.... 1889808us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.599374]  systemd-1       0.... 1889814us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.602614] kworker/-98      0...1 1890559us : blk_mq_free_request: 
complete: rq -1
[    7.605842]  systemd-1       0...1 1890947us : blk_mq_make_request: 
make rq -1
[    7.609035]  systemd-1       0.... 1891232us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.612235]  systemd-1       0.... 1891238us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.615497] kworker/-98      0...1 1894209us : blk_mq_free_request: 
complete: rq -1
[    7.618742]  systemd-1       0...1 1894557us : blk_mq_make_request: 
make rq -1
[    7.621954]  systemd-1       0.... 1894933us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.625180]  systemd-1       0.... 1894939us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.628464] kworker/-98      0...1 1898955us : blk_mq_free_request: 
complete: rq -1
[    7.631729]  systemd-1       0...1 1899158us : blk_mq_make_request: 
make rq -1
[    7.634945]  systemd-1       0.... 1899242us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.638170] kworker/-98      0...1 1900112us : blk_mq_free_request: 
complete: rq -1
[    7.641417]  systemd-1       0...1 1900302us : blk_mq_make_request: 
make rq -1
[    7.644627]  systemd-1       0.... 1900424us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.647809]  systemd-1       0.... 1900430us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.651042] kworker/-98      0...1 1901496us : blk_mq_free_request: 
complete: rq -1
[    7.654288]  systemd-1       0...1 1901604us : blk_mq_make_request: 
make rq -1
[    7.657505]  systemd-1       0.... 1901693us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.660675]  systemd-1       0.... 1901699us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.663902] kworker/-98      0...1 1902302us : blk_mq_free_request: 
complete: rq -1
[    7.667150]  systemd-1       0...1 1902572us : blk_mq_make_request: 
make rq -1
[    7.670358]  systemd-1       0.... 1902673us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.673535]  systemd-1       0.... 1902679us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.676769] kworker/-98      0...1 1903529us : blk_mq_free_request: 
complete: rq -1
[    7.680002]  systemd-1       0...1 1903918us : blk_mq_make_request: 
make rq -1
[    7.683206]  systemd-1       0.... 1904054us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.686380]  systemd-1       0.... 1904060us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.689609] kworker/-98      0...1 1905125us : blk_mq_free_request: 
complete: rq -1
[    7.692853]  systemd-1       0...1 1905215us : blk_mq_make_request: 
make rq -1
[    7.696058]  systemd-1       0.... 1905302us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.699235]  systemd-1       0.... 1905307us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.702461] kworker/-98      0...1 1905909us : blk_mq_free_request: 
complete: rq -1
[    7.705700]  systemd-1       0...1 1906165us : blk_mq_make_request: 
make rq -1
[    7.708914]  systemd-1       0.... 1906273us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.712080]  systemd-1       0.... 1906279us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.715318] kworker/-98      0...1 1907149us : blk_mq_free_request: 
complete: rq -1
[    7.718559]  systemd-1       0...1 1907527us : blk_mq_make_request: 
make rq -1
[    7.721760]  systemd-1       0.... 1907651us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.724931]  systemd-1       0.... 1907657us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.728161] kworker/-98      0...1 1908860us : blk_mq_free_request: 
complete: rq -1
[    7.731402]  systemd-1       0...1 1908949us : blk_mq_make_request: 
make rq -1
[    7.734610]  systemd-1       0.... 1909038us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.737784]  systemd-1       0.... 1909044us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.741013] kworker/-98      0...1 1909655us : blk_mq_free_request: 
complete: rq -1
[    7.744246]  systemd-1       0...1 1909939us : blk_mq_make_request: 
make rq -1
[    7.747452]  systemd-1       0.... 1910115us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.750627]  systemd-1       0.... 1910121us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.753859] kworker/-98      0...1 1911773us : blk_mq_free_request: 
complete: rq -1
[    7.757104]  systemd-1       0...1 1912290us : blk_mq_make_request: 
make rq -1
[    7.760318]  systemd-1       0.... 1912414us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.763491]  systemd-1       0.... 1912420us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.766727] kworker/-98      0...1 1913622us : blk_mq_free_request: 
complete: rq -1
[    7.769960]  systemd-1       0...1 1913710us : blk_mq_make_request: 
make rq -1
[    7.773171]  systemd-1       0.... 1913797us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.776340]  systemd-1       0.... 1913803us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.779569] kworker/-98      0...1 1914438us : blk_mq_free_request: 
complete: rq -1
[    7.782811]  systemd-1       0...1 1914758us : blk_mq_make_request: 
make rq -1
[    7.786026]  systemd-1       0.... 1914987us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.789203]  systemd-1       0.... 1914993us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.792437] kworker/-98      0...1 1917422us : blk_mq_free_request: 
complete: rq -1
[    7.795676]  systemd-1       0...1 1917873us : blk_mq_make_request: 
make rq -1
[    7.798897]  systemd-1       0.... 1917996us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.802114]  systemd-1       0.... 1918002us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.805399] kworker/-98      0...1 1919189us : blk_mq_free_request: 
complete: rq -1
[    7.808665]  systemd-1       0...1 1919280us : blk_mq_make_request: 
make rq -1
[    7.811887]  systemd-1       0.... 1919368us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.815113]  systemd-1       0.... 1919374us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.818398] kworker/-98      0...1 1919927us : blk_mq_free_request: 
complete: rq -1
[    7.821666]  systemd-1       0...1 1920260us : blk_mq_make_request: 
make rq -1
[    7.824898]  systemd-1       0.... 1920527us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.828127]  systemd-1       0.... 1920533us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.831421] kworker/-98      0...1 1923151us : blk_mq_free_request: 
complete: rq -1
[    7.834690]  systemd-1       0...1 1923583us : blk_mq_make_request: 
make rq -1
[    7.837924]  systemd-1       0.... 1923959us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.841158]  systemd-1       0.... 1923965us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.844454] kworker/-98      0...1 1927983us : blk_mq_free_request: 
complete: rq -1
[    7.847722]  systemd-1       0...1 1929413us : blk_mq_make_request: 
make rq -1
[    7.850953]  systemd-1       0.... 1929851us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.854185]  systemd-1       0.... 1929857us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.857476] kworker/-98      0...1 1934359us : blk_mq_free_request: 
complete: rq -1
[    7.860752]  systemd-1       0...1 1934807us : blk_mq_make_request: 
make rq -1
[    7.863980]  systemd-1       0.... 1935239us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.867208]  systemd-1       0.... 1935245us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.870492]  systemd-1       0...1 1935430us : blk_mq_make_request: 
make rq -1
[    7.873753]  systemd-1       0...1 1939812us : blk_mq_free_request: 
complete: rq -1
[    7.876975]  systemd-1       0.... 1939822us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.880190]  systemd-1       0.... 1939827us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.883455]  systemd-1       0...1 1940010us : blk_mq_make_request: 
make rq -1
[    7.886701]  systemd-1       0...1 1941468us : blk_mq_free_request: 
complete: rq -1
[    7.889905]  systemd-1       0.... 1941477us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.893096]  systemd-1       0.... 1941482us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.896353]  systemd-1       0...1 1942708us : blk_mq_make_request: 
make rq -1
[    7.899570]  systemd-1       0...1 1944635us : blk_mq_free_request: 
complete: rq -1
[    7.902750]  systemd-1       0.... 1944645us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.905921]  systemd-1       0.... 1944650us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.909156] kworker/-98      0...1 1945154us : blk_mq_free_request: 
complete: rq -1
[    7.912370]  systemd-1       0...1 1945528us : blk_mq_make_request: 
make rq -1
[    7.915546]  systemd-1       0.... 1945857us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.918718]  systemd-1       0.... 1945863us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.921941]  systemd-1       0...1 1946909us : blk_mq_make_request: 
make rq -1
[    7.925143]  systemd-1       0...1 1949481us : blk_mq_free_request: 
complete: rq -1
[    7.928300]  systemd-1       0.... 1949492us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.931458]  systemd-1       0.... 1949496us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.934671] kworker/-98      0...1 1953250us : blk_mq_free_request: 
complete: rq -1
[    7.937863]  systemd-1       0...1 1953687us : blk_mq_make_request: 
make rq -1
[    7.941016]  systemd-1       0.... 1954123us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.944165]  systemd-1       0.... 1954130us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.947381]  systemd-1       0...1 1954969us : blk_mq_make_request: 
make rq -1
[    7.950563]  systemd-1       0...1 1958746us : blk_mq_free_request: 
complete: rq -1
[    7.953695]  systemd-1       0.... 1958756us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.956829]  systemd-1       0.... 1958760us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.960020]  systemd-1       0...1 1960931us : blk_mq_make_request: 
make rq -1
[    7.963183]  systemd-1       0...1 1962337us : blk_mq_free_request: 
complete: rq -1
[    7.966297]  systemd-1       0.... 1962347us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.969402]  systemd-1       0.... 1962352us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.972568] kworker/-98      0...1 1965902us : blk_mq_free_request: 
complete: rq -1
[    7.975717]  systemd-1       0...1 1966288us : blk_mq_make_request: 
make rq -1
[    7.978826]  systemd-1       0.... 1966422us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.981929]  systemd-1       0.... 1966428us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.985089]  systemd-1       0...1 1966697us : blk_mq_make_request: 
make rq -1
[    7.988225]  systemd-1       0...1 1967645us : blk_mq_free_request: 
complete: rq -1
[    7.991315]  systemd-1       0.... 1967655us : mmc_mq_queue_rq: queue 
rq -1, 0
[    7.994404]  systemd-1       0.... 1967660us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    7.997548] kworker/-98      0...1 1969612us : blk_mq_free_request: 
complete: rq -1
[    8.000671]  systemd-1       0...1 1970356us : blk_mq_make_request: 
make rq -1
[    8.003761]  systemd-1       0.... 1970800us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.006850]  systemd-1       0.... 1970806us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.009996] kworker/-98      0...1 1975448us : blk_mq_free_request: 
complete: rq -1
[    8.013127]  systemd-1       0...1 1977857us : blk_mq_make_request: 
make rq -1
[    8.016221]  systemd-1       0.... 1978325us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.019305]  systemd-1       0.... 1978332us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.022453] kworker/-98      0...1 1982581us : blk_mq_free_request: 
complete: rq -1
[    8.025590]  systemd-1       0...1 1983864us : blk_mq_make_request: 
make rq -1
[    8.028696]  systemd-1       0.... 1984316us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.031815]  systemd-1       0.... 1984323us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.034989]  systemd-1       0.n.1 1988078us : blk_mq_make_request: 
make rq -1
[    8.038126] kworker/-98      0...1 1990264us : blk_mq_free_request: 
complete: rq -1
[    8.041246]  systemd-1       1.... 1990445us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.044399]  systemd-1       1.... 1990466us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.047605] kworker/-98      0...1 1995198us : blk_mq_free_request: 
complete: rq -1
[    8.050788]  systemd-1       1...1 1995662us : blk_mq_make_request: 
make rq -1
[    8.053953]  systemd-1       1.... 1996002us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.057119]  systemd-1       1.... 1996007us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.060350]   <idle>-0       1dnh1 2000449us : blk_mq_free_request: 
complete: rq -1
[    8.063565]  systemd-1       1...1 2001010us : blk_mq_make_request: 
make rq -1
[    8.066745]  systemd-1       1.... 2001245us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.069923]  systemd-1       1.... 2001250us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.073158]   <idle>-0       1dnh1 2004301us : blk_mq_free_request: 
complete: rq -1
[    8.076378]  systemd-1       1...1 2004530us : blk_mq_make_request: 
make rq -1
[    8.079561]  systemd-1       1.... 2004804us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.082762]  systemd-1       1.... 2004809us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.086021]   <idle>-0       1dnh1 2008565us : blk_mq_free_request: 
complete: rq -1
[    8.089260]  systemd-1       1...1 2009566us : blk_mq_make_request: 
make rq -1
[    8.092451]  systemd-1       1.... 2009662us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.095651]  systemd-1       1...1 2009719us : blk_mq_make_request: 
make rq -1
[    8.098840]  systemd-1       1...1 2010558us : blk_mq_free_request: 
complete: rq -1
[    8.102000]  systemd-1       1.... 2010570us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.105138]  systemd-1       1...1 2010627us : blk_mq_make_request: 
make rq -1
[    8.108287]  systemd-1       1...1 2011203us : blk_mq_free_request: 
complete: rq -1
[    8.111429]  systemd-1       1.... 2011215us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.114546]  systemd-1       1...1 2011270us : blk_mq_make_request: 
make rq -1
[    8.117634]  systemd-1       1...1 2011853us : blk_mq_free_request: 
complete: rq -1
[    8.120722]  systemd-1       1.... 2011865us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.123810]  systemd-1       1...1 2011919us : blk_mq_make_request: 
make rq -1
[    8.126874]  systemd-1       1...1 2012479us : blk_mq_free_request: 
complete: rq -1
[    8.129894]  systemd-1       1.... 2012491us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.132906]  systemd-1       1...1 2012545us : blk_mq_make_request: 
make rq -1
[    8.135923]  systemd-1       1...1 2013104us : blk_mq_free_request: 
complete: rq -1
[    8.138913]  systemd-1       1.... 2013115us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.141874]  systemd-1       1...1 2013170us : blk_mq_make_request: 
make rq -1
[    8.144839]  systemd-1       1...1 2013730us : blk_mq_free_request: 
complete: rq -1
[    8.147799]  systemd-1       1.... 2013741us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.150729]  systemd-1       1...1 2013796us : blk_mq_make_request: 
make rq -1
[    8.153624]  systemd-1       1...1 2014355us : blk_mq_free_request: 
complete: rq -1
[    8.156507]  systemd-1       1.... 2014366us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.159386]  systemd-1       1...1 2014420us : blk_mq_make_request: 
make rq -1
[    8.162237]  systemd-1       1...1 2015001us : blk_mq_free_request: 
complete: rq -1
[    8.165054]  systemd-1       1.... 2015012us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.167863]  systemd-1       1...1 2015066us : blk_mq_make_request: 
make rq -1
[    8.170666]  systemd-1       1...1 2015652us : blk_mq_free_request: 
complete: rq -1
[    8.173438]  systemd-1       1.... 2015663us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.176176]  systemd-1       1...1 2015718us : blk_mq_make_request: 
make rq -1
[    8.178906]  systemd-1       1...1 2016299us : blk_mq_free_request: 
complete: rq -1
[    8.181633]  systemd-1       1.... 2016310us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.184336]  systemd-1       1...1 2016365us : blk_mq_make_request: 
make rq -1
[    8.187011]  systemd-1       1...1 2016948us : blk_mq_free_request: 
complete: rq -1
[    8.189675]  systemd-1       1.... 2016959us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.192309]  systemd-1       1...1 2017014us : blk_mq_make_request: 
make rq -1
[    8.194926]  systemd-1       1...1 2017573us : blk_mq_free_request: 
complete: rq -1
[    8.197502]  systemd-1       1.... 2017584us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.200062]  systemd-1       1...1 2017638us : blk_mq_make_request: 
make rq -1
[    8.202633]  systemd-1       1...1 2018267us : blk_mq_free_request: 
complete: rq -1
[    8.205168]  systemd-1       1.... 2018280us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.207659]  systemd-1       1...1 2018358us : blk_mq_make_request: 
make rq -1
[    8.210151]  systemd-1       1...1 2018896us : blk_mq_free_request: 
complete: rq -1
[    8.212637]  systemd-1       1.... 2018908us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.215098]  systemd-1       1...1 2018963us : blk_mq_make_request: 
make rq -1
[    8.217517]  systemd-1       1...1 2019523us : blk_mq_free_request: 
complete: rq -1
[    8.219931]  systemd-1       1.... 2019535us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.222338]  systemd-1       1...1 2019589us : blk_mq_make_request: 
make rq -1
[    8.224722]  systemd-1       1...1 2020168us : blk_mq_free_request: 
complete: rq -1
[    8.227059]  systemd-1       1.... 2020180us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.229395]  systemd-1       1...1 2020234us : blk_mq_make_request: 
make rq -1
[    8.231728]  systemd-1       1...1 2020820us : blk_mq_free_request: 
complete: rq -1
[    8.234064]  systemd-1       1.... 2020831us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.236401]  systemd-1       1...1 2020886us : blk_mq_make_request: 
make rq -1
[    8.238738]  systemd-1       1...1 2021466us : blk_mq_free_request: 
complete: rq -1
[    8.241063]  systemd-1       1.... 2021478us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.243403]  systemd-1       1...1 2021532us : blk_mq_make_request: 
make rq -1
[    8.245736]  systemd-1       1...1 2022119us : blk_mq_free_request: 
complete: rq -1
[    8.248065]  systemd-1       1.... 2022130us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.250407]  systemd-1       1...1 2022184us : blk_mq_make_request: 
make rq -1
[    8.252743]  systemd-1       1...1 2022740us : blk_mq_free_request: 
complete: rq -1
[    8.255072]  systemd-1       1.... 2022751us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.257411]  systemd-1       1...1 2022805us : blk_mq_make_request: 
make rq -1
[    8.259752]  systemd-1       1...1 2023379us : blk_mq_free_request: 
complete: rq -1
[    8.262078]  systemd-1       1.... 2023390us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.264415]  systemd-1       1...1 2023444us : blk_mq_make_request: 
make rq -1
[    8.266754]  systemd-1       1...1 2024005us : blk_mq_free_request: 
complete: rq -1
[    8.269089]  systemd-1       1.... 2024017us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.271432]  systemd-1       1...1 2024071us : blk_mq_make_request: 
make rq -1
[    8.273774]  systemd-1       1...1 2024631us : blk_mq_free_request: 
complete: rq -1
[    8.276112]  systemd-1       1.... 2024643us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.278459]  systemd-1       1...1 2024697us : blk_mq_make_request: 
make rq -1
[    8.280797]  systemd-1       1...1 2025281us : blk_mq_free_request: 
complete: rq -1
[    8.283138]  systemd-1       1.... 2025292us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.285485]  systemd-1       1...1 2025346us : blk_mq_make_request: 
make rq -1
[    8.287827]  systemd-1       1...1 2025928us : blk_mq_free_request: 
complete: rq -1
[    8.290167]  systemd-1       1.... 2025940us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.292513]  systemd-1       1...1 2025994us : blk_mq_make_request: 
make rq -1
[    8.294854]  systemd-1       1...1 2026575us : blk_mq_free_request: 
complete: rq -1
[    8.297186]  systemd-1       1.... 2026586us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.299531]  systemd-1       1...1 2026641us : blk_mq_make_request: 
make rq -1
[    8.301867]  systemd-1       1...1 2027227us : blk_mq_free_request: 
complete: rq -1
[    8.304207]  systemd-1       1.... 2027238us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.306552]  systemd-1       1...1 2027292us : blk_mq_make_request: 
make rq -1
[    8.308895]  systemd-1       1...1 2027852us : blk_mq_free_request: 
complete: rq -1
[    8.311230]  systemd-1       1.... 2027863us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.313569]  systemd-1       1...1 2027940us : blk_mq_make_request: 
make rq -1
[    8.315909]  systemd-1       1...1 2028478us : blk_mq_free_request: 
complete: rq -1
[    8.318237]  systemd-1       1.... 2028491us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.320582]  systemd-1       1...1 2028547us : blk_mq_make_request: 
make rq -1
[    8.322920]  systemd-1       1...1 2029690us : blk_mq_free_request: 
complete: rq -1
[    8.325255]  systemd-1       1.... 2029699us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.327596]  systemd-1       1...1 2029743us : blk_mq_make_request: 
make rq -1
[    8.329937]  systemd-1       1...1 2030300us : blk_mq_free_request: 
complete: rq -1
[    8.332271]  systemd-1       1.... 2030309us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.334617]  systemd-1       1...1 2030328us : blk_mq_make_request: 
make rq -1
[    8.336957]  systemd-1       1...1 2030930us : blk_mq_free_request: 
complete: rq -1
[    8.339283]  systemd-1       1.... 2030938us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.341624]   <idle>-0       1dnh1 2031568us : blk_mq_free_request: 
complete: rq -1
[    8.343986]  systemd-1       1...1 2031684us : blk_mq_make_request: 
make rq -1
[    8.346340]  systemd-1       1.... 2031751us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.348708]   <idle>-0       1dnh1 2032652us : blk_mq_free_request: 
complete: rq -1
[    8.351093]  systemd-1       1...1 2032946us : blk_mq_make_request: 
make rq -1
[    8.353485]  systemd-1       1.... 2033206us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.355883]  systemd-1       1.... 2033212us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.358337]   <idle>-0       1dnh1 2036030us : blk_mq_free_request: 
complete: rq -1
[    8.360805]  systemd-1       1...1 2036231us : blk_mq_make_request: 
make rq -1
[    8.363275]  systemd-1       1.... 2036296us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.365741]  systemd-1       1...1 2036338us : blk_mq_make_request: 
make rq -1
[    8.368210]  systemd-1       1...1 2037151us : blk_mq_free_request: 
complete: rq -1
[    8.370690]  systemd-1       1.... 2037160us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.373154]  systemd-1       1...1 2037202us : blk_mq_make_request: 
make rq -1
[    8.375621]  systemd-1       1...1 2037654us : blk_mq_free_request: 
complete: rq -1
[    8.378096]  systemd-1       1.... 2037663us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.380561]  systemd-1       1...1 2037704us : blk_mq_make_request: 
make rq -1
[    8.383026]  systemd-1       1...1 2038288us : blk_mq_free_request: 
complete: rq -1
[    8.385501]  systemd-1       1.... 2038297us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.387957]  systemd-1       1...1 2038339us : blk_mq_make_request: 
make rq -1
[    8.390422]  systemd-1       1...1 2038890us : blk_mq_free_request: 
complete: rq -1
[    8.392899]  systemd-1       1.... 2038899us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.395369]  systemd-1       1...1 2038940us : blk_mq_make_request: 
make rq -1
[    8.397839]  systemd-1       1...1 2039490us : blk_mq_free_request: 
complete: rq -1
[    8.400307]  systemd-1       1.... 2039499us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.402774]  systemd-1       1...1 2039540us : blk_mq_make_request: 
make rq -1
[    8.405243]  systemd-1       1...1 2040088us : blk_mq_free_request: 
complete: rq -1
[    8.407714]  systemd-1       1.... 2040097us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.410179]  systemd-1       1...1 2040156us : blk_mq_make_request: 
make rq -1
[    8.412652]  systemd-1       1...1 2040695us : blk_mq_free_request: 
complete: rq -1
[    8.415127]  systemd-1       1.... 2040703us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.417599]  systemd-1       1...1 2040744us : blk_mq_make_request: 
make rq -1
[    8.420059]  systemd-1       1...1 2041317us : blk_mq_free_request: 
complete: rq -1
[    8.422530]  systemd-1       1.... 2041326us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.424998]  systemd-1       1...1 2041366us : blk_mq_make_request: 
make rq -1
[    8.427462]  systemd-1       1...1 2041944us : blk_mq_free_request: 
complete: rq -1
[    8.429938]  systemd-1       1.... 2041953us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.432401]  systemd-1       1...1 2041993us : blk_mq_make_request: 
make rq -1
[    8.434867]  systemd-1       1...1 2042567us : blk_mq_free_request: 
complete: rq -1
[    8.437337]  systemd-1       1.... 2042575us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.439804]  systemd-1       1...1 2042616us : blk_mq_make_request: 
make rq -1
[    8.442271]  systemd-1       1...1 2043204us : blk_mq_free_request: 
complete: rq -1
[    8.444746]  systemd-1       1.... 2043213us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.447208]  systemd-1       1...1 2043255us : blk_mq_make_request: 
make rq -1
[    8.449675]  systemd-1       1...1 2043805us : blk_mq_free_request: 
complete: rq -1
[    8.452137]  systemd-1       1.... 2043814us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.454600]  systemd-1       1...1 2043855us : blk_mq_make_request: 
make rq -1
[    8.457070]  systemd-1       1...1 2044406us : blk_mq_free_request: 
complete: rq -1
[    8.459542]  systemd-1       1.... 2044415us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.462008]  systemd-1       1...1 2044455us : blk_mq_make_request: 
make rq -1
[    8.464457]  systemd-1       1...1 2045008us : blk_mq_free_request: 
complete: rq -1
[    8.466891]  systemd-1       1.... 2045017us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.469322]  systemd-1       1...1 2045058us : blk_mq_make_request: 
make rq -1
[    8.471737]  systemd-1       1...1 2045612us : blk_mq_free_request: 
complete: rq -1
[    8.474146]  systemd-1       1.... 2045621us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.476546]  systemd-1       1...1 2045662us : blk_mq_make_request: 
make rq -1
[    8.478925]  systemd-1       1...1 2046238us : blk_mq_free_request: 
complete: rq -1
[    8.481260]  systemd-1       1.... 2046246us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.483587]  systemd-1       1...1 2046287us : blk_mq_make_request: 
make rq -1
[    8.485917]  systemd-1       1...1 2046862us : blk_mq_free_request: 
complete: rq -1
[    8.488239]  systemd-1       1.... 2046871us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.490571]  systemd-1       1...1 2046912us : blk_mq_make_request: 
make rq -1
[    8.492899]  systemd-1       1...1 2047485us : blk_mq_free_request: 
complete: rq -1
[    8.495219]  systemd-1       1.... 2047494us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.497553]  systemd-1       1...1 2047534us : blk_mq_make_request: 
make rq -1
[    8.499882]  systemd-1       1...1 2048196us : blk_mq_free_request: 
complete: rq -1
[    8.502200]  systemd-1       1.... 2048205us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.504534]  systemd-1       1...1 2048248us : blk_mq_make_request: 
make rq -1
[    8.506865]  systemd-1       1...1 2048737us : blk_mq_free_request: 
complete: rq -1
[    8.509188]  systemd-1       1.... 2048746us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.511517]  systemd-1       1...1 2048787us : blk_mq_make_request: 
make rq -1
[    8.513849]  systemd-1       1...1 2049960us : blk_mq_free_request: 
complete: rq -1
[    8.516171]  systemd-1       1.... 2049973us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.518503]  systemd-1       1...1 2050053us : blk_mq_make_request: 
make rq -1
[    8.520837]  systemd-1       1...1 2050579us : blk_mq_free_request: 
complete: rq -1
[    8.523164]  systemd-1       1.... 2050590us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.525498]  systemd-1       1...1 2050646us : blk_mq_make_request: 
make rq -1
[    8.527830]  systemd-1       1...1 2051204us : blk_mq_free_request: 
complete: rq -1
[    8.530155]  systemd-1       1.... 2051215us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.532487]  systemd-1       1...1 2051270us : blk_mq_make_request: 
make rq -1
[    8.534819]  systemd-1       1...1 2051722us : blk_mq_free_request: 
complete: rq -1
[    8.537146]  systemd-1       1.... 2051733us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.539479]  systemd-1       1...1 2051787us : blk_mq_make_request: 
make rq -1
[    8.541809]  systemd-1       1...1 2052369us : blk_mq_free_request: 
complete: rq -1
[    8.544136]  systemd-1       1.... 2052380us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.546475]  systemd-1       1...1 2052452us : blk_mq_make_request: 
make rq -1
[    8.548798]  systemd-1       1...1 2053021us : blk_mq_free_request: 
complete: rq -1
[    8.551127]  systemd-1       1.... 2053033us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.553468]  systemd-1       1...1 2053087us : blk_mq_make_request: 
make rq -1
[    8.555805]  systemd-1       1...1 2053667us : blk_mq_free_request: 
complete: rq -1
[    8.558132]  systemd-1       1.... 2053679us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.560467]  systemd-1       1...1 2053733us : blk_mq_make_request: 
make rq -1
[    8.562796]  systemd-1       1...1 2054288us : blk_mq_free_request: 
complete: rq -1
[    8.565118]  systemd-1       1.... 2054300us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.567457]  systemd-1       1...1 2054384us : blk_mq_make_request: 
make rq -1
[    8.569793]  systemd-1       1...1 2054907us : blk_mq_free_request: 
complete: rq -1
[    8.572123]  systemd-1       1.... 2054919us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.574462]  systemd-1       1...1 2054974us : blk_mq_make_request: 
make rq -1
[    8.576794]  systemd-1       1...1 2055528us : blk_mq_free_request: 
complete: rq -1
[    8.579128]  systemd-1       1.... 2055540us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.581467]  systemd-1       1...1 2055597us : blk_mq_make_request: 
make rq -1
[    8.583801]  systemd-1       1...1 2056149us : blk_mq_free_request: 
complete: rq -1
[    8.586136]  systemd-1       1.... 2056160us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.588477]  systemd-1       1...1 2056186us : blk_mq_make_request: 
make rq -1
[    8.590813]  systemd-1       1...1 2056793us : blk_mq_free_request: 
complete: rq -1
[    8.593151]  systemd-1       1.... 2056804us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.595498]   <idle>-0       1dnh1 2057448us : blk_mq_free_request: 
complete: rq -1
[    8.597866]  systemd-1       1...1 2057587us : blk_mq_make_request: 
make rq -1
[    8.600226]  systemd-1       1.... 2057676us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.602604]   <idle>-0       1dnh1 2058355us : blk_mq_free_request: 
complete: rq -1
[    8.605004]  systemd-1       1...1 2058730us : blk_mq_make_request: 
make rq -1
[    8.607393]  systemd-1       1.... 2058819us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.609799]   <idle>-0       1dnh1 2059730us : blk_mq_free_request: 
complete: rq -1
[    8.612225]  systemd-1       1...1 2060501us : blk_mq_make_request: 
make rq -1
[    8.614647]  systemd-1       1.... 2061069us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.617086]  systemd-1       1.... 2061076us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.619574]   <idle>-0       1dnh1 2065951us : blk_mq_free_request: 
complete: rq -1
[    8.622073]  systemd-1       1...1 2066424us : blk_mq_make_request: 
make rq -1
[    8.624588]  systemd-1       1.... 2066885us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.627096]  systemd-1       1.... 2066893us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.629668]   <idle>-0       1dnh1 2071143us : blk_mq_free_request: 
complete: rq -1
[    8.632257]  systemd-1       1...1 2071591us : blk_mq_make_request: 
make rq -1
[    8.634838]  systemd-1       1.... 2072006us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.637418]  systemd-1       1.... 2072014us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.640074]   <idle>-0       1dnh1 2075643us : blk_mq_free_request: 
complete: rq -1
[    8.642738]  systemd-1       1...1 2075952us : blk_mq_make_request: 
make rq -1
[    8.645389]  systemd-1       1.... 2076221us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.648058]  systemd-1       1.... 2076228us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.650780]   <idle>-0       1dnh1 2078862us : blk_mq_free_request: 
complete: rq -1
[    8.653517]  systemd-1       1...1 2079266us : blk_mq_make_request: 
make rq -1
[    8.656264]  systemd-1       1.... 2079818us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.659000]  systemd-1       1.... 2079826us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.661803]   <idle>-0       1dnh1 2084834us : blk_mq_free_request: 
complete: rq -1
[    8.664631]  systemd-1       1...1 2085309us : blk_mq_make_request: 
make rq -1
[    8.667452]  systemd-1       1.... 2085860us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.670272]  systemd-1       1.... 2085868us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.673152]  systemd-1       1...1 2086265us : blk_mq_make_request: 
make rq -1
[    8.676026]  systemd-1       1...1 2090688us : blk_mq_free_request: 
complete: rq -1
[    8.678896]  systemd-1       1.... 2090701us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.681776]  systemd-1       1.... 2090707us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.684712]   <idle>-0       1dnh1 2093035us : blk_mq_free_request: 
complete: rq -1
[    8.687657]  systemd-1       1...1 2093455us : blk_mq_make_request: 
make rq -1
[    8.690608]  systemd-1       1.... 2093998us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.693551]  systemd-1       1.... 2094006us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.696565]   <idle>-0       1dnh1 2098673us : blk_mq_free_request: 
complete: rq -1
[    8.699599]  systemd-1       1...1 2099172us : blk_mq_make_request: 
make rq -1
[    8.702625]  systemd-1       1.... 2099732us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.705656]  systemd-1       1.... 2099740us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.708746]   <idle>-0       1dnh1 2104533us : blk_mq_free_request: 
complete: rq -1
[    8.711853]  systemd-1       1...1 2106282us : blk_mq_make_request: 
make rq -1
[    8.714959]  systemd-1       1.... 2106413us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.718076]  systemd-1       1.... 2106421us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.721245]   <idle>-0       1dnh1 2107371us : blk_mq_free_request: 
complete: rq -1
[    8.724427]  systemd-1       1...1 2110065us : blk_mq_make_request: 
make rq -1
[    8.727616]  systemd-1       1.... 2110507us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.730795]  systemd-1       1.... 2110515us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.734021]  systemd-1       1...1 2110904us : blk_mq_make_request: 
make rq -1
[    8.737235]  systemd-1       1...1 2114768us : blk_mq_free_request: 
complete: rq -1
[    8.740436]  systemd-1       1.... 2114779us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.743624]  systemd-1       1.... 2114783us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    8.746874]   <idle>-0       1dnh1 2119158us : blk_mq_free_request: 
complete: rq -1
[    8.750129]  systemd-1       1...1 2120478us : blk_mq_make_request: 
make rq -1
[    8.753365]  systemd-1       1.... 2120557us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.756591]  systemd-1       1...1 2120602us : blk_mq_make_request: 
make rq -1
[    8.759819]  systemd-1       1...1 2121390us : blk_mq_free_request: 
complete: rq -1
[    8.763020]  systemd-1       1.... 2121400us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.766177]  systemd-1       1...1 2121462us : blk_mq_make_request: 
make rq -1
[    8.769325]  systemd-1       1...1 2121984us : blk_mq_free_request: 
complete: rq -1
[    8.772471]  systemd-1       1.... 2121994us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.775588]  systemd-1       1...1 2122035us : blk_mq_make_request: 
make rq -1
[    8.778672]  systemd-1       1...1 2122583us : blk_mq_free_request: 
complete: rq -1
[    8.781743]  systemd-1       1.... 2122592us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.784811]  systemd-1       1...1 2122633us : blk_mq_make_request: 
make rq -1
[    8.787856]  systemd-1       1...1 2123090us : blk_mq_free_request: 
complete: rq -1
[    8.790860]  systemd-1       1.... 2123098us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.793853]  systemd-1       1...1 2123140us : blk_mq_make_request: 
make rq -1
[    8.796846]  systemd-1       1...1 2123601us : blk_mq_free_request: 
complete: rq -1
[    8.799813]  systemd-1       1.... 2123609us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.802733]  systemd-1       1...1 2123650us : blk_mq_make_request: 
make rq -1
[    8.805652]  systemd-1       1...1 2124222us : blk_mq_free_request: 
complete: rq -1
[    8.808562]  systemd-1       1.... 2124231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.811445]  systemd-1       1...1 2124272us : blk_mq_make_request: 
make rq -1
[    8.814287]  systemd-1       1...1 2124849us : blk_mq_free_request: 
complete: rq -1
[    8.817116]  systemd-1       1.... 2124857us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.819944]  systemd-1       1...1 2124898us : blk_mq_make_request: 
make rq -1
[    8.822745]  systemd-1       1...1 2125357us : blk_mq_free_request: 
complete: rq -1
[    8.825523]  systemd-1       1.... 2125366us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.828304]  systemd-1       1...1 2125407us : blk_mq_make_request: 
make rq -1
[    8.831088]  systemd-1       1...1 2125872us : blk_mq_free_request: 
complete: rq -1
[    8.833843]  systemd-1       1.... 2125881us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.836557]  systemd-1       1...1 2125922us : blk_mq_make_request: 
make rq -1
[    8.839268]  systemd-1       1...1 2126471us : blk_mq_free_request: 
complete: rq -1
[    8.841966]  systemd-1       1.... 2126480us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.844639]  systemd-1       1...1 2126520us : blk_mq_make_request: 
make rq -1
[    8.847276]  systemd-1       1...1 2127072us : blk_mq_free_request: 
complete: rq -1
[    8.849905]  systemd-1       1.... 2127080us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.852529]  systemd-1       1...1 2127121us : blk_mq_make_request: 
make rq -1
[    8.855131]  systemd-1       1...1 2127697us : blk_mq_free_request: 
complete: rq -1
[    8.857688]  systemd-1       1.... 2127705us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.860236]  systemd-1       1...1 2127746us : blk_mq_make_request: 
make rq -1
[    8.862782]  systemd-1       1...1 2128329us : blk_mq_free_request: 
complete: rq -1
[    8.865299]  systemd-1       1.... 2128337us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.867777]  systemd-1       1...1 2128380us : blk_mq_make_request: 
make rq -1
[    8.870246]  systemd-1       1...1 2128953us : blk_mq_free_request: 
complete: rq -1
[    8.872714]  systemd-1       1.... 2128963us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.875151]  systemd-1       1...1 2129004us : blk_mq_make_request: 
make rq -1
[    8.877567]  systemd-1       1...1 2129578us : blk_mq_free_request: 
complete: rq -1
[    8.879989]  systemd-1       1.... 2129587us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.882400]  systemd-1       1...1 2129627us : blk_mq_make_request: 
make rq -1
[    8.884788]  systemd-1       1...1 2130175us : blk_mq_free_request: 
complete: rq -1
[    8.887131]  systemd-1       1.... 2130184us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.889469]  systemd-1       1...1 2130256us : blk_mq_make_request: 
make rq -1
[    8.891809]  systemd-1       1...1 2130778us : blk_mq_free_request: 
complete: rq -1
[    8.894143]  systemd-1       1.... 2130786us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.896485]  systemd-1       1...1 2130827us : blk_mq_make_request: 
make rq -1
[    8.898824]  systemd-1       1...1 2131375us : blk_mq_free_request: 
complete: rq -1
[    8.901158]  systemd-1       1.... 2131383us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.903503]  systemd-1       1...1 2131424us : blk_mq_make_request: 
make rq -1
[    8.905845]  systemd-1       1...1 2131884us : blk_mq_free_request: 
complete: rq -1
[    8.908176]  systemd-1       1.... 2131893us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.910517]  systemd-1       1...1 2131933us : blk_mq_make_request: 
make rq -1
[    8.912856]  systemd-1       1...1 2132506us : blk_mq_free_request: 
complete: rq -1
[    8.915191]  systemd-1       1.... 2132515us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.917535]  systemd-1       1...1 2132555us : blk_mq_make_request: 
make rq -1
[    8.919872]  systemd-1       1...1 2133131us : blk_mq_free_request: 
complete: rq -1
[    8.922204]  systemd-1       1.... 2133139us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.924546]  systemd-1       1...1 2133180us : blk_mq_make_request: 
make rq -1
[    8.926886]  systemd-1       1...1 2133750us : blk_mq_free_request: 
complete: rq -1
[    8.929218]  systemd-1       1.... 2133758us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.931552]  systemd-1       1...1 2133799us : blk_mq_make_request: 
make rq -1
[    8.933890]  systemd-1       1...1 2135014us : blk_mq_free_request: 
complete: rq -1
[    8.936221]  systemd-1       1.... 2135027us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.938557]  systemd-1       1...1 2135086us : blk_mq_make_request: 
make rq -1
[    8.940893]  systemd-1       1...1 2135631us : blk_mq_free_request: 
complete: rq -1
[    8.943226]  systemd-1       1.... 2135643us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.945562]  systemd-1       1...1 2135698us : blk_mq_make_request: 
make rq -1
[    8.947895]  systemd-1       1...1 2136249us : blk_mq_free_request: 
complete: rq -1
[    8.950229]  systemd-1       1.... 2136260us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.952568]  systemd-1       1...1 2136313us : blk_mq_make_request: 
make rq -1
[    8.954905]  systemd-1       1...1 2136866us : blk_mq_free_request: 
complete: rq -1
[    8.957235]  systemd-1       1.... 2136877us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.959572]  systemd-1       1...1 2136932us : blk_mq_make_request: 
make rq -1
[    8.961906]  systemd-1       1...1 2137488us : blk_mq_free_request: 
complete: rq -1
[    8.964240]  systemd-1       1.... 2137500us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.966582]  systemd-1       1...1 2137553us : blk_mq_make_request: 
make rq -1
[    8.968914]  systemd-1       1...1 2138197us : blk_mq_free_request: 
complete: rq -1
[    8.971243]  systemd-1       1.... 2138209us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.973585]  systemd-1       1...1 2138268us : blk_mq_make_request: 
make rq -1
[    8.975924]  systemd-1       1...1 2138802us : blk_mq_free_request: 
complete: rq -1
[    8.978252]  systemd-1       1.... 2138814us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.980591]  systemd-1       1...1 2138868us : blk_mq_make_request: 
make rq -1
[    8.982928]  systemd-1       1...1 2139449us : blk_mq_free_request: 
complete: rq -1
[    8.985258]  systemd-1       1.... 2139461us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.987591]  systemd-1       1...1 2139515us : blk_mq_make_request: 
make rq -1
[    8.989929]  systemd-1       1...1 2140093us : blk_mq_free_request: 
complete: rq -1
[    8.992260]  systemd-1       1.... 2140105us : mmc_mq_queue_rq: queue 
rq -1, 0
[    8.994604]  systemd-1       1...1 2140130us : blk_mq_make_request: 
make rq -1
[    8.996940]  systemd-1       1...1 2140709us : blk_mq_free_request: 
complete: rq -1
[    8.999271]  systemd-1       1.... 2140721us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.001607]   <idle>-0       1dnh1 2141248us : blk_mq_free_request: 
complete: rq -1
[    9.003975]  systemd-1       1...1 2141508us : blk_mq_make_request: 
make rq -1
[    9.006338]  systemd-1       1.... 2141596us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.008707]   <idle>-0       1dnh1 2142479us : blk_mq_free_request: 
complete: rq -1
[    9.011097]  systemd-1       1...1 2142909us : blk_mq_make_request: 
make rq -1
[    9.013486]  systemd-1       1.... 2142999us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.015875]   <idle>-0       1dnh1 2143908us : blk_mq_free_request: 
complete: rq -1
[    9.018295]  systemd-1       1...1 2144651us : blk_mq_make_request: 
make rq -1
[    9.020710]  systemd-1       1.... 2144758us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.023138]  systemd-1       1...1 2144815us : blk_mq_make_request: 
make rq -1
[    9.025563]  systemd-1       1...1 2145521us : blk_mq_free_request: 
complete: rq -1
[    9.027983]  systemd-1       1.... 2145533us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.030410]  systemd-1       1...1 2145589us : blk_mq_make_request: 
make rq -1
[    9.032832]  systemd-1       1...1 2146170us : blk_mq_free_request: 
complete: rq -1
[    9.035249]  systemd-1       1.... 2146182us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.037678]  systemd-1       1...1 2146237us : blk_mq_make_request: 
make rq -1
[    9.040104]  systemd-1       1...1 2146834us : blk_mq_free_request: 
complete: rq -1
[    9.042524]  systemd-1       1.... 2146846us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.044957]  systemd-1       1...1 2146901us : blk_mq_make_request: 
make rq -1
[    9.047387]  systemd-1       1...1 2147458us : blk_mq_free_request: 
complete: rq -1
[    9.049810]  systemd-1       1.... 2147470us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.052238]  systemd-1       1...1 2147524us : blk_mq_make_request: 
make rq -1
[    9.054670]  systemd-1       1...1 2148143us : blk_mq_free_request: 
complete: rq -1
[    9.057099]  systemd-1       1.... 2148156us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.059532]  systemd-1       1...1 2148217us : blk_mq_make_request: 
make rq -1
[    9.061966]  systemd-1       1...1 2148720us : blk_mq_free_request: 
complete: rq -1
[    9.064395]  systemd-1       1.... 2148732us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.066830]  systemd-1       1...1 2148787us : blk_mq_make_request: 
make rq -1
[    9.069261]  systemd-1       1...1 2149350us : blk_mq_free_request: 
complete: rq -1
[    9.071686]  systemd-1       1.... 2149361us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.074118]  systemd-1       1...1 2149416us : blk_mq_make_request: 
make rq -1
[    9.076551]  systemd-1       1...1 2150001us : blk_mq_free_request: 
complete: rq -1
[    9.078983]  systemd-1       1.... 2150012us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.081418]  systemd-1       1...1 2150067us : blk_mq_make_request: 
make rq -1
[    9.083846]  systemd-1       1...1 2150650us : blk_mq_free_request: 
complete: rq -1
[    9.086274]  systemd-1       1.... 2150662us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.088708]  systemd-1       1...1 2150716us : blk_mq_make_request: 
make rq -1
[    9.091133]  systemd-1       1...1 2151298us : blk_mq_free_request: 
complete: rq -1
[    9.093563]  systemd-1       1.... 2151309us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.095995]  systemd-1       1...1 2151386us : blk_mq_make_request: 
make rq -1
[    9.098427]  systemd-1       1...1 2151955us : blk_mq_free_request: 
complete: rq -1
[    9.100853]  systemd-1       1.... 2151967us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.103287]  systemd-1       1...1 2152023us : blk_mq_make_request: 
make rq -1
[    9.105723]  systemd-1       1...1 2152588us : blk_mq_free_request: 
complete: rq -1
[    9.108149]  systemd-1       1.... 2152599us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.110587]  systemd-1       1...1 2152653us : blk_mq_make_request: 
make rq -1
[    9.113020]  systemd-1       1...1 2153217us : blk_mq_free_request: 
complete: rq -1
[    9.115449]  systemd-1       1.... 2153231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.117886]  systemd-1       1...1 2153285us : blk_mq_make_request: 
make rq -1
[    9.120322]  systemd-1       1...1 2153840us : blk_mq_free_request: 
complete: rq -1
[    9.122727]  systemd-1       1.... 2153851us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.125121]  systemd-1       1...1 2153906us : blk_mq_make_request: 
make rq -1
[    9.127518]  systemd-1       1...1 2154466us : blk_mq_free_request: 
complete: rq -1
[    9.129896]  systemd-1       1.... 2154478us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.132262]  systemd-1       1...1 2154531us : blk_mq_make_request: 
make rq -1
[    9.134637]  systemd-1       1...1 2155706us : blk_mq_free_request: 
complete: rq -1
[    9.136983]  systemd-1       1.... 2155716us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.139327]  systemd-1       1...1 2155760us : blk_mq_make_request: 
make rq -1
[    9.141671]  systemd-1       1...1 2156338us : blk_mq_free_request: 
complete: rq -1
[    9.144007]  systemd-1       1.... 2156347us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.146355]  systemd-1       1...1 2156388us : blk_mq_make_request: 
make rq -1
[    9.148699]  systemd-1       1...1 2156966us : blk_mq_free_request: 
complete: rq -1
[    9.151033]  systemd-1       1.... 2156975us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.153375]  systemd-1       1...1 2157016us : blk_mq_make_request: 
make rq -1
[    9.155720]  systemd-1       1...1 2157599us : blk_mq_free_request: 
complete: rq -1
[    9.158055]  systemd-1       1.... 2157608us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.160398]  systemd-1       1...1 2157663us : blk_mq_make_request: 
make rq -1
[    9.162744]  systemd-1       1...1 2158222us : blk_mq_free_request: 
complete: rq -1
[    9.165085]  systemd-1       1.... 2158232us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.167434]  systemd-1       1...1 2158274us : blk_mq_make_request: 
make rq -1
[    9.169777]  systemd-1       1...1 2158829us : blk_mq_free_request: 
complete: rq -1
[    9.172118]  systemd-1       1.... 2158838us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.174465]  systemd-1       1...1 2158902us : blk_mq_make_request: 
make rq -1
[    9.176799]  systemd-1       1...1 2159439us : blk_mq_free_request: 
complete: rq -1
[    9.179135]  systemd-1       1.... 2159448us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.181485]  systemd-1       1...1 2159489us : blk_mq_make_request: 
make rq -1
[    9.183829]  systemd-1       1...1 2160047us : blk_mq_free_request: 
complete: rq -1
[    9.186166]  systemd-1       1.... 2160056us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.188510]  systemd-1       1...1 2160096us : blk_mq_make_request: 
make rq -1
[    9.190856]  systemd-1       1...1 2160687us : blk_mq_free_request: 
complete: rq -1
[    9.193194]  systemd-1       1.... 2160696us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.195537]  systemd-1       1...1 2160737us : blk_mq_make_request: 
make rq -1
[    9.197879]  systemd-1       1...1 2161344us : blk_mq_free_request: 
complete: rq -1
[    9.200216]  systemd-1       1.... 2161353us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.202565]  systemd-1       1...1 2161411us : blk_mq_make_request: 
make rq -1
[    9.204912]  systemd-1       1...1 2161974us : blk_mq_free_request: 
complete: rq -1
[    9.207249]  systemd-1       1.... 2161982us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.209590]  systemd-1       1...1 2162023us : blk_mq_make_request: 
make rq -1
[    9.211934]  systemd-1       1...1 2162609us : blk_mq_free_request: 
complete: rq -1
[    9.214276]  systemd-1       1.... 2162617us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.216624]  systemd-1       1...1 2162658us : blk_mq_make_request: 
make rq -1
[    9.218965]  systemd-1       1...1 2163213us : blk_mq_free_request: 
complete: rq -1
[    9.221301]  systemd-1       1.... 2163222us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.223646]  systemd-1       1...1 2163263us : blk_mq_make_request: 
make rq -1
[    9.225985]  systemd-1       1...1 2163818us : blk_mq_free_request: 
complete: rq -1
[    9.228322]  systemd-1       1.... 2163826us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.230663]  systemd-1       1...1 2163866us : blk_mq_make_request: 
make rq -1
[    9.232998]  systemd-1       1...1 2164429us : blk_mq_free_request: 
complete: rq -1
[    9.235329]  systemd-1       1.... 2164437us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.237670]  systemd-1       1...1 2164478us : blk_mq_make_request: 
make rq -1
[    9.240009]  systemd-1       1...1 2165037us : blk_mq_free_request: 
complete: rq -1
[    9.242347]  systemd-1       1.... 2165046us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.244692]  systemd-1       1...1 2165065us : blk_mq_make_request: 
make rq -1
[    9.247028]  systemd-1       1...1 2165668us : blk_mq_free_request: 
complete: rq -1
[    9.249362]  systemd-1       1.... 2165676us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.251701]   <idle>-0       1dnh1 2166304us : blk_mq_free_request: 
complete: rq -1
[    9.254068]  systemd-1       1...1 2166409us : blk_mq_make_request: 
make rq -1
[    9.256425]  systemd-1       1.... 2166485us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.258799]   <idle>-0       1dnh1 2167178us : blk_mq_free_request: 
complete: rq -1
[    9.261195]  systemd-1       1...1 2167409us : blk_mq_make_request: 
make rq -1
[    9.263588]  systemd-1       1.... 2167475us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.265993]   <idle>-0       1dnh1 2168351us : blk_mq_free_request: 
complete: rq -1
[    9.268411]  systemd-1       1...1 2168745us : blk_mq_make_request: 
make rq -1
[    9.270826]  systemd-1       1.... 2168821us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.273251]  systemd-1       1.... 2168826us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.275736]   <idle>-0       1dnh1 2169695us : blk_mq_free_request: 
complete: rq -1
[    9.278232]  systemd-1       1...1 2169906us : blk_mq_make_request: 
make rq -1
[    9.280730]  systemd-1       1.... 2169976us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.283229]  systemd-1       1.... 2169982us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.285790]   <idle>-0       1dnh1 2170846us : blk_mq_free_request: 
complete: rq -1
[    9.288375]  systemd-1       1...1 2171181us : blk_mq_make_request: 
make rq -1
[    9.290950]  systemd-1       1.... 2171253us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.293530]  systemd-1       1.... 2171259us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.296176]   <idle>-0       1dnh1 2171933us : blk_mq_free_request: 
complete: rq -1
[    9.298829]  systemd-1       1...1 2172087us : blk_mq_make_request: 
make rq -1
[    9.301477]  systemd-1       1.... 2172157us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.304136]  systemd-1       1.... 2172163us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.306851]   <idle>-0       1dnh1 2172849us : blk_mq_free_request: 
complete: rq -1
[    9.309578]  systemd-1       1...1 2173021us : blk_mq_make_request: 
make rq -1
[    9.312310]  systemd-1       1.... 2173091us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.315039]  systemd-1       1.... 2173097us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.317829]   <idle>-0       1dnh1 2173745us : blk_mq_free_request: 
complete: rq -1
[    9.320635]  systemd-1       1...1 2174019us : blk_mq_make_request: 
make rq -1
[    9.323434]  systemd-1       1.... 2174088us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.326228]  systemd-1       1.... 2174094us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.329103]   <idle>-0       1dnh1 2174782us : blk_mq_free_request: 
complete: rq -1
[    9.331972]  systemd-1       1...1 2174948us : blk_mq_make_request: 
make rq -1
[    9.334844]  systemd-1       1.... 2175030us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.337725]  systemd-1       1.... 2175036us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.340663]   <idle>-0       1dnh1 2175891us : blk_mq_free_request: 
complete: rq -1
[    9.343608]  systemd-1       1...1 2176652us : blk_mq_make_request: 
make rq -1
[    9.346567]  systemd-1       1.... 2176747us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.349524]  systemd-1       1.... 2176754us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.352540]   <idle>-0       1dnh1 2177448us : blk_mq_free_request: 
complete: rq -1
[    9.355576]  systemd-1       1...1 2177706us : blk_mq_make_request: 
make rq -1
[    9.358600]  systemd-1       1.... 2177798us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.361633]  systemd-1       1.... 2177806us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.364730]   <idle>-0       1dnh1 2178494us : blk_mq_free_request: 
complete: rq -1
[    9.367840]  systemd-1       1...1 2178821us : blk_mq_make_request: 
make rq -1
[    9.370943]  systemd-1       1.... 2178915us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.374059]  systemd-1       1.... 2178923us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.377231]   <idle>-0       1dnh1 2179828us : blk_mq_free_request: 
complete: rq -1
[    9.380413]  systemd-1       1...1 2180107us : blk_mq_make_request: 
make rq -1
[    9.383611]  systemd-1       1.... 2180199us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.386804]  systemd-1       1.... 2180206us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.390033]   <idle>-0       1dnh1 2181079us : blk_mq_free_request: 
complete: rq -1
[    9.393271]  systemd-1       1...1 2181328us : blk_mq_make_request: 
make rq -1
[    9.396501]  systemd-1       1.... 2181414us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.399715]  systemd-1       1...1 2181470us : blk_mq_make_request: 
make rq -1
[    9.402920]  systemd-1       1...1 2182320us : blk_mq_free_request: 
complete: rq -1
[    9.406132]  systemd-1       1.... 2182332us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.409321]  systemd-1       1...1 2182388us : blk_mq_make_request: 
make rq -1
[    9.412497]  systemd-1       1...1 2182984us : blk_mq_free_request: 
complete: rq -1
[    9.415667]  systemd-1       1.... 2182995us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.418814]  systemd-1       1...1 2183050us : blk_mq_make_request: 
make rq -1
[    9.421920]  systemd-1       1...1 2183656us : blk_mq_free_request: 
complete: rq -1
[    9.425024]  systemd-1       1.... 2183668us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.428125]  systemd-1       1...1 2183723us : blk_mq_make_request: 
make rq -1
[    9.431206]  systemd-1       1...1 2184296us : blk_mq_free_request: 
complete: rq -1
[    9.434236]  systemd-1       1.... 2184308us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.437265]  systemd-1       1...1 2184363us : blk_mq_make_request: 
make rq -1
[    9.440290]  systemd-1       1...1 2184936us : blk_mq_free_request: 
complete: rq -1
[    9.443285]  systemd-1       1.... 2184947us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.446240]  systemd-1       1...1 2185003us : blk_mq_make_request: 
make rq -1
[    9.449194]  systemd-1       1...1 2185577us : blk_mq_free_request: 
complete: rq -1
[    9.452134]  systemd-1       1.... 2185589us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.455051]  systemd-1       1...1 2185643us : blk_mq_make_request: 
make rq -1
[    9.457931]  systemd-1       1...1 2186220us : blk_mq_free_request: 
complete: rq -1
[    9.460802]  systemd-1       1.... 2186231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.463671]  systemd-1       1...1 2186286us : blk_mq_make_request: 
make rq -1
[    9.466513]  systemd-1       1...1 2186883us : blk_mq_free_request: 
complete: rq -1
[    9.469309]  systemd-1       1.... 2186895us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.472098]  systemd-1       1...1 2186972us : blk_mq_make_request: 
make rq -1
[    9.474891]  systemd-1       1...1 2187550us : blk_mq_free_request: 
complete: rq -1
[    9.477652]  systemd-1       1.... 2187562us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.480382]  systemd-1       1...1 2187616us : blk_mq_make_request: 
make rq -1
[    9.483106]  systemd-1       1...1 2188297us : blk_mq_free_request: 
complete: rq -1
[    9.485825]  systemd-1       1.... 2188310us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.488520]  systemd-1       1...1 2188367us : blk_mq_make_request: 
make rq -1
[    9.491167]  systemd-1       1...1 2188969us : blk_mq_free_request: 
complete: rq -1
[    9.493810]  systemd-1       1.... 2188981us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.496451]  systemd-1       1...1 2189036us : blk_mq_make_request: 
make rq -1
[    9.499070]  systemd-1       1...1 2189612us : blk_mq_free_request: 
complete: rq -1
[    9.501642]  systemd-1       1.... 2189624us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.504206]  systemd-1       1...1 2189678us : blk_mq_make_request: 
make rq -1
[    9.506777]  systemd-1       1...1 2190261us : blk_mq_free_request: 
complete: rq -1
[    9.509316]  systemd-1       1.... 2190272us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.511809]  systemd-1       1...1 2190328us : blk_mq_make_request: 
make rq -1
[    9.514305]  systemd-1       1...1 2190904us : blk_mq_free_request: 
complete: rq -1
[    9.516795]  systemd-1       1.... 2190915us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.519257]  systemd-1       1...1 2190970us : blk_mq_make_request: 
make rq -1
[    9.521682]  systemd-1       1...1 2191549us : blk_mq_free_request: 
complete: rq -1
[    9.524096]  systemd-1       1.... 2191561us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.526509]  systemd-1       1...1 2191615us : blk_mq_make_request: 
make rq -1
[    9.528899]  systemd-1       1...1 2192211us : blk_mq_free_request: 
complete: rq -1
[    9.531240]  systemd-1       1.... 2192223us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.533574]  systemd-1       1...1 2192277us : blk_mq_make_request: 
make rq -1
[    9.535912]  systemd-1       1...1 2192882us : blk_mq_free_request: 
complete: rq -1
[    9.538243]  systemd-1       1.... 2192893us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.540581]  systemd-1       1...1 2192947us : blk_mq_make_request: 
make rq -1
[    9.542918]  systemd-1       1...1 2193552us : blk_mq_free_request: 
complete: rq -1
[    9.545255]  systemd-1       1.... 2193563us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.547595]  systemd-1       1...1 2193617us : blk_mq_make_request: 
make rq -1
[    9.549931]  systemd-1       1...1 2194220us : blk_mq_free_request: 
complete: rq -1
[    9.552260]  systemd-1       1.... 2194231us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.554605]  systemd-1       1...1 2194285us : blk_mq_make_request: 
make rq -1
[    9.556942]  systemd-1       1...1 2194861us : blk_mq_free_request: 
complete: rq -1
[    9.559279]  systemd-1       1.... 2194872us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.561622]  systemd-1       1...1 2194926us : blk_mq_make_request: 
make rq -1
[    9.563956]  systemd-1       1...1 2195502us : blk_mq_free_request: 
complete: rq -1
[    9.566296]  systemd-1       1.... 2195513us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.568641]  systemd-1       1...1 2195566us : blk_mq_make_request: 
make rq -1
[    9.570980]  systemd-1       1...1 2196732us : blk_mq_free_request: 
complete: rq -1
[    9.573315]  systemd-1       1.... 2196741us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.575652]  systemd-1       1...1 2196785us : blk_mq_make_request: 
make rq -1
[    9.577995]  systemd-1       1...1 2197358us : blk_mq_free_request: 
complete: rq -1
[    9.580327]  systemd-1       1.... 2197367us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.582674]  systemd-1       1...1 2197424us : blk_mq_make_request: 
make rq -1
[    9.585014]  systemd-1       1...1 2198005us : blk_mq_free_request: 
complete: rq -1
[    9.587350]  systemd-1       1.... 2198013us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.589691]  systemd-1       1...1 2198055us : blk_mq_make_request: 
make rq -1
[    9.592029]  systemd-1       1...1 2198660us : blk_mq_free_request: 
complete: rq -1
[    9.594367]  systemd-1       1.... 2198669us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.596712]  systemd-1       1...1 2198713us : blk_mq_make_request: 
make rq -1
[    9.599053]  systemd-1       1...1 2199306us : blk_mq_free_request: 
complete: rq -1
[    9.601388]  systemd-1       1.... 2199315us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.603734]  systemd-1       1...1 2199356us : blk_mq_make_request: 
make rq -1
[    9.606076]  systemd-1       1...1 2199956us : blk_mq_free_request: 
complete: rq -1
[    9.608411]  systemd-1       1.... 2199965us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.610753]  systemd-1       1...1 2200005us : blk_mq_make_request: 
make rq -1
[    9.613095]  systemd-1       1...1 2200577us : blk_mq_free_request: 
complete: rq -1
[    9.615430]  systemd-1       1.... 2200585us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.617776]  systemd-1       1...1 2200626us : blk_mq_make_request: 
make rq -1
[    9.620115]  systemd-1       1...1 2201200us : blk_mq_free_request: 
complete: rq -1
[    9.622452]  systemd-1       1.... 2201208us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.624793]  systemd-1       1...1 2201249us : blk_mq_make_request: 
make rq -1
[    9.627129]  systemd-1       1...1 2201819us : blk_mq_free_request: 
complete: rq -1
[    9.629460]  systemd-1       1.... 2201828us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.631798]  systemd-1       1...1 2201869us : blk_mq_make_request: 
make rq -1
[    9.634137]  systemd-1       1...1 2202448us : blk_mq_free_request: 
complete: rq -1
[    9.636471]  systemd-1       1.... 2202456us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.638809]  systemd-1       1...1 2202476us : blk_mq_make_request: 
make rq -1
[    9.641144]  systemd-1       1...1 2203092us : blk_mq_free_request: 
complete: rq -1
[    9.643470]  systemd-1       1.... 2203101us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.645815]   <idle>-0       1dnh1 2203743us : blk_mq_free_request: 
complete: rq -1
[    9.648177]  systemd-1       1...1 2203848us : blk_mq_make_request: 
make rq -1
[    9.650531]  systemd-1       1.... 2203913us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.652904]   <idle>-0       1dnh1 2204465us : blk_mq_free_request: 
complete: rq -1
[    9.655298]  systemd-1       1...1 2204646us : blk_mq_make_request: 
make rq -1
[    9.657684]  systemd-1       1.... 2204718us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.660080]  systemd-1       1.... 2204723us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.662532]   <idle>-0       1dnh1 2205588us : blk_mq_free_request: 
complete: rq -1
[    9.665001]  systemd-1       1...1 2215645us : blk_mq_make_request: 
make rq -1
[    9.667479]  systemd-1       1.... 2215963us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.669953]  systemd-1       1.... 2215969us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[    9.672487]   <idle>-0       1dnh1 2219435us : blk_mq_free_request: 
complete: rq -1
[    9.675042]  systemd-1       1...1 2220427us : blk_mq_make_request: 
make rq -1
[    9.677585]  systemd-1       1.... 2220491us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.680135]   <idle>-0       1dnh1 2221246us : blk_mq_free_request: 
complete: rq -1
[    9.682718]  systemd-1       1...1 2221455us : blk_mq_make_request: 
make rq -1
[    9.685296]  systemd-1       1.... 2221507us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.687877]   <idle>-0       1dnh1 2222181us : blk_mq_free_request: 
complete: rq -1
[    9.690490]  systemd-1       1...1 2222451us : blk_mq_make_request: 
make rq -1
[    9.693093]  systemd-1       1.... 2222503us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.695701]  systemd-1       1...1 2222535us : blk_mq_make_request: 
make rq -1
[    9.698323]  systemd-1       1...1 2223323us : blk_mq_free_request: 
complete: rq -1
[    9.700931]  systemd-1       1.... 2223329us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.703541]  systemd-1       1...1 2223361us : blk_mq_make_request: 
make rq -1
[    9.706159]  systemd-1       1...1 2223927us : blk_mq_free_request: 
complete: rq -1
[    9.708767]  systemd-1       1.... 2223933us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.711374]  systemd-1       1...1 2223964us : blk_mq_make_request: 
make rq -1
[    9.713996]  systemd-1       1...1 2224531us : blk_mq_free_request: 
complete: rq -1
[    9.716602]  systemd-1       1.... 2224537us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.719210]  systemd-1       1...1 2224568us : blk_mq_make_request: 
make rq -1
[    9.721829]  systemd-1       1...1 2225139us : blk_mq_free_request: 
complete: rq -1
[    9.724438]  systemd-1       1.... 2225145us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.727043]  systemd-1       1...1 2225175us : blk_mq_make_request: 
make rq -1
[    9.729661]  systemd-1       1...1 2225764us : blk_mq_free_request: 
complete: rq -1
[    9.732269]  systemd-1       1.... 2225771us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.734871]  systemd-1       1...1 2225801us : blk_mq_make_request: 
make rq -1
[    9.737485]  systemd-1       1...1 2226392us : blk_mq_free_request: 
complete: rq -1
[    9.740077]  systemd-1       1.... 2226399us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.742679]  systemd-1       1...1 2226430us : blk_mq_make_request: 
make rq -1
[    9.745290]  systemd-1       1...1 2227018us : blk_mq_free_request: 
complete: rq -1
[    9.747896]  systemd-1       1.... 2227024us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.750498]  systemd-1       1...1 2227054us : blk_mq_make_request: 
make rq -1
[    9.753107]  systemd-1       1...1 2227649us : blk_mq_free_request: 
complete: rq -1
[    9.755707]  systemd-1       1.... 2227656us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.758306]  systemd-1       1...1 2227700us : blk_mq_make_request: 
make rq -1
[    9.760912]  systemd-1       1...1 2228262us : blk_mq_free_request: 
complete: rq -1
[    9.763515]  systemd-1       1.... 2228270us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.766121]  systemd-1       1...1 2228303us : blk_mq_make_request: 
make rq -1
[    9.768732]  systemd-1       1...1 2228864us : blk_mq_free_request: 
complete: rq -1
[    9.771329]  systemd-1       1.... 2228870us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.773909]  systemd-1       1...1 2228901us : blk_mq_make_request: 
make rq -1
[    9.776490]  systemd-1       1...1 2229470us : blk_mq_free_request: 
complete: rq -1
[    9.779062]  systemd-1       1.... 2229476us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.781605]  systemd-1       1...1 2229506us : blk_mq_make_request: 
make rq -1
[    9.784154]  systemd-1       1...1 2230075us : blk_mq_free_request: 
complete: rq -1
[    9.786699]  systemd-1       1.... 2230081us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.789215]  systemd-1       1...1 2230124us : blk_mq_make_request: 
make rq -1
[    9.791692]  systemd-1       1...1 2230703us : blk_mq_free_request: 
complete: rq -1
[    9.794160]  systemd-1       1.... 2230709us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.796622]  systemd-1       1...1 2230761us : blk_mq_make_request: 
make rq -1
[    9.799062]  systemd-1       1...1 2231330us : blk_mq_free_request: 
complete: rq -1
[    9.801456]  systemd-1       1.... 2231336us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.803837]  systemd-1       1...1 2231367us : blk_mq_make_request: 
make rq -1
[    9.806220]  systemd-1       1...1 2231956us : blk_mq_free_request: 
complete: rq -1
[    9.808578]  systemd-1       1.... 2231963us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.810932]  systemd-1       1...1 2231994us : blk_mq_make_request: 
make rq -1
[    9.813288]  systemd-1       1...1 2232588us : blk_mq_free_request: 
complete: rq -1
[    9.815618]  systemd-1       1.... 2232594us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.817941]  systemd-1       1...1 2232625us : blk_mq_make_request: 
make rq -1
[    9.820267]  systemd-1       1...1 2233190us : blk_mq_free_request: 
complete: rq -1
[    9.822586]  systemd-1       1.... 2233196us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.824910]  systemd-1       1...1 2233226us : blk_mq_make_request: 
make rq -1
[    9.827236]  systemd-1       1...1 2233795us : blk_mq_free_request: 
complete: rq -1
[    9.829559]  systemd-1       1.... 2233802us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.831891]  systemd-1       1...1 2233832us : blk_mq_make_request: 
make rq -1
[    9.834221]  systemd-1       1...1 2234397us : blk_mq_free_request: 
complete: rq -1
[    9.836537]  systemd-1       1.... 2234403us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.838866]  systemd-1       1...1 2234433us : blk_mq_make_request: 
make rq -1
[    9.841192]  systemd-1       1...1 2235006us : blk_mq_free_request: 
complete: rq -1
[    9.843516]  systemd-1       1.... 2235012us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.845841]  systemd-1       1...1 2235042us : blk_mq_make_request: 
make rq -1
[    9.848167]  systemd-1       1...1 2235634us : blk_mq_free_request: 
complete: rq -1
[    9.850490]  systemd-1       1.... 2235640us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.852810]  systemd-1       1...1 2235670us : blk_mq_make_request: 
make rq -1
[    9.855137]  systemd-1       1...1 2236260us : blk_mq_free_request: 
complete: rq -1
[    9.857454]  systemd-1       1.... 2236266us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.859779]  systemd-1       1...1 2236297us : blk_mq_make_request: 
make rq -1
[    9.862104]  systemd-1       1...1 2236888us : blk_mq_free_request: 
complete: rq -1
[    9.864421]  systemd-1       1.... 2236895us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.866745]  systemd-1       1...1 2236938us : blk_mq_make_request: 
make rq -1
[    9.869063]  systemd-1       1...1 2237518us : blk_mq_free_request: 
complete: rq -1
[    9.871381]  systemd-1       1.... 2237525us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.873709]  systemd-1       1...1 2237555us : blk_mq_make_request: 
make rq -1
[    9.876031]  systemd-1       1...1 2238179us : blk_mq_free_request: 
complete: rq -1
[    9.878352]  systemd-1       1.... 2238186us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.880679]  systemd-1       1...1 2238218us : blk_mq_make_request: 
make rq -1
[    9.883009]  systemd-1       1...1 2239423us : blk_mq_free_request: 
complete: rq -1
[    9.885323]  systemd-1       1.... 2239436us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.887648]  systemd-1       1...1 2239495us : blk_mq_make_request: 
make rq -1
[    9.889972]  systemd-1       1...1 2240064us : blk_mq_free_request: 
complete: rq -1
[    9.892294]  systemd-1       1.... 2240076us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.894624]  systemd-1       1...1 2240137us : blk_mq_make_request: 
make rq -1
[    9.896951]  systemd-1       1...1 2240702us : blk_mq_free_request: 
complete: rq -1
[    9.899268]  systemd-1       1.... 2240714us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.901593]  systemd-1       1...1 2240769us : blk_mq_make_request: 
make rq -1
[    9.903918]  systemd-1       1...1 2241364us : blk_mq_free_request: 
complete: rq -1
[    9.906241]  systemd-1       1.... 2241375us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.908566]  systemd-1       1...1 2241429us : blk_mq_make_request: 
make rq -1
[    9.910894]  systemd-1       1...1 2242025us : blk_mq_free_request: 
complete: rq -1
[    9.913221]  systemd-1       1.... 2242037us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.915551]  systemd-1       1...1 2242093us : blk_mq_make_request: 
make rq -1
[    9.917875]  systemd-1       1...1 2242688us : blk_mq_free_request: 
complete: rq -1
[    9.920198]  systemd-1       1.... 2242699us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.922526]  systemd-1       1...1 2242724us : blk_mq_make_request: 
make rq -1
[    9.924857]  systemd-1       1...1 2243328us : blk_mq_free_request: 
complete: rq -1
[    9.927183]  systemd-1       1.... 2243338us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.929515]   <idle>-0       1dnh1 2243994us : blk_mq_free_request: 
complete: rq -1
[    9.931868]  systemd-1       1...1 2244209us : blk_mq_make_request: 
make rq -1
[    9.934221]  systemd-1       1.... 2244297us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.936584]   <idle>-0       1dnh1 2245208us : blk_mq_free_request: 
complete: rq -1
[    9.938967]  systemd-1       1...1 2245383us : blk_mq_make_request: 
make rq -1
[    9.941351]  systemd-1       1.... 2245469us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.943740]  systemd-1       1...1 2245524us : blk_mq_make_request: 
make rq -1
[    9.946131]  systemd-1       1...1 2246346us : blk_mq_free_request: 
complete: rq -1
[    9.948516]  systemd-1       1.... 2246358us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.950911]  systemd-1       1...1 2246413us : blk_mq_make_request: 
make rq -1
[    9.953306]  systemd-1       1...1 2246965us : blk_mq_free_request: 
complete: rq -1
[    9.955693]  systemd-1       1.... 2246977us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.958086]  systemd-1       1...1 2247031us : blk_mq_make_request: 
make rq -1
[    9.960478]  systemd-1       1...1 2247586us : blk_mq_free_request: 
complete: rq -1
[    9.962864]  systemd-1       1.... 2247598us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.965258]  systemd-1       1...1 2247653us : blk_mq_make_request: 
make rq -1
[    9.967656]  systemd-1       1...1 2248472us : blk_mq_free_request: 
complete: rq -1
[    9.970045]  systemd-1       1.... 2248485us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.972447]  systemd-1       1...1 2248566us : blk_mq_make_request: 
make rq -1
[    9.974848]  systemd-1       1...1 2249117us : blk_mq_free_request: 
complete: rq -1
[    9.977240]  systemd-1       1.... 2249129us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.979644]  systemd-1       1...1 2249185us : blk_mq_make_request: 
make rq -1
[    9.982044]  systemd-1       1...1 2249759us : blk_mq_free_request: 
complete: rq -1
[    9.984432]  systemd-1       1.... 2249771us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.986836]  systemd-1       1...1 2249828us : blk_mq_make_request: 
make rq -1
[    9.989231]  systemd-1       1...1 2250403us : blk_mq_free_request: 
complete: rq -1
[    9.991629]  systemd-1       1.... 2250414us : mmc_mq_queue_rq: queue 
rq -1, 0
[    9.994034]  systemd-1       1...1 2250470us : blk_mq_make_request: 
make rq -1
[    9.996438]  systemd-1       1...1 2251036us : blk_mq_free_request: 
complete: rq -1
[    9.998831]  systemd-1       1.... 2251048us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.001235]  systemd-1       1...1 2251102us : blk_mq_make_request: 
make rq -1
[   10.003639]  systemd-1       1...1 2251657us : blk_mq_free_request: 
complete: rq -1
[   10.006038]  systemd-1       1.... 2251669us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.008446]  systemd-1       1...1 2251723us : blk_mq_make_request: 
make rq -1
[   10.010849]  systemd-1       1...1 2252272us : blk_mq_free_request: 
complete: rq -1
[   10.013250]  systemd-1       1.... 2252283us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.015660]  systemd-1       1...1 2252338us : blk_mq_make_request: 
make rq -1
[   10.018066]  systemd-1       1...1 2252894us : blk_mq_free_request: 
complete: rq -1
[   10.020465]  systemd-1       1.... 2252906us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.022866]  systemd-1       1...1 2252960us : blk_mq_make_request: 
make rq -1
[   10.025263]  systemd-1       1...1 2253538us : blk_mq_free_request: 
complete: rq -1
[   10.027655]  systemd-1       1.... 2253550us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.030047]  systemd-1       1...1 2253604us : blk_mq_make_request: 
make rq -1
[   10.032448]  systemd-1       1...1 2254182us : blk_mq_free_request: 
complete: rq -1
[   10.034847]  systemd-1       1.... 2254194us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.037249]  systemd-1       1...1 2254248us : blk_mq_make_request: 
make rq -1
[   10.039651]  systemd-1       1...1 2254827us : blk_mq_free_request: 
complete: rq -1
[   10.042049]  systemd-1       1.... 2254838us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.044454]  systemd-1       1...1 2254892us : blk_mq_make_request: 
make rq -1
[   10.046857]  systemd-1       1...1 2255470us : blk_mq_free_request: 
complete: rq -1
[   10.049235]  systemd-1       1.... 2255481us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.051604]  systemd-1       1...1 2255535us : blk_mq_make_request: 
make rq -1
[   10.053973]  systemd-1       1...1 2256089us : blk_mq_free_request: 
complete: rq -1
[   10.056318]  systemd-1       1.... 2256100us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.058663]  systemd-1       1...1 2256153us : blk_mq_make_request: 
make rq -1
[   10.061006]  systemd-1       1...1 2256710us : blk_mq_free_request: 
complete: rq -1
[   10.063346]  systemd-1       1.... 2256721us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.065685]  systemd-1       1...1 2256775us : blk_mq_make_request: 
make rq -1
[   10.068030]  systemd-1       1...1 2257327us : blk_mq_free_request: 
complete: rq -1
[   10.070368]  systemd-1       1.... 2257338us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.072714]  systemd-1       1...1 2257393us : blk_mq_make_request: 
make rq -1
[   10.075057]  systemd-1       1...1 2257950us : blk_mq_free_request: 
complete: rq -1
[   10.077391]  systemd-1       1.... 2257962us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.079730]  systemd-1       1...1 2258038us : blk_mq_make_request: 
make rq -1
[   10.082073]  systemd-1       1...1 2258600us : blk_mq_free_request: 
complete: rq -1
[   10.084405]  systemd-1       1.... 2258612us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.086748]  systemd-1       1...1 2258669us : blk_mq_make_request: 
make rq -1
[   10.089086]  systemd-1       1...1 2259243us : blk_mq_free_request: 
complete: rq -1
[   10.091420]  systemd-1       1.... 2259255us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.093759]  systemd-1       1...1 2259309us : blk_mq_make_request: 
make rq -1
[   10.096101]  systemd-1       1...1 2260471us : blk_mq_free_request: 
complete: rq -1
[   10.098441]  systemd-1       1.... 2260480us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.100789]  systemd-1       1...1 2260524us : blk_mq_make_request: 
make rq -1
[   10.103135]  systemd-1       1...1 2261099us : blk_mq_free_request: 
complete: rq -1
[   10.105481]  systemd-1       1.... 2261108us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.107831]  systemd-1       1...1 2261149us : blk_mq_make_request: 
make rq -1
[   10.110179]  systemd-1       1...1 2261698us : blk_mq_free_request: 
complete: rq -1
[   10.112521]  systemd-1       1.... 2261706us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.114871]  systemd-1       1...1 2261747us : blk_mq_make_request: 
make rq -1
[   10.117215]  systemd-1       1...1 2262298us : blk_mq_free_request: 
complete: rq -1
[   10.119547]  systemd-1       1.... 2262307us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.121887]  systemd-1       1...1 2262348us : blk_mq_make_request: 
make rq -1
[   10.124232]  systemd-1       1...1 2262898us : blk_mq_free_request: 
complete: rq -1
[   10.126561]  systemd-1       1.... 2262907us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.128904]  systemd-1       1...1 2262948us : blk_mq_make_request: 
make rq -1
[   10.131246]  systemd-1       1...1 2263501us : blk_mq_free_request: 
complete: rq -1
[   10.133583]  systemd-1       1.... 2263510us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.135925]  systemd-1       1...1 2263551us : blk_mq_make_request: 
make rq -1
[   10.138267]  systemd-1       1...1 2264127us : blk_mq_free_request: 
complete: rq -1
[   10.140607]  systemd-1       1.... 2264135us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.142946]  systemd-1       1...1 2264176us : blk_mq_make_request: 
make rq -1
[   10.145289]  systemd-1       1...1 2264750us : blk_mq_free_request: 
complete: rq -1
[   10.147622]  systemd-1       1.... 2264758us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.149959]  systemd-1       1...1 2264799us : blk_mq_make_request: 
make rq -1
[   10.152299]  systemd-1       1...1 2265374us : blk_mq_free_request: 
complete: rq -1
[   10.154632]  systemd-1       1.... 2265383us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.156974]  systemd-1       1...1 2265423us : blk_mq_make_request: 
make rq -1
[   10.159312]  systemd-1       1...1 2266000us : blk_mq_free_request: 
complete: rq -1
[   10.161648]  systemd-1       1.... 2266009us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.163984]  systemd-1       1...1 2266028us : blk_mq_make_request: 
make rq -1
[   10.166318]  systemd-1       1...1 2266600us : blk_mq_free_request: 
complete: rq -1
[   10.168648]  systemd-1       1.... 2266609us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.170982]   <idle>-0       1dnh1 2267233us : blk_mq_free_request: 
complete: rq -1
[   10.173335]  systemd-1       1...1 2267389us : blk_mq_make_request: 
make rq -1
[   10.175693]  systemd-1       1.... 2267454us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.178061]   <idle>-0       1dnh1 2268314us : blk_mq_free_request: 
complete: rq -1
[   10.180449]  systemd-1       1...1 2268590us : blk_mq_make_request: 
make rq -1
[   10.182832]  systemd-1       1.... 2268657us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.185229]  systemd-1       1...1 2268717us : blk_mq_make_request: 
make rq -1
[   10.187618]  systemd-1       1...1 2269297us : blk_mq_free_request: 
complete: rq -1
[   10.190010]  systemd-1       1.... 2269307us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.192409]  systemd-1       1...1 2269349us : blk_mq_make_request: 
make rq -1
[   10.194803]  systemd-1       1...1 2269898us : blk_mq_free_request: 
complete: rq -1
[   10.197189]  systemd-1       1.... 2269906us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.199583]  systemd-1       1...1 2269947us : blk_mq_make_request: 
make rq -1
[   10.201976]  systemd-1       1...1 2270501us : blk_mq_free_request: 
complete: rq -1
[   10.204367]  systemd-1       1.... 2270509us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.206760]  systemd-1       1...1 2270549us : blk_mq_make_request: 
make rq -1
[   10.209146]  systemd-1       1...1 2271102us : blk_mq_free_request: 
complete: rq -1
[   10.211526]  systemd-1       1.... 2271110us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.213917]  systemd-1       1...1 2271151us : blk_mq_make_request: 
make rq -1
[   10.216306]  systemd-1       1...1 2271727us : blk_mq_free_request: 
complete: rq -1
[   10.218686]  systemd-1       1.... 2271736us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.221068]  systemd-1       1...1 2271775us : blk_mq_make_request: 
make rq -1
[   10.223441]  systemd-1       1...1 2272351us : blk_mq_free_request: 
complete: rq -1
[   10.225816]  systemd-1       1.... 2272360us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.228206]  systemd-1       1...1 2272401us : blk_mq_make_request: 
make rq -1
[   10.230589]  systemd-1       1...1 2272974us : blk_mq_free_request: 
complete: rq -1
[   10.232970]  systemd-1       1.... 2272983us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.235354]  systemd-1       1...1 2273026us : blk_mq_make_request: 
make rq -1
[   10.237739]  systemd-1       1...1 2273475us : blk_mq_free_request: 
complete: rq -1
[   10.240119]  systemd-1       1.... 2273483us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.242512]  systemd-1       1...1 2273563us : blk_mq_make_request: 
make rq -1
[   10.244894]  systemd-1       1...1 2273978us : blk_mq_free_request: 
complete: rq -1
[   10.247274]  systemd-1       1.... 2273987us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.249662]  systemd-1       1...1 2274029us : blk_mq_make_request: 
make rq -1
[   10.252042]  systemd-1       1...1 2274580us : blk_mq_free_request: 
complete: rq -1
[   10.254417]  systemd-1       1.... 2274588us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.256802]  systemd-1       1...1 2274629us : blk_mq_make_request: 
make rq -1
[   10.259187]  systemd-1       1...1 2275079us : blk_mq_free_request: 
complete: rq -1
[   10.261565]  systemd-1       1.... 2275087us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.263947]  systemd-1       1...1 2275128us : blk_mq_make_request: 
make rq -1
[   10.266332]  systemd-1       1...1 2275704us : blk_mq_free_request: 
complete: rq -1
[   10.268715]  systemd-1       1.... 2275713us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.271105]  systemd-1       1...1 2275753us : blk_mq_make_request: 
make rq -1
[   10.273486]  systemd-1       1...1 2276327us : blk_mq_free_request: 
complete: rq -1
[   10.275865]  systemd-1       1.... 2276336us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.278254]  systemd-1       1...1 2276377us : blk_mq_make_request: 
make rq -1
[   10.280640]  systemd-1       1...1 2276951us : blk_mq_free_request: 
complete: rq -1
[   10.283018]  systemd-1       1.... 2276960us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.285410]  systemd-1       1...1 2277001us : blk_mq_make_request: 
make rq -1
[   10.287789]  systemd-1       1...1 2277450us : blk_mq_free_request: 
complete: rq -1
[   10.290152]  systemd-1       1.... 2277459us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.292507]  systemd-1       1...1 2277516us : blk_mq_make_request: 
make rq -1
[   10.294865]  systemd-1       1...1 2278052us : blk_mq_free_request: 
complete: rq -1
[   10.297201]  systemd-1       1.... 2278060us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.299530]  systemd-1       1...1 2278189us : blk_mq_make_request: 
make rq -1
[   10.301857]  systemd-1       1...1 2278658us : blk_mq_free_request: 
complete: rq -1
[   10.304185]  systemd-1       1.... 2278667us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.306519]  systemd-1       1...1 2278711us : blk_mq_make_request: 
make rq -1
[   10.308846]  systemd-1       1...1 2279258us : blk_mq_free_request: 
complete: rq -1
[   10.311172]  systemd-1       1.... 2279267us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.313504]  systemd-1       1...1 2279307us : blk_mq_make_request: 
make rq -1
[   10.315834]  systemd-1       1...1 2279863us : blk_mq_free_request: 
complete: rq -1
[   10.318163]  systemd-1       1.... 2279871us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.320492]  systemd-1       1...1 2279912us : blk_mq_make_request: 
make rq -1
[   10.322822]  systemd-1       1...1 2280487us : blk_mq_free_request: 
complete: rq -1
[   10.325147]  systemd-1       1.... 2280496us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.327481]  systemd-1       1...1 2280536us : blk_mq_make_request: 
make rq -1
[   10.329814]  systemd-1       1...1 2281729us : blk_mq_free_request: 
complete: rq -1
[   10.332142]  systemd-1       1.... 2281741us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.334479]  systemd-1       1...1 2281799us : blk_mq_make_request: 
make rq -1
[   10.336815]  systemd-1       1...1 2282371us : blk_mq_free_request: 
complete: rq -1
[   10.339146]  systemd-1       1.... 2282383us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.341485]  systemd-1       1...1 2282438us : blk_mq_make_request: 
make rq -1
[   10.343821]  systemd-1       1...1 2282912us : blk_mq_free_request: 
complete: rq -1
[   10.346152]  systemd-1       1.... 2282923us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.348488]  systemd-1       1...1 2282976us : blk_mq_make_request: 
make rq -1
[   10.350820]  systemd-1       1...1 2283529us : blk_mq_free_request: 
complete: rq -1
[   10.353151]  systemd-1       1.... 2283540us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.355490]  systemd-1       1...1 2283594us : blk_mq_make_request: 
make rq -1
[   10.357826]  systemd-1       1...1 2284148us : blk_mq_free_request: 
complete: rq -1
[   10.360157]  systemd-1       1.... 2284160us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.362494]  systemd-1       1...1 2284214us : blk_mq_make_request: 
make rq -1
[   10.364829]  systemd-1       1...1 2284765us : blk_mq_free_request: 
complete: rq -1
[   10.367157]  systemd-1       1.... 2284776us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.369500]  systemd-1       1...1 2284830us : blk_mq_make_request: 
make rq -1
[   10.371838]  systemd-1       1...1 2285388us : blk_mq_free_request: 
complete: rq -1
[   10.374176]  systemd-1       1.... 2285400us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.376525]  systemd-1       1...1 2285454us : blk_mq_make_request: 
make rq -1
[   10.378866]  systemd-1       1...1 2286032us : blk_mq_free_request: 
complete: rq -1
[   10.381203]  systemd-1       1.... 2286043us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.383548]  systemd-1       1...1 2286097us : blk_mq_make_request: 
make rq -1
[   10.385892]  systemd-1       1...1 2286676us : blk_mq_free_request: 
complete: rq -1
[   10.388230]  systemd-1       1.... 2286687us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.390576]  systemd-1       1...1 2286742us : blk_mq_make_request: 
make rq -1
[   10.392921]  systemd-1       1...1 2287339us : blk_mq_free_request: 
complete: rq -1
[   10.395262]  systemd-1       1.... 2287350us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.397610]  systemd-1       1...1 2287427us : blk_mq_make_request: 
make rq -1
[   10.399953]  systemd-1       1...1 2287984us : blk_mq_free_request: 
complete: rq -1
[   10.402287]  systemd-1       1.... 2287996us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.404635]  systemd-1       1...1 2288022us : blk_mq_make_request: 
make rq -1
[   10.406981]  systemd-1       1...1 2288611us : blk_mq_free_request: 
complete: rq -1
[   10.409324]  systemd-1       1.... 2288623us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.411678]   <idle>-0       1dnh1 2289137us : blk_mq_free_request: 
complete: rq -1
[   10.414052]  systemd-1       1...1 2289338us : blk_mq_make_request: 
make rq -1
[   10.416415]  systemd-1       1.... 2289425us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.418792]   <idle>-0       1dnh1 2290327us : blk_mq_free_request: 
complete: rq -1
[   10.421193]  systemd-1       1...1 2291218us : blk_mq_make_request: 
make rq -1
[   10.423594]  systemd-1       1.... 2291311us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.426006]  systemd-1       1...1 2291368us : blk_mq_make_request: 
make rq -1
[   10.428408]  systemd-1       1...1 2292166us : blk_mq_free_request: 
complete: rq -1
[   10.430809]  systemd-1       1.... 2292178us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.433217]  systemd-1       1...1 2292237us : blk_mq_make_request: 
make rq -1
[   10.435630]  systemd-1       1...1 2292779us : blk_mq_free_request: 
complete: rq -1
[   10.438032]  systemd-1       1.... 2292791us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.440440]  systemd-1       1...1 2292846us : blk_mq_make_request: 
make rq -1
[   10.442848]  systemd-1       1...1 2293421us : blk_mq_free_request: 
complete: rq -1
[   10.445254]  systemd-1       1.... 2293432us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.447668]  systemd-1       1...1 2293486us : blk_mq_make_request: 
make rq -1
[   10.450074]  systemd-1       1...1 2294059us : blk_mq_free_request: 
complete: rq -1
[   10.452472]  systemd-1       1.... 2294070us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.454882]  systemd-1       1...1 2294125us : blk_mq_make_request: 
make rq -1
[   10.457285]  systemd-1       1...1 2294589us : blk_mq_free_request: 
complete: rq -1
[   10.459685]  systemd-1       1.... 2294601us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.462091]  systemd-1       1...1 2294655us : blk_mq_make_request: 
make rq -1
[   10.464491]  systemd-1       1...1 2295114us : blk_mq_free_request: 
complete: rq -1
[   10.466887]  systemd-1       1.... 2295125us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.469289]  systemd-1       1...1 2295179us : blk_mq_make_request: 
make rq -1
[   10.471684]  systemd-1       1...1 2295733us : blk_mq_free_request: 
complete: rq -1
[   10.474080]  systemd-1       1.... 2295744us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.476485]  systemd-1       1...1 2295798us : blk_mq_make_request: 
make rq -1
[   10.478886]  systemd-1       1...1 2296346us : blk_mq_free_request: 
complete: rq -1
[   10.481280]  systemd-1       1.... 2296357us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.483680]  systemd-1       1...1 2296411us : blk_mq_make_request: 
make rq -1
[   10.486077]  systemd-1       1...1 2296960us : blk_mq_free_request: 
complete: rq -1
[   10.488467]  systemd-1       1.... 2296972us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.490859]  systemd-1       1...1 2297025us : blk_mq_make_request: 
make rq -1
[   10.493249]  systemd-1       1...1 2297581us : blk_mq_free_request: 
complete: rq -1
[   10.495640]  systemd-1       1.... 2297592us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.498036]  systemd-1       1...1 2297670us : blk_mq_make_request: 
make rq -1
[   10.500429]  systemd-1       1...1 2298273us : blk_mq_free_request: 
complete: rq -1
[   10.502814]  systemd-1       1.... 2298286us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.505212]  systemd-1       1...1 2298342us : blk_mq_make_request: 
make rq -1
[   10.507602]  systemd-1       1...1 2298920us : blk_mq_free_request: 
complete: rq -1
[   10.509984]  systemd-1       1.... 2298931us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.512373]  systemd-1       1...1 2298986us : blk_mq_make_request: 
make rq -1
[   10.514764]  systemd-1       1...1 2299447us : blk_mq_free_request: 
complete: rq -1
[   10.517152]  systemd-1       1.... 2299458us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.519546]  systemd-1       1...1 2299512us : blk_mq_make_request: 
make rq -1
[   10.521938]  systemd-1       1...1 2300092us : blk_mq_free_request: 
complete: rq -1
[   10.524321]  systemd-1       1.... 2300103us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.526719]  systemd-1       1...1 2300157us : blk_mq_make_request: 
make rq -1
[   10.529107]  systemd-1       1...1 2300709us : blk_mq_free_request: 
complete: rq -1
[   10.531471]  systemd-1       1.... 2300721us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.533833]  systemd-1       1...1 2300774us : blk_mq_make_request: 
make rq -1
[   10.536195]  systemd-1       1...1 2301235us : blk_mq_free_request: 
complete: rq -1
[   10.538531]  systemd-1       1.... 2301246us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.540859]  systemd-1       1...1 2301301us : blk_mq_make_request: 
make rq -1
[   10.543188]  systemd-1       1...1 2302355us : blk_mq_free_request: 
complete: rq -1
[   10.545509]  systemd-1       1.... 2302365us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.547847]  systemd-1       1...1 2302410us : blk_mq_make_request: 
make rq -1
[   10.550178]  systemd-1       1...1 2302960us : blk_mq_free_request: 
complete: rq -1
[   10.552503]  systemd-1       1.... 2302969us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.554835]  systemd-1       1...1 2303011us : blk_mq_make_request: 
make rq -1
[   10.557170]  systemd-1       1...1 2303584us : blk_mq_free_request: 
complete: rq -1
[   10.559494]  systemd-1       1.... 2303592us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.561829]  systemd-1       1...1 2303633us : blk_mq_make_request: 
make rq -1
[   10.564156]  systemd-1       1...1 2304222us : blk_mq_free_request: 
complete: rq -1
[   10.566483]  systemd-1       1.... 2304230us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.568818]  systemd-1       1...1 2304271us : blk_mq_make_request: 
make rq -1
[   10.571150]  systemd-1       1...1 2304844us : blk_mq_free_request: 
complete: rq -1
[   10.573480]  systemd-1       1.... 2304853us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.575815]  systemd-1       1...1 2304893us : blk_mq_make_request: 
make rq -1
[   10.578142]  systemd-1       1...1 2305467us : blk_mq_free_request: 
complete: rq -1
[   10.580470]  systemd-1       1.... 2305476us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.582808]  systemd-1       1...1 2305516us : blk_mq_make_request: 
make rq -1
[   10.585141]  systemd-1       1...1 2306066us : blk_mq_free_request: 
complete: rq -1
[   10.587469]  systemd-1       1.... 2306074us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.589809]  systemd-1       1...1 2306115us : blk_mq_make_request: 
make rq -1
[   10.592145]  systemd-1       1...1 2306662us : blk_mq_free_request: 
complete: rq -1
[   10.594475]  systemd-1       1.... 2306670us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.596811]  systemd-1       1...1 2306710us : blk_mq_make_request: 
make rq -1
[   10.599140]  systemd-1       1...1 2307261us : blk_mq_free_request: 
complete: rq -1
[   10.601471]  systemd-1       1.... 2307269us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.603812]  systemd-1       1...1 2307327us : blk_mq_make_request: 
make rq -1
[   10.606150]  systemd-1       1...1 2307860us : blk_mq_free_request: 
complete: rq -1
[   10.608475]  systemd-1       1.... 2307868us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.610810]  systemd-1       1...1 2307909us : blk_mq_make_request: 
make rq -1
[   10.613147]  systemd-1       1...1 2308486us : blk_mq_free_request: 
complete: rq -1
[   10.615480]  systemd-1       1.... 2308495us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.617815]  systemd-1       1...1 2308537us : blk_mq_make_request: 
make rq -1
[   10.620151]  systemd-1       1...1 2309109us : blk_mq_free_request: 
complete: rq -1
[   10.622482]  systemd-1       1.... 2309118us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.624826]  systemd-1       1...1 2309158us : blk_mq_make_request: 
make rq -1
[   10.627164]  systemd-1       1...1 2309729us : blk_mq_free_request: 
complete: rq -1
[   10.629496]  systemd-1       1.... 2309737us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.631834]  systemd-1       1...1 2309763us : blk_mq_make_request: 
make rq -1
[   10.634166]  systemd-1       1...1 2310355us : blk_mq_free_request: 
complete: rq -1
[   10.636497]  systemd-1       1.... 2310364us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.638835]   <idle>-0       1dnh1 2310869us : blk_mq_free_request: 
complete: rq -1
[   10.641191]  systemd-1       1...1 2311021us : blk_mq_make_request: 
make rq -1
[   10.643543]  systemd-1       1.... 2311095us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.645908]  systemd-1       1.... 2311101us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.648328]   <idle>-0       1dnh1 2311941us : blk_mq_free_request: 
complete: rq -1
[   10.650755]  systemd-1       1...1 2327697us : blk_mq_make_request: 
make rq -1
[   10.653197]  systemd-1       1.... 2327778us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.655635]  systemd-1       1.... 2327782us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.658126]   <idle>-0       1dnh1 2328642us : blk_mq_free_request: 
complete: rq -1
[   10.660646]  systemd-1       1...1 2328905us : blk_mq_make_request: 
make rq -1
[   10.663153]  systemd-1       1.... 2329155us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.665665]  systemd-1       1.... 2329159us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.668249]   <idle>-0       1dnh1 2333417us : blk_mq_free_request: 
complete: rq -1
[   10.670842]  systemd-1       1...1 2333940us : blk_mq_make_request: 
make rq -1
[   10.673425]  systemd-1       1.... 2333995us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.676017]  systemd-1       1.... 2333999us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.678672]   <idle>-0       1dnh1 2334843us : blk_mq_free_request: 
complete: rq -1
[   10.681333]  systemd-1       1...1 2335180us : blk_mq_make_request: 
make rq -1
[   10.684006]  systemd-1       1.... 2335233us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.686676]  systemd-1       1.... 2335239us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.689405]   <idle>-0       1dnh1 2335886us : blk_mq_free_request: 
complete: rq -1
[   10.692147]  systemd-1       1...1 2337355us : blk_mq_make_request: 
make rq -1
[   10.694891]  systemd-1       1.... 2337414us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.697639]   <idle>-0       1dnh1 2337984us : blk_mq_free_request: 
complete: rq -1
[   10.700416]  systemd-1       1...1 2338218us : blk_mq_make_request: 
make rq -1
[   10.703183]  systemd-1       1.... 2338274us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.705956]  systemd-1       1.... 2338278us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.708801]   <idle>-0       1dnh1 2338935us : blk_mq_free_request: 
complete: rq -1
[   10.711650] (sd-exec-104     0...1 2347389us : blk_mq_make_request: 
make rq -1
[   10.714508] (sd-exec-104     0.... 2347488us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.717374] kworker/-98      0...1 2348308us : blk_mq_free_request: 
complete: rq -1
[   10.720261] (direxec-105     1...1 2350981us : blk_mq_make_request: 
make rq -1
[   10.723150] (direxec-105     1.... 2351089us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.726049] (direxec-105     1.... 2351093us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.729000] systemd--106     1dnh. 2352478us : blk_mq_free_request: 
complete: rq -1
[   10.731965] systemd--106     1...1 2357250us : blk_mq_make_request: 
make rq -1
[   10.734934] systemd--106     1.... 2357431us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.737899] systemd--106     1.... 2357438us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.740919] systemd--108     1dnh2 2358654us : blk_mq_free_request: 
complete: rq -1
[   10.743951] systemd--106     1...1 2360097us : blk_mq_make_request: 
make rq -1
[   10.746973] systemd--106     1.... 2360187us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.749991] systemd--106     1.... 2360191us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.753082] systemd--109     1dnh. 2361118us : blk_mq_free_request: 
complete: rq -1
[   10.756170] systemd--107     0...1 2362157us : blk_mq_make_request: 
make rq -1
[   10.759249] systemd--107     0.... 2362282us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.762333] systemd--107     0.... 2362287us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.765478] kworker/-98      0...1 2363316us : blk_mq_free_request: 
complete: rq -1
[   10.768628] systemd--110     1...1 2369150us : blk_mq_make_request: 
make rq -1
[   10.771791] systemd--110     1.... 2369287us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.774945] systemd--110     1.... 2369292us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.778139] systemd--109     1...1 2369516us : blk_mq_make_request: 
make rq -1
[   10.781330] systemd--108     1...1 2369711us : blk_mq_make_request: 
make rq -1
[   10.784488] systemd--115     1...1 2370728us : blk_mq_make_request: 
make rq -1
[   10.787592] systemd--115     1.n.1 2370900us : blk_mq_free_request: 
complete: rq -1
[   10.790663] systemd--110     1d.h. 2371841us : blk_mq_free_request: 
complete: rq -1
[   10.793698] systemd--110     1...1 2372401us : blk_mq_make_request: 
make rq -1
[   10.796721] systemd--110     1.... 2372473us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.799718] systemd--110     1.... 2372477us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.802724] systemd--112     0...1 2372690us : blk_mq_make_request: 
make rq -1
[   10.805729] systemd--108     1...1 2373229us : blk_mq_free_request: 
complete: rq -1
[   10.808733] systemd--108     1.... 2373238us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.811716] systemd--108     1.... 2373242us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.814716] systemd--113     0...1 2373731us : blk_mq_make_request: 
make rq -1
[   10.817707] systemd--109     1...1 2374326us : blk_mq_free_request: 
complete: rq -1
[   10.820697] systemd--109     1.... 2374334us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.823656] systemd--109     1.... 2374338us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.826641] systemd--108     1d.h1 2375194us : blk_mq_free_request: 
complete: rq -1
[   10.829622] systemd--112     0.... 2375203us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.832610] systemd--112     0.... 2375208us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.835625] systemd--108     1...1 2375562us : blk_mq_make_request: 
make rq -1
[   10.838600] systemd--113     0...1 2375964us : blk_mq_free_request: 
complete: rq -1
[   10.841576] systemd--113     0.... 2375971us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.844551] systemd--113     0.... 2375974us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.847565] kworker/-98      0...1 2376940us : blk_mq_free_request: 
complete: rq -1
[   10.850579] systemd--108     1.... 2378356us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.853611] systemd--108     1.... 2378365us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.856676] systemd--115     1.... 2378390us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.859699] systemd--115     1.... 2378394us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.862766] systemd--115     1d.h. 2379396us : blk_mq_free_request: 
complete: rq -1
[   10.865835] systemd--114     1...1 2398665us : blk_mq_make_request: 
make rq -1
[   10.868876] systemd--114     1.... 2398792us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.871905] systemd--114     1.... 2398796us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.875002] systemd--110     1d.h. 2400019us : blk_mq_free_request: 
complete: rq -1
[   10.878067] systemd--107     0...1 2406186us : blk_mq_make_request: 
make rq -1
[   10.881090] systemd--107     0.... 2406635us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.884119] systemd--107     0.... 2406640us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.887209] systemd--112     0.n.1 2411122us : blk_mq_make_request: 
make rq -1
[   10.890274] kworker/-98      0...1 2411506us : blk_mq_free_request: 
complete: rq -1
[   10.893313] systemd--107     0...1 2412025us : blk_mq_make_request: 
make rq -1
[   10.896354] systemd--107     0.... 2412323us : mmc_mq_queue_rq: queue 
rq -1, 0
[   10.899388] systemd--107     0.... 2412327us : 
blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
[   10.902463] (direxec-111     1...1 2413829us : blk_mq_make_request: 
make rq -1
[   10.905513] systemd--114     1...1 2415159us : blk_mq_make_request: 
make rq -1
[   10.908528] ---------------------------------
[   10.911540] mmc3: sdhci: ============ SDHCI REGISTER DUMP ===========
[   10.914582] mmc3: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
[   10.917595] mmc3: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[   10.920586] mmc3: sdhci: Argument:  0x0213dd28 | Trn mode: 0x00000033
[   10.923574] mmc3: sdhci: Present:   0x1ff70000 | Host ctl: 0x00000031
[   10.926530] mmc3: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   10.929451] mmc3: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[   10.932387] mmc3: sdhci: Timeout:   0x0000000e | Int stat: 0x00000002
[   10.935337] mmc3: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02fc008b
[   10.938292] mmc3: sdhci: AC12 err:  0x00000001 | Slot int: 0x00000000
[   10.941261] mmc3: sdhci: Caps:      0x61ff30b0 | Caps_1:   0x00000000
[   10.944233] mmc3: sdhci: Cmd:       0x0000123a | Max curr: 0x00000001
[   10.947196] mmc3: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x04800e92
[   10.950132] mmc3: sdhci: Resp[2]:   0x074b8000 | Resp[3]:  0x00000240
[   10.953015] mmc3: sdhci: Host ctl2: 0x00000000
[   10.955881] mmc3: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x2d8e3200
[   10.958771] mmc3: sdhci: ============================================

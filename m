Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34220 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933447AbeBVRyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 12:54:13 -0500
Subject: Re: [PATCH V15 06/22] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <1511962879-24262-7-git-send-email-adrian.hunter@intel.com>
 <bc65b542-9703-aa04-f1c7-b10584e44391@gmail.com>
 <829308a3-3bf6-c173-65fa-e2a0f45f7f61@intel.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68886f99-97f5-897a-f754-6f414741bd5a@gmail.com>
Date: Thu, 22 Feb 2018 20:54:08 +0300
MIME-Version: 1.0
In-Reply-To: <829308a3-3bf6-c173-65fa-e2a0f45f7f61@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 22.02.2018 10:42, Adrian Hunter wrote:
> On 21/02/18 22:50, Dmitry Osipenko wrote:
>> On 29.11.2017 16:41, Adrian Hunter wrote:
>>> Define and use a blk-mq queue. Discards and flushes are processed
>>> synchronously, but reads and writes asynchronously. In order to support
>>> slow DMA unmapping, DMA unmapping is not done until after the next request
>>> is started. That means the request is not completed until then. If there is
>>> no next request then the completion is done by queued work.
>>
>> Hello,
>>
>> I'm using (running linux-next and doing some upstream development for) some old
>> NVIDIA Tegra tablet that has built-in (internal) and external MMC's and with the
>> blk-mq being enabled I'm observing a soft lockup. The lockup seems is
>> reproducible quite reliably by running fsck on any MMC partition, sometimes
>> kernels lockups on boot during probing partitions table (weirdly only when both
>> SDHCI's are present, i.e. internal storage enabled in DT and external SD is
>> inserted/enabled) and it also lockups pretty quickly in a case of just a general
>> use. Reverting mmc/ commits up to 1bec43a3b18 ("Remove option not to use
>> blk-mq") and disabling CONFIG_MMC_MQ_DEFAULT makes everything working fine
>> again. There is also a third SDHCI populated with built-in WiFi/Bluetooth SDIO
>> and I'm observing odd MMC timeouts with the blk-mq enabled, disabling
>> CONFIG_MMC_MQ_DEFAULT fixes these timeouts as well.
>>
>> Any thoughts?
> 
> SDIO (unless it is a combo card) should be unaffected by changes to the
> block driver.
> 
> I don't have any ideas.  Adding more NVIDIA people.
> 
>>
>> WiFi issue
>> ========================
>>
>> [   38.247006] mmc2: Timeout waiting for hardware interrupt.
>> [   38.247027] brcmfmac: brcmf_escan_timeout: timer expired
>> [   38.247036] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   38.247047] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
>> [   38.247055] mmc2: sdhci: Blk size:  0x00007008 | Blk cnt:  0x00000000
>> [   38.247062] mmc2: sdhci: Argument:  0x21000008 | Trn mode: 0x00000013
>> [   38.247070] mmc2: sdhci: Present:   0x01d70000 | Host ctl: 0x00000013
>> [   38.247077] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
>> [   38.247084] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>> [   38.247091] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>> [   38.247098] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02fc000b
>> [   38.247105] mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
>> [   38.247112] mmc2: sdhci: Caps:      0x61ff30b0 | Caps_1:   0x00000000
>> [   38.247119] mmc2: sdhci: Cmd:       0x0000353a | Max curr: 0x00000001
>> [   38.247126] mmc2: sdhci: Resp[0]:   0x00001800 | Resp[1]:  0x08002db5
>> [   38.247133] mmc2: sdhci: Resp[2]:   0x16da8000 | Resp[3]:  0x00000400
>> [   38.247139] mmc2: sdhci: Host ctl2: 0x00000000
>> [   38.247146] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x17c47200
>> [   38.247152] mmc2: sdhci: ============================================
>> [   38.247250] brcmfmac: brcmf_sdio_readframes: read 520 bytes from channel 1
>> failed: -84
>> [   38.247274] brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>> [   40.807019] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>> [   40.807042] brcmfmac: brcmf_notify_escan_complete: Scan abort failed
>> [   48.487007] mmc2: Timeout waiting for hardware interrupt.
>> [   48.487057] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   48.487096] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
>> [   48.487128] mmc2: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000001
>> [   48.487160] mmc2: sdhci: Argument:  0x21000040 | Trn mode: 0x00000013
>> [   48.487191] mmc2: sdhci: Present:   0x01d70000 | Host ctl: 0x00000013
>> [   48.487221] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
>> [   48.487251] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>> [   48.487281] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>> [   48.487313] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02fc000b
>> [   48.487343] mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
>> [   48.487374] mmc2: sdhci: Caps:      0x61ff30b0 | Caps_1:   0x00000000
>> [   48.487404] mmc2: sdhci: Cmd:       0x0000353a | Max curr: 0x00000001
>> [   48.487435] mmc2: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x08002db5
>> [   48.487466] mmc2: sdhci: Resp[2]:   0x16da8000 | Resp[3]:  0x00000400
>> [   48.487493] mmc2: sdhci: Host ctl2: 0x00000000
>> [   48.487525] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x17c47200
>> [   48.487552] mmc2: sdhci: ============================================
>> [   48.487749] brcmfmac: brcmf_sdio_readframes: read 480 bytes from channel 1
>> failed: -84
>> [   48.487822] brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>
>>
>> Soft lockup issue
>> ========================
>>
>> # fsck -f /dev/disk/by-uuid/6768309f-3545-49d5-9ac7-d5be24d35ef2
>> fsck из util-linux 2.30.2
>> e2fsck 1.43.9 (8-Feb-2018)
>> Проход 1: Проверка inodes, блокs, а также размеров
>> Pass 2: Checking каталог structure
>> Pass 3: Checking каталог connectivity
>> Pass 4: Checking reference counts
>> Pass 5: Checking группа summary information
>> ....
>>
>> [  125.925436] INFO: task kworker/0:3H:263 blocked for more than 60 seconds.
>> [  125.925496]       Not tainted
>> 4.16.0-rc2-next-20180220-00101-gaefde91c3955-dirty #2041
>> [  125.925530] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>> [  125.925562] kworker/0:3H    D    0   263      2 0x00000000
>> [  125.925653] Workqueue: kblockd mmc_blk_mq_complete_work
>> [  125.925747] [<c0b991cc>] (__schedule) from [<c0b998f0>] (schedule+0x60/0xcc)
>> [  125.925805] [<c0b998f0>] (schedule) from [<c086c870>]
>> (__mmc_claim_host+0xdc/0x24c)
>> [  125.925849] [<c086c870>] (__mmc_claim_host) from [<c08750bc>]
> 
> That claim host should not be there.  Here is a fix for that:
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 908e4db03535..62049f95116b 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -932,9 +932,7 @@ static int mmc_read_bkops_status(struct mmc_card *card)
>  	int err;
>  	u8 *ext_csd;
> 
> -	mmc_claim_host(card->host);
>  	err = mmc_get_ext_csd(card, &ext_csd);
> -	mmc_release_host(card->host);
>  	if (err)
>  		return err;

Looks like this patch fixes all the problems. I'll keep testing it for a couple
of days and then report back the final result. Thank you very much.

>> (mmc_start_bkops+0x4c/0x190)
>> [  125.925895] [<c08750bc>] (mmc_start_bkops) from [<c087d254>]
>> (mmc_blk_urgent_bkops+0x48/0x5c)
>> [  125.925945] [<c087d254>] (mmc_blk_urgent_bkops) from [<c087f2e0>]
>> (mmc_blk_mq_complete_prev_req.part.5+0x74/0x210)
>> [  125.925995] [<c087f2e0>] (mmc_blk_mq_complete_prev_req.part.5) from
>> [<c08813d0>] (mmc_blk_mq_complete_work+0x30/0x34)
>> [  125.926049] [<c08813d0>] (mmc_blk_mq_complete_work) from [<c014306c>]
>> (process_one_work+0x1f8/0x584)
>> [  125.926093] [<c014306c>] (process_one_work) from [<c014402c>]
>> (worker_thread+0x68/0x5d4)
>> [  125.926144] [<c014402c>] (worker_thread) from [<c014965c>] (kthread+0x178/0x184)
>> [  125.926188] [<c014965c>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> [  125.926209] Exception stack(0xd579ffb0 to 0xd579fff8)
>> [  125.926239] ffa0:                                     00000000 00000000
>> 00000000 00000000
>> [  125.926272] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>> [  125.926301] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [  125.926361] INFO: task fsck.ext4:471 blocked for more than 60 seconds.
>> [  125.926399]       Not tainted
>> 4.16.0-rc2-next-20180220-00101-gaefde91c3955-dirty #2041
>> [  125.926427] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>> [  125.926455] fsck.ext4       D    0   471    470 0x00000000
>> [  125.926536] [<c0b991cc>] (__schedule) from [<c0b998f0>] (schedule+0x60/0xcc)
>> [  125.926593] [<c0b998f0>] (schedule) from [<c015823c>] (io_schedule+0x20/0x40)
>> [  125.926654] [<c015823c>] (io_schedule) from [<c0220acc>]
>> (wait_on_page_bit+0x120/0x144)
>> [  125.926705] [<c0220acc>] (wait_on_page_bit) from [<c0220bc4>]
>> (__filemap_fdatawait_range+0xd4/0x114)
>> [  125.926757] [<c0220bc4>] (__filemap_fdatawait_range) from [<c0223784>]
>> (file_write_and_wait_range+0x98/0xb4)
>> [  125.926810] [<c0223784>] (file_write_and_wait_range) from [<c02c0300>]
>> (blkdev_fsync+0x2c/0x5c)
>> [  125.926867] [<c02c0300>] (blkdev_fsync) from [<c02b7ce8>]
>> (vfs_fsync_range+0x4c/0xb0)
>> [  125.926912] [<c02b7ce8>] (vfs_fsync_range) from [<c02b7dd4>] (do_fsync+0x4c/0x74)
>> [  125.926954] [<c02b7dd4>] (do_fsync) from [<c02b80a0>] (SyS_fsync+0x1c/0x20)
>> [  125.926996] [<c02b80a0>] (SyS_fsync) from [<c0101000>]
>> (ret_fast_syscall+0x0/0x54)
>> [  125.927016] Exception stack(0xd5631fa8 to 0xd5631ff0)
>> [  125.927050] 1fa0:                   00480fc8 00481108 00000004 00481108
>> 00000000 00000000
>> [  125.927086] 1fc0: 00480fc8 00481108 00000000 00000076 00000000 7f2bb750
>> 00483268 bec602e8
>> [  125.927113] 1fe0: 00000076 bec60288 b6de5e8b b6d67cf6
>> [  177.015618] random: crng init done
>> [  187.365434] INFO: task kworker/0:3H:263 blocked for more than 60 seconds.
>> [  187.365491]       Not tainted
>> 4.16.0-rc2-next-20180220-00101-gaefde91c3955-dirty #2041
>> [  187.365524] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>> [  187.365556] kworker/0:3H    D    0   263      2 0x00000000
>> [  187.365647] Workqueue: kblockd mmc_blk_mq_complete_work
>> [  187.365741] [<c0b991cc>] (__schedule) from [<c0b998f0>] (schedule+0x60/0xcc)
>> [  187.365798] [<c0b998f0>] (schedule) from [<c086c870>]
>> (__mmc_claim_host+0xdc/0x24c)
>> [  187.365842] [<c086c870>] (__mmc_claim_host) from [<c08750bc>]
>> (mmc_start_bkops+0x4c/0x190)
>> [  187.365887] [<c08750bc>] (mmc_start_bkops) from [<c087d254>]
>> (mmc_blk_urgent_bkops+0x48/0x5c)
>> [  187.365936] [<c087d254>] (mmc_blk_urgent_bkops) from [<c087f2e0>]
>> (mmc_blk_mq_complete_prev_req.part.5+0x74/0x210)
>> [  187.365986] [<c087f2e0>] (mmc_blk_mq_complete_prev_req.part.5) from
>> [<c08813d0>] (mmc_blk_mq_complete_work+0x30/0x34)
>> [  187.366039] [<c08813d0>] (mmc_blk_mq_complete_work) from [<c014306c>]
>> (process_one_work+0x1f8/0x584)
>> [  187.366083] [<c014306c>] (process_one_work) from [<c014402c>]
>> (worker_thread+0x68/0x5d4)
>> [  187.366134] [<c014402c>] (worker_thread) from [<c014965c>] (kthread+0x178/0x184)
>> [  187.366178] [<c014965c>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> [  187.366200] Exception stack(0xd579ffb0 to 0xd579fff8)
>> [  187.366229] ffa0:                                     00000000 00000000
>> 00000000 00000000
>> [  187.366262] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>> [  187.366291] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [  187.366350] INFO: task fsck.ext4:471 blocked for more than 60 seconds.
>> [  187.366388]       Not tainted
>> 4.16.0-rc2-next-20180220-00101-gaefde91c3955-dirty #2041
>> [  187.366416] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>> [  187.366445] fsck.ext4       D    0   471    470 0x00000000
>> [  187.366526] [<c0b991cc>] (__schedule) from [<c0b998f0>] (schedule+0x60/0xcc)
>> [  187.366582] [<c0b998f0>] (schedule) from [<c015823c>] (io_schedule+0x20/0x40)
>> [  187.366644] [<c015823c>] (io_schedule) from [<c0220acc>]
>> (wait_on_page_bit+0x120/0x144)
>> [  187.366693] [<c0220acc>] (wait_on_page_bit) from [<c0220bc4>]
>> (__filemap_fdatawait_range+0xd4/0x114)
>> [  187.366745] [<c0220bc4>] (__filemap_fdatawait_range) from [<c0223784>]
>> (file_write_and_wait_range+0x98/0xb4)
>> [  187.366799] [<c0223784>] (file_write_and_wait_range) from [<c02c0300>]
>> (blkdev_fsync+0x2c/0x5c)
>> [  187.366857] [<c02c0300>] (blkdev_fsync) from [<c02b7ce8>]
>> (vfs_fsync_range+0x4c/0xb0)
>> [  187.366902] [<c02b7ce8>] (vfs_fsync_range) from [<c02b7dd4>] (do_fsync+0x4c/0x74)
>> [  187.366944] [<c02b7dd4>] (do_fsync) from [<c02b80a0>] (SyS_fsync+0x1c/0x20)
>> [  187.366987] [<c02b80a0>] (SyS_fsync) from [<c0101000>]
>> (ret_fast_syscall+0x0/0x54)
>> [  187.367008] Exception stack(0xd5631fa8 to 0xd5631ff0)
>> [  187.367041] 1fa0:                   00480fc8 00481108 00000004 00481108
>> 00000000 00000000
>> [  187.367078] 1fc0: 00480fc8 00481108 00000000 00000076 00000000 7f2bb750
>> 00483268 bec602e8
>> [  187.367103] 1fe0: 00000076 bec60288 b6de5e8b b6d67cf6
>>
> 

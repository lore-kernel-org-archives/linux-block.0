Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BFC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE7421736
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfAVLBC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:01:02 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:27217 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfAVLBC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 06:01:02 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5F7D913F8AF;
        Tue, 22 Jan 2019 11:59:33 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
Date:   Tue, 22 Jan 2019 11:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/01/2019 04:12, Jianchao Wang wrote:

> On 1/21/19 11:22 PM, Marc Gonzalez wrote:
> 
>> Well, now we know for sure that the clk_scaling_lock is a red herring.
>> I applied the patch below, and still the system locked up:
>>
>> # dd if=/dev/sde of=/dev/null bs=1M status=progress
>> 3892314112 bytes (3.9 GB, 3.6 GiB) copied, 50.0042 s, 77.8 MB/s
>>
>> I can't seem to get the RCU stall warning anymore. How can I get
>> to the bottom of this issue?
> 
> Can you detail the system 'locked up' ?
> dd hangs there ? any hung task warning log ?
> hang forever or just hang for a relatively long time.

The system is an arm64 dev board (APQ8098 MEDIABOX) with 4GB RAM and 64 GB UFS.
USB, SDHC, PCIe, SATA, Ethernet are not functional yet (so much work ahead).
All I have is a single serial console.
When the shell hangs, I lose access to the system altogether.
SysRq is not implemented either. I am blind once the shell locks up.
The system has been frozen for 15 hours, I think that qualifies as 'forever' ;-)

> And what is the status of the dd when it hangs ?
> Can you take some samples of the /proc/<dd's pid>/status and /proc/<dd's pid>/stack during the hang ?

Sadly, I cannot access this information once the shell locks up.

However, the kernel did print many warnings overnight (see below).

> And also would you please share the dmesg log and config ?

See below.

> Since always fails with buffered read with fixed bytes,
> what is the capacity of your system memory ? 

4GB RAM. And the system hangs after reading 3.8GB
I think this is not a coincidence.
NB: swap is disabled (this might be relevant)

On a freshly booted system, I get

# free
random: get_random_u64 called from copy_process.isra.9.part.10+0x2c8/0x1700 with crng_init=1
random: get_random_u64 called from arch_pick_mmap_layout+0xdc/0x100 with crng_init=1
random: get_random_u64 called from load_elf_binary+0x2b8/0x12b4 with crng_init=1
             total       used       free     shared    buffers     cached
Mem:       3948996      48916    3900080      17124          0      17124
-/+ buffers/cache:      31792    3917204
Swap:            0          0          0

# cat /proc/meminfo 
random: get_random_u64 called from copy_process.isra.9.part.10+0x2c8/0x1700 with crng_init=1
random: get_random_u64 called from arch_pick_mmap_layout+0xdc/0x100 with crng_init=1
random: get_random_u64 called from load_elf_binary+0x2b8/0x12b4 with crng_init=1
MemTotal:        3948996 kB
MemFree:         3899824 kB
MemAvailable:    3880472 kB
Buffers:               0 kB
Cached:            17124 kB
SwapCached:            0 kB
Active:             5700 kB
Inactive:          11748 kB
Active(anon):       5700 kB
Inactive(anon):    11748 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           432 kB
Mapped:             2244 kB
Shmem:             17124 kB
KReclaimable:       8444 kB
Slab:              18120 kB
SReclaimable:       8444 kB
SUnreclaim:         9676 kB
KernelStack:        1372 kB
PageTables:           44 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1974496 kB
Committed_AS:      19072 kB
VmallocTotal:   262930368 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
Percpu:              832 kB


BOOT LOG:

Booting Linux on physical CPU 0x0000000000 [0x51af8014]
Linux version 5.0.0-rc1 (mgonzalez@venus) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #54 SMP PREEMPT Mon Jan 21 19:06:50 CET 2019
Machine model: Qualcomm Technologies, Inc. MSM8998 v1 MTP
psci: probing for conduit method from DT.
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: MIGRATE_INFO_TYPE not supported.
psci: SMC Calling Convention v1.0
random: get_random_bytes called from start_kernel+0xb4/0x45c with crng_init=0
percpu: Embedded 23 pages/cpu @(____ptrval____) s53272 r8192 d32744 u94208
Detected VIPT I-cache on CPU0
CPU features: detected: Kernel page table isolation (KPTI)
Built 1 zonelists, mobility grouping on.  Total pages: 1012273
Kernel command line: loglevel=7 androidboot.bootdevice=1da4000.ufshc androidboot.serialno=53733c35 androidboot.baseband=apq mdss_mdp.panel=1:hdmi:16
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)
Memory: 3943364K/4114176K available (3646K kernel code, 478K rwdata, 1296K rodata, 5632K init, 12850K bss, 170812K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
ftrace: allocating 12677 entries in 50 pages
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu:    RCU lockdep checking is enabled.
rcu:    RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
        Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
GICv3: Distributor has no Range Selector support
GICv3: no VLPI support, no direct LPI support
GICv3: CPU0: found redistributor 0 region 0:0x0000000017b00000
ITS: No ITS available, not enabling LPIs
arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
Console: colour dummy device 80x25
printk: console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 7263 kB
 per task-struct memory footprint: 1920 bytes
Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=76800)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
random: get_random_u64 called from copy_process.isra.9.part.10+0x2c8/0x1700 with crng_init=0
ASID allocator initialised with 32768 entries
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 1 region 0:0x0000000017b20000
CPU1: Booted secondary processor 0x0000000001 [0x51af8014]
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 2 region 0:0x0000000017b40000
CPU2: Booted secondary processor 0x0000000002 [0x51af8014]
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 3 region 0:0x0000000017b60000
CPU3: Booted secondary processor 0x0000000003 [0x51af8014]
Detected VIPT I-cache on CPU4
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
CPU features: Unsupported CPU feature variation detected.
GICv3: CPU4: found redistributor 100 region 0:0x0000000017b80000
CPU4: Booted secondary processor 0x0000000100 [0x51af8001]
Detected VIPT I-cache on CPU5
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU5: 0x00000000101122
GICv3: CPU5: found redistributor 101 region 0:0x0000000017ba0000
CPU5: Booted secondary processor 0x0000000101 [0x51af8001]
Detected VIPT I-cache on CPU6
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU6: 0x00000000101122
GICv3: CPU6: found redistributor 102 region 0:0x0000000017bc0000
CPU6: Booted secondary processor 0x0000000102 [0x51af8001]
Detected VIPT I-cache on CPU7
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU7: 0x00000000101122
GICv3: CPU7: found redistributor 103 region 0:0x0000000017be0000
CPU7: Booted secondary processor 0x0000000103 [0x51af8001]
smp: Brought up 1 node, 8 CPUs
SMP: Total of 8 processors activated.
CPU features: detected: GIC system register CPU interface
CPU features: detected: 32-bit EL0 Support
CPU features: detected: CRC32 instructions
CPU: All CPU(s) started at EL1
alternatives: patching kernel code
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
futex hash table entries: 2048 (order: 6, 262144 bytes)
pinctrl core: initialized pinctrl subsystem
vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
DMA: preallocated 256 KiB pool for atomic allocations
SCSI subsystem initialized
clocksource: Switched to clocksource arch_sys_counter
s1: supplied by vph_pwr
s2: supplied by vph_pwr
s3: supplied by vph_pwr
s3: Bringing 0uV into 1352000-1352000uV
s4: supplied by vph_pwr
s4: Bringing 0uV into 1800000-1800000uV
s5: supplied by vph_pwr
s5: Bringing 0uV into 1904000-1904000uV
s6: supplied by vph_pwr
s7: supplied by vph_pwr
s7: Bringing 0uV into 900000-900000uV
s8: supplied by vph_pwr
s9: supplied by vph_pwr
s10: supplied by vph_pwr
s11: supplied by vph_pwr
s12: supplied by vph_pwr
s13: supplied by vph_pwr
l1: supplied by s7
l1: Bringing 0uV into 880000-880000uV
l2: supplied by s3
l2: Bringing 0uV into 1200000-1200000uV
l3: supplied by s7
l3: Bringing 0uV into 1000000-1000000uV
l4: supplied by s7
l5: supplied by s7
l5: Bringing 0uV into 800000-800000uV
l6: supplied by s5
l6: Bringing 0uV into 1808000-1808000uV
l7: supplied by s5
l7: Bringing 0uV into 1800000-1800000uV
l8: supplied by s3
l8: Bringing 0uV into 1200000-1200000uV
l9: Bringing 0uV into 1808000-1808000uV
l10: Bringing 0uV into 1808000-1808000uV
l11: supplied by s7
l11: Bringing 0uV into 1000000-1000000uV
l12: supplied by s5
l12: Bringing 0uV into 1800000-1800000uV
l13: Bringing 0uV into 1808000-1808000uV
l14: supplied by s5
l14: Bringing 0uV into 1880000-1880000uV
l15: supplied by s5
l15: Bringing 0uV into 1800000-1800000uV
l16: Bringing 0uV into 2704000-2704000uV
l17: supplied by s3
l17: Bringing 0uV into 1304000-1304000uV
l18: Bringing 0uV into 2704000-2704000uV
l19: Bringing 0uV into 3008000-3008000uV
l20: Bringing 0uV into 2960000-2960000uV
l21: Bringing 0uV into 2960000-2960000uV
l22: Bringing 0uV into 2864000-2864000uV
l23: Bringing 0uV into 3312000-3312000uV
l24: Bringing 0uV into 3088000-3088000uV
l25: Bringing 0uV into 3104000-3104000uV
l26: supplied by s3
l26: Bringing 0uV into 1200000-1200000uV
l27: supplied by s7
l28: Bringing 0uV into 3008000-3008000uV
lvs1: supplied by s4
lvs2: supplied by s4
bob: supplied by vph_pwr
bob: Bringing 0uV into 3312000-3312000uV
workingset: timestamp_bits=62 max_order=20 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
msm_serial c1b0000.serial: msm_serial: detected port #0
msm_serial c1b0000.serial: uartclk = 1843200
c1b0000.serial: ttyMSM0 at MMIO 0xc1b0000 (irq = 15, base_baud = 115200) is a MSM
msm_serial: console setup on port #0
printk: console [ttyMSM0] enabled
msm_serial: driver initialized
ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
l20: supplied by bob
ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5
ENTER ufshcd_runtime_suspend
scsi host0: ufshcd
random: get_random_bytes called from init_oops_id+0x40/0x50 with crng_init=0
random: get_random_bytes called from prandom_seed_full_state+0x60/0x110 with crng_init=0
ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
l9: supplied by bob
l10: supplied by bob
l13: supplied by bob
l16: supplied by bob
l18: supplied by bob
l19: supplied by bob
l21: supplied by bob
l22: supplied by bob
l23: supplied by bob
l24: supplied by bob
l25: supplied by bob
l28: supplied by bob
ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
scsi 0:0:0:49488: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c150hN
scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
scsi 0:0:0:49476: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c144hN
scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
scsi 0:0:0:49456: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c130hN
scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
sd 0:0:0:0: Power-on or device reset occurred
scsi 0:0:0:1: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
sd 0:0:0:0: [sda] 14145536 4096-byte logical blocks: (57.9 GB/54.0 GiB)
sd 0:0:0:1: Power-on or device reset occurred
scsi 0:0:0:2: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
sd 0:0:0:2: Power-on or device reset occurred
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
scsi 0:0:0:3: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
sd 0:0:0:3: Power-on or device reset occurred
sd 0:0:0:3: [sdd] 32768 4096-byte logical blocks: (134 MB/128 MiB)
sd 0:0:0:1: [sdb] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
sd 0:0:0:1: [sdb] Write Protect is off
sd 0:0:0:1: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
sd 0:0:0:2: [sdc] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
sd 0:0:0:2: [sdc] Write Protect is off
sd 0:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
random: fast init done
 sdb: sdb1
sd 0:0:0:3: [sdd] Write Protect is off
scsi 0:0:0:4: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
 sdc: sdc1
sd 0:0:0:4: Power-on or device reset occurred
sd 0:0:0:1: [sdb] Attached SCSI disk
sd 0:0:0:4: [sde] 1048576 4096-byte logical blocks: (4.29 GB/4.00 GiB)
sd 0:0:0:4: [sde] Write Protect is off
sd 0:0:0:4: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 0:0:0:3: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 0:0:0:2: [sdc] Attached SCSI disk
 sde: sde1 sde2 sde3 sde4 sde5 sde6 sde7 sde8 sde9 sde10 sde11 sde12 sde13 sde14 sde15 sde16 sde17 sde18 sde19 sde20 sde21 sde22 sde23 sde24 sde25 sde26 sde27 sde28 sde29 sde30 sde31 sde32 sde33 sde34 sde35 sde36 sde37 sde38
scsi 0:0:0:5: Direct-Access     SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
 sdd: sdd1 sdd2
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:3: [sdd] Attached SCSI disk
sd 0:0:0:5: Power-on or device reset occurred
sd 0:0:0:4: [sde] Attached SCSI disk
sd 0:0:0:5: [sdf] 393216 4096-byte logical blocks: (1.61 GB/1.50 GiB)
sd 0:0:0:5: [sdf] Write Protect is off
sd 0:0:0:5: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdf: sdf1 sdf2 sdf3
sd 0:0:0:5: [sdf] Attached SCSI disk
Freeing unused kernel memory: 5632K
Checked W+X mappings: passed, no W+X pages found


DEFCONFIG

# CONFIG_SWAP is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_BLK_DEV_INITRD=y
CONFIG_ARCH_QCOM=y
# CONFIG_EFI is not set
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_BLK_DEV is not set
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_QCOM=y
CONFIG_SCSI_UFS_BSG=y
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO_SERPORT is not set
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_LEGACY_PTY_COUNT=16
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_MSM=y
CONFIG_SERIAL_MSM_CONSOLE=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_HW_RANDOM is not set
CONFIG_PINCTRL_MSM8998=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_HWMON is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_QCOM_SMD_RPM=y
# CONFIG_HID is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_COMMON_CLK_XGENE is not set
CONFIG_COMMON_CLK_QCOM=y
# CONFIG_QCOM_A53PLL is not set
# CONFIG_QCOM_CLK_APCS_MSM8916 is not set
CONFIG_QCOM_CLK_SMD_RPM=y
CONFIG_MSM_GCC_8998=y
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_QCOM=y
CONFIG_MAILBOX=y
CONFIG_QCOM_APCS_IPC=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_QCOM_GLINK_SMEM=y
CONFIG_RPMSG_QCOM_SMD=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_QCOM_COMMAND_DB=y
CONFIG_QCOM_SMEM=y
CONFIG_QCOM_SMD_RPM=y
CONFIG_PHY_QCOM_QMP=y
CONFIG_TMPFS=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=5
CONFIG_WQ_WATCHDOG=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_RCU_CPU_STALL_TIMEOUT=3
CONFIG_FUNCTION_TRACER=y
CONFIG_DEBUG_WX=y



FULL SESSION LOG:

https://pastebin.ubuntu.com/p/YSm82GxhNW/

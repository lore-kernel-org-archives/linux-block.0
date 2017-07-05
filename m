Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:32879 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752665AbdGENQF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 09:16:05 -0400
Date: Wed, 5 Jul 2017 15:58:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: OOPS from cciss_ioctl in 4.12+git
Message-ID: <alpine.LRH.2.20.1707051555130.20086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tried todays git snapshot of starting 4.13 tree on some machines. On HP 
DL380 G4 with cciss storage, there is an OOPS in dmesg but the machine 
keeps running fine after that.

[    0.000000] Linux version 4.12.0-03441-g19964541c231 (mroos@dl380g4) (gcc version 6.3.0 20170628 (Debian 6.3.0-21) ) #12 SMP Wed Jul 5 09:40:01 EEST 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.0-03441-g19964541c231 root=/dev/cciss/c0d0p1 ro
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dfff2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dfff3000-0x00000000dfffafff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dfffb000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fecfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021bffefff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: HP ProLiant DL380 G4, BIOS P51 07/19/2007
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21bfff max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: last_pfn = 0xdfff3 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4f80-0x000f4f8f] mapped at [ffff8800000f4f80]
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x02262000, 0x02262fff] PGTABLE
[    0.000000] BRK [0x02263000, 0x02263fff] PGTABLE
[    0.000000] BRK [0x02264000, 0x02264fff] PGTABLE
[    0.000000] BRK [0x02265000, 0x02265fff] PGTABLE
[    0.000000] BRK [0x02266000, 0x02266fff] PGTABLE
[    0.000000] BRK [0x02267000, 0x02267fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F4F00 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x00000000DFFF3300 000044 (v01 HP     P51      00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FACP 0x00000000DFFF3380 0000F4 (v03 HP     P51      00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20170531/tbfadt-708)
[    0.000000] ACPI: DSDT 0x00000000DFFF3480 002DAB (v01 HP     DSDT     00000001 INTL 20030228)
[    0.000000] ACPI: FACS 0x00000000DFFF3100 000040
[    0.000000] ACPI: FACS 0x00000000DFFF3100 000040
[    0.000000] ACPI: SPCR 0x00000000DFFF3140 000050 (v01 HP     SPCRRBSU 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: MCFG 0x00000000DFFF31C0 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.000000] ACPI: APIC 0x00000000DFFF3200 0000C2 (v01 HP     00000083 00000002      00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021bffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000dfff2fff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021bffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021bffefff]
[    0.000000] On node 0 totalpages: 2080656
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14272 pages used for memmap
[    0.000000]   DMA32 zone: 913395 pages, LIFO batch:31
[    0.000000]   Normal zone: 18176 pages used for memmap
[    0.000000]   Normal zone: 1163263 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x908
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
[    0.000000] IOAPIC[3]: apic_id 11, version 32, address 0xfec84000, GSI 72-95
[    0.000000] IOAPIC[4]: apic_id 12, version 32, address 0xfec84400, GSI 96-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: 8 Processors exceeds NR_CPUS limit of 4
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfff3000-0xdfffafff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfffb000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee10000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 36 pages/cpu @ffff88021ba00000 s108696 r8192 d30568 u524288
[    0.000000] pcpu-alloc: s108696 r8192 d30568 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2048123
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.12.0-03441-g19964541c231 root=/dev/cciss/c0d0p1 ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Memory: 8093716K/8322624K available (8163K kernel code, 7196K rwdata, 1164K rodata, 908K init, 396K bss, 228908K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.004000] tsc: Fast TSC calibration using PIT
[    0.008000] tsc: Detected 3200.191 MHz processor
[    0.008000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6400.38 BogoMIPS (lpj=12800764)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] ACPI: Core revision 20170531
[    0.013234] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.013421] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.013576] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.014322] CPU: Physical Processor ID: 0
[    0.014469] CPU: Processor Core ID: 0
[    0.014614] mce: CPU supports 4 MCE banks
[    0.014765] CPU0: Thermal monitoring enabled (TM1)
[    0.014918] process: using mwait in idle threads
[    0.015072] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 64
[    0.015215] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 64, 1GB 0
[    0.015533] Freeing SMP alternatives memory: 24K
[    0.016214] smpboot: Max logical packages: 8
[    0.020704] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.064000] smpboot: CPU0: Intel(R) Xeon(TM) CPU 3.20GHz (family: 0xf, model: 0x4, stepping: 0x1)
[    0.064000] Performance Events: Netburst events, Netburst P4/Xeon PMU driver.
[    0.064000] ... version:                0
[    0.064000] ... bit width:              40
[    0.064000] ... generic registers:      18
[    0.064000] ... value mask:             000000ffffffffff
[    0.064000] ... max period:             0000007fffffffff
[    0.064000] ... fixed-purpose events:   0
[    0.064000] ... event mask:             000000000003ffff
[    0.064000] Hierarchical SRCU implementation.
[    0.064000] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.064000] smp: Bringing up secondary CPUs ...
[    0.064000] x86: Booting SMP configuration:
[    0.064000] .... node  #0, CPUs:      #1
[    0.154061] smp: Brought up 1 node, 2 CPUs
[    0.154061] smpboot: Total of 2 processors activated (12801.06 BogoMIPS)
[    0.156468] devtmpfs: initialized
[    0.156468] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.156468] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.156737] NET: Registered protocol family 16
[    0.156737] cpuidle: using governor ladder
[    0.156737] cpuidle: using governor menu
[    0.156737] ACPI: bus type PCI registered
[    0.156737] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.156737] PCI: Intel Corporation E7520 Memory Controller Hub with MMCONFIG support
[    0.156867] PCI: not using MMCONFIG
[    0.157011] PCI: Using configuration type 1 for base access
[    0.157163] PCI: HP ProLiant DL380 detected, enabling pci=bfsort.
[    0.160896] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.160896] ACPI: Added _OSI(Module Device)
[    0.160896] ACPI: Added _OSI(Processor Device)
[    0.160896] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.160896] ACPI: Added _OSI(Processor Aggregator Device)
[    0.164185] ACPI: Interpreter enabled
[    0.164401] ACPI: (supports S0 S4 S5)
[    0.164595] ACPI: Using IOAPIC for interrupt routing
[    0.164831] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.174165] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
[    0.174364] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.174564] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.174760] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.175204] PCI host bridge to bus 0000:00
[    0.175393] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.175588] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.175775] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.176008] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfebfffff window]
[    0.176320] pci_bus 0000:00: root bus resource [bus 00-7f]
[    0.176521] pci 0000:00:00.0: [8086:3590] type 00 class 0x060000
[    0.176678] pci 0000:00:02.0: [8086:3595] type 01 class 0x060400
[    0.176739] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.176840] pci 0000:00:06.0: [8086:3599] type 01 class 0x060400
[    0.176898] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.177019] pci 0000:00:1d.0: [8086:24d2] type 00 class 0x0c0300
[    0.177072] pci 0000:00:1d.0: reg 0x20: [io  0x3000-0x301f]
[    0.177177] pci 0000:00:1d.1: [8086:24d4] type 00 class 0x0c0300
[    0.177235] pci 0000:00:1d.1: reg 0x20: [io  0x3020-0x303f]
[    0.177341] pci 0000:00:1d.2: [8086:24d7] type 00 class 0x0c0300
[    0.177400] pci 0000:00:1d.2: reg 0x20: [io  0x3040-0x305f]
[    0.177501] pci 0000:00:1d.3: [8086:24de] type 00 class 0x0c0300
[    0.177559] pci 0000:00:1d.3: reg 0x20: [io  0x3060-0x307f]
[    0.177670] pci 0000:00:1d.7: [8086:24dd] type 00 class 0x0c0320
[    0.177692] pci 0000:00:1d.7: reg 0x10: [mem 0xfbef0000-0xfbef03ff]
[    0.177790] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.177876] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060400
[    0.178007] pci 0000:00:1f.0: [8086:24d0] type 00 class 0x060100
[    0.178086] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.178096] pci 0000:00:1f.0: quirk: [io  0x0900-0x097f] claimed by ICH4 ACPI/GPIO/TCO
[    0.178435] pci 0000:00:1f.0: quirk: [io  0x0800-0x083f] claimed by ICH4 GPIO
[    0.178708] pci 0000:00:1f.1: [8086:24db] type 00 class 0x01018a
[    0.178724] pci 0000:00:1f.1: reg 0x10: [io  0x01f0-0x01f7]
[    0.178735] pci 0000:00:1f.1: reg 0x14: [io  0x03f4-0x03f7]
[    0.178745] pci 0000:00:1f.1: reg 0x18: [io  0x0170-0x0177]
[    0.178756] pci 0000:00:1f.1: reg 0x1c: [io  0x0374-0x0377]
[    0.178766] pci 0000:00:1f.1: reg 0x20: [io  0x0500-0x050f]
[    0.178777] pci 0000:00:1f.1: reg 0x24: [mem 0x00000000-0x000003ff]
[    0.178791] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.178972] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.179147] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.179350] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.179680] pci 0000:02:00.0: [8086:0329] type 01 class 0x060400
[    0.179683] pci 0000:02:00.0: PXH quirk detected; SHPC device MSI disabled
[    0.180042] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.180132] pci 0000:02:00.2: [8086:032a] type 01 class 0x060400
[    0.180135] pci 0000:02:00.2: PXH quirk detected; SHPC device MSI disabled
[    0.180367] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.180449] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.180782] pci 0000:00:02.0: PCI bridge to [bus 02-04]
[    0.180962] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    0.180966] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    0.181031] pci 0000:03:01.0: [14e4:1648] type 00 class 0x020000
[    0.181052] pci 0000:03:01.0: reg 0x10: [mem 0xfdef0000-0xfdefffff 64bit]
[    0.181132] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.181202] pci 0000:03:01.1: [14e4:1648] type 00 class 0x020000
[    0.181222] pci 0000:03:01.1: reg 0x10: [mem 0xfdee0000-0xfdeeffff 64bit]
[    0.181300] pci 0000:03:01.1: PME# supported from D3hot D3cold
[    0.181395] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.181585] pci 0000:02:00.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.181649] pci 0000:04:03.0: [0e11:0046] type 00 class 0x010400
[    0.181670] pci 0000:04:03.0: reg 0x10: [mem 0xfdff0000-0xfdff1fff 64bit]
[    0.181679] pci 0000:04:03.0: reg 0x18: [io  0x4000-0x40ff]
[    0.181692] pci 0000:04:03.0: reg 0x1c: [mem 0xfdf80000-0xfdfbffff 64bit]
[    0.181708] pci 0000:04:03.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.181748] pci 0000:04:03.0: supports D1
[    0.181825] pci 0000:02:00.2: PCI bridge to [bus 04]
[    0.182020] pci 0000:02:00.2:   bridge window [io  0x4000-0x4fff]
[    0.182025] pci 0000:02:00.2:   bridge window [mem 0xfdf00000-0xfdffffff]
[    0.182106] pci 0000:05:00.0: [8086:0329] type 01 class 0x060400
[    0.182109] pci 0000:05:00.0: PXH quirk detected; SHPC device MSI disabled
[    0.182353] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.182444] pci 0000:05:00.2: [8086:032a] type 01 class 0x060400
[    0.182446] pci 0000:05:00.2: PXH quirk detected; SHPC device MSI disabled
[    0.182708] pci 0000:05:00.2: PME# supported from D0 D3hot D3cold
[    0.182786] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.184015] pci 0000:00:06.0: PCI bridge to [bus 05-0c]
[    0.184280] pci 0000:05:00.0: PCI bridge to [bus 06-09]
[    0.184554] pci 0000:05:00.2: PCI bridge to [bus 0a-0c]
[    0.184804] pci 0000:01:03.0: [1002:4752] type 00 class 0x030000
[    0.184823] pci 0000:01:03.0: reg 0x10: [mem 0xfc000000-0xfcffffff]
[    0.184834] pci 0000:01:03.0: reg 0x14: [io  0x2000-0x20ff]
[    0.184845] pci 0000:01:03.0: reg 0x18: [mem 0xfbff0000-0xfbff0fff]
[    0.184881] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.184919] pci 0000:01:03.0: supports D1 D2
[    0.184984] pci 0000:01:04.0: [0e11:b203] type 00 class 0x088000
[    0.185001] pci 0000:01:04.0: reg 0x10: [io  0x1800-0x18ff]
[    0.185011] pci 0000:01:04.0: reg 0x14: [mem 0xfbfe0000-0xfbfe01ff]
[    0.185155] pci 0000:01:04.2: [0e11:b204] type 00 class 0x088000
[    0.185174] pci 0000:01:04.2: reg 0x10: [io  0x2400-0x24ff]
[    0.185185] pci 0000:01:04.2: reg 0x14: [mem 0xfbfd0000-0xfbfd07ff]
[    0.185196] pci 0000:01:04.2: reg 0x18: [mem 0xfbfc0000-0xfbfc1fff]
[    0.185207] pci 0000:01:04.2: reg 0x1c: [mem 0xfbf00000-0xfbf7ffff]
[    0.185236] pci 0000:01:04.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.185274] pci 0000:01:04.2: PME# supported from D0 D3hot D3cold
[    0.188007] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
[    0.188157] pci 0000:00:1e.0:   bridge window [io  0x1000-0x2fff]
[    0.188162] pci 0000:00:1e.0:   bridge window [mem 0xfbf00000-0xfcffffff]
[    0.188167] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.188170] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.188172] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.188175] pci 0000:00:1e.0:   bridge window [mem 0xe0000000-0xfebfffff window] (subtractive decode)
[    0.188193] pci_bus 0000:00: on NUMA node 0
[    0.190202] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
[    0.190448] ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7 10 11)
[    0.190698] ACPI: PCI Interrupt Link [LNKC] (IRQs *5 7 10 11)
[    0.190946] ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 10 11)
[    0.191192] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
[    0.191442] ACPI: PCI Interrupt Link [LNKF] (IRQs *5 7 10 11)
[    0.191688] ACPI: PCI Interrupt Link [LNKG] (IRQs *5 7 10 11)
[    0.191940] ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7 10 11)
[    0.192104] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.192381] pci 0000:01:03.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.192381] pci 0000:01:03.0: vgaarb: bridge control possible
[    0.192442] vgaarb: loaded
[    0.192683] SCSI subsystem initialized
[    0.192863] EDAC MC: Ver: 3.0.0
[    0.193169] PCI: Using ACPI for IRQ routing
[    0.193169] PCI: pci_cache_line_size set to 64 bytes
[    0.193169] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    0.193169] e820: reserve RAM buffer [mem 0xdfff3000-0xdfffffff]
[    0.193169] e820: reserve RAM buffer [mem 0x21bfff000-0x21bffffff]
[    0.193169] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.193169] hpet clockevent registered
[    0.193169] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.193169] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.193169] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.197038] clocksource: Switched to clocksource hpet
[    0.197038] pnp: PnP ACPI init
[    0.198301] system 00:00: [io  0x0408-0x040f] has been reserved
[    0.198454] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.198604] system 00:00: [io  0x0700-0x071f] has been reserved
[    0.198752] system 00:00: [io  0x0800-0x083f] has been reserved
[    0.198905] system 00:00: [io  0x0900-0x097f] has been reserved
[    0.199049] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    0.199197] system 00:00: [io  0x0cd4-0x0cd7] has been reserved
[    0.199351] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    0.199505] system 00:00: [io  0x02f8-0x02ff] has been reserved
[    0.199662] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.199820] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.199879] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.199925] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    0.200205] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    0.200397] pnp 00:04: [dma 2]
[    0.200442] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.200711] pnp: PnP ACPI: found 5 devices
[    0.208829] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.209148] pci 0000:00:1e.0: BAR 15: assigned [mem 0xf0000000-0xf00fffff pref]
[    0.209400] pci 0000:00:1f.1: BAR 5: assigned [mem 0xf0100000-0xf01003ff]
[    0.209560] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.209715] pci 0000:02:00.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.209870] pci 0000:04:03.0: BAR 6: assigned [mem 0xfdf00000-0xfdf3ffff pref]
[    0.210105] pci 0000:02:00.2: PCI bridge to [bus 04]
[    0.210251] pci 0000:02:00.2:   bridge window [io  0x4000-0x4fff]
[    0.210401] pci 0000:02:00.2:   bridge window [mem 0xfdf00000-0xfdffffff]
[    0.210558] pci 0000:00:02.0: PCI bridge to [bus 02-04]
[    0.210706] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    0.210857] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    0.211010] pci 0000:05:00.0: PCI bridge to [bus 06-09]
[    0.211152] pci 0000:05:00.2: PCI bridge to [bus 0a-0c]
[    0.211309] pci 0000:00:06.0: PCI bridge to [bus 05-0c]
[    0.211465] pci 0000:01:03.0: BAR 6: assigned [mem 0xf0000000-0xf001ffff pref]
[    0.211714] pci 0000:01:04.2: BAR 6: assigned [mem 0xf0020000-0xf002ffff pref]
[    0.211962] pci 0000:00:1e.0: PCI bridge to [bus 01]
[    0.212111] pci 0000:00:1e.0:   bridge window [io  0x1000-0x2fff]
[    0.212265] pci 0000:00:1e.0:   bridge window [mem 0xfbf00000-0xfcffffff]
[    0.212419] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xf00fffff pref]
[    0.212674] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.212676] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.212678] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.212681] pci_bus 0000:00: resource 7 [mem 0xe0000000-0xfebfffff window]
[    0.212684] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.212686] pci_bus 0000:02: resource 1 [mem 0xfde00000-0xfdffffff]
[    0.212688] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdefffff]
[    0.212691] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.212693] pci_bus 0000:04: resource 1 [mem 0xfdf00000-0xfdffffff]
[    0.212696] pci_bus 0000:01: resource 0 [io  0x1000-0x2fff]
[    0.212698] pci_bus 0000:01: resource 1 [mem 0xfbf00000-0xfcffffff]
[    0.212701] pci_bus 0000:01: resource 2 [mem 0xf0000000-0xf00fffff pref]
[    0.212703] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[    0.212705] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
[    0.212707] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.212710] pci_bus 0000:01: resource 7 [mem 0xe0000000-0xfebfffff window]
[    0.212819] NET: Registered protocol family 2
[    0.213212] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.213719] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.214456] TCP: Hash tables configured (established 65536 bind 65536)
[    0.214800] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.215059] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.215426] NET: Registered protocol family 1
[    0.215604] pci_bus 0000:02: writes to ASPM control bits will be ignored
[    0.215761] pci_bus 0000:05: writes to ASPM control bits will be ignored
[    0.216965] pci 0000:02:00.0: rerouting interrupts for [8086:0329]
[    0.217098] pci 0000:02:00.2: rerouting interrupts for [8086:032a]
[    0.217233] pci 0000:05:00.0: rerouting interrupts for [8086:0329]
[    0.217362] pci 0000:05:00.2: rerouting interrupts for [8086:032a]
[    0.217490] PCI: CLS 64 bytes, default 64
[    0.217533] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.217662] software IO TLB [mem 0xdbff3000-0xdfff3000] (64MB) mapped at [ffff8800dbff3000-ffff8800dfff2fff]
[    0.217962] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.218901] audit: initializing netlink subsys (disabled)
[    0.219135] audit: type=2000 audit(1499258956.219:1): state=initialized audit_enabled=0 res=1
[    0.219326] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    0.222828] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.223039] io scheduler noop registered
[    0.223236] io scheduler cfq registered (default)
[    0.223963] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.244472] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.264877] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.265500] Non-volatile memory driver v1.3
[    0.265785] HP CISS Driver (v 3.6.26)
[    0.266098] cciss 0000:04:03.0: PCI IRQ 51 -> rerouted to legacy IRQ 19
[    0.404142] cciss 0000:04:03.0: cciss0: <0x46> at PCI 0000:04:03.0 IRQ 19 using DAC
[    0.446484]  cciss/c0d0: p1 p2 < p5 >
[    0.447076] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    0.449145] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.449323] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.449549] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.449876] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.450065] rtc_cmos rtc_cmos: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.450594] NET: Registered protocol family 10
[    0.451693] Segment Routing with IPv6
[    0.451886] mip6: Mobile IPv6
[    0.452065] NET: Registered protocol family 17
[    0.452435] microcode: sig=0xf41, pf=0x1, revision=0x17
[    0.452669] microcode: Microcode Update Driver: v2.2.
[    0.452680] sched_clock: Marking stable (452658755, 0)->(568353432, -115694677)
[    0.453717] console [netcon0] enabled
[    0.453874] netconsole: network logging started
[    0.454070] rtc_cmos rtc_cmos: setting system clock to 2017-07-05 12:49:17 UTC (1499258957)
[    0.486475] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.487278] EXT4-fs (cciss!c0d0p1): couldn't mount as ext3 due to feature incompatibilities
[    0.487986] EXT4-fs (cciss!c0d0p1): couldn't mount as ext2 due to feature incompatibilities
[    0.535220] EXT4-fs (cciss!c0d0p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.535458] VFS: Mounted root (ext4 filesystem) readonly on device 104:1.
[    0.550274] devtmpfs: mounted
[    0.551773] Freeing unused kernel memory: 908K
[    0.551938] Write protecting the kernel read-only data: 10240k
[    0.552289] Freeing unused kernel memory: 12K
[    0.556185] Freeing unused kernel memory: 884K
[    0.559436] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.758628] random: fast init done
[    1.244033] tsc: Refined TSC clocksource calibration: 3200.113 MHz
[    1.244180] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e20b4b4bc2, max_idle_ns: 440795278723 ns
[    1.369427] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.457888] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN default-hierarchy=hybrid)
[    1.458414] systemd[1]: Detected architecture x86-64.
[    1.473343] systemd[1]: Set hostname to <dl380g4>.
[    2.109922] systemd[1]: Listening on Syslog Socket.
[    2.110959] systemd[1]: Created slice System Slice.
[    2.111643] systemd[1]: Listening on udev Kernel Socket.
[    2.113757] systemd[1]: Mounting Huge Pages File System...
[    2.114543] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.115619] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    2.117889] systemd[1]: Mounting POSIX Message Queue File System...
[    2.268110] clocksource: Switched to clocksource tsc
[    2.945512] EXT4-fs (cciss!c0d0p1): re-mounted. Opts: errors=remount-ro
[    3.040864] systemd-journald[77]: Received request to flush runtime journal from PID 1
[    3.388656] Contact your BIOS vendor to see if the E752x error registers can be safely un-hidden
[    3.389399] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    3.389653] ACPI: Power Button [PWRF]
[    3.488385] thermal LNXTHERM:00: registered as thermal_zone0
[    3.488521] ACPI: Thermal Zone [THM0] (8 C)
[    3.492377] intel_rng: FWH not detected
[    3.500916] libata version 3.00 loaded.
[    3.521365] ata_piix 0000:00:1f.1: version 2.13
[    3.521383] ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
[    3.521707] ata_piix 0000:00:1f.1: can't derive routing for PCI INT A
[    3.522874] ACPI: bus type USB registered
[    3.523074] usbcore: registered new interface driver usbfs
[    3.523237] usbcore: registered new interface driver hub
[    3.523416] usbcore: registered new device driver usb
[    3.526835] scsi host0: ata_piix
[    3.527215] scsi host1: ata_piix
[    3.527460] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x500 irq 14
[    3.527592] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x508 irq 15
[    3.537885] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.540462] uhci_hcd: USB Universal Host Controller Interface driver
[    3.540922] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.541090] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    3.541390] uhci_hcd 0000:00:1d.0: irq 16, io base 0x00003000
[    3.541728] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    3.541863] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.542079] usb usb1: Product: UHCI Host Controller
[    3.542218] usb usb1: Manufacturer: Linux 4.12.0-03441-g19964541c231 uhci_hcd
[    3.542371] usb usb1: SerialNumber: 0000:00:1d.0
[    3.542933] hub 1-0:1.0: USB hub found
[    3.543101] hub 1-0:1.0: 2 ports detected
[    3.543708] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.543856] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    3.544158] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003020
[    3.544477] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.544608] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.544825] usb usb2: Product: UHCI Host Controller
[    3.544955] usb usb2: Manufacturer: Linux 4.12.0-03441-g19964541c231 uhci_hcd
[    3.545085] usb usb2: SerialNumber: 0000:00:1d.1
[    3.548118] ehci-pci: EHCI PCI platform driver
[    3.549066] hub 2-0:1.0: USB hub found
[    3.549224] hub 2-0:1.0: 2 ports detected
[    3.549837] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.549982] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    3.550251] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[    3.550568] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.550698] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.550908] usb usb3: Product: UHCI Host Controller
[    3.551036] usb usb3: Manufacturer: Linux 4.12.0-03441-g19964541c231 uhci_hcd
[    3.551168] usb usb3: SerialNumber: 0000:00:1d.2
[    3.551598] hub 3-0:1.0: USB hub found
[    3.551747] hub 3-0:1.0: 2 ports detected
[    3.552962] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    3.553125] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 4
[    3.553379] ehci-pci 0000:00:1d.7: debug port 1
[    3.557422] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    3.557457] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbef0000
[    3.572027] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    3.572310] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    3.572448] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.572663] usb usb4: Product: EHCI Host Controller
[    3.572794] usb usb4: Manufacturer: Linux 4.12.0-03441-g19964541c231 ehci_hcd
[    3.572929] usb usb4: SerialNumber: 0000:00:1d.7
[    3.573366] hub 4-0:1.0: USB hub found
[    3.573519] hub 4-0:1.0: 8 ports detected
[    3.603558] hub 1-0:1.0: USB hub found
[    3.603714] hub 1-0:1.0: 2 ports detected
[    3.632189] hub 2-0:1.0: USB hub found
[    3.632378] hub 2-0:1.0: 2 ports detected
[    3.660229] hub 3-0:1.0: USB hub found
[    3.660382] hub 3-0:1.0: 2 ports detected
[    3.661195] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    3.661338] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    3.661598] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
[    3.661948] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.662078] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.662290] usb usb5: Product: UHCI Host Controller
[    3.662417] usb usb5: Manufacturer: Linux 4.12.0-03441-g19964541c231 uhci_hcd
[    3.662546] usb usb5: SerialNumber: 0000:00:1d.3
[    3.662956] hub 5-0:1.0: USB hub found
[    3.663100] hub 5-0:1.0: 2 ports detected
[    3.702134] ata1.00: ATAPI: DW-224E-A, A.SD, max UDMA/25
[    3.706397] pps_core: LinuxPPS API ver. 1 registered
[    3.706534] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.707073] ata1.00: configured for UDMA/25
[    3.709230] scsi 0:0:0:0: CD-ROM            TEAC     DW-224E-A        A.SD PQ: 0 ANSI: 5
[    3.730510] BUG: unable to handle kernel paging request at 000000046474e550
[    3.730659] IP: memset_orig+0x82/0xac
[    3.730784] PGD 0 
[    3.730786] P4D 0 

[    3.731155] Oops: 0002 [#1] SMP
[    3.731281] Modules linked in: pps_core libphy evdev hpilo ehci_pci uhci_hcd ehci_hcd lpc_ich mfd_core ata_piix usbcore usb_common libata thermal rng_core button e752x_edac processor ip_tables x_tables autofs4
[    3.731630] CPU: 0 PID: 167 Comm: scsi_id Not tainted 4.12.0-03441-g19964541c231 #12
[    3.731841] Hardware name: HP ProLiant DL380 G4, BIOS P51 07/19/2007
[    3.731970] task: ffff88020e66ae00 task.stack: ffffc90000310000
[    3.732111] RIP: 0010:memset_orig+0x82/0xac
[    3.732239] RSP: 0018:ffffc90000313bb0 EFLAGS: 00010206
[    3.732366] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000000
[    3.732496] RDX: 0000000000000005 RSI: 0000000000000000 RDI: 000000046474e550
[    3.732623] RBP: 0000000000000000 R08: 00007ffecc298cfb R09: 0000000000000000
[    3.732750] R10: 000000046474e550 R11: 0000000000000000 R12: 000000046474e550
[    3.732878] R13: ffff88020e66ae00 R14: ffff88021219ac00 R15: ffffc90000313c70
[    3.733006] FS:  00007f459d1a1b40(0000) GS:ffff88021ba00000(0000) knlGS:0000000000000000
[    3.733220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.733348] CR2: 000000046474e550 CR3: 000000020c998000 CR4: 00000000000006f0
[    3.733476] Call Trace:
[    3.733604]  ? _copy_from_user+0x68/0x82
[    3.733735]  ? sg_io+0xe2/0x4a2
[    3.733861]  ? blkdev_get+0x126/0x40c
[    3.733988]  ? scsi_cmd_ioctl+0x294/0x3f8
[    3.734116]  ? path_openat+0x85e/0x2257
[    3.734245]  ? cciss_ioctl+0x2ef/0x128a
[    3.734370]  ? touch_atime+0x3b/0x115
[    3.734499]  ? seccomp_run_filters+0x5b/0xdf
[    3.734625]  ? do_filp_open+0xb0/0x125
[    3.734750]  ? _copy_to_user+0x3c/0x66
[    3.734881]  ? blkdev_ioctl+0x60d/0xf81
[    3.735008]  ? block_ioctl+0x41/0x81
[    3.735134]  ? do_vfs_ioctl+0xa9/0x8a1
[    3.735260]  ? syscall_trace_enter+0xf5/0x4a4
[    3.735386]  ? SyS_ioctl+0x36/0x70
[    3.735510]  ? do_syscall_64+0x70/0x1cc
[    3.735636]  ? entry_SYSCALL64_slow_path+0x25/0x25
[    3.735760] Code: d8 0f 1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff c9 48 89 07 48 8d 7f 08 75 f5 83 e2 07 74 0a ff ca <88> 07 48 8d 7f 01 75 f6 4c 89 d0 c3 48 83 fa 07 76 e7 48 89 07 
[    3.738273] RIP: memset_orig+0x82/0xac RSP: ffffc90000313bb0
[    3.738406] CR2: 000000046474e550
[    3.738592] ---[ end trace 2aba8bfa70dd6384 ]---
[    3.741154] PTP clock support registered
[    3.753965] tg3.c:v3.137 (May 11, 2014)
[    3.754274] tg3 0000:03:01.0: PCI IRQ 25 -> rerouted to legacy IRQ 17
[    3.835742] tg3 0000:03:01.0 eth0: Tigon3 [partno(N/A) rev 2100] (PCIX:133MHz:64-bit) MAC address 00:11:85:e8:13:33
[    3.836047] tg3 0000:03:01.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.836332] tg3 0000:03:01.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
[    3.836644] tg3 0000:03:01.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[    3.837061] tg3 0000:03:01.1: PCI IRQ 26 -> rerouted to legacy IRQ 18
[    3.864521] iTCO_vendor_support: vendor-support=0
[    3.866783] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.866998] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[    3.902941] scsi 0:0:0:0: Attached scsi generic sg0 type 5
[    3.924910] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    3.925137] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.925538] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    3.933843] tg3 0000:03:01.1 eth1: Tigon3 [partno(N/A) rev 2100] (PCIX:133MHz:64-bit) MAC address 00:11:85:e8:13:32
[    3.934067] tg3 0000:03:01.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.934285] tg3 0000:03:01.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    3.934498] tg3 0000:03:01.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[    4.087705] tg3 0000:03:01.0 enp3s1f0: renamed from eth0
[    4.104286] tg3 0000:03:01.1 enp3s1f1: renamed from eth1
[    4.122580] Adding 6222844k swap on /dev/cciss/c0d0p5.  Priority:-1 extents:1 across:6222844k 
[    4.756360] random: crng init done
[    5.391882] IPv6: ADDRCONF(NETDEV_UP): enp3s1f0: link is not ready
[    6.995223] tg3 0000:03:01.0 enp3s1f0: Link is up at 100 Mbps, full duplex
[    6.995291] tg3 0000:03:01.0 enp3s1f0: Flow control is off for TX and off for RX
[    6.995379] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s1f0: link becomes ready

-- 
Meelis Roos (mroos@linux.ee)

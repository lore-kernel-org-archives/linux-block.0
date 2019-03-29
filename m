Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C1C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAB02173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="liT7jYwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfC2NIY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:08:24 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:54406 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbfC2NIX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 09:08:23 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 09:08:20 EDT
Received: from fire.localdomain (unknown [IPv6:2001:470:28:88::100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 44W22c6Bwdz9xRN;
        Fri, 29 Mar 2019 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=032019;
        t=1553864553; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=CbE70e8Vk2FQEJckV7QVMLznk6sI3ljskDgUaJzbvO4=;
        b=liT7jYwXiP1InsKet1reIlPG+qYry9zVYSGCgpwhyMGNzL4EOL570JdS5Lo968A9iu/y98
        IrOiZ4DI7pigU3qmIccrOXjfxnwVpjZKEeyEvOhO/AUWcm34gFVZ+QlkFAsTMdUVBA8ePs
        aNiNQAx1W0virYXGS48ViUcqVGBYth5/IVWQ8RRkRBTqGKu44BTfUpstMBU/JatBEGsoak
        jjdnyrrWOmqh+GckejCURTKVZtsEDIENnwL4ERI/AYeUxl8J33v3ZPwi5mAmwzdYAvmbky
        EOO/6qnfUPz8O+Fm/43fcjX2xJUfRURfAPXBxacn2KTD2e0qkRjGY3aEA+VHcw==
Date:   Fri, 29 Mar 2019 16:02:27 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
Message-ID: <20190329160227.7d55c8dd@fire.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/pz9zHNmnBMlbpQTqwua7w1U"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc032019; t=1553864553;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=CbE70e8Vk2FQEJckV7QVMLznk6sI3ljskDgUaJzbvO4=;
        b=PehlxWwfL/kyHlqUeZjPoR4zGKmJKQd+eM+/+Ys9TwUBjeqXqhA2dWp0rl8vZQiu1KbJLT
        KLj7gnYdDBSHESSnDeVnsd1e58UTj3+qWPGIDBKyM/MjUvX2FJQ85+inYyakv3iwE3fdNx
        pNl6kKiJq32kkEDus+J07K/oSqbXKPfP3huhKvL41iqvv0TGD8yDsI3fKMGr2lsmefi6ZR
        mQzDyuwzUKWs+kXO2VrYaS0wVF/+xbkEHilgKidVTrzGCBSAJZfN4unzi6CU6s2qkfnUY5
        1XXJ8BtQujSK/P33TtfXHw4BR96ZyslG6wXJIln8XZms8RiusHLgA7siMqzndg==
ARC-Seal: i=1; s=arc032019; d=demfloro.ru; t=1553864553; a=rsa-sha256;
        cv=none;
        b=uubhdlOOCv5e6aF9zBbwZbMjgrdP8EALidSQPToLQnSESU55uauAbNmnivM2CuWzRNwPB0
        zLHrBRsyDrJhr1lU7IaNiYs92eK6Ov0mhCiB03eTUhi2gl2SO1bwbVftnKw+/5AVq/faLa
        4C4S0Q5LGDeW/aWW4p3zLHNpHb8biyqzVV+xI1FMriGn5SyH3PFso3/Hz6/e2pUgV5XJKu
        DG7myhSFUVRup5tjnTl9kOErFLN9c1w1bJhy1hH1yVk0aB1lQRaR49U/44Tc+nk35/YH1K
        f8dHbN8YV0E4uMcCEMrwwqc1r5Inc83muAz6EoqWXAu6LFU/h48vwdPHn9AjbA==
ARC-Authentication-Results: i=1;
        mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--MP_/pz9zHNmnBMlbpQTqwua7w1U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I got kernel panic since v5.1-rc1 when working with files on block
device with BFQ scheduler assigned. I didn't find trivial way to
reproduce the panic but "git checkout origin/linux-5.0.y"
on linux-stable-rc[1] git repo on btrfs filesystem reproduces the
problem 100% of the time on my bare-metal machine and in a VM.

Bisect led me to commit 9dee8b3b057e1 (block, bfq: fix queue removal
from weights tree). After reverting this commit on top of current
mainline master(9936328b41ce) I can't reproduce the problem.

dmesg with the panic and bisect log attached.

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

--MP_/pz9zHNmnBMlbpQTqwua7w1U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000][    T0] Linux version 5.1.0-rc2-ARCH-test2 (feanor@fire) (gc=
c version 8.3.0 (GCC)) #4 SMP Fri Mar 29 15:21:03 MSK 2019
[    0.000000][    T0] Command line: BOOT_IMAGE=3D/vmlinuz-linux-test2 root=
=3DUUID=3D9c04c835-60ce-4acf-973d-4a47ac59e769 rw console=3DttyS0,115200n8 =
stack_guard_gap=3D512 page_poison=3D1 slub_debug=3DFZP pti=3Don spectre_v2=
=3Don
 spectre_v2_user=3Don spec_store_bypass_disable=3Don
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0] random: get_random_u32 called from bsp_init_amd+0x17=
1/0x200 with crng_init=3D0
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'
[    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56
[    0.000000][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'standard' format.
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000007ffff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000800000-0x0000000000807ff=
f] ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000808000-0x000000000080fff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000810000-0x00000000008ffff=
f] ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000900000-0x000000007e7cfff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007e7d0000-0x000000007e7d0ff=
f] ACPI data
[    0.000000][    T0] BIOS-e820: [mem 0x000000007e7d1000-0x000000007ea6dff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007ea6e000-0x000000007ea79ff=
f] ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x000000007ea7a000-0x000000007eb1aff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x000000007eb1b000-0x000000007fb9aff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fb9b000-0x000000007fbcaff=
f] type 20
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fbcb000-0x000000007fbf2ff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fbf3000-0x000000007fbfaff=
f] ACPI data
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fbfb000-0x000000007fbfeff=
f] ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fbff000-0x000000007fedbff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007fedc000-0x000000007ff5fff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x000000007ff60000-0x000000007ffffff=
f] ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x0000000080000000-0x000000008ffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000ffc00000-0x00000000fffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000017ffffff=
f] usable
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] efi: EFI v2.70 by EDK II
[    0.000000][    T0] efi:  SMBIOS=3D0x7fbcc000  ACPI=3D0x7fbfa000  ACPI 2=
.0=3D0x7fbfa014  MEMATTR=3D0x7e8c4298
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0=
 02/06/2015
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000][    T0] kvm-clock: cpu 0, msr 2ccf7001, primary cpu clock
[    0.000000][    T0] kvm-clock: using sched offset of 14312683989764 cycl=
es
[    0.000002][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004][    T0] tsc: Detected 4515.104 MHz processor
[    0.000027][    T0] last_pfn =3D 0x180000 max_arch_pfn =3D 0x400000000
[    0.000077][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT
[    0.000086][    T0] last_pfn =3D 0x7fedc max_arch_pfn =3D 0x400000000
[    0.003468][    T0] check: Scanning 1 areas for low memory corruption
[    0.003480][    T0] Kernel/User page tables isolation: force enabled on =
command line.
[    0.003484][    T0] Using GB pages for direct mapping
[    0.003890][    T0] Secure boot could not be determined
[    0.003892][    T0] RAMDISK: [mem 0x37157000-0x378a2fff]
[    0.003902][    T0] ACPI: Early table checksum verification disabled
[    0.003904][    T0] ACPI: RSDP 0x000000007FBFA014 000024 (v02 BOCHS )
[    0.003907][    T0] ACPI: XSDT 0x000000007FBF90E8 00004C (v01 BOCHS  BXP=
CFACP 00000001      01000013)
[    0.003911][    T0] ACPI: FACP 0x000000007FBF6000 0000F4 (v03 BOCHS  BXP=
CFACP 00000001 BXPC 00000001)
[    0.003915][    T0] ACPI: DSDT 0x000000007FBF7000 001FC9 (v01 BOCHS  BXP=
CDSDT 00000001 BXPC 00000001)
[    0.003918][    T0] ACPI: FACS 0x000000007FBFD000 000040
[    0.003920][    T0] ACPI: APIC 0x000000007FBF5000 000090 (v01 BOCHS  BXP=
CAPIC 00000001 BXPC 00000001)
[    0.003923][    T0] ACPI: HPET 0x000000007FBF4000 000038 (v01 BOCHS  BXP=
CHPET 00000001 BXPC 00000001)
[    0.003925][    T0] ACPI: MCFG 0x000000007FBF3000 00003C (v01 BOCHS  BXP=
CMCFG 00000001 BXPC 00000001)
[    0.003927][    T0] ACPI: BGRT 0x000000007E7D0000 000038 (v01 INTEL  EDK=
2     00000002      01000013)
[    0.003954][    T0] Zone ranges:
[    0.003955][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.003956][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.003958][    T0]   Normal   [mem 0x0000000100000000-0x000000017ffffff=
f]
[    0.003959][    T0] Movable zone start for each node
[    0.003960][    T0] Early memory node ranges
[    0.003961][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ff=
ff]
[    0.003962][    T0]   node   0: [mem 0x0000000000100000-0x00000000007fff=
ff]
[    0.003963][    T0]   node   0: [mem 0x0000000000808000-0x000000000080ff=
ff]
[    0.003964][    T0]   node   0: [mem 0x0000000000900000-0x000000007e7cff=
ff]
[    0.003965][    T0]   node   0: [mem 0x000000007e7d1000-0x000000007ea6df=
ff]
[    0.003965][    T0]   node   0: [mem 0x000000007eb1b000-0x000000007fb9af=
ff]
[    0.003966][    T0]   node   0: [mem 0x000000007fbff000-0x000000007fedbf=
ff]
[    0.003967][    T0]   node   0: [mem 0x0000000100000000-0x000000017fffff=
ff]
[    0.003984][    T0] Zeroed struct page in unavailable ranges: 911 pages
[    0.003985][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0017fffffff]
[    0.021164][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.021174][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.021207][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.021209][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
[    0.021211][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.021212][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.021214][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.021215][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.021219][    T0] Using ACPI (MADT) for SMP configuration information
[    0.021221][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.021228][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.021256][    T0] [mem 0x90000000-0xffbfffff] available for PCI devices
[    0.021258][    T0] Booting paravirtualized kernel on KVM
[    0.021260][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.110659][    T0] random: get_random_bytes called from start_kernel+0x=
a5/0x46d with crng_init=3D0
[    0.110668][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids=
:4 nr_node_ids:1
[    0.111006][    T0] percpu: Embedded 41 pages/cpu @(____ptrval____) s129=
624 r8192 d30120 u524288
[    0.111036][    T0] KVM setup async PF for cpu 0
[    0.111042][    T0] kvm-stealtime: cpu 0, msr 17ba14e00
[    0.111048][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096=
 bytes)
[    0.111051][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 1029479
[    0.111054][    T0] Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux-tes=
t2 root=3DUUID=3D9c04c835-60ce-4acf-973d-4a47ac59e769 rw console=3DttyS0,11=
5200n8 stack_guard_gap=3D512 page_poison=3D1 slub_debug=3DFZP pti=3Don spec=
tr
e_v2=3Don spectre_v2_user=3Don spec_store_bypass_disable=3Don
[    0.111762][    T0] Dentry cache hash table entries: 524288 (order: 10, =
4194304 bytes)
[    0.112083][    T0] Inode-cache hash table entries: 262144 (order: 9, 20=
97152 bytes)
[    0.740803][    T0] Memory: 3993788K/4190660K available (10242K kernel c=
ode, 514K rwdata, 1856K rodata, 960K init, 1128K bss, 196872K reserved, 0K =
cma-reserved)
[    0.740813][    T0] random: get_random_u64 called from __kmem_cache_crea=
te+0x3d/0x4f0 with crng_init=3D0
[    0.741040][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D4, Nodes=3D1
[    0.741042][    T0] Kernel/User page tables isolation: enabled
[    0.741151][    T0] rcu: Hierarchical RCU implementation.
[    0.741152][    T0] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr=
_cpu_ids=3D4.
[    0.741154][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 10 jiffies.
[    0.741155][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D4
[    0.741171][    T0] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
[    0.741539][    T0] Console: colour dummy device 80x25
[    0.935721][    T0] printk: console [ttyS0] enabled
[    0.936785][    T0] ACPI: Core revision 20190215
[    0.938098][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns
[    0.940492][    T0] APIC: Switch to symmetric I/O mode setup
[    0.941858][    T0] KVM setup pv IPIs
[    0.943800][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1
[    0.945374][    T0] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.946949][    T0] Calibrating delay loop (skipped) preset value.. 9030=
.20 BogoMIPS (lpj=3D45151040)
[    0.948956][    T0] pid_max: default: 32768 minimum: 301
[    0.963016][    T0] LSM: Security Framework initializing
[    0.964218][    T0] Yama: becoming mindful.
[    0.965231][    T0] AppArmor: AppArmor initialized
[    0.966312][    T0] Mount-cache hash table entries: 8192 (order: 4, 6553=
6 bytes)
[    0.966944][    T0] Mountpoint-cache hash table entries: 8192 (order: 4,=
 65536 bytes)
[    0.969091][    T0] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.970578][    T0] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, =
1GB 0
[    0.972098][    T0] Spectre V2 : Mitigation: Full AMD retpoline
[    0.973439][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fil=
ling RSB on context switch
[    0.975568][    T0] Spectre V2 : mitigation: Enabling always-on Indirect=
 Branch Prediction Barrier
[    0.976944][    T0] Speculative Store Bypass: Mitigation: Speculative St=
ore Bypass disabled
[    0.979106][    T0] Freeing SMP alternatives memory: 24K
[    0.981254][    T1] smpboot: CPU0: AMD FX(tm)-9590 Eight-Core Processor =
(family: 0x15, model: 0x2, stepping: 0x0)
[    0.983856][    T1] Performance Events: Fam15h core perfctr, AMD PMU dri=
ver.
[    0.985498][    T1] ... version:                0
[    0.986631][    T1] ... bit width:              48
[    0.986939][    T1] ... generic registers:      6
[    0.986939][    T1] ... value mask:             0000ffffffffffff
[    0.986939][    T1] ... max period:             00007fffffffffff
[    0.986943][    T1] ... fixed-purpose events:   0
[    0.987935][    T1] ... event mask:             000000000000003f
[    0.989336][    T1] rcu: Hierarchical SRCU implementation.
[    0.990829][    T1] smp: Bringing up secondary CPUs ...
[    0.992239][    T1] x86: Booting SMP configuration:
[    0.993351][    T1] .... node  #0, CPUs:      #1
[    0.205447][    T0] kvm-clock: cpu 1, msr 2ccf7041, secondary cpu clock
[    0.994852][   T14] KVM setup async PF for cpu 1
[    0.994852][   T14] kvm-stealtime: cpu 1, msr 17ba94e00
[    0.997088][    T1]  #2
[    0.205447][    T0] kvm-clock: cpu 2, msr 2ccf7081, secondary cpu clock
[    0.997892][   T19] KVM setup async PF for cpu 2
[    0.999285][   T19] kvm-stealtime: cpu 2, msr 17bb14e00
[    1.000406][    T1]  #3
[    0.205447][    T0] kvm-clock: cpu 3, msr 2ccf70c1, secondary cpu clock
[    1.000406][   T24] KVM setup async PF for cpu 3
[    1.000406][   T24] kvm-stealtime: cpu 3, msr 17bb94e00
[    1.006947][    T1] smp: Brought up 1 node, 4 CPUs
[    1.008089][    T1] smpboot: Max logical packages: 4
[    1.009249][    T1] smpboot: Total of 4 processors activated (36120.83 B=
ogoMIPS)
[    1.011441][    T1] devtmpfs: initialized
[    1.011441][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 19112604462750000 ns
[    1.011441][    T1] futex hash table entries: 1024 (order: 4, 65536 byte=
s)
[    1.017103][    T1] xor: automatically using best checksumming function =
  avx
[    1.019114][    T1] NET: Registered protocol family 16
[    1.020415][    T1] audit: initializing netlink subsys (disabled)
[    1.021830][   T34] audit: type=3D2000 audit(1553862765.564:1): state=3D=
initialized audit_enabled=3D0 res=3D1
[    1.021830][    T1] KVM setup pv remote TLB flush
[    1.021830][    T1] ACPI: bus type PCI registered
[    1.021830][    T1] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x=
80000000-0x8fffffff] (base 0x80000000)
[    1.026963][    T1] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserve=
d in E820
[    1.028553][    T1] PCI: Using configuration type 1 for base access
[    1.043902][    T1] HugeTLB registered 2.00 MiB page size, pre-allocated=
 0 pages
[    1.043902][    T1] cryptd: max_cpu_qlen set to 1000
[    1.047083][    T1] raid6: using algorithm sse2x4 gen() 0 MB/s
[    1.048201][    T1] raid6: .... xor() 0 MB/s, rmw enabled
[    1.049376][    T1] raid6: using ssse3x2 recovery algorithm
[    1.050803][    T1] ACPI: Added _OSI(Module Device)
[    1.052030][    T1] ACPI: Added _OSI(Processor Device)
[    1.053108][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.054390][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    1.055920][    T1] ACPI: Added _OSI(Linux-Dell-Video)
[    1.056946][    T1] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.058440][    T1] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.069935][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded
[    1.073425][    T1] ACPI: Interpreter enabled
[    1.074480][    T1] ACPI: (supports S0 S5)
[    1.075513][    T1] ACPI: Using IOAPIC for interrupt routing
[    1.077098][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    1.079545][    T1] ACPI: Enabled 1 GPEs in block 00 to 3F
[    1.090567][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    1.092055][    T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig A=
SPM ClockPM Segments MSI]
[    1.094474][    T1] acpi PNP0A08:00: _OSC: platform does not support [LT=
R]
[    1.096344][    T1] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIe=
Capability]
[    1.097052][    T1] PCI host bridge to bus 0000:00
[    1.098135][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    1.099750][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    1.101524][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    1.103482][    T1] pci_bus 0000:00: root bus resource [mem 0x90000000-0=
xfebfffff window]
[    1.105180][    T1] pci_bus 0000:00: root bus resource [mem 0x800000000-=
0xfffffffff window]
[    1.106746][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.119494][    T1] pci 0000:00:01.0: BAR 0: assigned to efifb
[    1.176675][    T1] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed=
 by ICH6 ACPI/GPIO/TCO
[    1.192653][    T1] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.194404][    T1] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.196211][    T1] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.197237][    T1] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.198921][    T1] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    1.200535][    T1] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    1.202193][    T1] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    1.203854][    T1] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    1.205333][    T1] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    1.206798][    T1] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    1.206987][    T1] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    1.208332][    T1] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    1.209814][    T1] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    1.211325][    T1] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    1.212832][    T1] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    1.214351][    T1] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    1.216803][    T1] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    1.216803][    T1] pci 0000:00:01.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    1.216956][    T1] pci 0000:00:01.0: vgaarb: bridge control possible
[    1.218545][    T1] vgaarb: loaded
[    1.219671][    T1] SCSI subsystem initialized
[    1.220864][    T1] ACPI: bus type USB registered
[    1.222132][    T1] usbcore: registered new interface driver usbfs
[    1.223720][    T1] usbcore: registered new interface driver hub
[    1.225273][    T1] usbcore: registered new device driver usb
[    1.226775][    T1] pps_core: LinuxPPS API ver. 1 registered
[    1.226944][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    1.229148][    T1] PTP clock support registered
[    1.230475][    T1] Registered efivars operations
[    1.231674][    T1] Advanced Linux Sound Architecture Driver Initialized.
[    1.231674][    T1] PCI: Using ACPI for IRQ routing
[    1.289794][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.291165][    T1] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.295956][    T1] clocksource: Switched to clocksource kvm-clock
[    1.295956][    T1] AppArmor: AppArmor Filesystem Enabled
[    1.295956][    T1] pnp: PnP ACPI init
[    1.295956][    T1] pnp: PnP ACPI: found 4 devices
[    1.302979][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    1.305047][    T1] pci 0000:00:01.0: can't claim BAR 6 [mem 0xffff0000-=
0xffffffff pref]: no compatible bridge window
[    1.307280][    T1] pci 0000:00:04.0: can't claim BAR 6 [mem 0xfffc0000-=
0xffffffff pref]: no compatible bridge window
[    1.309508][    T1] pci 0000:00:04.0: BAR 6: assigned [mem 0x90840000-0x=
9087ffff pref]
[    1.311311][    T1] pci 0000:00:01.0: BAR 6: assigned [mem 0x90810000-0x=
9081ffff pref]
[    1.313253][    T1] NET: Registered protocol family 2
[    1.314524][    T1] tcp_listen_portaddr_hash hash table entries: 2048 (o=
rder: 3, 32768 bytes)
[    1.316336][    T1] TCP established hash table entries: 32768 (order: 6,=
 262144 bytes)
[    1.318146][    T1] TCP bind hash table entries: 32768 (order: 7, 524288=
 bytes)
[    1.320021][    T1] TCP: Hash tables configured (established 32768 bind =
32768)
[    1.321795][    T1] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    1.323416][    T1] UDP-Lite hash table entries: 2048 (order: 4, 65536 b=
ytes)
[    1.325156][    T1] NET: Registered protocol family 1
[    1.326395][    T1] pci 0000:00:01.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    1.330045][    T1] PCI Interrupt Link [GSIA] enabled at IRQ 16
[    1.334552][    T1] PCI Interrupt Link [GSIB] enabled at IRQ 17
[    1.339024][    T1] PCI Interrupt Link [GSIC] enabled at IRQ 18
[    1.343542][    T1] PCI Interrupt Link [GSID] enabled at IRQ 19
[    1.346899][    T1] Unpacking initramfs...
[    1.432913][    T1] Freeing initrd memory: 7472K
[    1.434082][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    1.435797][    T1] software IO TLB: mapped [mem 0x77f1e000-0x7bf1e000] =
(64MB)
[    1.437560][    T1] check: Scanning for low memory corruption every 60 s=
econds
[    1.460319][    T1] Initialise system trusted keyrings
[    1.461696][    T1] workingset: timestamp_bits=3D46 max_order=3D20 bucke=
t_order=3D0
[    1.518477][    T1] Key type asymmetric registered
[    1.519532][    T1] Asymmetric key parser 'x509' registered
[    1.520972][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 251)
[    1.522956][    T1] io scheduler bfq registered
[    1.524490][    T1] hv_vmbus: registering driver hv_pci
[    1.525614][    T1] hv_vmbus: registering driver hyperv_fb
[    1.526792][    T1] efifb: probing for efifb
[    1.527862][    T1] efifb: framebuffer at 0x90000000, using 1920k, total=
 1920k
[    1.529478][    T1] efifb: mode is 800x600x32, linelength=3D3200, pages=
=3D1
[    1.530942][    T1] efifb: scrolling: redraw
[    1.531996][    T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.537144][    T1] Console: switching to colour frame buffer device 100=
x37
[    1.541219][    T1] fb0: EFI VGA frame buffer device
[    1.542408][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    1.544343][    T1] ACPI: Power Button [PWRF]
[    1.546957][    T1] PCI Interrupt Link [GSIF] enabled at IRQ 21
[    1.550540][    T1] PCI Interrupt Link [GSIG] enabled at IRQ 22
[    1.556323][    T1] PCI Interrupt Link [GSIH] enabled at IRQ 23
[    1.559762][    T1] PCI Interrupt Link [GSIE] enabled at IRQ 20
[    1.561923][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    1.591484][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    1.594903][  T802] random: fast init done
[    1.595194][    T1] [drm] pci: virtio-vga detected at 0000:00:01.0
[    1.596091][  T802] random: crng init done
[    1.597492][    T1] fb0: switching to virtiodrmfb from EFI VGA
[    1.599632][  T802] random: 715 get_random_xx warning(s) missed due to r=
atelimiting
[    1.599683][    T1] Console: switching to colour dummy device 80x25
[    1.603251][    T1] virtio-pci 0000:00:01.0: vgaarb: deactivate vga cons=
ole
[    1.604886][    T1] [drm] virgl 3d acceleration not supported by host
[    1.607225][    T1] [TTM] Zone  kernel: Available graphics memory: 20158=
52 kiB
[    1.608923][    T1] [TTM] Initializing pool allocator
[    1.610014][    T1] [TTM] Initializing DMA pool allocator
[    1.611281][    T1] [drm] number of scanouts: 1
[    1.612247][    T1] [drm] number of cap sets: 0
[    1.613562][    T1] [drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on =
minor 0
[    1.639282][    T1] Console: switching to colour frame buffer device 239=
x71
[    1.653449][    T1] virtio_gpu virtio0: fb0: DRM emulated frame buffer d=
evice
[    1.667567][    T1] loop: module loaded
[    1.669983][    T1] scsi host0: Virtio SCSI HBA
[    1.677105][    T1] hv_vmbus: registering driver hv_storvsc
[    1.677374][   T31] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDI=
SK    2.5+ PQ: 0 ANSI: 5
[    1.682109][    T1] hv_vmbus: registering driver hv_netvsc
[    1.684312][    T1] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =
Driver
[    1.686986][    T1] ehci-pci: EHCI PCI platform driver
[    1.690599][    T1] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.692327][    T1] ehci-pci 0000:00:1d.7: new USB bus registered, assig=
ned bus number 1
[    1.694963][    T1] ehci-pci 0000:00:1d.7: irq 19, io mem 0x90801000
[    1.706894][    C3] sd 0:0:0:0: Power-on or device reset occurred
[    1.708559][   T31] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.710158][  T799] sd 0:0:0:0: [sda] 83886080 512-byte logical blocks: =
(42.9 GB/40.0 GiB)
[    1.712103][  T799] sd 0:0:0:0: [sda] Write Protect is off
[    1.713355][  T799] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    1.715452][  T799] sd 0:0:0:0: [sda] Optimal transfer size 0 bytes < PA=
GE_SIZE (4096 bytes)
[    1.720368][  T799]  sda: sda1 sda2 sda3
[    1.721871][  T799] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.727039][    T1] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.728553][    T1] usb usb1: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002, bcdDevice=3D 5.01
[    1.730495][    T1] usb usb1: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    1.732141][    T1] usb usb1: Product: EHCI Host Controller
[    1.733304][    T1] usb usb1: Manufacturer: Linux 5.1.0-rc2-ARCH-test2 e=
hci_hcd
[    1.734817][    T1] usb usb1: SerialNumber: 0000:00:1d.7
[    1.736158][    T1] hub 1-0:1.0: USB hub found
[    1.737186][    T1] hub 1-0:1.0: 6 ports detected
[    1.738526][    T1] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driv=
er
[    1.740025][    T1] ohci-pci: OHCI PCI platform driver
[    1.741224][    T1] uhci_hcd: USB Universal Host Controller Interface dr=
iver
[    1.744888][    T1] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.746360][    T1] uhci_hcd 0000:00:1d.0: new USB bus registered, assig=
ned bus number 2
[    1.748282][    T1] uhci_hcd 0000:00:1d.0: irq 16, io base 0x000060e0
[    1.749789][    T1] usb usb2: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0001, bcdDevice=3D 5.01
[    1.751760][    T1] usb usb2: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    1.753488][    T1] usb usb2: Product: UHCI Host Controller
[    1.754684][    T1] usb usb2: Manufacturer: Linux 5.1.0-rc2-ARCH-test2 u=
hci_hcd
[    1.756304][    T1] usb usb2: SerialNumber: 0000:00:1d.0
[    1.757741][    T1] hub 2-0:1.0: USB hub found
[    1.758739][    T1] hub 2-0:1.0: 2 ports detected
[    1.761783][    T1] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.763221][    T1] uhci_hcd 0000:00:1d.1: new USB bus registered, assig=
ned bus number 3
[    1.765224][    T1] uhci_hcd 0000:00:1d.1: irq 17, io base 0x000060c0
[    1.766993][    T1] usb usb3: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0001, bcdDevice=3D 5.01
[    1.769373][    T1] usb usb3: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    1.771396][    T1] usb usb3: Product: UHCI Host Controller
[    1.772815][    T1] usb usb3: Manufacturer: Linux 5.1.0-rc2-ARCH-test2 u=
hci_hcd
[    1.774705][    T1] usb usb3: SerialNumber: 0000:00:1d.1
[    1.776204][    T1] hub 3-0:1.0: USB hub found
[    1.777347][    T1] hub 3-0:1.0: 2 ports detected
[    1.780691][    T1] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.782216][    T1] uhci_hcd 0000:00:1d.2: new USB bus registered, assig=
ned bus number 4
[    1.784035][    T1] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000060a0
[    1.785520][    T1] usb usb4: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0001, bcdDevice=3D 5.01
[    1.787502][    T1] usb usb4: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    1.789306][    T1] usb usb4: Product: UHCI Host Controller
[    1.790572][    T1] usb usb4: Manufacturer: Linux 5.1.0-rc2-ARCH-test2 u=
hci_hcd
[    1.792204][    T1] usb usb4: SerialNumber: 0000:00:1d.2
[    1.793486][    T1] hub 4-0:1.0: USB hub found
[    1.794507][    T1] hub 4-0:1.0: 2 ports detected
[    1.795864][    T1] usbcore: registered new interface driver usb-storage
[    1.797457][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12
[    1.800204][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.801465][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.802769][    T1] hv_vmbus: registering driver hyperv_keyboard
[    1.804135][    T1] mousedev: PS/2 mouse device common for all mice
[    1.806248][  T320] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1
[    1.807219][    T1] rtc_cmos 00:00: RTC can wake from S4
[    1.811210][    T1] rtc_cmos 00:00: registered as rtc0
[    1.813173][    T1] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes=
 nvram, hpet irqs
[    1.817914][    T1] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.819572][    T1] hidraw: raw HID events driver (C) Jiri Kosina
[    1.821063][    T1] hv_vmbus: registering driver hid_hyperv
[    1.822432][    T1] usbcore: registered new interface driver usbhid
[    1.823815][    T1] usbhid: USB HID core driver
[    1.824817][    T1] hv_utils: Registering HyperV Utility Driver
[    1.826225][    T1] hv_vmbus: registering driver hv_utils
[    1.827705][    T1] hv_vmbus: registering driver hv_balloon
[    1.829534][    T1] Initializing XFRM netlink socket
[    1.831013][    T1] NET: Registered protocol family 10
[    1.832693][    T1] Segment Routing with IPv6
[    1.833713][    T1] NET: Registered protocol family 17
[    1.834830][    T1] NET: Registered protocol family 15
[    1.835983][    T1] bridge: filtering via arp/ip/ip6tables is no longer =
available by default. Update your scripts to load br_netfilter if you need =
this.
[    1.839371][    T1] AVX version of gcm_enc/dec engaged.
[    1.840504][    T1] AES CTR mode by8 optimization enabled
[    1.862135][    T1] sched_clock: Marking stable (1666674337, 195447403)-=
>(1888999479, -26877739)
[    1.864868][    T1] Loading compiled-in X.509 certificates
[    1.870537][    T1] Loaded X.509 cert 'Modules: 6658372c83ac517747ebb777=
f75c50d93800a9b7'
[    1.873556][    T1] Btrfs loaded, crc32c=3Dcrc32c-intel
[    1.874888][    T1] AppArmor: AppArmor sha1 policy hashing enabled
[    1.876781][    T1] ALSA device list:
[    1.877811][    T1]   No soundcards found.
[    1.879649][    T1] Freeing unused kernel image memory: 960K
[    1.927138][    T1] Write protecting the kernel read-only data: 14336k
[    1.929373][    T1] Freeing unused kernel image memory: 2036K
[    1.930858][    T1] Freeing unused kernel image memory: 192K
[    1.932450][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[    1.934098][    T1] x86/mm: Checking user space page tables
[    1.935462][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[    1.937041][    T1] Run /init as init process
:: running early hook [udev]
Warning: /lib/modules/5.1.0-rc2-ARCH-test2/modules.devname not found - igno=
ring
Starting version 241.7-2-arch
:: running hook [udev]
:: Triggering uevents...
[    2.117022][  T915] usb 1-1: new high-speed USB device number 2 using eh=
ci-pci
[    2.206261][ T1167] BTRFS: device label root devid 1 transid 503 /dev/sd=
a3
[    2.318833][  T915] usb 1-1: New USB device found, idVendor=3D0627, idPr=
oduct=3D0001, bcdDevice=3D 0.00
[    2.321017][  T915] usb 1-1: New USB device strings: Mfr=3D1, Product=3D=
3, SerialNumber=3D5
[    2.322948][  T915] usb 1-1: Product: QEMU USB Tablet
[    2.324118][  T915] usb 1-1: Manufacturer: QEMU
[    2.325256][  T915] usb 1-1: SerialNumber: 42
[    2.329864][  T915] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0=
000:00:1d.7/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input4
[    2.332760][  T915] hid-generic 0003:0627:0001.0001: input,hidraw0: USB =
HID v0.01 Mouse [QEMU QEMU USB Tablet] on usb-0000:00:1d.7-1/input0
:: performing fsck on '/dev/sda3'
:: mounting '/dev/sda3' on real root
[    2.400759][ T1436] BTRFS info (device sda3): using free space tree
[    2.402235][ T1436] BTRFS info (device sda3): has skinny extents
[    2.438597][  T320] input: ImExPS/2 Generic Explorer Mouse as /devices/p=
latform/i8042/serio1/input/input3
:: running cleanup hook [udev]
[    3.096177][    T1] systemd[1]: Failed to find module 'autofs4'
[    3.113775][    T1] systemd[1]: systemd 241.7-2-arch running in system m=
ode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTS=
ETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[    3.118856][    T1] systemd[1]: Detected virtualization kvm.
[    3.120073][    T1] systemd[1]: Detected architecture x86-64.

Welcome to Arch Linux!

[    3.136227][    T1] systemd[1]: Set hostname to <test>.
[    3.608105][    T1] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[    3.611457][    T1] systemd[1]: Listening on Device-mapper event daemon =
FIFOs.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[    3.615249][    T1] systemd[1]: Listening on LVM2 poll daemon socket.
[  OK  ] Listening on LVM2 poll daemon socket.
[    3.618199][    T1] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    3.620667][    T1] systemd[1]: Condition check resulted in Kernel Debug=
 File System being skipped.
[    3.622770][    T1] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started Dispatch Password =E2=80=A6ts to Console Directory Watch.
[  OK  ] Listening on Process Core Dump Socket.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Listening on Journal Socket (/dev/log).
         Starting Journal Service...
[  OK  ] Created slice system-getty.slice.
         Starting Apply Kernel Variables...
[  OK  ] Listening on Network Service Netlink Socket.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Listening on LVM2 metadata daemon socket.
         Starting Monitoring of LVM=E2=80=A6meventd or progress polling...
[  OK  ] Listening on initctl Compatibility Named Pipe.
         Mounting POSIX Message Queue File System...
[  OK  ] Started Forward Password R=E2=80=A6uests to Wall Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
         Mounting Huge Pages File System...
[  OK  ] Reached target Paths.
[    3.745118][ T1491] BTRFS info (device sda3): use zstd compression, leve=
l 3
[    3.747055][ T1491] BTRFS info (device sda3): enabling auto defrag
[    3.748464][ T1491] BTRFS info (device sda3): using free space tree
[  OK  ] Listening on udev Kernel Socket.
         Starting udev Coldplug all Devices...
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Started LVM2 metadata daemon.
         Starting Load/Save Random Seed...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Journal Service.
[    4.043735][   T34] audit: type=3D1130 audit(1553862768.584:2): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostn=
ame=3D? ad
dr=3D? terminal=3D? res=3Dsuccess'
         Starting Flush Journal to Persistent Storage...
[    4.097598][ T1489] systemd-journald[1489]: Received request to flush ru=
ntime journal from PID 1
[  OK  ] Started udev Kernel Device Manager.
[    4.446329][   T34] audit: type=3D1130 audit(1553862768.984:3): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-udevd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D
? terminal=3D? res=3Dsuccess'
         Starting Network Service...
[  OK  ] Found device /dev/ttyS0.
[    4.596099][ T1913] virtio_net virtio3 enp0s4: renamed from eth0
[  OK  ] Started Flush Journal to Persistent Storage.
[    4.675012][   T34] audit: type=3D1130 audit(1553862769.214:4): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-journal-flush comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" =
hostname
=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Found device QEMU_HARDDISK 2.
[    4.911481][ T1907] A link change request failed with some changes commi=
tted already. Interface enp0s4 may have been left with an inconsistent conf=
iguration, please check.
[  OK  ] Found device QEMU_HARDDISK 1.
[  OK  ] Started Network Service.
[    4.925070][   T34] audit: type=3D1130 audit(1553862769.464:5): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-networkd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostn=
ame=3D? ad
dr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Reached target Network.
         Activating swap /dev/disk/=E2=80=A68ab3-414f-b6ac-91e0e904eb08...
[    5.045388][ T1939] Adding 4194300k swap on /dev/sda2.  Priority:-2 exte=
nts:1 across:4194300k
[  OK  ] Activated swap /dev/disk/b=E2=80=A68-8ab3-414f-b6ac-91e0e904eb08.
[  OK  ] Reached target Swap.
         Mounting Temporary Directory (/tmp)...
[  OK  ] Mounted Temporary Directory (/tmp).
[  OK  ] Started Monitoring of LVM2=E2=80=A6 dmeventd or progress polling.
[    5.181607][   T34] audit: type=3D1130 audit(1553862769.724:6): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D?
 terminal=3D? res=3Dsuccess'
[  OK  ] Reached target Local File Systems (Pre).
         Mounting /boot...
[    5.195003][ T1941] FAT-fs (sda1): Volume was not properly unmounted. So=
me data may be corrupt. Please run fsck.
[  OK  ] Mounted /boot.
[  OK  ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
[    5.257618][   T34] audit: type=3D1130 audit(1553862769.804:7): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd"=
 hostnam
e=3D? addr=3D? terminal=3D? res=3Dsuccess'
         Starting Update UTMP about System Boot/Shutdown...
[    5.268333][   T34] audit: type=3D1127 audit(1553862769.814:8): pid=3D19=
43 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D' =
comm=3D"systemd-update-utmp" exe=3D"/usr/lib/systemd/systemd-update-utmp" h=
ostnam
e=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[    5.275548][   T34] audit: type=3D1130 audit(1553862769.814:9): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=
=3Dsystemd-update-utmp comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" ho=
stname=3D?
 addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily verification of password and group files.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily man-db regeneration.
[  OK  ] Reached target Timers.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Permit User Sessions...
[  OK  ] Started D-Bus System Message Bus.
[    5.304923][   T34] audit: type=3D1130 audit(1553862769.844:10): pid=3D1=
 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'uni=
t=3Ddbus comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? termin
al=3D? res=3Dsuccess'
         Starting Login Service...
[  OK  ] Started OpenSSH Daemon.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Login Service.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.

Arch Linux 5.1.0-rc2-ARCH-test2 (ttyS0)

test login: [   11.281974][   T34] kauditd_printk_skb: 5 callbacks suppress=
ed
[   11.281975][   T34] audit: type=3D1006 audit(1553862775.824:16): pid=3D1=
965 uid=3D0 subj=3D=3Dunconfined old-auid=3D4294967295 auid=3D0 tty=3D(none=
) old-ses=3D4294967295 ses=3D1 res=3D1
[   11.315508][   T34] audit: type=3D1130 audit(1553862775.854:17): pid=3D1=
 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'uni=
t=3Duser-runtime-dir@0 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" ho=
stname=3D?
 addr=3D? terminal=3D? res=3Dsuccess'
[   11.324377][   T34] audit: type=3D1006 audit(1553862775.864:18): pid=3D1=
968 uid=3D0 subj=3D=3Dunconfined old-auid=3D4294967295 auid=3D0 tty=3D(none=
) old-ses=3D4294967295 ses=3D2 res=3D1
[   11.418557][   T34] audit: type=3D1130 audit(1553862775.964:19): pid=3D1=
 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined msg=3D'uni=
t=3Duser@0 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? term
inal=3D? res=3Dsuccess'
[   32.837998][ T1975] bash (1975): drop_caches: 3
[   32.840195][ T1975] bash (1975): drop_caches: 3
[   39.935663][ T1975] bash (1975): drop_caches: 3
[   41.034974][    C0] general protection fault: 0000 [#1] SMP PTI
[   41.036291][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            =
    T 5.1.0-rc2-ARCH-test2 #4
[   41.038287][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.0.0 02/06/2015
[   41.040235][    C0] RIP: 0010:bfq_bfqq_expire+0x1f3/0x3d0
[   41.041455][    C0] Code: 01 00 00 00 00 00 00 a8 02 75 3c 41 83 ec 01 4=
1 83 fc 01 76 32 48 0f ba ab 08 01 00 00 03 48 8b 83 c8 00 00 00 48 85 c0 7=
4 07 <c7> 40 40 00 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 e8 e8
42 d3 ff 48
[   41.045818][    C0] RSP: 0018:ffffa1d87ba03ed0 EFLAGS: 00010002
[   41.047207][    C0] RAX: 6b6b6b6b6b6b6b6b RBX: ffffa1d87a2c27c8 RCX: 000=
000000010000c
[   41.049022][    C0] RDX: 0000000000000046 RSI: 0000000000000000 RDI: fff=
fa1d87ab13c40
[   41.050907][    C0] RBP: ffffa1d879434e68 R08: 0000000000000000 R09: fff=
fa1d87a2c2900
[   41.052751][    C0] R10: ffffa1d87a2c27c8 R11: 0000000000000001 R12: 000=
0000000000000
[   41.054631][    C0] R13: 0000000000000002 R14: ffffa1d879434e00 R15: fff=
fa1d87ba1b340
[   41.056313][    C0] FS:  0000000000000000(0000) GS:ffffa1d87ba00000(0000=
) knlGS:0000000000000000
[   41.058442][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.059804][    C0] CR2: 00006ffc44000010 CR3: 00000001774be000 CR4: 000=
00000000406b0
[   41.061536][    C0] Call Trace:
[   41.062291][    C0]  <IRQ>
[   41.062882][    C0]  bfq_idle_slice_timer+0x5f/0xb0
[   41.063924][    C0]  ? bfq_dispatch_request+0x870/0x870
[   41.065034][    C0]  __hrtimer_run_queues+0xf4/0x1a0
[   41.066091][    C0]  hrtimer_interrupt+0xfe/0x220
[   41.067096][    C0]  smp_apic_timer_interrupt+0x57/0x90
[   41.068209][    C0]  apic_timer_interrupt+0xf/0x20
[   41.069269][    C0]  </IRQ>
[   41.069909][    C0] RIP: 0010:default_idle+0x9/0x20
[   41.070947][    C0] Code: 01 00 00 00 00 ad de 48 89 44 24 20 48 05 00 0=
1 00 00 48 89 44 24 28 eb c5 e8 43 b7 8a ff 90 90 90 65 8b 05 d9 5b c1 6b f=
b f4 <65> 8b 05 d0 5b c1 6b c3 66 66 2e 0f 1f 84 00 00 00 00
00 0f 1f 40
[   41.075110][    C0] RSP: 0018:ffffffff94a03ee0 EFLAGS: 00000246 ORIG_RAX=
: ffffffffffffff13
[   41.076855][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000001
[   41.078619][    C0] RDX: 0000000000005e66 RSI: 0000000000000083 RDI: 000=
0000000000000
[   41.080255][    C0] RBP: ffffffff94a77a70 R08: 0000000000001400 R09: 000=
0000000000000
[   41.081898][    C0] R10: 0000000000000000 R11: 000000000000025f R12: fff=
fffff94a154c0
[   41.083589][    C0] R13: ffffa1d87fff7a00 R14: 000000007bcd65a8 R15: 000=
000007e797c3e
[   41.085238][    C0]  do_idle+0xd1/0xf0
[   41.086044][    C0]  cpu_startup_entry+0x14/0x20
[   41.087029][    C0]  start_kernel+0x44d/0x46d
[   41.087956][    C0]  secondary_startup_64+0xa4/0xb0
[   41.089076][    C0] Modules linked in:
[   41.089984][    C0] ---[ end trace 0e0bd22bb3439150 ]---
[   41.091187][    C0] RIP: 0010:bfq_bfqq_expire+0x1f3/0x3d0
[   41.092390][    C0] Code: 01 00 00 00 00 00 00 a8 02 75 3c 41 83 ec 01 4=
1 83 fc 01 76 32 48 0f ba ab 08 01 00 00 03 48 8b 83 c8 00 00 00 48 85 c0 7=
4 07 <c7> 40 40 00 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 e8 e8
42 d3 ff 48
[   41.096757][    C0] RSP: 0018:ffffa1d87ba03ed0 EFLAGS: 00010002
[   41.098012][    C0] RAX: 6b6b6b6b6b6b6b6b RBX: ffffa1d87a2c27c8 RCX: 000=
000000010000c
[   41.099755][    C0] RDX: 0000000000000046 RSI: 0000000000000000 RDI: fff=
fa1d87ab13c40
[   41.101418][    C0] RBP: ffffa1d879434e68 R08: 0000000000000000 R09: fff=
fa1d87a2c2900
[   41.103112][    C0] R10: ffffa1d87a2c27c8 R11: 0000000000000001 R12: 000=
0000000000000
[   41.104841][    C0] R13: 0000000000000002 R14: ffffa1d879434e00 R15: fff=
fa1d87ba1b340
[   41.106480][    C0] FS:  0000000000000000(0000) GS:ffffa1d87ba00000(0000=
) knlGS:0000000000000000
[   41.108319][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.109787][    C0] CR2: 00006ffc44000010 CR3: 00000001774be000 CR4: 000=
00000000406b0
[   41.111502][    C0] Kernel panic - not syncing: Fatal exception in inter=
rupt
[   41.113187][    C0] Kernel Offset: 0x12c00000 from 0xffffffff81000000 (r=
elocation range: 0xffffffff80000000-0xffffffffbfffffff)


--MP_/pz9zHNmnBMlbpQTqwua7w1U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bisect-log.txt

git bisect start
# bad: [9e98c678c2d6ae3a17cb2de55d17f69dddaa231b] Linux 5.1-rc1
git bisect bad 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect good 1c163f4c7b3f621efff9b28a47abb36f7378d783
# good: [e266ca36da7de45b64b05698e98e04b578a88888] Merge tag 'staging-5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good e266ca36da7de45b64b05698e98e04b578a88888
# bad: [36011ddc78395b59a8a418c37f20bcc18828f1ef] Merge tag 'gfs2-5.1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect bad 36011ddc78395b59a8a418c37f20bcc18828f1ef
# good: [4b057e73f28f1df13b77b77a52094238ffdf8abd] Merge tag 'drm-misc-fixes-2019-02-22' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect good 4b057e73f28f1df13b77b77a52094238ffdf8abd
# good: [610cd4eadec4f97acd25d3108b0e50d1362b3319] Merge branch 'x86-uv-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 610cd4eadec4f97acd25d3108b0e50d1362b3319
# good: [cf2e8c544cd3b33e9e403b7b72404c221bf888d1] Merge tag 'mfd-next-5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect good cf2e8c544cd3b33e9e403b7b72404c221bf888d1
# bad: [80201fe175cbf7f3e372f53eba0a881a702ad926] Merge tag 'for-5.1/block-20190302' of git://git.kernel.dk/linux-block
git bisect bad 80201fe175cbf7f3e372f53eba0a881a702ad926
# good: [4221b807d1f73c03d22543416d303b60a5d1ef31] Merge tag 'for-5.1/libata-20190301' of git://git.kernel.dk/linux-block
git bisect good 4221b807d1f73c03d22543416d303b60a5d1ef31
# bad: [19d62f6d00972f957c94aba0975c14490cfed385] block: remove bvec_iter_rewind()
git bisect bad 19d62f6d00972f957c94aba0975c14490cfed385
# bad: [e8cf978dffb2c603340d4615eec2e5358c9df06d] bcache: fix indentation issue, remove tabs on a hunk of code
git bisect bad e8cf978dffb2c603340d4615eec2e5358c9df06d
# bad: [058fdecc6de7cdecbf4c59b851e80eb2d6c5295f] block, bfq: fix in-service-queue check for queue merging
git bisect bad 058fdecc6de7cdecbf4c59b851e80eb2d6c5295f
# good: [05c2f5c30b3ca2346a5bb7c74b0c9515d8f4fbd2] block, bfq: split function bfq_better_to_idle
git bisect good 05c2f5c30b3ca2346a5bb7c74b0c9515d8f4fbd2
# bad: [9dee8b3b057e1da26f85f1842f2aaf3bb200fb94] block, bfq: fix queue removal from weights tree
git bisect bad 9dee8b3b057e1da26f85f1842f2aaf3bb200fb94
# good: [530c4cbb3c62f9e42dbf39279fb346f2d2ab4dbb] block, bfq: unconditionally plug I/O in asymmetric scenarios
git bisect good 530c4cbb3c62f9e42dbf39279fb346f2d2ab4dbb
# good: [d87447d84fe194b0e4f5413b5344dc82cc100711] block, bfq: fix sequential rq detection in rate estimation
git bisect good d87447d84fe194b0e4f5413b5344dc82cc100711
# first bad commit: [9dee8b3b057e1da26f85f1842f2aaf3bb200fb94] block, bfq: fix queue removal from weights tree

--MP_/pz9zHNmnBMlbpQTqwua7w1U--

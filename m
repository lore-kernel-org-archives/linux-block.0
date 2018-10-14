Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
In-Reply-To: <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
Date: Sun, 14 Oct 2018 14:32:13 +1100
Message-ID: <87d0sd19vm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Set PAGE_KERNEL directly in the caller and do not rely on a
> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>
> As already done for PPC64, use pgprot_cache() helpers instead of
> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Something in here is breaking my p5020ds (both 32-bit and 64-bit):

# first bad commit: [cb9220cc18345a2a1ec287752e576a2c88fa4a2b] powerpc/mm: properly set PAGE_KERNEL flags in ioremap()

64-bit:

  io scheduler mq-deadline registered
  io scheduler kyber registered
  pcieport 0000:00:00.0: AER enabled with IRQ 482
  pcieport 2000:00:00.0: AER enabled with IRQ 480
  Unable to handle kernel paging request for data at address 0x8000080080080000
  Faulting instruction address: 0xc0000000000152e4
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE SMP NR_CPUS=32 CoreNet Generic
  Modules linked in:
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc3-gcc-7.3.1-00135-gcb9220cc1834 #16
  NIP:  c0000000000152e4 LR: c0000000005173b8 CTR: 0000000000100000
  REGS: c0000000f30eb420 TRAP: 0300   Not tainted  (4.19.0-rc3-gcc-7.3.1-00135-gcb9220cc1834)
  MSR:  0000000080029000 <CE,EE,ME>  CR: 24000224  XER: 00000000
  DEAR: 8000080080080000 ESR: 0000000000800000 IRQMASK: 0 
  GPR00: c0000000005173a0 c0000000f30eb6a0 c000000000f86e00 8000080080080000 
  GPR04: 0000000000000000 0000000000400000 00000ffbff000004 0000000000000008 
  GPR08: 0000000000000000 0000000000100000 0000000000000000 0000000000000080 
  GPR12: 0000000084000422 c00000003ffff7c0 c00000000000263c 0000000000000000 
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR24: c000000000dbe0a0 c000000000d41bf8 8000080080080000 c0000000ffff89a8 
  GPR28: c0000000f3492400 c0000000f3492410 0000000000400000 c000000000ff0a18 
  NIP [c0000000000152e4] ._memset_io+0x6c/0x9c
  LR [c0000000005173b8] .fsl_qman_probe+0x188/0x918
  Call Trace:
  [c0000000f30eb6a0] [c0000000005173a0] .fsl_qman_probe+0x170/0x918 (unreliable)
  [c0000000f30eb740] [c0000000005797dc] .platform_drv_probe+0x58/0xac
  [c0000000f30eb7c0] [c0000000005772b0] .really_probe+0x2a8/0x380
  [c0000000f30eb860] [c0000000005776f0] .__driver_attach+0x138/0x13c
  [c0000000f30eb8f0] [c000000000574550] .bus_for_each_dev+0x9c/0x110
  [c0000000f30eb9a0] [c000000000576a18] .driver_attach+0x24/0x38
  [c0000000f30eba10] [c0000000005761ec] .bus_add_driver+0x16c/0x2ac
  [c0000000f30ebab0] [c000000000578194] .driver_register+0x88/0x178
  [c0000000f30ebb30] [c000000000579770] .__platform_driver_register+0x48/0x5c
  [c0000000f30ebba0] [c000000000d85744] .fsl_qman_driver_init+0x1c/0x30
  [c0000000f30ebc10] [c000000000002374] .do_one_initcall+0x70/0x258
  [c0000000f30ebcf0] [c000000000d4a244] .kernel_init_freeable+0x340/0x43c
  [c0000000f30ebdb0] [c000000000002658] .kernel_init+0x1c/0x130
  [c0000000f30ebe30] [c0000000000009e4] .ret_from_kernel_thread+0x58/0x74
  Instruction dump:
  4e800020 2ba50003 40dd003c 3925fffc 5488402e 7929f082 7d082378 39290001 
  550a801e 7d2903a6 7d4a4378 794a0020 <91430000> 38630004 4200fff8 70a50003 
  ---[ end trace 372a57fd67efb6fe ]---

32 bit:

  [    1.076133] pcieport 2000:02:00.0: AER enabled with IRQ 480
  [    1.082106] Unable to handle kernel paging request for data at address 0xf1100000
  [    1.089488] Faulting instruction address: 0xc0011c80
  [    1.094437] Oops: Kernel access of bad area, sig: 11 [#1]
  [    1.099816] BE SMP NR_CPUS=24 CoreNet Generic
  [    1.104157] Modules linked in:
  [    1.107197] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc3-gcc7x-g8f0c636b0542 #1
  [    1.115181] NIP:  c0011c80 LR: c058f970 CTR: 00100000
  [    1.120216] REGS: e8107c80 TRAP: 0300   Not tainted  (4.19.0-rc3-gcc7x-g8f0c636b0542)
  [    1.128026] MSR:  00029002 <CE,EE,ME>  CR: 24000284  XER: 00000000
  [    1.134190] DEAR: f1100000 ESR: 00800000 
  [    1.134190] GPR00: c058f958 e8107d30 e8108000 f1100000 00000000 00400000 e8107cd8 e8107d0c 
  [    1.134190] GPR08: 00000000 00100000 00000000 ff000000 24000282 00000000 c0003340 00000000 
  [    1.134190] GPR16: 00000000 00000000 00000000 00000000 c0d64410 c0edb34c c0ec6700 00000007 
  [    1.134190] GPR24: c0ef0000 f1100000 efffcab8 c0ef0000 e8231c00 e8231c10 0040003f c101d290 
  [    1.171519] NIP [c0011c80] _memset_io+0x90/0xd0
  [    1.176030] LR [c058f970] fsl_qman_probe+0x190/0x8c0
  [    1.180975] Call Trace:
  [    1.183410] [e8107d30] [c001f6c0] ioremap_prot+0x40/0x50 (unreliable)
  [    1.189830] [e8107d40] [c058f958] fsl_qman_probe+0x178/0x8c0
  [    1.195475] [e8107d70] [c0600894] platform_drv_probe+0x54/0xb0
  [    1.201287] [e8107d90] [c05fe15c] really_probe+0x28c/0x350
  [    1.206756] [e8107dc0] [c05fe73c] __driver_attach+0x12c/0x130
  [    1.212485] [e8107de0] [c05fb5a8] bus_for_each_dev+0x98/0x110
  [    1.218213] [e8107e10] [c05fd048] bus_add_driver+0x158/0x2b0
  [    1.223855] [e8107e40] [c05ff1c4] driver_register+0x94/0x180
  [    1.229498] [e8107e60] [c0002fc4] do_one_initcall+0x54/0x2d0
  [    1.235144] [e8107ed0] [c0d650e8] kernel_init_freeable+0x2e8/0x3bc
  [    1.241302] [e8107f20] [c0003364] kernel_init+0x24/0x130
  [    1.246599] [e8107f40] [c0015298] ret_from_kernel_thread+0x14/0x1c
  [    1.252758] Instruction dump:
  [    1.255711] 2b850003 40dd0040 5488402e 3925fffc 7d082378 5529f0be 550a801e 39290001 
  [    1.263435] 7d4a4378 7d2903a6 60000000 60000000 <91430000> 38630004 4200fff8 70a50003 
  [    1.271337] ---[ end trace f6eb249464967cf7 ]---
  [    1.275934] 
  [    2.277413] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
  [    2.286358] in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: swapper/0
  [    2.292956] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D           4.19.0-rc3-gcc7x-g8f0c636b0542 #1
  [    2.302328] Call Trace:
  [    2.304762] [e8107b80] [c0aa3774] dump_stack+0x88/0xc4 (unreliable)
  [    2.311011] [e8107ba0] [c0074e10] ___might_sleep+0xe0/0x130
  [    2.316567] [e8107bb0] [c0055410] exit_signals+0x50/0x2d0
  [    2.321949] [e8107bf0] [c00434dc] do_exit+0xcc/0xad0
  [    2.326897] [e8107c40] [c000ee98] die+0x228/0x390
  [    2.331582] [e8107c70] [c00153f4] handle_page_fault+0x34/0x38
  [    2.337311] --- interrupt: 300 at _memset_io+0x90/0xd0
  [    2.337311]     LR = fsl_qman_probe+0x190/0x8c0
  [    2.346945] [e8107d30] [c001f6c0] ioremap_prot+0x40/0x50 (unreliable)
  [    2.353368] [e8107d40] [c058f958] fsl_qman_probe+0x178/0x8c0
  [    2.359010] [e8107d70] [c0600894] platform_drv_probe+0x54/0xb0
  [    2.364825] [e8107d90] [c05fe15c] really_probe+0x28c/0x350
  [    2.370294] [e8107dc0] [c05fe73c] __driver_attach+0x12c/0x130
  [    2.376023] [e8107de0] [c05fb5a8] bus_for_each_dev+0x98/0x110
  [    2.381751] [e8107e10] [c05fd048] bus_add_driver+0x158/0x2b0
  [    2.387394] [e8107e40] [c05ff1c4] driver_register+0x94/0x180
  [    2.393035] [e8107e60] [c0002fc4] do_one_initcall+0x54/0x2d0
  [    2.398678] [e8107ed0] [c0d650e8] kernel_init_freeable+0x2e8/0x3bc
  [    2.404840] [e8107f20] [c0003364] kernel_init+0x24/0x130
  [    2.410135] [e8107f40] [c0015298] ret_from_kernel_thread+0x14/0x1c
  [    2.416312] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

cheers

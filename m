Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:33158 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbcELQlj (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 12 May 2016 12:41:39 -0400
Date: Thu, 12 May 2016 19:05:52 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: UBSAN: Undefined behaviour in block/blk-mq.c:1459:27 with pata_amd
Message-ID: <alpine.LRH.2.20.1605121902440.4797@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is form dual AthlonMP 32-bit x86 system with onboatrd AMD PATA 
controller:

[    0.550152] pata_amd 0000:00:07.1: version 0.4.1
[    0.550865] scsi host0: pata_amd
[    0.550966] ================================================================================
[    0.551124] UBSAN: Undefined behaviour in block/blk-mq.c:1459:27
[    0.551221] shift exponent 4294967295 is too large for 32-bit type 'unsigned int'
[    0.551380] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22
[    0.551536] Hardware name: Unknown Unknown/S2462 THUNDER K7, BIOS Guinness-8    04/07/2003
[    0.551695]  00000000 c134beac 00000046 f6461c28 00001000 c1381f8b f6461c1c 00000020
[    0.552053]  c1382516 c1700128 f6461c2c 00000020 c18d66c0 00000202 34393234 32373639
[    0.552409]  00003539 c11a4799 00000020 00000000 f668bc00 00000000 f668bdc8 000001c0
[    0.552766] Call Trace:
[    0.552868]  [<c134beac>] ? dump_stack+0x45/0x69
[    0.552965]  [<c1381f8b>] ? ubsan_epilogue+0xb/0x40
[    0.553060]  [<c1382516>] ? __ubsan_handle_shift_out_of_bounds+0xd6/0x120
[    0.553160]  [<c11a4799>] ? kmem_cache_alloc+0xc9/0x130
[    0.553258]  [<c132af00>] ? bt_alloc+0x60/0x160
[    0.553351]  [<c11a4400>] ? __kmalloc+0x130/0x1b0
[    0.553447]  [<c132b634>] ? blk_mq_init_tags+0x84/0x110
[    0.553549]  [<c132599e>] ? blk_mq_init_rq_map+0x6e/0x410
[    0.553647]  [<c1325c00>] ? blk_mq_init_rq_map+0x2d0/0x410
[    0.553747]  [<c142d44b>] ? dev_printk_emit+0x1b/0x20
[    0.553843]  [<c1325dbf>] ? blk_mq_alloc_tag_set+0x7f/0x290
[    0.553940]  [<c1325df3>] ? blk_mq_alloc_tag_set+0xb3/0x290
[    0.554039]  [<c145afbf>] ? scsi_add_host_with_dma+0x23f/0x3b0
[    0.554139]  [<c148f984>] ? ata_scsi_add_hosts+0xd4/0x200
[    0.554241]  [<c1487513>] ? ata_host_register+0x113/0x460
[    0.554338]  [<c135e634>] ? vscnprintf+0x14/0x40
[    0.554433]  [<c149146b>] ? ata_port_desc+0x6b/0xe0
[    0.554531]  [<c149bb6f>] ? ata_pci_sff_activate_host+0x8f/0x2e0
[    0.554629]  [<c149f140>] ? ata_bmdma_port_intr+0x180/0x180
[    0.554726]  [<c149ce8f>] ? ata_pci_init_one+0x14f/0x1c0
[    0.554824]  [<c1383637>] ? pci_bus_write_config_byte+0x57/0x90
[    0.554848]  [<c149cf50>] ? ata_pci_bmdma_init_one+0x20/0x30
[    0.554848]  [<c14a2fa5>] ? amd_init_one+0xc5/0x1e0
[    0.554848]  [<c1393d71>] ? pci_device_probe+0x91/0x130
[    0.554848]  [<c1431f48>] ? driver_probe_device+0xc8/0x330
[    0.554848]  [<c14321b0>] ? driver_probe_device+0x330/0x330
[    0.554848]  [<c14321b0>] ? driver_probe_device+0x330/0x330
[    0.554848]  [<c1432249>] ? __driver_attach+0x99/0xd0
[    0.554848]  [<c142fb3c>] ? bus_for_each_dev+0x4c/0x90
[    0.554848]  [<c143170a>] ? driver_attach+0x1a/0x40
[    0.554848]  [<c14321b0>] ? driver_probe_device+0x330/0x330
[    0.554848]  [<c1431107>] ? bus_add_driver+0x127/0x290
[    0.554848]  [<c1a73437>] ? ata_sff_init+0x26/0x26
[    0.554848]  [<c1432c67>] ? driver_register+0x67/0x120
[    0.554848]  [<c100042a>] ? do_one_initcall+0x8a/0x260
[    0.554848]  [<c1a73437>] ? ata_sff_init+0x26/0x26
[    0.554848]  [<c10962af>] ? parameq+0xf/0xb0
[    0.554848]  [<c1096555>] ? parse_args+0x205/0x510
[    0.554848]  [<c1a46dad>] ? kernel_init_freeable+0x153/0x25c
[    0.554848]  [<c1a46e2a>] ? kernel_init_freeable+0x1d0/0x25c
[    0.554848]  [<c1644f99>] ? kernel_init+0x9/0x120
[    0.554848]  [<c10a320b>] ? schedule_tail+0xb/0xa0
[    0.554848]  [<c164de09>] ? ret_from_kernel_thread+0x21/0x38
[    0.554848]  [<c1644f90>] ? rest_init+0x60/0x60
[    0.554848] ================================================================================

-- 
Meelis Roos (mroos@linux.ee)

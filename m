Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35462 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLBsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Apr 2018 21:48:45 -0400
Cc: shawn.lin@rock-chips.com
To: linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: System hung in I/O when booting with sd card
Message-ID: <3ba451a8-ac7b-429a-4a1b-703ea38136ce@rock-chips.com>
Date: Thu, 12 Apr 2018 09:48:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I ran into 2 times that my system hung here when booting with a ext4 sd
card. No sure how to reproduce it but it seems doesn't matter with the
ext4 as I see it again with a vfat sd card, this morning with Linus'
master branch. Is it a known issue or any idea how to debug this?


[  110.877652] Unable to handle kernel NULL pointer dereference at 
virtual address 000000c8
[  110.878360] Mem abort info:
[  110.878607]   ESR = 0x96000006
[  110.878876]   Exception class = DABT (current EL), IL = 32 bits
[  110.879391]   SET = 0, FnV = 0
[  110.879659]   EA = 0, S1PTW = 0
[  110.879957] Data abort info:
[  110.880210]   ISV = 0, ISS = 0x00000006
[  110.880545]   CM = 0, WnR = 0
[  110.880807] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000ed0ed92e
[  110.881382] [00000000000000c8] pgd=00000000f015e003, 
pud=00000000f0173003, pmd=0000000000000000
[  110.882143] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[  110.882629] Modules linked in:
[  110.882902] CPU: 4 PID: 1777 Comm: ls Not tainted 
4.16.0-next-20180410-00013-geabffa6-dirty #315
[  110.883665] Hardware name: Excavator-RK3399 Board (DT)
[  110.884114] pstate: 40000005 (nZcv daif -PAN -UAO)
[  110.884542] pc : percpu_counter_add_batch+0x2c/0x100
[  110.884977] lr : generic_make_request_checks+0x214/0x478
[  110.885440] sp : ffff00000c403960
[  110.885730] x29: ffff00000c403960 x28: ffff8000efcba6e0
[  110.886196] x27: ffff000008a81000 x26: ffff0000082643f8
[  110.886662] x25: ffff000008263828 x24: 0000000000003000
[  110.887127] x23: 0000000000001000 x22: 0000000000000000
[  110.887591] x21: 0000000000001000 x20: 00000000000000a8
[  110.888056] x19: ffff8000f0d7dc00 x18: 0000000000000001
[  110.888521] x17: 00000000004ab8a8 x16: ffff000008241628
[  110.888986] x15: 00000000ffffff80 x14: ffff7e0003bbaf80
[  110.889451] x13: 00000000000000c5 x12: ffff000009069b88
[  110.889916] x11: 0000000000000040 x10: ffff8000efc57dc0
[  110.890380] x9 : ffff8000efc57e90 x8 : ffff8000f0d3b138
[  110.890844] x7 : 0000000000000000 x6 : ffff8000f0d7dc88
[  110.891309] x5 : 0000000000000e56 x4 : 0000000000000001
[  110.891774] x3 : ffff8000f0cab800 x2 : 000000003fffffff
[  110.892239] x1 : 00008000edf30000 x0 : 00000000000000a8
[  110.892705] Process ls (pid: 1777, stack limit = 0x00000000b3fb6733)
[  110.893258] Call trace:
[  110.893475]  percpu_counter_add_batch+0x2c/0x100
[  110.893879]  generic_make_request_checks+0x214/0x478
[  110.894313]  generic_make_request+0x34/0x260
[  110.894686]  submit_bio+0xcc/0x1b0
[  110.894988]  ll_rw_block+0xc0/0x100
[  110.895295]  ext4_bread+0x74/0xc0
[  110.895587]  __ext4_read_dirblock+0x3c/0x2d8
[  110.895960]  htree_dirblock_to_tree+0x70/0x1d8
[  110.896349]  ext4_htree_fill_tree+0xa4/0x2c8
[  110.896723]  ext4_readdir+0x5f4/0x7f0
[  110.897046]  iterate_dir+0x9c/0x1a8
[  110.897351]  ksys_getdents64+0x8c/0x168
[  110.897687]  sys_getdents64+0xc/0x18
[  110.898001]  el0_svc_naked+0x30/0x34
[  110.898315] Code: b9401064 11000484 b9001064 d538d081 (f9401000)
[  110.898848] ---[ end trace 3b0d37baa3bb2fb3 ]---
[  110.899260] note: ls[1777] exited with preempt_count 1
[  110.899852] WARNING: CPU: 4 PID: 1777 at kernel/rcu/tree_plugin.h:330 
rcu_note_context_switch+0x30/0x3b8
[  110.900676] Modules linked in:
Se[gmentation fault  110.900947
[root@rockchip:/]# ] CPU: 4 PID: 1777 Comm: ls Tainted: G      D 
   4.16.0-next-20180410-00013-geabffa6-dirty #315
[  110.902121] Hardware name: Excavator-RK3399 Board (DT)
[  110.902570] pstate: 20000085 (nzCv daIf -PAN -UAO)
[  110.902990] pc : rcu_note_context_switch+0x30/0x3b8
[  110.903417] lr : rcu_note_context_switch+0x1c/0x3b8
[  110.903841] sp : ffff00000c403480
[  110.904132] x29: ffff00000c403480 x28: ffff00000c403820
[  110.904597] x27: 0000000000000000 x26: ffff8000f0cab800
[  110.905062] x25: ffff0000080fdaa8 x24: ffff000009069000
[  110.905527] x23: ffff000009042000 x22: ffff8000f0cab800
[  110.905992] x21: ffff8000f6f7ed00 x20: 0000000000000000
[  110.906456] x19: ffff8000f0cab800 x18: ffffffffffffffff
[  110.906921] x17: 00000000004ab8a8 x16: ffff000008241628
[  110.907386] x15: 0000000000000000 x14: 0000000000000400
[  110.907851] x13: ffff0000091b6200 x12: 0000000000000004
[  110.908316] x11: 00000019c85d4000 x10: 0000000000000400
[  110.908781] x9 : 0000000000000004 x8 : ffff8000f02e6a00
[  110.909246] x7 : ffff8000f6f7f760 x6 : 00000000090ba86f
[  110.909711] x5 : 0000000000000000 x4 : 0000000000000000
[  110.910176] x3 : 00008000edf30000 x2 : 0000000000000004
[  110.910641] x1 : ffff00000904fa98 x0 : 0000000000000001
[  110.911106] Call trace:
[  110.911322]  rcu_note_context_switch+0x30/0x3b8
[  110.911722]  __schedule+0x90/0x600
[  110.912022]  do_task_dead+0x40/0x48
[  110.912328]  do_exit+0x6c8/0x9b8
[  110.912613]  die+0x1cc/0x1f8
[  110.912868]  __do_kernel_fault+0xa4/0xf8
[  110.913212]  do_page_fault+0x1f0/0x428
[  110.913541]  do_translation_fault+0x5c/0x68
[  110.913908]  do_mem_abort+0x54/0xd8
[  110.914215]  el1_da+0x20/0x80
[  110.914476]  percpu_counter_add_batch+0x2c/0x100
[  110.914880]  generic_make_request_checks+0x214/0x478
[  110.915314]  generic_make_request+0x34/0x260
[  110.915687]  submit_bio+0xcc/0x1b0
[  110.915986]  ll_rw_block+0xc0/0x100
[  110.916292]  ext4_bread+0x74/0xc0
[  110.916583]  __ext4_read_dirblock+0x3c/0x2d8
[  110.916956]  htree_dirblock_to_tree+0x70/0x1d8
[  110.917345]  ext4_htree_fill_tree+0xa4/0x2c8
[  110.917719]  ext4_readdir+0x5f4/0x7f0
[  110.918041]  iterate_dir+0x9c/0x1a8
[  110.918346]  ksys_getdents64+0x8c/0x168
[  110.918684]  sys_getdents64+0xc/0x18
[  110.918997]  el0_svc_naked+0x30/0x34
[  110.919310] ---[ end trace 3b0d37baa3bb2fb4 ]---

...
	
[  131.887919] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  131.888427]  Tasks blocked on level-0 rcu_node (CPUs 0-5): P1777
[  131.888954]  (detected by 3, t=5252 jiffies, g=3, c=2, q=85)

...

[  194.907919] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  194.908425]  Tasks blocked on level-0 rcu_node (CPUs 0-5): P1777
[  194.908952]  (detected by 1, t=21007 jiffies, g=3, c=2, q=101)

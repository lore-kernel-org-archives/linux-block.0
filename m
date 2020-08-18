Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690DC433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFEC204EA
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRMGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:06:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgHRMGM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:12 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B172E9DB86231BCCAB7A;
        Tue, 18 Aug 2020 13:06:10 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 18 Aug
 2020 13:06:10 +0100
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
Message-ID: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
Date:   Tue, 18 Aug 2020 13:03:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.123]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi guys,

JFYI, While doing some testing on v5.9-rc1, I stumbled across this:

[  218.792457] 
==================================================================
[  218.799686] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
[  218.805248] Read of size 8 at addr ffff002a084d8a00 by task fio/1554
[  218.811589]
[  218.813074] CPU: 37 PID: 1554 Comm: fio Not tainted 
5.9.0-rc1-31278-g9689aa7be1cb-dirty #755
[  218.821499] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[  218.830012] Call trace:
[  218.832453]  dump_backtrace+0x0/0x2d0
[  218.836106]  show_stack+0x18/0x28
[  218.839412]  dump_stack+0xf4/0x168
[  218.842806]  print_address_description.constprop.12+0x6c/0x4ec
[  218.848628]  kasan_report+0x130/0x200
[  218.852279]  __asan_load8+0x9c/0xd8
[  218.855757]  bt_iter+0x80/0xf8
[  218.858801]  blk_mq_queue_tag_busy_iter+0x2dc/0x528
[  218.863670]  blk_mq_in_flight+0x80/0xb8
[  218.867496]  part_stat_show+0xd8/0x238
[  218.871237]  dev_attr_show+0x44/0x90
[  218.874804]  sysfs_kf_seq_show+0x128/0x1c0
[  218.878890]  kernfs_seq_show+0xa0/0xb8
[  218.882630]  seq_read+0x1c0/0x7d0
[  218.885935]  kernfs_fop_read+0x70/0x330
[  218.889762]  vfs_read+0xe4/0x250
[  218.892980]  ksys_read+0xc8/0x178
[  218.896285]  __arm64_sys_read+0x44/0x58
[  218.900112]  el0_svc_common.constprop.2+0xc4/0x1e8
[  218.904893]  do_el0_svc+0x90/0xa0
[  218.908198]  el0_sync_handler+0x150/0x1b8
[  218.912196]  el0_sync+0x158/0x180
[  218.915498]
[  218.916979] Allocated by task 1553:
[  218.920459]  kasan_save_stack+0x28/0x58
[  218.924284]  __kasan_kmalloc.isra.6+0xcc/0xf0
[  218.928630]  kasan_slab_alloc+0x18/0x28
[  218.932457]  slab_post_alloc_hook+0x64/0x2b8
[  218.936717]  kmem_cache_alloc+0x160/0x260
[  218.940719]  getname_flags+0x68/0x240
[  218.944371]  user_path_at_empty+0x30/0x68
[  218.948370]  vfs_statx+0xf8/0x200
[  218.951674]  __do_sys_newfstatat+0x84/0xd8
[  218.955760]  __arm64_sys_newfstatat+0x54/0x68
[  218.960107]  el0_svc_common.constprop.2+0xc4/0x1e8
[  218.964888]  do_el0_svc+0x90/0xa0
[  218.968192]  el0_sync_handler+0x150/0x1b8
[  218.972191]  el0_sync+0x158/0x180
[  218.975493]
[  218.976974] Freed by task 1553:
[  218.980104]  kasan_save_stack+0x28/0x58
[  218.983928]  kasan_set_track+0x28/0x40
[  218.987667]  kasan_set_free_info+0x24/0x48
[  218.991752]  __kasan_slab_free+0x104/0x188
[  218.995838]  kasan_slab_free+0x14/0x20
[  218.999577]  slab_free_freelist_hook+0x8c/0x190
[  219.004097]  kmem_cache_free+0x98/0x3e0
[  219.007923]  putname+0x8c/0xa8
[  219.010968]  filename_lookup.part.70+0x130/0x1e8
[  219.015575]  user_path_at_empty+0x50/0x68
[  219.019573]  vfs_statx+0xf8/0x200
[  219.022878]  __do_sys_newfstatat+0x84/0xd8
[  219.026963]  __arm64_sys_newfstatat+0x54/0x68
[  219.031310]  el0_svc_common.constprop.2+0xc4/0x1e8
[  219.036091]  do_el0_svc+0x90/0xa0
[  219.039396]  el0_sync_handler+0x150/0x1b8
[  219.043394]  el0_sync+0x158/0x180
[  219.046696]
[  219.048178] The buggy address belongs to the object at ffff002a084d8000
[  219.048178]  which belongs to the cache names_cache of size 4096
[  219.060771] The buggy address is located 2560 bytes inside of
[  219.060771]  4096-byte region [ffff002a084d8000, ffff002a084d9000)
[  219.072668] The buggy address belongs to the page:
[  219.077456] page:0000000099a7b02f refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x2a084d8
[  219.086924] head:0000000099a7b02f order:3 compound_mapcount:0 
compound_pincount:0
[  219.094396] flags: 0x2ffff00000010200(slab|head)
[  219.099006] raw: 2ffff00000010200 dead000000000100 dead000000000122 
ffff002a53180f00
[  219.106739] raw: 0000000000000000 0000000000070007 00000001ffffffff 
0000000000000000
[  219.114469] page dumped because: kasan: bad access detected
[  219.120028]
[  219.121507] Memory state around the buggy address:
[  219.126287]  ffff002a084d8900: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  219.133499]  ffff002a084d8980: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  219.140709] >ffff002a084d8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  219.147918]  ^
[  219.151135]  ffff002a084d8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  219.158347]  ffff002a084d8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  219.165555] 
==================================================================

Here's my steps to recreate (some may be redundant):

root@ubuntu:/sys/class/block/sda/queue# more scheduler
[mq-deadline] kyber bfq none
fio /home/john/sda.fio   # just run fio on sda
echo 400 > nr_requests
fio /home/john/sda.fio
echo 30 > nr_requests
fio /home/john/sda.fio
echo none > scheduler
fio /home/john/sda.fio [issue triggered here]

I assume that this is a block issue, I'll have a look when I can.

Cheers,
john

Some config options (in addition to KASAN):
john@htsatcamb-server:~/kernel-dev4$ more .config | grep BLK
CONFIG_BLK_CGROUP=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_MTD_BLKDEVS=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_BLK_DEV_UMEM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_DRBD=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=y
# CONFIG_BLK_DEV_RSXX is not set
# CONFIG_BLK_DEV_NVME is not set
CONFIG_BLK_DEV_SD=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_BLK_DEV_MD=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_PSTORE_BLK is not set

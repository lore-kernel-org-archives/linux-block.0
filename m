Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755285AbdLTOjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 09:39:23 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBKEYdN1062181
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:39:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eysjkgytj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:39:22 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Wed, 20 Dec 2017 09:34:21 -0500
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
 <1512144528.2520.2.camel@sandisk.com>
 <ea717cce-a083-1fef-362f-6c302b4434fa@linux.vnet.ibm.com>
 <1513201741.2413.7.camel@wdc.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 12:34:14 -0200
MIME-Version: 1.0
In-Reply-To: <1513201741.2413.7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9e15a909-8556-850a-aeeb-ad2f72f348bc@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 12/13/2017 07:49 PM, Bart Van Assche wrote:
> Would it be possible to repeat your test with the patch below applied on your
> kernel tree? This patch has just been posted on the dm-devel mailing list.

Sorry for the delay. I missed this.

Unfortunately the oops problem still happens on PATCH v2 and that patch
(actually, the version that ended up in v4.15-rc4 [1] by Mike Snitzer).

The problem does not happen with PATCH v3 (a.k.a. v1) -- i.e., v3 is OK.

Thanks!


Test-case w/ PATCH v3:
---

[root@guest ~]# uname -r
4.15.0-rc4.mingleiv3

[root@guest ~]# reboot
...
systemd-shutdown[1]: Detaching DM devices.
systemd-shutdown[1]: Detaching DM 253:2.
shutdown: 7 output lines suppressed due to ratelimiting
dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
XFS (dm-0): Unmounting Filesystem
dracut Warning: Unmounted /oldroot.
dracut: Disassembling device-mapper devices
Rebooting.
sd 0:0:0:0: [sda] Synchronizing SCSI cache
reboot: Restarting system


Test-case w/ PATCH v2:
---

[root@guest ~]# uname -r
4.15.0-rc4.mingleiv2

[root@guest ~]# reboot
...
systemd-shutdown[1]: Detaching DM devices.
systemd-shutdown[1]: Detaching DM 253:2.
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: vmx_crypto virtio_balloon ip_tables x_tables xfs 
libcrc32c virtio_net virtio_scsi crc32c_vpmsum virtio_pci virtio_ring 
virtio autofs4
CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 4.15.0-rc4.mingleiv2 #4
<...>
NIP [0000000000000000]           (null)
LR [c00000000057d0dc] __blk_run_queue+0x6c/0xb0
Call Trace:
[c0000001fb083970] [c0000001fb0839e0] 0xc0000001fb0839e0 (unreliable)
[c0000001fb0839a0] [c00000000057d6ec] blk_run_queue+0x4c/0x80
[c0000001fb0839d0] [c000000000592834] blk_freeze_queue_start+0xa4/0xb0
[c0000001fb083a00] [c00000000057deac] blk_set_queue_dying+0x6c/0x190
[c0000001fb083a30] [c0000000008a4b7c] __dm_destroy+0xac/0x300
[c0000001fb083ad0] [c0000000008b0244] dev_remove+0x154/0x1d0
[c0000001fb083b20] [c0000000008b0b70] ctl_ioctl+0x360/0x4f0
[c0000001fb083d10] [c0000000008b0d38] dm_ctl_ioctl+0x38/0x50
[c0000001fb083d50] [c0000000003867d8] do_vfs_ioctl+0xd8/0x8c0
[c0000001fb083df0] [c000000000387028] SyS_ioctl+0x68/0x100
[c0000001fb083e30] [c00000000000b760] system_call+0x58/0x6c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 0fceefbe4fc1cd29 ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.15&id=afc567a4977b2d798e05153dd131a3c8d4758c0c


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center

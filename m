Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751989AbdLAStk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 13:49:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1InOjx001414
        for <linux-block@vger.kernel.org>; Fri, 1 Dec 2017 13:49:39 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8wguwgg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2017 13:49:39 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 13:49:37 -0500
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
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 16:49:31 -0200
MIME-Version: 1.0
In-Reply-To: <1512144528.2520.2.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ea717cce-a083-1fef-362f-6c302b4434fa@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 12/01/2017 02:08 PM, Bart Van Assche wrote:
> The test chenxiang ran does not prove that there is anything wrong with v2.
> Maybe chenxiang hit the issue described inhttps://lkml.org/lkml/2017/9/5/381?

Unfortunately v2 has been found to exhibit another problem, an Oops in
the systemd shutdown path for device-mapper LVM volumes at least, when
calling 'q->request_fn(q)' if 'q->request_fn' is NULL.

I couldn't find a more synthetic test-case yet (say, dmsetup commands),
but the default LVM scheme in RHEL triggers it consistently.

Here are the tests with 4.15-rc1 +v2 (oops), +v1 (okay), clean (okay).

[root@guest ~]# dmsetup table
guest-swap: 0 8388608 linear 8:3 2048
guest-root: 0 104857600 linear 8:3 161458176
guest-home: 0 153067520 linear 8:3 8390656

[root@guest ~]# dmsetup ls -o blkdevname,ascii --tree
rhel_guest-swap <dm-1> (253:1)
  `- <sda3> (8:3)
rhel_guest-root <dm-0> (253:0)
  `- <sda3> (8:3)
rhel_guest-home <dm-2> (253:2)
  `- <sda3> (8:3)

[root@guest ~]# uname -r
4.15.0-rc1.mingleiv2

[root@guest ~]# reboot
<...>
systemd-shutdown[1]: Detaching DM devices.
systemd-shutdown[1]: Detaching DM 253:2.
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: vmx_crypto virtio_balloon ip_tables x_tables autofs4 
xfs libcrc32c virtio_net virtio_scsi crc32c_vpmsum virtio_pci 
virtio_ring virtio
CPU: 8 PID: 1 Comm: systemd-shutdow Not tainted 4.15.0-rc1.mingleiv2 #2
task: c0000001fb000000 task.stack: c0000001fb080000
NIP:  0000000000000000 LR: c00000000057c7fc CTR: 0000000000000000
REGS: c0000001fb0836f0 TRAP: 0400   Not tainted  (4.15.0-rc1.mingleiv2)
MSR:  8000000040009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22042422  XER: 00000000
CFAR: c0000000000087c0 SOFTE: 0
GPR00: c00000000057ce0c c0000001fb083970 c000000000f91000 c0000001ee070000
GPR04: 0000000000000001 0000000000000000 0000000000000000 0000000000000003
GPR08: 0000000000000001 0000000000000000 0000000000000001 0000000000000000
GPR12: 0000000000000000 c00000000fd42c00 00000001184eea18 0000000000000000
GPR16: 00000001184ee4b8 00000001184ee468 00000001184ee348 00000001184ee3c8
GPR20: 0000000000000001 00007fffcc925140 00007fffcc925030 0000000000000003
GPR24: 0000000000000000 c0000000008af550 c0000001ed4b5000 0000000000000000
GPR28: 0000000000000000 c0000001ee070000 0000000000000001 c0000001ee070000
NIP [0000000000000000]           (null)
LR [c00000000057c7fc] __blk_run_queue+0x6c/0xb0
Call Trace:
[c0000001fb083970] [c0000001fb0839e0] 0xc0000001fb0839e0 (unreliable)
[c0000001fb0839a0] [c00000000057ce0c] blk_run_queue+0x4c/0x80
[c0000001fb0839d0] [c000000000591f54] blk_freeze_queue_start+0xa4/0xb0
[c0000001fb083a00] [c00000000057d5cc] blk_set_queue_dying+0x6c/0x190
[c0000001fb083a30] [c0000000008a3fbc] __dm_destroy+0xac/0x300
[c0000001fb083ad0] [c0000000008af6a4] dev_remove+0x154/0x1d0
[c0000001fb083b20] [c0000000008affd0] ctl_ioctl+0x360/0x4f0
[c0000001fb083d10] [c0000000008b0198] dm_ctl_ioctl+0x38/0x50
[c0000001fb083d50] [c0000000003863b8] do_vfs_ioctl+0xd8/0x8c0
[c0000001fb083df0] [c000000000386c08] SyS_ioctl+0x68/0x100
[c0000001fb083e30] [c00000000000b760] system_call+0x58/0x6c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace e1710ec836e5526f ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Rebooting in 10 seconds..

<...>

[root@guest ~]# uname -r
4.15.0-rc1.mingleiv1

[root@guest ~]# reboot
<...>
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

<...>

[root@guest ~]# uname -r
4.15.0-rc1

[root@guest ~]# reboot
<...>
systemd-shutdown[1]: Detaching DM devices.
systemd-shutdown[1]: Detaching DM 253:2.
shutdown: 7 output lines suppressed due to ratelimiting
dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
XFS (dm-0): Unmounting Filesystem
dracut Warning: Unmounted /oldroot.
dracut: Disassembling device-mapper devices
Rebooting.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center

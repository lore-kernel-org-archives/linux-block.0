Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751032AbdLAPgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 10:36:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1FYWuq193041
        for <linux-block@vger.kernel.org>; Fri, 1 Dec 2017 10:36:23 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8mxmn29-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2017 10:36:22 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 08:36:21 -0700
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>, Linuxarm <linuxarm@huawei.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 13:36:13 -0200
MIME-Version: 1.0
In-Reply-To: <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming Lei,

On 11/29/2017 12:57 AM, chenxiang (M) wrote:
> I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA 
> disk, then disable the disk with sysfs interface
> (echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung. 
> But with v1 patch, it doesn't
> has this issue. Please have a check.

Indeed, with this particular test-case (thanks, chenxiang) the problem
can be recreated with PATCH v2 but _not_ with v1.

For reference, I'm including the tests with v2 in this e-mail.
The same tests have too been performed with v1, without blocked tasks.

Interestingly, physical disk pulls did not hit the problem either
on v1 or v2 (but it does not matter anymore) -- so v1 is the one.

That said, I have to withdraw my Tested-By tag from v2:

On 11/27/2017 10:15 AM, Mauricio Faria de Oliveira wrote:
 > Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Thanks.



# ls -ld 
/sys/class/sas_phy/phy-*/device/port/end_device*/target*/*/block/sd* 
 

...
drwxr-xr-x 8 root root 0 Dec  1 08:55 
/sys/class/sas_phy/phy-0:5/device/port/end_device-0:0/target0:0:0/0:0:0:0/block/sdg
...

# fio -name=test-sdg -filename=/dev/sdg -direct=1 -iodepth 1 -thread 
-rw=read -ioengine=psync -bs=4k -numjobs=64 -runtime=300 -group_reporting
test-sdg: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, 
iodepth=1 & 

... 

fio-2.16 

time     4360  cycles_start=233715732609 

Starting 64 threads
...

# echo 0 > /sys/class/sas_phy/phy-0:5/enable

...
fio: io_u error on file /dev/sdg: Input/output error: read 
offset=38236160, buflen=4096
fio: io_u error on file /dev/sdg: Input/output error: read 
offset=38236160, buflen=4096
fio: pid=4402, err=5/file:io_u.c:1712, func=io_u error, 
error=Input/output error
...
fio: pid=4383, err=5/file:io_u.c:1712, func=io_u error, 
error=Input/output error
fio: pid=4370, err=5/file:io_u.c:1712, func=io_u error, 
error=Input/output error
fio: pid=4394, err=5/file:io_u.c:1712, func=io_u error, 
error=Input/output error

test-sdg: (groupid=0, jobs=64): err= 5 (file:io_u.c:1712, func=io_u 
error, error=Input/output error): pid=4362: Fri Dec  1 09:02:38 2017 

...

# dmesg
...
[  434.880517] sd 0:0:0:0: [sdg] tag#1 FAILED Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  434.880519] sd 0:0:0:0: [sdg] tag#3 FAILED Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  434.880521] sd 0:0:0:0: [sdg] tag#4 FAILED Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  434.880524] sd 0:0:0:0: [sdg] tag#0 FAILED Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  434.880526] sd 0:0:0:0: [sdg] tag#2 FAILED Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
...
[  434.880637] sd 0:0:0:0: [sdg] tag#11 CDB: Read(10) 28 00 00 02 7d c0 
00 00 18 00
[  434.880775] sd 0:0:0:0: [sdg] Synchronizing SCSI cache 

[  434.880900] sd 0:0:0:0: [sdg] Synchronize Cache(10) failed: Result: 
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK 

[  617.732540] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
...
[  617.732815] Call Trace: 

[  617.732819] [c000000002eef270] [c00000000001c9a8] 
__switch_to+0x318/0x620 

[  617.732824] [c000000002eef2d0] [c000000000c55764] 
__schedule+0x354/0xaf0
[  617.732827] [c000000002eef3a0] [c000000000c56818] 
schedule_preempt_disabled+0x48/0xc0
[  617.732830] [c000000002eef3d0] [c000000000c58da4] 
__mutex_lock.isra.6+0x1b4/0x650
[  617.732834] [c000000002eef460] [c00000000061e9b0] 
blk_cleanup_queue+0x40/0x240
[  617.732839] [c000000002eef4a0] [d000000011930d94] 
sas_end_device_release+0x34/0x70 [scsi_transport_sas] 

[  617.732843] [c000000002eef4d0] [c0000000007f5640] 
device_release+0x60/0xf0
[  617.732846] [c000000002eef550] [c000000000c3eaec] 
kobject_put+0x1dc/0x360
[  617.732850] [c000000002eef5d0] [c0000000007f5bf4] 
put_device+0x34/0x50
[  617.732853] [c000000002eef600] [c000000000656f8c] 
bsg_request_fn+0x17c/0x210 

[  617.732856] [c000000002eef660] [c0000000006203ac] 
blk_run_queue+0x8c/0xf0
[  617.732859] [c000000002eef690] [c0000000006374a4] 
blk_freeze_queue_start+0xa4/0xb0
[  617.732862] [c000000002eef6c0] [c00000000061d190] 
blk_set_queue_dying+0x70/0x1b0
[  617.732865] [c000000002eef6f0] [c00000000061e9bc] 
blk_cleanup_queue+0x4c/0x240 

[  617.732869] [c000000002eef730] [d000000011930d94] 
sas_end_device_release+0x34/0x70 [scsi_transport_sas] 

[  617.732872] [c000000002eef760] [c0000000007f5640] 
device_release+0x60/0xf0 

[  617.732875] [c000000002eef7e0] [c000000000c3eaec] 
kobject_put+0x1dc/0x360 

[  617.732878] [c000000002eef860] [c0000000007f5bf4] 
put_device+0x34/0x50 

[  617.732882] [c000000002eef890] [d000000011935c60] 
sas_port_delete+0x180/0x310 [scsi_transport_sas] 

[  617.732889] [c000000002eef8f0] [d000000012d31918] 
mpt3sas_transport_port_remove+0x278/0x340 [mpt3sas] 

[  617.732895] [c000000002eef9a0] [d000000012d22470] 
_scsih_remove_device+0x200/0x440 [mpt3sas] 

[  617.732901] [c000000002eefa70] [d000000012d22a50] 
_scsih_device_remove_by_handle.part.23+0x110/0x290 [mpt3sas] 

[  617.732907] [c000000002eefac0] [d000000012d2abd4] 
_firmware_event_work+0x2334/0x2d90 [mpt3sas] 

[  617.732911] [c000000002eefc80] [c00000000015d5ec] 
process_one_work+0x1bc/0x5f0
[  617.732913] [c000000002eefd20] [c00000000016060c] 
worker_thread+0xac/0x6b0
[  617.732916] [c000000002eefdc0] [c00000000016a528] kthread+0x168/0x1b0
[  617.732920] [c000000002eefe30] [c00000000000b4e8] 
ret_from_kernel_thread+0x5c/0x74
...

# dmesg | grep blocked
[  617.732540] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[  740.612135] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[  863.482376] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[  986.357365] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1109.234520] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1232.112572] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1354.985545] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1477.856508] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1600.729815] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.
[ 1723.604766] INFO: task kworker/u320:3:3914 blocked for more than 120 
seconds.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center

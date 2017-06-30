Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:52104 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdF3OFc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 10:05:32 -0400
Subject: Re: LightNVM pblk: read/write of random kernel memory
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42c49a3a-447b-8a31-91b5-92264f196085@gmx.net>
 <BE9E3136-5D3F-44E7-ACE4-49FEC95B330A@cnexlabs.com>
 <7a0a2821-0007-7af0-7eb8-d58650123718@gmx.net>
 <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Message-ID: <1981dbb5-84e1-a970-703f-8e3837cbd000@gmx.net>
Date: Fri, 30 Jun 2017 16:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 28.06.2017 16:58, Javier Gonzalez wrote:
>> On 28 Jun 2017, at 16.33, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
>>
>> thanks for the pointer to the github reporting page.
>> I'll answer your questions here (to make then indexable by search
>> engines in case someone else stumbles upon this) and link to newly
>> created github issues for the various problems I encountered.
>>
> Ok. I answered each issue directly on the github. A couple og things
> inline though, for completion.
>
>> On 28.06.2017 13:07, Javier Gonzalez wrote:
>>> https://github.com/OpenChannelSSD
>>>
>>>> On 28 Jun 2017, at 01.30, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
>>>>
>>>> I'm currently having trouble with LightNVM pblk with kernel 4.12-rc7 on
>>>> Ubuntu 16.04.2 x86_64 in a Qemu VM using latest
>>>> https://github.com/OpenChannelSSD/qemu-nvme .
>>>>
>>>> Writing to the pblk device is only partially successful. I can see some
>>>> of the content which was written to the pblk device turn up in the
>>>> backing store file nvmebackingstore10G.nvme, but mostly the backing
>>>> store file contains random kernel memory from the VM. Reading back the
>>>> just written contents from the pblk device in the VM also yields random
>>>> kernel memory (or at least that's what I think that stuff is, i.e. lots
>>>> of strings present in various printk calls).
>>> Can you better define partially succesful?
>> Some of the contents written to the pblk device inside the vm end up
>> being written to the backing store, and some regions of the backing
>> store contain random kernel memory of the vm after a write. I am unable
>> to detect a pattern there, but random kernel memory should never be
>> written to disk in any case.
>>
>>
>>> Which workload are you
>>> running on top of the block device exposed by the pblk instance? Is it
>>> failing in any way?
>> I run fdisk on the instance to create a single partition with maximum
>> size, then
>> mkfs.ext4 /dev/mylightnvmdevice1
>> mount /dev/mylightnvmdevice1 /mnt
>> yes yes|head -n 4096 >/mnt/yes
>> umount /mnt
>>
>> Sometimes this results in an immediate hang during writing /mnt/yes,
>> sometimes it hangs on umount.
>> Filed as https://github.com/OpenChannelSSD/linux/issues/28
>>
>>
>> Inspecting the backing store sometimes yields the expected amount of
>> data written, sometimes parts of the backing store contain random vm
>> kernel memory. This random kernel memory can also be read from inside
>> the vm by hexdumping /dev/mylightnvmdevice .
>> Filed as https://github.com/OpenChannelSSD/linux/issues/30
>>
>>
>>>> qemu command line follows:
>>>> qemu-nvme.git/x86_64-softmmu/qemu-system-x86_64 -m 4096 -machine
>>>> q35,accel=kvm -vga qxl -spice port=5901,addr=127.0.0.1,disable-ticketing
>>>> -net nic,model=e1000 -net user -hda
>>>> /storage2/vmimages/usefulimages/ubuntu-16.04.2-server-kernel412rc6.qcow2
>>>> -drive
>>>> file=/storage2/vmimages/nvmebackingstore10G.nvme,if=none,id=mynvme
>>>> -device
>>>> nvme,drive=mynvme,serial=deadbeef,namespaces=1,lver=1,lmetasize=16,ll2pmode=0,nlbaf=5,lba_index=3,mdts=10,lnum_lun=1,
>>> As mentioned above, try several with several LUNs.
>>>
>>>> lnum_pln=2,lsec_size=4096,lsecs_per_pg=4,lpgs_per_blk=512,lbbtable=/storage2/vmimages/nvmebackingstore10G.bbtable,lmetadata=/storage2/vmimages/nvmebackingstore10G.meta,ldebug=1
>>>>
>>>> The backing store file was created with
>>>> truncate -s 10G /storage2/vmimages/nvmebackingstore10G.nvme
>>>>
>>>> This might either be a bug in the OpenChannelSSD qemu tree, or it might
>>>> be a kernel bug.
>>>>
>>>> I also got warnings like the below:
>>> In the 4.12 patches for pblk we do not have an error state machine. This
>>> is, when writes fail on the device (on qemu in this case), we did not
>>> communicate this to the application. This bad error handling results in
>>> unexpected side-errors like the one you are experiencing. On the patches
>>> for 4.13, we have implemented the error state machine, so this type of
>>> errors should be better handled.
>> Oh. Shouldn't a minimal version of those patches get merged into 4.12
>> (or 4.12-stable once 4.12 is released) to avoid releasing a kernel with
>> a data corruption bug?
> This is only in case the device fails, how we handle the error on the
> host. If the device is not accepting writes for some reason, data is
> lost anyway. So I don't think we need the fix for stable.
>
>
>>> You can pick up the code from out github (linux.git - branch:
>>> pblk.for-4.13) or take it directly form Jens' for-4.13/core

I can reproduce the hang in a few seconds just by writing 4096 MB to a
standard pblk device.
dd if=/dev/zero bs=1M count=4096 of=/dev/mypblkdevice
See also https://github.com/OpenChannelSSD/linux/issues/32

I can reproduce even with OpenChannelSSD linux.git branch pblk.for-4.13_v2 .

Any idea what to do next?

If it's really a qemu problem, does anyone have a working qemu command
line in combination with a way to create a backing store file which
works, and can you share that?

Regards,
Carl-Daniel

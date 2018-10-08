Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:46324 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJHNH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Oct 2018 09:07:58 -0400
Subject: Re: nvme-pci: number of queues off by one
To: Prasun Ratn <prasun.ratn@gmail.com>, ming.lei@redhat.com
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
 <20180312090827.GB23903@ming.t460p>
 <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
Cc: keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
        tglx@linutronix.de
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9c851b95-1c41-2171-40ec-bd47032401fc@oracle.com>
Date: Mon, 8 Oct 2018 13:59:05 +0800
MIME-Version: 1.0
In-Reply-To: <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I can reproduce with qemu:

# ls /sys/block/nvme*n1/mq/*/cpu_list
/sys/block/nvme0n1/mq/0/cpu_list
/sys/block/nvme0n1/mq/1/cpu_list
/sys/block/nvme0n1/mq/2/cpu_list
/sys/block/nvme0n1/mq/3/cpu_list
/sys/block/nvme0n1/mq/4/cpu_list
/sys/block/nvme0n1/mq/5/cpu_list
/sys/block/nvme0n1/mq/6/cpu_list

Here is the qemu cmdline emulating 8-queue nvme while the VM has 12 cpu:

# qemu-system-x86_64 -m 4096 -smp 12 \
	-kernel /path-to-kernel/linux-4.18.10/arch/x86_64/boot/bzImage \
	-hda /path-to-img/ubuntu1804.qcow2  \
	-append "root=/dev/sda1 init=/sbin/init text" -enable-kvm \
	-net nic -net user,hostfwd=tcp::5022-:22 \
	-device nvme,drive=nvme1,serial=deadbeaf1,num_queues=8 \
	-drive file=/path-to-img/nvme.disk,if=none,id=nvme1

Dongli Zhang


On 10/08/2018 01:05 PM, Prasun Ratn wrote:
> Hi
> 
> I have an NVMe SSD that has 8 hw queues and on older kernels I see all
> 8 show up. However on a recent kernel (I tried 4.18), I only see 7. Is
> this a known issue?
> 
> $ uname -r
> 4.14.1-1.el7.elrepo.x86_64
> 
> $ ls /sys/block/nvme*n1/mq/*/cpu_list
> /sys/block/nvme0n1/mq/0/cpu_list
> /sys/block/nvme0n1/mq/1/cpu_list
> /sys/block/nvme0n1/mq/2/cpu_list
> /sys/block/nvme0n1/mq/3/cpu_list
> /sys/block/nvme0n1/mq/4/cpu_list
> /sys/block/nvme0n1/mq/5/cpu_list
> /sys/block/nvme0n1/mq/6/cpu_list
> /sys/block/nvme0n1/mq/7/cpu_list
> /sys/block/nvme1n1/mq/0/cpu_list
> /sys/block/nvme1n1/mq/1/cpu_list
> /sys/block/nvme1n1/mq/2/cpu_list
> /sys/block/nvme1n1/mq/3/cpu_list
> /sys/block/nvme1n1/mq/4/cpu_list
> /sys/block/nvme1n1/mq/5/cpu_list
> /sys/block/nvme1n1/mq/6/cpu_list
> /sys/block/nvme1n1/mq/7/cpu_list
> /sys/block/nvme2n1/mq/0/cpu_list
> /sys/block/nvme2n1/mq/1/cpu_list
> /sys/block/nvme2n1/mq/2/cpu_list
> /sys/block/nvme2n1/mq/3/cpu_list
> /sys/block/nvme2n1/mq/4/cpu_list
> /sys/block/nvme2n1/mq/5/cpu_list
> /sys/block/nvme2n1/mq/6/cpu_list
> /sys/block/nvme2n1/mq/7/cpu_list
> /sys/block/nvme3n1/mq/0/cpu_list
> /sys/block/nvme3n1/mq/1/cpu_list
> /sys/block/nvme3n1/mq/2/cpu_list
> /sys/block/nvme3n1/mq/3/cpu_list
> /sys/block/nvme3n1/mq/4/cpu_list
> /sys/block/nvme3n1/mq/5/cpu_list
> /sys/block/nvme3n1/mq/6/cpu_list
> /sys/block/nvme3n1/mq/7/cpu_list
> 
> 
> $ uname -r
> 4.18.10-1.el7.elrepo.x86_64
> 
> $ ls /sys/block/nvme*n1/mq/*/cpu_list
> /sys/block/nvme0n1/mq/0/cpu_list
> /sys/block/nvme0n1/mq/1/cpu_list
> /sys/block/nvme0n1/mq/2/cpu_list
> /sys/block/nvme0n1/mq/3/cpu_list
> /sys/block/nvme0n1/mq/4/cpu_list
> /sys/block/nvme0n1/mq/5/cpu_list
> /sys/block/nvme0n1/mq/6/cpu_list
> /sys/block/nvme1n1/mq/0/cpu_list
> /sys/block/nvme1n1/mq/1/cpu_list
> /sys/block/nvme1n1/mq/2/cpu_list
> /sys/block/nvme1n1/mq/3/cpu_list
> /sys/block/nvme1n1/mq/4/cpu_list
> /sys/block/nvme1n1/mq/5/cpu_list
> /sys/block/nvme1n1/mq/6/cpu_list
> /sys/block/nvme2n1/mq/0/cpu_list
> /sys/block/nvme2n1/mq/1/cpu_list
> /sys/block/nvme2n1/mq/2/cpu_list
> /sys/block/nvme2n1/mq/3/cpu_list
> /sys/block/nvme2n1/mq/4/cpu_list
> /sys/block/nvme2n1/mq/5/cpu_list
> /sys/block/nvme2n1/mq/6/cpu_list
> /sys/block/nvme3n1/mq/0/cpu_list
> /sys/block/nvme3n1/mq/1/cpu_list
> /sys/block/nvme3n1/mq/2/cpu_list
> /sys/block/nvme3n1/mq/3/cpu_list
> /sys/block/nvme3n1/mq/4/cpu_list
> /sys/block/nvme3n1/mq/5/cpu_list
> /sys/block/nvme3n1/mq/6/cpu_list
> 

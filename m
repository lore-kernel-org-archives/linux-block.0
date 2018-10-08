Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbeJHWHq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Oct 2018 18:07:46 -0400
Date: Mon, 8 Oct 2018 08:54:33 -0600
From: Keith Busch <keith.busch@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Prasun Ratn <prasun.ratn@gmail.com>, ming.lei@redhat.com,
        jianchao.w.wang@oracle.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        linux-block@vger.kernel.org, tglx@linutronix.de
Subject: Re: nvme-pci: number of queues off by one
Message-ID: <20181008145433.GC24716@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
 <20180312090827.GB23903@ming.t460p>
 <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
 <9c851b95-1c41-2171-40ec-bd47032401fc@oracle.com>
 <847ccf73-9fb8-0507-b68e-99960530468a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <847ccf73-9fb8-0507-b68e-99960530468a@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 08, 2018 at 02:58:21PM +0800, Dongli Zhang wrote:
> I got the same result when emulating nvme with qemu: the VM has 12 cpu, while
> the num_queues of nvme is 8.
> 
> # uname -r
> 4.14.1
> # ll /sys/block/nvme*n1/mq/*/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/0/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/1/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/2/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/3/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/4/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/5/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:30 /sys/block/nvme0n1/mq/6/cpu_list
> 
> 
> # uname -r
> 4.18.10
> # ll /sys/block/nvme*n1/mq/*/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/0/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/1/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/2/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/3/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/4/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/5/cpu_list
> -r--r--r-- 1 root root 4096 Oct  8 14:34 /sys/block/nvme0n1/mq/6/cpu_list
> 
> From below qemu source code, when n->num_queues is 8, the handler of
> NVME_FEAT_NUM_QUEUES returns 0x60006.
> 
>  719 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  720 {
>  721     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>  722     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>  723
>  724     switch (dw10) {
>  725     case NVME_VOLATILE_WRITE_CACHE:
>  726         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>  727         break;
>  728     case NVME_NUMBER_OF_QUEUES:
>  729         trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
>  730                                 ((dw11 >> 16) & 0xFFFF) + 1,
>  731                                 n->num_queues - 1, n->num_queues - 1);
>  732         req->cqe.result =
>  733             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
> ----> returns 0x60006 when num_queues is 8.
> 
> 
> Finally, nr_io_queues is set to 6+1=7 in nvme_set_queue_count() in VM kernel.
> 
> I do not know how to paraphrase this in the world of nvme.
> 
> Dongli Zhang
> 
> On 10/08/2018 01:59 PM, Dongli Zhang wrote:
> > I can reproduce with qemu:
> > 
> > # ls /sys/block/nvme*n1/mq/*/cpu_list
> > /sys/block/nvme0n1/mq/0/cpu_list
> > /sys/block/nvme0n1/mq/1/cpu_list
> > /sys/block/nvme0n1/mq/2/cpu_list
> > /sys/block/nvme0n1/mq/3/cpu_list
> > /sys/block/nvme0n1/mq/4/cpu_list
> > /sys/block/nvme0n1/mq/5/cpu_list
> > /sys/block/nvme0n1/mq/6/cpu_list
> > 
> > Here is the qemu cmdline emulating 8-queue nvme while the VM has 12 cpu:
> > 
> > # qemu-system-x86_64 -m 4096 -smp 12 \
> > 	-kernel /path-to-kernel/linux-4.18.10/arch/x86_64/boot/bzImage \
> > 	-hda /path-to-img/ubuntu1804.qcow2  \
> > 	-append "root=/dev/sda1 init=/sbin/init text" -enable-kvm \
> > 	-net nic -net user,hostfwd=tcp::5022-:22 \
> > 	-device nvme,drive=nvme1,serial=deadbeaf1,num_queues=8 \
> > 	-drive file=/path-to-img/nvme.disk,if=none,id=nvme1
> > 
> > Dongli Zhang

Qemu counts one of those queues as the admin queue.

> > On 10/08/2018 01:05 PM, Prasun Ratn wrote:
> >> Hi
> >>
> >> I have an NVMe SSD that has 8 hw queues and on older kernels I see all
> >> 8 show up. However on a recent kernel (I tried 4.18), I only see 7. Is
> >> this a known issue?

That probably means you only have 8 MSI-x vectors, one of which is
reserved for the admin queue. We used to share an IO vector with the
admin queue, however some people figured out you can break your controller
that way with the linux irq spread.

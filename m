Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRa3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Oct 2018 13:30:29 -0400
Date: Mon, 8 Oct 2018 18:19:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Prasun Ratn <prasun.ratn@gmail.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        jianchao.w.wang@oracle.com, tglx@linutronix.de, hch@lst.de
Subject: Re: nvme-pci: number of queues off by one
Message-ID: <20181008101919.GB10966@ming.t460p>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
 <20180312090827.GB23903@ming.t460p>
 <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
 <9c851b95-1c41-2171-40ec-bd47032401fc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c851b95-1c41-2171-40ec-bd47032401fc@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 08, 2018 at 01:59:05PM +0800, Dongli Zhang wrote:
> I can reproduce with qemu:
> 
> # ls /sys/block/nvme*n1/mq/*/cpu_list
> /sys/block/nvme0n1/mq/0/cpu_list
> /sys/block/nvme0n1/mq/1/cpu_list
> /sys/block/nvme0n1/mq/2/cpu_list
> /sys/block/nvme0n1/mq/3/cpu_list
> /sys/block/nvme0n1/mq/4/cpu_list
> /sys/block/nvme0n1/mq/5/cpu_list
> /sys/block/nvme0n1/mq/6/cpu_list
> 
> Here is the qemu cmdline emulating 8-queue nvme while the VM has 12 cpu:
> 
> # qemu-system-x86_64 -m 4096 -smp 12 \
> 	-kernel /path-to-kernel/linux-4.18.10/arch/x86_64/boot/bzImage \
> 	-hda /path-to-img/ubuntu1804.qcow2  \
> 	-append "root=/dev/sda1 init=/sbin/init text" -enable-kvm \
> 	-net nic -net user,hostfwd=tcp::5022-:22 \
> 	-device nvme,drive=nvme1,serial=deadbeaf1,num_queues=8 \
> 	-drive file=/path-to-img/nvme.disk,if=none,id=nvme1

This 'issue' can be reproduced on v4.14 too.

Thanks,
Ming

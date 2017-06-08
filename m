Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Jun 2017 10:28:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] blk-mq: create hctx for each present CPU
Message-ID: <20170608022819.GB5602@ming.t460p>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-8-hch@lst.de>
 <20170607091038.GA25572@ming.t460p>
 <20170607190659.GA32550@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607190659.GA32550@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 07, 2017 at 09:06:59PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 07, 2017 at 05:10:46PM +0800, Ming Lei wrote:
> > One thing not sure is that we may need to handle new CPU hotplug
> > after initialization. Without the CPU hotplug handler, system may
> > not scale well when more CPUs are added to sockets.
> 
> Adding physical CPUs to sockets is a very rare activity, and we
> should not optimize for it.  Taking CPUs that are physically present
> offline and online is the case that is interesting, and that's what
> this patchset changes.

Yeah, I understand. It depends if there are real use cases in which
system can't be rebooted, but sometimes CPUs need to be added or removed
for some reasons. Looks CONFIG_HOTPLUG_CPU addresses this requirement,

>From searching on google, looks there are some for virtualization,
and both Qemu and Vmware support that.

> 
> > Another thing is that I don't see how NVMe handles this situation,
> > blk_mq_update_nr_hw_queues() is called in nvme_reset_work(), so
> > that means RESET need to be triggered after new CPUs are added to
> > system?
> 
> Yes.

Unfortunately I don't see the Reset comes when new CPU cores becomes
online.

> 
> > I have tried to add new CPUs runtime on Qemu, and not see
> > new hw queues are added no matter this patchset is applied or not.
> 
> Do you even see the CPUs in your VM?  For physical hotplug you'll
> need to reserve spots in the cpumap beforehand.

Yes, I can add the new CPUs in console of Qemu, and these CPUs become
present first in VM, then switched online via command line after the hotplug,
but number of hw queues doesn't change.

Please see the following log:

root@ming:/sys/kernel/debug/block# echo "before adding one CPU"
before adding one CPU
root@ming:/sys/kernel/debug/block#
root@ming:/sys/kernel/debug/block# lscpu | head -n 10
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             2
NUMA node(s):          1
Vendor ID:             GenuineIntel
root@ming:/sys/kernel/debug/block# ls nvme0n1/
hctx0  hctx1  hctx2  hctx3  poll_stat  requeue_list  state
root@ming:/sys/kernel/debug/block#
root@ming:/sys/kernel/debug/block# echo "one CPU will be added"
one CPU will be added
root@ming:/sys/kernel/debug/block#
device: 'cpu4': device_add
bus: 'cpu': add device cpu4
PM: Adding info for cpu:cpu4
CPU4 has been hot-added
bus: 'cpu': driver_probe_device: matched device cpu4 with driver processor
bus: 'cpu': really_probe: probing driver processor with device cpu4
processor cpu4: no default pinctrl state
devices_kset: Moving cpu4 to end of list
driver: 'processor': driver_bound: bound to device 'cpu4'
bus: 'cpu': really_probe: bound device cpu4 to driver processor

root@ming:/sys/kernel/debug/block# echo 1 > /sys/devices/system/cpu/cpu4/online
smpboot: Booting Node 0 Processor 4 APIC 0x4/sys/devices/system/cpu/cpu4/online
kvm-clock: cpu 4, msr 2:7ff5e101, secondary cpu clock
TSC ADJUST compensate: CPU4 observed 349440008297 warp. Adjust: 2147483647
TSC ADJUST compensate: CPU4 observed 347292524597 warp. Adjust: 2147483647
TSC synchronization [CPU#1 -> CPU#4]:
Measured 347292524561 cycles TSC warp between CPUs, turning off TSC clock.
tsc: Marking TSC unstable due to check_tsc_sync_source failed
KVM setup async PF for cpu 4
kvm-stealtime: cpu 4, msr 27fd0d900
Will online and init hotplugged CPU: 4
device: 'cooling_device4': device_add
PM: Adding info for No Bus:cooling_device4
device: 'cache': device_add
PM: Adding info for No Bus:cache
device: 'index0': device_add
PM: Adding info for No Bus:index0
device: 'index1': device_add
PM: Adding info for No Bus:index1
device: 'index2': device_add
PM: Adding info for No Bus:index2
device: 'index3': device_add
PM: Adding info for No Bus:index3
device: 'machinecheck4': device_add
bus: 'machinecheck': add device machinecheck4
PM: Adding info for machinecheck:machinecheck4
root@ming:/sys/kernel/debug/block# lscpu | head -n 10
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                5
On-line CPU(s) list:   0-4
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             3
NUMA node(s):          1
Vendor ID:             GenuineIntel
root@ming:/sys/kernel/debug/block# ls nvme0n1/
hctx0  hctx1  hctx2  hctx3  poll_stat  requeue_list  state


Thanks,
Ming

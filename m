Return-Path: <ming.lei@redhat.com>
Date: Fri, 6 Apr 2018 17:13:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180406091257.GA9605@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <20180308105358.1506-5-ming.lei@redhat.com>
 <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de>
 <20180403160001.GA25255@ming.t460p>
 <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
 <20180404150759.GA24824@ming.t460p>
 <alpine.DEB.2.21.1804042027130.1492@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1804042027130.1492@nanos.tec.linutronix.de>
List-ID: <linux-block@vger.kernel.org>

Hi Thomas,

On Wed, Apr 04, 2018 at 09:38:26PM +0200, Thomas Gleixner wrote:
> On Wed, 4 Apr 2018, Ming Lei wrote:
> > On Wed, Apr 04, 2018 at 10:25:16AM +0200, Thomas Gleixner wrote:
> > > In the example above:
> > > 
> > > > > > 	irq 39, cpu list 0,4
> > > > > > 	irq 40, cpu list 1,6
> > > > > > 	irq 41, cpu list 2,5
> > > > > > 	irq 42, cpu list 3,7
> > > 
> > > and assumed that at driver init time only CPU 0-3 are online then the
> > > hotplug of CPU 4-7 will not result in any interrupt delivered to CPU 4-7.
> > 
> > Indeed, and I just tested this case, and found that no interrupts are
> > delivered to CPU 4-7.
> > 
> > In theory, the affinity has been assigned to these irq vectors, and
> > programmed to interrupt controller, I understand it should work.
> > 
> > Could you explain it a bit why interrupts aren't delivered to CPU 4-7?
> 
> As I explained before:
> 
> "If the device is already in use when the offline CPUs get hot plugged, then
>  the interrupts still stay on cpu 0-3 because the effective affinity of
>  interrupts on X86 (and other architectures) is always a single CPU."
> 
> IOW. If you set the affinity mask so it contains more than one CPU then the
> kernel selects a single CPU as target. The selected CPU must be online and
> if there is more than one online CPU in the mask then the kernel picks the
> one which has the least number of interrupts targeted at it. This selected
> CPU target is programmed into the corresponding interrupt chip
> (IOAPIC/MSI/MSIX....) and it stays that way until the selected target CPU
> goes offline or the affinity mask changes.
> 
> The reasons why we use single target delivery on X86 are:
> 
>    1) Not all X86 systems support multi target delivery
> 
>    2) If a system supports multi target delivery then the interrupt is
>       preferrably delivered to the CPU with the lowest APIC ID (which
>       usually corresponds to the lowest CPU number) due to hardware magic
>       and only a very small percentage of interrupts are delivered to the
>       other CPUs in the multi target set. So the benefit is rather dubious
>       and extensive performance testing did not show any significant
>       difference.
> 
>    3) The management of multi targets on the software side is painful as
>       the same low level vector number has to be allocated on all possible
>       target CPUs. That's making a lot of things including hotplug more
>       complex for very little - if at all - benefit.
> 
> So at some point we ripped out the multi target support on X86 and moved
> everything to single target delivery mode.
> 
> Other architectures never supported multi target delivery either due to
> hardware restrictions or for similar reasons why X86 dropped it. There
> might be a few architectures which support it, but I have no overview at
> the moment.
> 
> The information is in procfs
> 
> # cat /proc/irq/9/smp_affinity_list 
> 0-3
> # cat /proc/irq/9/effective_affinity_list 
> 1
> 
> # cat /proc/irq/10/smp_affinity_list 
> 0-3
> # cat /proc/irq/10/effective_affinity_list 
> 2
> 
> smp_affinity[_list] is the affinity which is set either by the kernel or by
> writing to /proc/irq/$N/smp_affinity[_list]
> 
> effective_affinity[_list] is the affinity which is effective, i.e. the
> single target CPU to which the interrupt is affine at this point.
> 
> As you can see in the above examples the target CPU is selected from the
> given possible target set and the internal spreading of the low level x86
> vector allocation code picks a CPU which has the lowest number of
> interrupts targeted at it.
> 
> Let's assume for the example below
> 
> # cat /proc/irq/10/smp_affinity_list 
> 0-3
> # cat /proc/irq/10/effective_affinity_list 
> 2
> 
> that CPU 3 was offline when the device was initialized. So there was no way
> to select it and when CPU 3 comes online there is no reason to change the
> affinity of that interrupt, at least not from the kernel POV. Actually we
> don't even have a mechanism to do so automagically.
> 
> If I offline CPU 2 after onlining CPU 3 then the kernel has to move the
> interrupt away from CPU 2, so it selects CPU 3 as it's the one with the
> lowest number of interrupts targeted at it.
> 
> Now this is a bit different if you use affinity managed interrupts like
> NVME and other devices do.
> 
> Many of these devices create one queue per possible CPU, so the spreading
> is simple; One interrupt per possible cpu. Pretty boring.
> 
> When the device has less queues than possible CPUs, then stuff gets more
> interesting. The queues and therefore the interrupts must be targeted at
> multiple CPUs. There is some logic which spreads them over the numa nodes
> and takes siblings into account when Hyperthreading is enabled.
> 
> In both cases the managed interrupts are handled over CPU soft
> hotplug/unplug:
> 
>   1) If a CPU is soft unplugged and an interrupt is targeted at the CPU
>      then the interrupt is either moved to a still online CPU in the
>      affinity mask or if the outgoing CPU is the last one in the affinity
>      mask it is shut down.
> 
>   2) If a CPU is soft plugged then the interrupts are scanned and the ones
>      which are managed and shutdown checked whether the affinity mask
>      contains the upcoming CPU. If that's the case then the interrupt is
>      started up and can deliver interrupts for the corresponding queue.
> 
>      If an interupt is managed and already started, then nothing happens
>      and the effective affinity is untouched even if the upcoming CPU is in
>      the affinity set.
> 
> Lets briefly talk about the 3 cpu masks:
> 
>   1) cpus_possible_mask:
> 
>      The CPUs which are possible on a system.
> 
>   2) cpus_present_mask:
> 
>      The CPUs which are present on a system. Present means phsyically
>      present. Physical hotplug sets or removes CPUs from that mask,
> 
>      "Physical" hotplug is used in virtualization as well.
> 
>   3) cpus_online_mask:
> 
>      The CPUs which are soft onlined. If a present CPU is not soft onlined
>      then its cleared in the online mask, but still set in the present
>      mask.

Great thanks for your so detailed explanation.

> 
> Now back to my suggestion in the other end of this thread, that we should
> use cpus_present_mask instead of cpus_online_mask.
> 
> The reason why I suggested this is that we have to differentiate between
> soft plugging and phsycial plugging of CPUs.
> 
> If CPUs are in the present mask, i.e. phsyically available, but not in the
> online mask, then it's trivial to plug them soft by writing to the
> corresponding online file in sysfs. CPU soft plugging is used for power
> management nowadays, so the scenario I described in the other mail is not
> completely unrealistic.

OK, got it, and this scenario can be emulated easily by offlining CPU
before loading device driver.

I will post V4 soon by using cpu_present_mask in the 1st stage irq spread.
And it should work fine for Kashyap's case in normal cases.

It might not work fine when there are lots of offline CPUs before device
initialization, in which less active irq vectors will be assigned. But
given driver is usually loaded during kernel booting, at that time generally
all CPUs are online, so looks it shouldn't be one issue to consider.

> 
> In case of physical hotplug it's a different story. Neither the kernel nor
> user space can plug a CPU phsyically. It needs interaction by the operator,
> i.e. in the real world by inserting/removing hardware or in the
> virtualization space by changing the current CPU allocation. So here the
> present mask wont help when the number of queues is less than the number of
> possible CPUs and an initially not present CPU gets 'physically' plugged
> in.
> 
> To make things worse we have the unfortunate case of qualiteee BIOS/ACPI
> tables which claim that there are more possible CPUs than present CPUs on
> systems which cannot support phsyical hotplug due to lack of hardware
> support. Unfortunately there is no simple way to figure out whether a
> system supports physical hotplug or not, so we cannot make an informed
> decision here. But we can look at the present mask which tells us how many
> CPUs are physically available. In a regular boot up the present mask and
> the online mask are identical, so there is no difference.
> 
> For the physical hotplug case - real or virtual - neither of the spreading
> algorithms is ideal. Solving this needs more thought as it would require to
> recalculate the spreading once the physically plugged CPUs become
> available/online.

I agree, that may be an another improvement in this field.

> 
> Hope that clarifies the internals.

Sure, it does, thanks again for your clarification!

Thanks,
Ming

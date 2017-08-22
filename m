Return-Path: <jhugo@codeaurora.org>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
To: Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 pprakash@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <rcochran@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Weinberger <richard@nod.at>
References: <20170327181711.GF3637@linux.vnet.ibm.com>
 <20170620234623.GA16200@linux.vnet.ibm.com>
 <df080eec-62b8-7d19-c201-e1a44febb96d@codeaurora.org>
 <20170621161853.GB3721@linux.vnet.ibm.com>
 <20170623033456.GA15959@linux.vnet.ibm.com>
 <c367a3a4-6fac-957a-5a5e-ac4a68bc4648@codeaurora.org>
 <20170628001130.GB3721@linux.vnet.ibm.com>
 <d64c9d16-3b91-2081-0633-7f6a5196fd45@codeaurora.org>
 <20170630001855.GL2393@linux.vnet.ibm.com>
 <ec57e246-8b16-5db3-45d7-527627fb964c@codeaurora.org>
 <20170820205658.GS11320@linux.vnet.ibm.com>
 <a0627c12-3406-5e13-8346-649bd8e27edf@redhat.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <ea73b38d-d4c4-a7f4-bf49-f4e24f899b25@codeaurora.org>
Date: Tue, 22 Aug 2017 14:53:55 -0600
MIME-Version: 1.0
In-Reply-To: <a0627c12-3406-5e13-8346-649bd8e27edf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 8/22/2017 10:12 AM, Paolo Bonzini wrote:
> On 20/08/2017 22:56, Paul E. McKenney wrote:
>>>        KVM: async_pf: avoid async pf injection when in guest mode
>>>        KVM: cpuid: Fix read/write out-of-bounds vulnerability in cpuid emulation
>>>        arm: KVM: Allow unaligned accesses at HYP
>>>        arm64: KVM: Allow unaligned accesses at EL2
>>>        arm64: KVM: Preserve RES1 bits in SCTLR_EL2
>>>        KVM: arm/arm64: Handle possible NULL stage2 pud when ageing pages
>>>        KVM: nVMX: Fix exception injection
>>>        kvm: async_pf: fix rcu_irq_enter() with irqs enabled
>>>        KVM: arm/arm64: vgic-v3: Fix nr_pre_bits bitfield extraction
>>>        KVM: s390: fix ais handling vs cpu model
>>>        KVM: arm/arm64: Fix isues with GICv2 on GICv3 migration
>>>
>>> Nothing really stands out to me which would "fix" the issue.
>>
>> My guess would be an undo of the change that provoked the problem
>> in the first place.  Did you try bisecting within the above group
>> of commits?
>>
>> Either way, CCing Paolo for his thoughts?
> 
> There is "kvm: async_pf: fix rcu_irq_enter() with irqs enabled", but it
> would have caused splats, not deadlocks.
> 
> If you are using nested virtualization, "KVM: async_pf: avoid async pf
> injection when in guest mode" can be a wildcard, but only if you have
> memory pressure.
> 
> My bet is still on the former changing the timing just a little bit.
> 
> Paolo
> 

I'm sorry, I must have done the bisect incorrectly.

I attempted to bisect the KVM changes from the merge, but was seeing 
that the issue didn't repro with any of them.  I double checked the 
merge commit, and found it did not introduce a "fix".

I redid the bisect, and it identified the following change this time.  I 
double checked that reverting the change reintroduces the deadlock, and 
cherry-picking the change onto 4.12-rc4 (known to exhibit the issue) 
causes the issue to disappear.  I'm pretty sure (knock on wood) that the 
bisect result is actually correct this time.

commit 6460495709aeb651896bc8e5c134b2e4ca7d34a8
Author: James Wang <jnwang@suse.com>
Date:   Thu Jun 8 14:52:51 2017 +0800

     Fix loop device flush before configure v3

     While installing SLES-12 (based on v4.4), I found that the installer
     will stall for 60+ seconds during LVM disk scan.  The root cause was
     determined to be the removal of a bound device check in loop_flush()
     by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").

     Restoring this check, examining ->lo_state as set by loop_set_fd()
     eliminates the bad behavior.

     Test method:
     modprobe loop max_loop=64
     dd if=/dev/zero of=disk bs=512 count=200K
     for((i=0;i<4;i++))do losetup -f disk; done
     mkfs.ext4 -F /dev/loop0
     for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
     for f in `ls /dev/loop[0-9]*|sort`; do \
         echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
         done

     Test output:  stock          patched
     /dev/loop0    18.1217e-05    8.3842e-05
     /dev/loop1     6.1114e-05    0.000147979
     /dev/loop10    0.414701      0.000116564
     /dev/loop11    0.7474        6.7942e-05
     /dev/loop12    0.747986      8.9082e-05
     /dev/loop13    0.746532      7.4799e-05
     /dev/loop14    0.480041      9.3926e-05
     /dev/loop15    1.26453       7.2522e-05

     Note that from loop10 onward, the device is not mounted, yet the
     stock kernel consumes several orders of magnitude more wall time
     than it does for a mounted device.
     (Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

     Reviewed-by: Hannes Reinecke <hare@suse.com>
     Reviewed-by: Ming Lei <ming.lei@redhat.com>
     Signed-off-by: James Wang <jnwang@suse.com>
     Fixes: b5dd2f6047ca ("block: loop: improve performance via blk-mq")
     Signed-off-by: Jens Axboe <axboe@fb.com>

Considering the original analysis of the issue, it seems plausible that 
this change could be fixing it.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

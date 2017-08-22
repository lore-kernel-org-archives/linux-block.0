Return-Path: <pbonzini@redhat.com>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
To: paulmck@linux.vnet.ibm.com, Jeffrey Hugo <jhugo@codeaurora.org>
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0627c12-3406-5e13-8346-649bd8e27edf@redhat.com>
Date: Tue, 22 Aug 2017 18:12:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170820205658.GS11320@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 20/08/2017 22:56, Paul E. McKenney wrote:
>>       KVM: async_pf: avoid async pf injection when in guest mode
>>       KVM: cpuid: Fix read/write out-of-bounds vulnerability in cpuid emulation
>>       arm: KVM: Allow unaligned accesses at HYP
>>       arm64: KVM: Allow unaligned accesses at EL2
>>       arm64: KVM: Preserve RES1 bits in SCTLR_EL2
>>       KVM: arm/arm64: Handle possible NULL stage2 pud when ageing pages
>>       KVM: nVMX: Fix exception injection
>>       kvm: async_pf: fix rcu_irq_enter() with irqs enabled
>>       KVM: arm/arm64: vgic-v3: Fix nr_pre_bits bitfield extraction
>>       KVM: s390: fix ais handling vs cpu model
>>       KVM: arm/arm64: Fix isues with GICv2 on GICv3 migration
>>
>> Nothing really stands out to me which would "fix" the issue.
>
> My guess would be an undo of the change that provoked the problem
> in the first place.  Did you try bisecting within the above group
> of commits?
> 
> Either way, CCing Paolo for his thoughts?

There is "kvm: async_pf: fix rcu_irq_enter() with irqs enabled", but it
would have caused splats, not deadlocks.

If you are using nested virtualization, "KVM: async_pf: avoid async pf
injection when in guest mode" can be a wildcard, but only if you have
memory pressure.

My bet is still on the former changing the timing just a little bit.

Paolo

Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 22 Aug 2017 09:54:37 -0700
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Message-ID: <20170822165437.GG491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821144832.GE491396@devbig577.frc2.facebook.com>
 <87r2w4bcq2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2w4bcq2.fsf@concordia.ellerman.id.au>
List-ID: <linux-block@vger.kernel.org>

Hello, Michael.

On Tue, Aug 22, 2017 at 11:41:41AM +1000, Michael Ellerman wrote:
> > This is something powerpc needs to fix.
> 
> There is no way for us to fix it.

I don't think that's true.  The CPU id used in kernel doesn't have to
match the physical one and arch code should be able to pre-map CPU IDs
to nodes and use the matching one when hotplugging CPUs.  I'm not
saying that's the best way to solve the problem tho.  It could be that
the best way forward is making cpu <-> node mapping dynamic and
properly synchronized.  However, please note that that does mean we
mess up node affinity for things like per-cpu memory which are
allocated before the cpu comes up, so there's some inherent benefits
to keeping the mapping static even if that involves indirection.

> > Workqueue isn't the only one making this assumption. mm as a whole
> > assumes that CPU <-> node mapping is stable regardless of hotplug
> > events.
> 
> At least in this case I don't think the mapping changes, it's just we
> don't know the mapping at boot.
> 
> Currently we have to report possible but not present CPUs as belonging
> to node 0, because otherwise we trip this helpful piece of code:
> 
> 	for_each_possible_cpu(cpu) {
> 		node = cpu_to_node(cpu);
> 		if (WARN_ON(node == NUMA_NO_NODE)) {
> 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> 			/* happens iff arch is bonkers, let's just proceed */
> 			return;
> 		}
> 
> But if we remove that, we could then accurately report NUMA_NO_NODE at
> boot, and then update the mapping when the CPU is hotplugged.

If you think that making this dynamic is the right way to go, I have
no objection but we should be doing this properly instead of patching
up what seems to be crashing right now.  What synchronization and
notification mechanisms do we need to make cpu <-> node mapping
dynamic?  Do we need any synchronization in memory allocation paths?
If not, why would it be safe?

Thanks.

-- 
tejun

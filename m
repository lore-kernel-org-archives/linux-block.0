Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 23 Aug 2017 06:26:42 -0700
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Message-ID: <20170823132642.GH491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821144832.GE491396@devbig577.frc2.facebook.com>
 <87r2w4bcq2.fsf@concordia.ellerman.id.au>
 <20170822165437.GG491396@devbig577.frc2.facebook.com>
 <87lgmay2eg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgmay2eg.fsf@concordia.ellerman.id.au>
List-ID: <linux-block@vger.kernel.org>

Hello, Michael.

On Wed, Aug 23, 2017 at 09:00:39PM +1000, Michael Ellerman wrote:
> > I don't think that's true.  The CPU id used in kernel doesn't have to
> > match the physical one and arch code should be able to pre-map CPU IDs
> > to nodes and use the matching one when hotplugging CPUs.  I'm not
> > saying that's the best way to solve the problem tho.
> 
> We already virtualise the CPU numbers, but not the node IDs. And it's
> the node IDs that are really the problem.

Yeah, it just needs to match up new cpus to the cpu ids assigned to
the right node.

> > It could be that the best way forward is making cpu <-> node mapping
> > dynamic and properly synchronized.
> 
> We don't need it to be dynamic (at least for this bug).

The node mapping for that cpu id changes *dynamically* while the
system is running and that can race with node-affinity sensitive
operations such as memory allocations.

> Laurent is booting Qemu with a fixed CPU <-> Node mapping, it's just
> that because some CPUs aren't present at boot we don't know what the
> node mapping is. (Correct me if I'm wrong Laurent).
> 
> So all we need is:
>  - the workqueue code to cope with CPUs that are possible but not online
>    having NUMA_NO_NODE to begin with.
>  - a way to update the workqueue cpumask when the CPU comes online.
> 
> Which seems reasonable to me?

Please take a step back and think through the problem again.  You
can't bandaid it this way.

Thanks.

-- 
tejun

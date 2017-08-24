Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 24 Aug 2017 06:51:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Message-ID: <20170824135122.GM491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821144832.GE491396@devbig577.frc2.facebook.com>
 <87r2w4bcq2.fsf@concordia.ellerman.id.au>
 <20170822165437.GG491396@devbig577.frc2.facebook.com>
 <87lgmay2eg.fsf@concordia.ellerman.id.au>
 <20170823132642.GH491396@devbig577.frc2.facebook.com>
 <6ab4f6f1-b42f-a5fe-4974-0996baa86502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ab4f6f1-b42f-a5fe-4974-0996baa86502@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Laurent.

On Thu, Aug 24, 2017 at 02:10:31PM +0200, Laurent Vivier wrote:
> > Yeah, it just needs to match up new cpus to the cpu ids assigned to
> > the right node.
> 
> We are not able to assign the cpu ids to the right node before the CPU
> is present, because firmware doesn't provide CPU mapping <-> node id
> before that.

What I meant was to assign the matching CPU ID when the CPU becomes
present - ie. have CPU IDs available for different nodes and allocate
them to the new CPU according to its node mapping when it actually
comes up.  Please note that I'm not saying this is the way to go, just
that it is a solvable problem from the arch code.

> > The node mapping for that cpu id changes *dynamically* while the
> > system is running and that can race with node-affinity sensitive
> > operations such as memory allocations.
> 
> Memory is mapped to the node through its own firmware entry, so I don't
> think cpu id change can affect memory affinity, and before we know the
> node id of the CPU, the CPU is not present and thus it can't use memory.

The latter part isn't true.  For example, percpu memory gets alloacted
for all possible CPUs according to their node affinity, so the memory
node association change which happens when the CPU comes up for the
first time can race against such allocations.  I don't know whether
that's actually problematic but we don't have *any* synchronization
around it.  If you think it's safe to have such races, please explain
why that is.

> > Please take a step back and think through the problem again.  You
> > can't bandaid it this way.
> 
> Could you give some ideas, proposals?
> As the firmware doesn't provide the information before the CPU is really
> plugged, I really don't know how to manage this problem.

There are two possible approaches, I think.

1. Make physical cpu -> logical cpu mapping indirect so that the
   kernel's cpu ID assignment is always on the right numa node.  This
   may mean that the kernel might have to keep more possible CPUs
   around than necessary but it does have the benefit that all memory
   allocations are affine to the right node.

2. Make cpu <-> node mapping properly dynamic.  Identify what sort of
   synchronization we'd need around the mapping changing dynamically.
   Note that we might not need much but it'll most likely need some.
   Build synchronization and notification infrastructure around it.

Thanks.

-- 
tejun

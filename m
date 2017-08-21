Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 21 Aug 2017 07:48:33 -0700
From: Tejun Heo <tj@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Message-ID: <20170821144832.GE491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821134951.18848-1-lvivier@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 21, 2017 at 03:49:50PM +0200, Laurent Vivier wrote:
> In wq_numa_init() a list of NUMA nodes with their list of possible CPUs
> is built.
> 
> Unfortunately, on powerpc, the Firmware is only able to provide the
> node of a CPU if the CPU is present. So, in our case (possible CPU)
> CPU ids are known, but as the CPU is not present, the node id is
> unknown and all the unplugged CPUs are attached to node 0.

This is something powerpc needs to fix.  Workqueue isn't the only one
making this assumption.  mm as a whole assumes that CPU <-> node
mapping is stable regardless of hotplug events.  Powerpc people know
about the issue and AFAIK are working on it.

Thanks.

-- 
tejun

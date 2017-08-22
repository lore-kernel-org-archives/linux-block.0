Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:33163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754252AbdHVBln (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 21:41:43 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>, Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
In-Reply-To: <20170821144832.GE491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com> <20170821144832.GE491396@devbig577.frc2.facebook.com>
Date: Tue, 22 Aug 2017 11:41:41 +1000
Message-ID: <87r2w4bcq2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> On Mon, Aug 21, 2017 at 03:49:50PM +0200, Laurent Vivier wrote:
>> In wq_numa_init() a list of NUMA nodes with their list of possible CPUs
>> is built.
>> 
>> Unfortunately, on powerpc, the Firmware is only able to provide the
>> node of a CPU if the CPU is present. So, in our case (possible CPU)
>> CPU ids are known, but as the CPU is not present, the node id is
>> unknown and all the unplugged CPUs are attached to node 0.
>
> This is something powerpc needs to fix.

There is no way for us to fix it.

At boot, for possible but not present CPUs, we have no way of knowing
the CPU <-> node mapping, firmware simply doesn't tell us.

> Workqueue isn't the only one making this assumption. mm as a whole
> assumes that CPU <-> node mapping is stable regardless of hotplug
> events.

At least in this case I don't think the mapping changes, it's just we
don't know the mapping at boot.

Currently we have to report possible but not present CPUs as belonging
to node 0, because otherwise we trip this helpful piece of code:

	for_each_possible_cpu(cpu) {
		node = cpu_to_node(cpu);
		if (WARN_ON(node == NUMA_NO_NODE)) {
			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
			/* happens iff arch is bonkers, let's just proceed */
			return;
		}

But if we remove that, we could then accurately report NUMA_NO_NODE at
boot, and then update the mapping when the CPU is hotplugged.

cheers

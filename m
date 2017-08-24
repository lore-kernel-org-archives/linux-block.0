Return-Path: <lvivier@redhat.com>
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
To: Tejun Heo <tj@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821144832.GE491396@devbig577.frc2.facebook.com>
 <87r2w4bcq2.fsf@concordia.ellerman.id.au>
 <20170822165437.GG491396@devbig577.frc2.facebook.com>
 <87lgmay2eg.fsf@concordia.ellerman.id.au>
 <20170823132642.GH491396@devbig577.frc2.facebook.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6ab4f6f1-b42f-a5fe-4974-0996baa86502@redhat.com>
Date: Thu, 24 Aug 2017 14:10:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170823132642.GH491396@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 23/08/2017 15:26, Tejun Heo wrote:
> Hello, Michael.
> 
> On Wed, Aug 23, 2017 at 09:00:39PM +1000, Michael Ellerman wrote:
>>> I don't think that's true.  The CPU id used in kernel doesn't have to
>>> match the physical one and arch code should be able to pre-map CPU IDs
>>> to nodes and use the matching one when hotplugging CPUs.  I'm not
>>> saying that's the best way to solve the problem tho.
>>
>> We already virtualise the CPU numbers, but not the node IDs. And it's
>> the node IDs that are really the problem.
> 
> Yeah, it just needs to match up new cpus to the cpu ids assigned to
> the right node.

We are not able to assign the cpu ids to the right node before the CPU
is present, because firmware doesn't provide CPU mapping <-> node id
before that.

>>> It could be that the best way forward is making cpu <-> node mapping
>>> dynamic and properly synchronized.
>>
>> We don't need it to be dynamic (at least for this bug).
> 
> The node mapping for that cpu id changes *dynamically* while the
> system is running and that can race with node-affinity sensitive
> operations such as memory allocations.

Memory is mapped to the node through its own firmware entry, so I don't
think cpu id change can affect memory affinity, and before we know the
node id of the CPU, the CPU is not present and thus it can't use memory.

>> Laurent is booting Qemu with a fixed CPU <-> Node mapping, it's just
>> that because some CPUs aren't present at boot we don't know what the
>> node mapping is. (Correct me if I'm wrong Laurent).
>>
>> So all we need is:
>>  - the workqueue code to cope with CPUs that are possible but not online
>>    having NUMA_NO_NODE to begin with.
>>  - a way to update the workqueue cpumask when the CPU comes online.
>>
>> Which seems reasonable to me?
> 
> Please take a step back and think through the problem again.  You
> can't bandaid it this way.

Could you give some ideas, proposals?
As the firmware doesn't provide the information before the CPU is really
plugged, I really don't know how to manage this problem.

Thanks,
Laurent

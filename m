Return-Path: <lvivier@redhat.com>
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
To: Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821144832.GE491396@devbig577.frc2.facebook.com>
 <87r2w4bcq2.fsf@concordia.ellerman.id.au>
 <20170822165437.GG491396@devbig577.frc2.facebook.com>
 <87lgmay2eg.fsf@concordia.ellerman.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <08f458b8-d54f-a9f4-b434-a1267da668f4@redhat.com>
Date: Wed, 23 Aug 2017 13:17:38 +0200
MIME-Version: 1.0
In-Reply-To: <87lgmay2eg.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 23/08/2017 13:00, Michael Ellerman wrote:
> Hi Tejun,
> 
> Tejun Heo <tj@kernel.org> writes:
>> Hello, Michael.
>>
>> On Tue, Aug 22, 2017 at 11:41:41AM +1000, Michael Ellerman wrote:
>>>> This is something powerpc needs to fix.
>>>
>>> There is no way for us to fix it.
>>
>> I don't think that's true.  The CPU id used in kernel doesn't have to
>> match the physical one and arch code should be able to pre-map CPU IDs
>> to nodes and use the matching one when hotplugging CPUs.  I'm not
>> saying that's the best way to solve the problem tho.
> 
> We already virtualise the CPU numbers, but not the node IDs. And it's
> the node IDs that are really the problem.
> 
> So yeah I guess we might be able to make that work, but I'd have to
> think about it a bit more.
> 
>> It could be that the best way forward is making cpu <-> node mapping
>> dynamic and properly synchronized.
> 
> We don't need it to be dynamic (at least for this bug).
> 
> Laurent is booting Qemu with a fixed CPU <-> Node mapping, it's just
> that because some CPUs aren't present at boot we don't know what the
> node mapping is. (Correct me if I'm wrong Laurent).

You're correct.

Qemu is started with:

    -numa node,cpus=0-1 -numa node,cpus=2-3 \
    -smp 2,maxcpus=4,cores=4,threads=1,sockets=1

Which means we have 2 nodes with cpu ids 0 and 1 on node 0, and cpu ids
2 and 3 on node 1, but at boot only 2 CPUs are present.

The problem I try to fix with this series is when we hotplug a third
CPU, to node 1 with id 2.

Thanks,
Laurent

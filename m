Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:33101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753813AbdHWLAo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 07:00:44 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
In-Reply-To: <20170822165437.GG491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com> <20170821144832.GE491396@devbig577.frc2.facebook.com> <87r2w4bcq2.fsf@concordia.ellerman.id.au> <20170822165437.GG491396@devbig577.frc2.facebook.com>
Date: Wed, 23 Aug 2017 21:00:39 +1000
Message-ID: <87lgmay2eg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

Tejun Heo <tj@kernel.org> writes:
> Hello, Michael.
>
> On Tue, Aug 22, 2017 at 11:41:41AM +1000, Michael Ellerman wrote:
>> > This is something powerpc needs to fix.
>> 
>> There is no way for us to fix it.
>
> I don't think that's true.  The CPU id used in kernel doesn't have to
> match the physical one and arch code should be able to pre-map CPU IDs
> to nodes and use the matching one when hotplugging CPUs.  I'm not
> saying that's the best way to solve the problem tho.

We already virtualise the CPU numbers, but not the node IDs. And it's
the node IDs that are really the problem.

So yeah I guess we might be able to make that work, but I'd have to
think about it a bit more.

> It could be that the best way forward is making cpu <-> node mapping
> dynamic and properly synchronized.

We don't need it to be dynamic (at least for this bug).

Laurent is booting Qemu with a fixed CPU <-> Node mapping, it's just
that because some CPUs aren't present at boot we don't know what the
node mapping is. (Correct me if I'm wrong Laurent).

So all we need is:
 - the workqueue code to cope with CPUs that are possible but not online
   having NUMA_NO_NODE to begin with.
 - a way to update the workqueue cpumask when the CPU comes online.


Which seems reasonable to me?

cheers

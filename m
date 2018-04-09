Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757451AbeDICrm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Apr 2018 22:47:42 -0400
Date: Mon, 9 Apr 2018 10:47:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-nvme@lists.infradead.org
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
Message-ID: <20180409024722.GC26619@ming.t460p>
References: <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p>
 <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
 <20180408110417.GA19252@ming.t460p>
 <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
 <20180408125735.GA23106@ming.t460p>
 <f5b97687-b8e6-d1f7-1588-0cfa0883f92d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <f5b97687-b8e6-d1f7-1588-0cfa0883f92d@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Apr 08, 2018 at 04:35:59PM +0300, Sagi Grimberg wrote:
> 
> 
> On 04/08/2018 03:57 PM, Ming Lei wrote:
> > On Sun, Apr 08, 2018 at 02:53:03PM +0300, Sagi Grimberg wrote:
> > > 
> > > > > > > > > Hi Sagi
> > > > > > > > > 
> > > > > > > > > Still can reproduce this issue with the change:
> > > > > > > > 
> > > > > > > > Thanks for validating Yi,
> > > > > > > > 
> > > > > > > > Would it be possible to test the following:
> > > > > > > > --
> > > > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > > > index 75336848f7a7..81ced3096433 100644
> > > > > > > > --- a/block/blk-mq.c
> > > > > > > > +++ b/block/blk-mq.c
> > > > > > > > @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct
> > > > > > > > request_queue *q,
> > > > > > > >                    return ERR_PTR(-EXDEV);
> > > > > > > >            }
> > > > > > > >            cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> > > > > > > > +       if (cpu >= nr_cpu_ids) {
> > > > > > > > +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
> > > > > > > > +               cpu = cpumask_first(alloc_data.hctx->cpumask);
> > > > > > > > +       }
> > > > > > > >            alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> > > > > > > > 
> > > > > > > >            rq = blk_mq_get_request(q, NULL, op, &alloc_data);
> > > > > > > > --
> > > > > > > > ...
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > [� 153.384977] BUG: unable to handle kernel paging request at
> > > > > > > > > 00003a9ed053bd48
> > > > > > > > > [� 153.393197] IP: blk_mq_get_request+0x23e/0x390
> > > > > > > > 
> > > > > > > > Also would it be possible to provide gdb output of:
> > > > > > > > 
> > > > > > > > l *(blk_mq_get_request+0x23e)
> > > > > > > 
> > > > > > > nvmf_connect_io_queue() is used in this way by asking blk-mq to allocate
> > > > > > > request from one specific hw queue, but there may not be all online CPUs
> > > > > > > mapped to this hw queue.
> > > > > 
> > > > > Yes, this is what I suspect..
> > > > > 
> > > > > > And the following patchset may fail this kind of allocation and avoid
> > > > > > the kernel oops.
> > > > > > 
> > > > > > 	https://marc.info/?l=linux-block&m=152318091025252&w=2
> > > > > 
> > > > > Thanks Ming,
> > > > > 
> > > > > But I don't want to fail the allocation, nvmf_connect_io_queue simply
> > > > > needs a tag to issue the connect request, I much rather to take this
> > > > > tag from an online cpu than failing it... We use this because we reserve
> > > > 
> > > > The failure is only triggered when there isn't any online CPU mapped to
> > > > this hctx, so do you want to wait for CPUs for this hctx becoming online?
> > > 
> > > I was thinking of allocating a tag from that hctx even if it had no
> > > online cpu, the execution is done on an online cpu (hence the call
> > > to blk_mq_alloc_request_hctx).
> > 
> > That can be done, but not following the current blk-mq's rule, because
> > blk-mq requires to dispatch the request on CPUs mapping to this hctx.
> > 
> > Could you explain a bit why you want to do in this way?
> 
> My device exposes nr_hw_queues which is not higher than num_online_cpus
> so I want to connect all hctxs with hope that they will be used.

The issue is that CPU online & offline can happen any time, and after
blk-mq removes CPU hotplug handler, there is no way to remap queue
when CPU topo is changed.

For example:

1) after nr_hw_queues is set as num_online_cpus() and hw queues
are initialized, then some of CPUs become offline, and the issue
reported by Zhang Yi is triggered, but in this case, we should fail
the allocation since 1:1 mapping doesn't need to use this inactive
hw queue.

2) when nr_hw_queues is set as num_online_cpus(), there may be
much less online CPUs, so the hw queue number can be initialized as
much smaller, then performance is degraded much even if some CPUs
become online later.

So the current policy is to map all possible CPUs for handing CPU
hotplug, and if you want to get 1:1 mapping between hw queue and
online CPU, the nr_hw_queues can be set as num_possible_cpus.

Please see commit 16ccfff28976130 (nvme: pci: pass max vectors as
num_possible_cpus() to pci_alloc_irq_vectors).

It will waste some memory resource just like percpu variable, but it
simplifies the queue mapping logic a lot, and can support both hard
and soft CPU online/offline without CPU hotplug handler, which may
cause very complicated queue dependency issue.

> 
> I agree we don't want to connect hctx which doesn't have an online
> cpu, that's redundant, but this is not the case here.

OK, I will explain below, and it can be fixed by the following patch too:

https://marc.info/?l=linux-block&m=152318093725257&w=2

> 
> > > > Or I may understand you wrong, :-)
> > > 
> > > In the report we connected 40 hctxs (which was exactly the number of
> > > online cpus), after Yi removed 3 cpus, we tried to connect 37 hctxs.
> > > I'm not sure why some hctxs are left without any online cpus.
> > 
> > That is possible after the following two commits:
> > 
> > 4b855ad37194 ("blk-mq: Create hctx for each present CPU)
> > 20e4d8139319 (blk-mq: simplify queue mapping & schedule with each possisble CPU)
> > 
> > And this can be triggered even without putting down any CPUs.
> > 
> > The blk-mq CPU hotplug handler is removed in 4b855ad37194, and we can't
> > remap queue any more when CPU topo is changed, so the static & fixed mapping
> > has to be setup from the beginning.
> > 
> > Then if there are less enough online CPUs compared with number of hw queues,
> > some of hctxes can be mapped with all offline CPUs. For example, if one device
> > has 4 hw queues, but there are only 2 online CPUs and 6 offline CPUs, at most
> > 2 hw queues are assigned to online CPUs, and the other two are all with offline
> > CPUs.
> 
> That is fine, but the problem that I gave in the example below which has
> nr_hw_queues == num_online_cpus but because of the mapping, we still
> have unmapped hctxs.

For FC's case, there may be some hctxs not 'mapped', which is caused by
blk_mq_map_queues(), but that should one bug.

So the patch(blk-mq: don't keep offline CPUs mapped to hctx 0)[1] is
fixing the issue:
	
[1]	https://marc.info/?l=linux-block&m=152318093725257&w=2

Once this patch is in, any hctx should be mapped by at least one CPU.

Then later, the patch(blk-mq: reimplement blk_mq_hw_queue_mapped)[2]
extends the mapping concept, maybe it should have been renamed as
blk_mq_hw_queue_active(), will do it in V2.

[2] https://marc.info/?l=linux-block&m=152318099625268&w=2

> 
> > > Lets say I have 4-cpu system and my device always allocates
> > > num_online_cpus() hctxs.
> > > 
> > > at first I get:
> > > cpu0 -> hctx0
> > > cpu1 -> hctx1
> > > cpu2 -> hctx2
> > > cpu3 -> hctx3
> > > 
> > > When cpu1 goes offline I think the new mapping will be:
> > > cpu0 -> hctx0
> > > cpu1 -> hctx0 (from cpu_to_queue_index) // offline
> > > cpu2 -> hctx2
> > > cpu3 -> hctx0 (from cpu_to_queue_index)
> > > 
> > > This means that now hctx1 is unmapped. I guess we can fix nvmf code
> > > to not connect it. But we end up with less queues than cpus without
> > > any good reason.
> > > 
> > > I would have optimally want a different mapping that will use all
> > > the queues:
> > > cpu0 -> hctx0
> > > cpu2 -> hctx1
> > > cpu3 -> hctx2
> > > * cpu1 -> hctx1 (doesn't matter, offline)
> > > 
> > > Something looks broken...
> > 
> > No, it isn't broken.
> 
> maybe broken is the wrong phrase, but its suboptimal...
> 
> > Storage is client/server model, the hw queue should be only active if
> > there is request coming from client(CPU),
> 
> Correct.
> 
> > and the hw queue becomes inactive if no online CPU is mapped to it.
> 
> But when we reset the controller, we call blk_mq_update_nr_hw_queues()
> with the current number of nr_hw_queues which never exceeds
> num_online_cpus. This in turn, remaps the mq_map which results
> in unmapped queues because of the mapping function, not because we
> have more hctx than online cpus...

As I mentioned, num_online_cpus() isn't one stable variable, and it
can change any time.

After patch(blk-mq: don't keep offline CPUs mapped to hctx 0) is in,
there won't be unmapped queue any more.

> 
> An easy fix, is to allocate num_present_cpus queues, and only connect
> the oneline ones, but as you said, we have unused resources this way.

Yeah, it should be num_possible_cpus queues because physical CPU hotplug
is needed to be supported for KVM or S390, or even some X86_64 system.

> 
> We also have an issue with blk_mq_rdma_map_queues with the only
> device that supports it because it doesn't use managed affinity (code
> was reverted) and can have irq affinity redirected in case of cpu
> offlining...

That can be one corner case, looks I have to re-consider the patch
(blk-mq: remove code for dealing with remapping queue), which may cause
regression for this RDMA case, but I guess CPU hotplug may break this
case easily.

[3] https://marc.info/?l=linux-block&m=152318100625284&w=2

Also this case will make blk-mq's queue mapping much complicated,
could you provide one link about the reason for reverting managed affinity
on this device?

Recently we fix quite a few issues on managed affinity, maybe the
original issue for RDMA affinity has been addressed already.

> 
> The goal here I think, should be to allocate just enough queues (not
> more than the number online cpus) and spread it 1x1 with online cpus,
> and also make sure to allocate completion vectors that align to online
> cpus. I just need to figure out how to do that...

I think we have to support CPU hotplug, so your goal may be hard to
reach if you don't want to waste memory resource.

Thanks,
Ming

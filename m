Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751662AbeDHM6C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Apr 2018 08:58:02 -0400
Date: Sun, 8 Apr 2018 20:57:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
Message-ID: <20180408125735.GA23106@ming.t460p>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p>
 <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
 <20180408110417.GA19252@ming.t460p>
 <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Apr 08, 2018 at 02:53:03PM +0300, Sagi Grimberg wrote:
> 
> > > > > > > Hi Sagi
> > > > > > > 
> > > > > > > Still can reproduce this issue with the change:
> > > > > > 
> > > > > > Thanks for validating Yi,
> > > > > > 
> > > > > > Would it be possible to test the following:
> > > > > > --
> > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > index 75336848f7a7..81ced3096433 100644
> > > > > > --- a/block/blk-mq.c
> > > > > > +++ b/block/blk-mq.c
> > > > > > @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct
> > > > > > request_queue *q,
> > > > > >                   return ERR_PTR(-EXDEV);
> > > > > >           }
> > > > > >           cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> > > > > > +       if (cpu >= nr_cpu_ids) {
> > > > > > +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
> > > > > > +               cpu = cpumask_first(alloc_data.hctx->cpumask);
> > > > > > +       }
> > > > > >           alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> > > > > > 
> > > > > >           rq = blk_mq_get_request(q, NULL, op, &alloc_data);
> > > > > > --
> > > > > > ...
> > > > > > 
> > > > > > 
> > > > > > > [� 153.384977] BUG: unable to handle kernel paging request at
> > > > > > > 00003a9ed053bd48
> > > > > > > [� 153.393197] IP: blk_mq_get_request+0x23e/0x390
> > > > > > 
> > > > > > Also would it be possible to provide gdb output of:
> > > > > > 
> > > > > > l *(blk_mq_get_request+0x23e)
> > > > > 
> > > > > nvmf_connect_io_queue() is used in this way by asking blk-mq to allocate
> > > > > request from one specific hw queue, but there may not be all online CPUs
> > > > > mapped to this hw queue.
> > > 
> > > Yes, this is what I suspect..
> > > 
> > > > And the following patchset may fail this kind of allocation and avoid
> > > > the kernel oops.
> > > > 
> > > > 	https://marc.info/?l=linux-block&m=152318091025252&w=2
> > > 
> > > Thanks Ming,
> > > 
> > > But I don't want to fail the allocation, nvmf_connect_io_queue simply
> > > needs a tag to issue the connect request, I much rather to take this
> > > tag from an online cpu than failing it... We use this because we reserve
> > 
> > The failure is only triggered when there isn't any online CPU mapped to
> > this hctx, so do you want to wait for CPUs for this hctx becoming online?
> 
> I was thinking of allocating a tag from that hctx even if it had no
> online cpu, the execution is done on an online cpu (hence the call
> to blk_mq_alloc_request_hctx).

That can be done, but not following the current blk-mq's rule, because
blk-mq requires to dispatch the request on CPUs mapping to this hctx.

Could you explain a bit why you want to do in this way?

> 
> > Or I may understand you wrong, :-)
> 
> In the report we connected 40 hctxs (which was exactly the number of
> online cpus), after Yi removed 3 cpus, we tried to connect 37 hctxs.
> I'm not sure why some hctxs are left without any online cpus.

That is possible after the following two commits:

4b855ad37194 ("blk-mq: Create hctx for each present CPU)
20e4d8139319 (blk-mq: simplify queue mapping & schedule with each possisble CPU)

And this can be triggered even without putting down any CPUs.

The blk-mq CPU hotplug handler is removed in 4b855ad37194, and we can't
remap queue any more when CPU topo is changed, so the static & fixed mapping
has to be setup from the beginning.

Then if there are less enough online CPUs compared with number of hw queues,
some of hctxes can be mapped with all offline CPUs. For example, if one device
has 4 hw queues, but there are only 2 online CPUs and 6 offline CPUs, at most
2 hw queues are assigned to online CPUs, and the other two are all with offline
CPUs.

> 
> This seems to be related to the queue mapping.

Yes.

> 
> Lets say I have 4-cpu system and my device always allocates
> num_online_cpus() hctxs.
> 
> at first I get:
> cpu0 -> hctx0
> cpu1 -> hctx1
> cpu2 -> hctx2
> cpu3 -> hctx3
> 
> When cpu1 goes offline I think the new mapping will be:
> cpu0 -> hctx0
> cpu1 -> hctx0 (from cpu_to_queue_index) // offline
> cpu2 -> hctx2
> cpu3 -> hctx0 (from cpu_to_queue_index)
> 
> This means that now hctx1 is unmapped. I guess we can fix nvmf code
> to not connect it. But we end up with less queues than cpus without
> any good reason.
> 
> I would have optimally want a different mapping that will use all
> the queues:
> cpu0 -> hctx0
> cpu2 -> hctx1
> cpu3 -> hctx2
> * cpu1 -> hctx1 (doesn't matter, offline)
> 
> Something looks broken...

No, it isn't broken.

Storage is client/server model, the hw queue should be only active if
there is request coming from client(CPU), and the hw queue becomes
inactive if no online CPU is mapped to it.

That is why the normal rule is that request allocation needs CPU context
info, then the hctx is obtained via the queue mapping.

Thanks
Ming

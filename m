Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751387AbeDHLEh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Apr 2018 07:04:37 -0400
Date: Sun, 8 Apr 2018 19:04:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
Message-ID: <20180408110417.GA19252@ming.t460p>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p>
 <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Apr 08, 2018 at 01:58:49PM +0300, Sagi Grimberg wrote:
> 
> > > > > Hi Sagi
> > > > > 
> > > > > Still can reproduce this issue with the change:
> > > > 
> > > > Thanks for validating Yi,
> > > > 
> > > > Would it be possible to test the following:
> > > > --
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 75336848f7a7..81ced3096433 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct
> > > > request_queue *q,
> > > >                  return ERR_PTR(-EXDEV);
> > > >          }
> > > >          cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> > > > +       if (cpu >= nr_cpu_ids) {
> > > > +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
> > > > +               cpu = cpumask_first(alloc_data.hctx->cpumask);
> > > > +       }
> > > >          alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> > > > 
> > > >          rq = blk_mq_get_request(q, NULL, op, &alloc_data);
> > > > --
> > > > ...
> > > > 
> > > > 
> > > > > [� 153.384977] BUG: unable to handle kernel paging request at
> > > > > 00003a9ed053bd48
> > > > > [� 153.393197] IP: blk_mq_get_request+0x23e/0x390
> > > > 
> > > > Also would it be possible to provide gdb output of:
> > > > 
> > > > l *(blk_mq_get_request+0x23e)
> > > 
> > > nvmf_connect_io_queue() is used in this way by asking blk-mq to allocate
> > > request from one specific hw queue, but there may not be all online CPUs
> > > mapped to this hw queue.
> 
> Yes, this is what I suspect..
> 
> > And the following patchset may fail this kind of allocation and avoid
> > the kernel oops.
> > 
> > 	https://marc.info/?l=linux-block&m=152318091025252&w=2
> 
> Thanks Ming,
> 
> But I don't want to fail the allocation, nvmf_connect_io_queue simply
> needs a tag to issue the connect request, I much rather to take this
> tag from an online cpu than failing it... We use this because we reserve

The failure is only triggered when there isn't any online CPU mapped to
this hctx, so do you want to wait for CPUs for this hctx becoming online?

Or I may understand you wrong, :-)

> a tag per-queue for this, but in this case, I'd rather block until the
> inflight tag complete than failing the connect.

No, there can't be any inflight request for this hctx.


Thanks,
Ming
